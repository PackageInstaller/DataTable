module("game.branchStory.manager.BranchStoryConst", Class.impl())



TACTIVS = 1 -- 战术训练
EQUIP = 2 --备战试炼
MAIN = 3 -- 战场异闻
POWER = 4 --能源力场

function getTabList(self)
    local tab = {}

    if
        (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BRANCH_STORY_EQUIP, false) or
            funcopen.FuncOpenManager:getFuncOpenData(funcopen.FuncOpenConst.FUNC_ID_BRANCH_STORY_EQUIP).event == 1)
     then
        tab[EQUIP] = {page = EQUIP, nomalLan = _TT(44051), nomalLanEn = ""}
    end
    if
        (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BRANCH_STORY_MAIN, false) or
            funcopen.FuncOpenManager:getFuncOpenData(funcopen.FuncOpenConst.FUNC_ID_BRANCH_STORY_MAIN).event == 1)
     then
        tab[MAIN] = {page = MAIN, nomalLan = _TT(44052), nomalLanEn = ""}
    end
    if
        (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BRANCH_STORY_TACTIVS, false) or
            funcopen.FuncOpenManager:getFuncOpenData(funcopen.FuncOpenConst.FUNC_ID_BRANCH_STORY_TACTIVS).event == 1)
     then
        tab[TACTIVS] = {page = TACTIVS, nomalLan = _TT(44053), nomalLanEn = ""}
    end
    if
        (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BRANCH_POWER, false) or
            funcopen.FuncOpenManager:getFuncOpenData(funcopen.FuncOpenConst.FUNC_ID_BRANCH_POWER).event == 1)
     then
        tab[POWER] = {page = POWER, nomalLan = _TT(44054), nomalLanEn = ""}
    end



    return tab
end

return _M
-- -- 页签类型
-- branchStory.TabType = {
--     -- 芯片特训
--     EQUIP = 0,
--     -- 支线特训
--     MAIN = 1,
--     --战术训练
--     TACTIVS = 2
-- }

-- branchStory.getTabName = function(cusTabType)
--     local name = ""
--     if (cusTabType == branchStory.TabType.EQUIP) then
--         name = _TT(44051) -- "芯片特训"
--     elseif (cusTabType == branchStory.TabType.MAIN) then
--         name = _TT(44052) -- "支线特训"
--     elseif (cusTabType == branchStory.TabType.TACTIVS) then
--         name = _TT(44053) -- "战术训练"
--     end
--     return name
-- end

-- branchStory.getIsOpenByTabType = function(cusTabType, cusShowTips)
--     local isOpen = false
--     if (cusTabType == branchStory.TabType.EQUIP) then
--         isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BRANCH_STORY_EQUIP, cusShowTips)
--     elseif (cusTabType == branchStory.TabType.MAIN) then
--         isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BRANCH_STORY_MAIN, cusShowTips)
--     elseif (cusTabType == branchStory.TabType.TACTIVS) then
--         isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BRANCH_STORY_TACTIVS, cusShowTips)
--     end
--     return isOpen
-- end
 
--[[ 替换语言包自动生成，请勿修改！
]]
