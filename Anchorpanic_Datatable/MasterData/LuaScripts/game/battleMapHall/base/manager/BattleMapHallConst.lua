-- 战斗地图大厅页签类型
battleMap.HallTabType = {
    -- 主线关卡
    MAIN_MAP_TAB = 0,
    -- 副本关卡
    DUP_MAP_TAB = 1,
    -- 挑战副本关卡
    DUP_CHALLENGE_TAB = 2,
    -- 支线剧情
    BRANCH_STORY = 3,
    -- 战员传记
    HERO_BIOGRAPHY = 4,
    -- 支线
    FRAGMENT_MAP_TAB = 5,
}

battleMap.getHallTabName = function(cusTabType)
    local name = ""
    if (cusTabType == battleMap.HallTabType.MAIN_MAP_TAB) then
        name = _TT(71301)
    elseif (cusTabType == battleMap.HallTabType.DUP_MAP_TAB) then
        name = _TT(71302)
    elseif (cusTabType == battleMap.HallTabType.DUP_CHALLENGE_TAB) then
        name = _TT(27)
    elseif (cusTabType == battleMap.HallTabType.BRANCH_STORY) then
        name = _TT(71303)
    elseif (cusTabType == battleMap.HallTabType.HERO_BIOGRAPHY) then
        name = _TT(71304)
    elseif (cusTabType == battleMap.HallTabType.FRAGMENT_MAP_TAB) then
        name = _TT(71303)
    end
    return name
end

battleMap.getHallTabByBattleType = function(cusBattleType)
    local tabType
    if (cusBattleType == PreFightBattleType.MainMapStage) then
        tabType = battleMap.HallTabType.MAIN_MAP_TAB
    elseif (cusBattleType == PreFightBattleType.ClimbTowerDup) then
        tabType = battleMap.HallTabType.DUP_MAP_TAB
    elseif (cusBattleType == PreFightBattleType.DupMoney) then
        tabType = battleMap.HallTabType.DUP_CHALLENGE_TAB
    elseif (cusBattleType == PreFightBattleType.HeroBiography) then
        tabType = battleMap.HallTabType.HERO_BIOGRAPHY
    elseif (cusBattleType == PreFightBattleType.Fragment) then
        tabType = battleMap.HallTabType.FRAGMENT_MAP_TAB
    end
    return tabType
end

battleMap.getUICodeByTabType = function(cusTabType)
    local uiCode = LinkCode.MainMap
    if (cusTabType == battleMap.HallTabType.MAIN_MAP_TAB) then
        uiCode = LinkCode.MainMap
    elseif (cusTabType == battleMap.HallTabType.DUP_MAP_TAB) then
        uiCode = LinkCode.DupDaily
    elseif (cusTabType == battleMap.HallTabType.DUP_CHALLENGE_TAB) then
        uiCode = LinkCode.Challenge
    elseif (cusTabType == battleMap.HallTabType.BRANCH_STORY) then
        uiCode = LinkCode.BranchStory
    elseif (cusTabType == battleMap.HallTabType.HERO_BIOGRAPHY) then
        uiCode = LinkCode.Biography
    elseif (cusTabType == battleMap.HallTabType.FRAGMENT_MAP_TAB) then
        uiCode = LinkCode.MainMap
    end
    return uiCode
end

battleMap.getIsOpenByTabType = function(cusTabType, cusShowTips)
    local isOpen = false
    if (cusTabType == battleMap.HallTabType.MAIN_MAP_TAB) then
        isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_MAINMAP, cusShowTips)
    elseif (cusTabType == battleMap.HallTabType.DUP_MAP_TAB) then
        isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_DUP_DAILY, cusShowTips)
    elseif (cusTabType == battleMap.HallTabType.DUP_CHALLENGE_TAB) then
        isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CHALLENGE, cusShowTips)
    elseif (cusTabType == battleMap.HallTabType.BRANCH_STORY) then
        isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BRANCH_STORY, cusShowTips)
    elseif (cusTabType == battleMap.HallTabType.HERO_BIOGRAPHY) then
        isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BIOGRAPHY, cusShowTips)
    elseif (cusTabType == battleMap.HallTabType.FRAGMENT_MAP_TAB) then
        isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FRAGMENTMAP, cusShowTips)
    end
    return isOpen
end


 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71304):	"战员传记"
	语言包: _TT(71303):	"支线剧情"
	语言包: _TT(71302):	"行动"
	语言包: _TT(71301):	"战纪"
	语言包: _TT(27):	"挑战"
]]
