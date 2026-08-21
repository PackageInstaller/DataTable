--[[ 
-----------------------------------------------------
@filename       : MainPlayConst
@Description    : 主界面常量
@date           : 2021-08-23 15:32:22
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("game.mainPlay.manager.MainPlayConst", Class.impl())

MAINPLAY_CHALLAGE = 1 -- 挑战
MAINPLAY_STORY = 2 -- 训练
MAINPLAY_BIOGRAPHY = 3 -- 传记
MAINPLAY_DUP = 4 -- 物资
MAINPLAY_FRAGMENT = 5 -- 支线
MAINPLAY_MAIN = 6 -- 主线

function getTabList()
    local tab = {}
    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CHALLENGE, false)) then
        tab[MAINPLAY_CHALLAGE] = { page = MAINPLAY_CHALLAGE, nomalLan = _TT(44206), nomalLanEn = "" }
    end

    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BRANCH_STORY, false)) then
        tab[MAINPLAY_STORY] = { page = MAINPLAY_STORY, nomalLan = _TT(44203), nomalLanEn = "", manager = branchStory.BranchStoryManager}
    end

    if( funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_DUP_DAILY,false)) then
        tab[MAINPLAY_DUP] = {page = MAINPLAY_DUP,nomalLan = _TT(44205), nomalLanEn = ""}
    end

    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_MAINMAP, false)) then
        tab[MAINPLAY_MAIN] = { page = MAINPLAY_MAIN, nomalLan = _TT(44204), nomalLanEn = "" }
    end

    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BIOGRAPHY, false)) then
        tab[MAINPLAY_BIOGRAPHY] = { page = MAINPLAY_BIOGRAPHY, nomalLan = _TT(44207), nomalLanEn = "" }
    end

    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FRAGMENTMAP, false)) then
       tab[MAINPLAY_FRAGMENT] = { page = MAINPLAY_FRAGMENT, nomalLan = _TT(44217), nomalLanEn = "" }
    end

    return tab
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]