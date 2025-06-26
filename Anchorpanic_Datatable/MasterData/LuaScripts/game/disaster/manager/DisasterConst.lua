disaster.AwardType = {
    Rank = 1,
    Award = 2,
}

disaster.getDisasterRewardList = function()
    local tab = {}
    tab[disaster.AwardType.Rank] = {
        page = disaster.AwardType.Rank,
        nomalLan = "排行",
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_2.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_2.png"),
    }

    tab[disaster.AwardType.Award] = {
        page = disaster.AwardType.Award,
        nomalLan = _TT(29143),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_74.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_74.png"),
    }
    return tab
end