
-- 竞技场奖励类型，和配置表保持一致，只用到3和4
arena.ArenaAwardType = {
    -- -- 挑战成功奖励
    -- CHALLENGE_SUC = 1,
    -- -- 挑战失败奖励
	-- CHALLENGE_FAIL = 2,
	-- -- 每日结算奖励
	DAILY = 3,
	-- 赛季结算奖励
	SEASON = 1,
    -- 排行奖励
    RANKAWARD = 2,
}
-- 竞技场排行榜页签类型
arena.RankHallTabType = {
	-- 排行榜
    RANK_LIST = 1,
	-- 奖励
    RANK_AWARD = 2,
}
arena.getRanHallTabName = function(cusTabType)
    local name = ""
    if (cusTabType == arena.RankHallTabType.RANK_LIST) then
        name = _TT(163)
    elseif (cusTabType == arena.RankHallTabType.RANK_AWARD) then
        name = _TT(165)
    end
    return name
end

arena.getAwardTypeName = function(cusTabType)
    local name = ""
    if (cusTabType == arena.ArenaAwardType.DAILY) then
        name = _TT(167)
    elseif (cusTabType == arena.ArenaAwardType.SEASON) then
        name = _TT(168)
    end
    return name
end
 

arena.TabViewType = {
    TypeAttack =1,
    TypeDefense = 2
}


arena.getCollectionTypeList = function()
    local tab = {}
    tab[arena.ArenaAwardType.DAILY] = { page =arena.ArenaAwardType.DAILY, nomalLan = "每日奖励", nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_58.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_58.png") }
    tab[arena.ArenaAwardType.SEASON] = { page =arena.ArenaAwardType.SEASON, nomalLan = "赛季段位", nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_56.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_56.png") }
    tab[arena.ArenaAwardType.RANKAWARD] = { page = arena.ArenaAwardType.RANKAWARD, nomalLan = "赛季排行", nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_57.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_57.png") }
    return tab
end

arena.getLogTypeList = function()
    local tab = {}
    tab[arena.TabViewType.TypeAttack] = { page =arena.TabViewType.TypeAttack, nomalLan = "进攻记录", nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_54.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_54.png") }
    tab[arena.TabViewType.TypeDefense] = { page =arena.TabViewType.TypeDefense, nomalLan = "防守记录", nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_55.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_55.png") }
    return tab
end

--[[ 替换语言包自动生成，请勿修改！
]]
