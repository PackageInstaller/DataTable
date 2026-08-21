doundless.WarType = {
    Low = 1,   --低级区
    Middle = 2,--中级区
    Hight = 3,  --高级区

    Promote = 4,--城区晋级
    Warup = 5,  --战区晋级
}

doundless.getWarName = function(warId)
    local name = ""
    if warId == doundless.WarType.Low then
        name = _TT(97965)
    elseif warId == doundless.WarType.Middle then
        name = _TT(97966)
    elseif warId == doundless.WarType.Hight then
        name =  _TT(97967)
    end
    return name
end

doundless.CityType = {
    None = 0,
    Low = 1,--下城区
    Middle = 2,--中城区
    Hight = 3,--高城区
}

doundless.getCityName = function(cityId)
    local name = ""
    if cityId == doundless.CityType.Low then
        name = _TT(97962)
    elseif cityId == doundless.CityType.Middle then
        name = _TT(97963)
    elseif cityId == doundless.CityType.Hight then
        name = _TT(97964)
    end
    return name
end

doundless.getCityEasyName = function(cityId)
    local name = ""
    if cityId == doundless.CityType.None then
        name = _TT(97961)
    elseif cityId == doundless.CityType.Low then
        name = _TT(97001)
    elseif cityId == doundless.CityType.Middle then
        name = _TT(97002)
    elseif cityId == doundless.CityType.Hight then
        name = _TT(97003)
    end
    return name
end

doundless.getDoundlessRewardList = function()
    local tab = {}
    tab[doundless.WarType.Low] = {
        page = doundless.WarType.Low,
        nomalLan = _TT(97022),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_74.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_74.png"),
    }
    tab[doundless.WarType.Middle] = {
        page = doundless.WarType.Middle,
        nomalLan = _TT(97023),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_75.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_75.png"),
    }
    tab[doundless.WarType.Hight] = {
        page = doundless.WarType.Hight,
        nomalLan = _TT(97024),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_76.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_76.png"),
    }
    tab[doundless.WarType.Promote] = {
        page = doundless.WarType.Promote,
        nomalLan = _TT(97047),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_77.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_77.png"),
    }
    tab[doundless.WarType.Warup] = {
        page = doundless.WarType.Warup,
        nomalLan = _TT(97048),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_2.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_2.png"),
    }

    return tab
end

doundless.CanOpenType = {
    Award = 1,--奖励
    Rank = 2,--排行
}