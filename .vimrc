syntax on
set nocompatible              " be iMproved, required
filetype off                  " required


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'skywind3000/gutentags_plus'
Plugin 'skywind3000/vim-preview'
Plugin 'tomlion/vim-solidity'
Plugin 'instant-markdown/vim-instant-markdown'

" All of your Plugins must be added before the following line
call vundle#end()            " required


if $FUCHSIA_DIR != ""
  source $FUCHSIA_DIR/scripts/vim/fuchsia.vim
endif
filetype plugin indent on    " required

highlight Pmenu ctermfg=white ctermbg=black
highlight PmenuSel ctermfg=blue ctermbg=gray

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set tabstop=4
set expandtab
set autoindent
" set softtabstop=4
set shiftwidth=4
set showmatch
set number
set hlsearch
set incsearch

" cscope setting
"if has("cscope")
"   set csto=0
"   set cst
"   set nocsverb
" add any database in current directory
"   if filereadable("cscope.out")
"       cs add cscope.out
    " else add database pointed to by environment
"    elseif $CSCOPE_DB != ""
"       cs add $CSCOPE_DB
"   endif
"   set csverb
"endif

" Tlist setting
map <F4> :TlistToggle<CR>
"   auto close Tlist if there is only one window
let Tlist_Exit_OnlyWindow = 1

" NERDTree setting
map <F2> :NERDTreeToggle<CR>
"   auto close NERDTree if there is only one window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Show trailing whitepace and spaces before a tab:
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

fun! StripTrailingWhitespace()
    " Only strip if the b:noStripeWhitespace variable isn't set
    if exists('b:noStripWhitespace')
        return
    endif
    %s/\s\+$//e
endfun

" auto remove leading and trailing whitespace when save
:autocmd BufWritePre * call StripTrailingWhitespace()
:autocmd FileType markdown let b:noStripWhitespace=1
" using :retab to change tab to space*4

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
"set cscopetag

let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '~/.vimrc/gtags.conf'

" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.root']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1
let g:gutentags_auto_add_gtags_cscope = 1

"let g:gutentags_trace = 1
let g:gutentags_define_advanced_commands = 1

nmap <C-\>s :GscopeFind s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :GscopeFind f <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :GscopeFind g <C-R>=expand("<cword>")<CR><CR>
noremap <C-]> g<C-]>

"预览 quickfix 窗口 ctrl-w z 关闭
"P 预览 大p关闭
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
noremap <Leader>u :PreviewScroll -1<cr> " 往上滚动预览窗口
noremap <leader>d :PreviewScroll +1<cr> "  往下滚动预览窗口

":highlight YcmErrorLine ctermfg=white
":highlight YcmWarningLine ctermfg=white
let g:ycm_show_diagnostics_ui = 0

"instant markdown
filetype plugin on
let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
let g:instant_markdown_port = 8894
let g:instant_markdown_open_to_the_world = 1
