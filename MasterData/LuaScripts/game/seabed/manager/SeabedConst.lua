--界面相关
seabed.SeabedViewType = {
    --战员技能页面
    Skill = 1,
    --地图界面
    Map = 2,
    --buff选择界面
    Buff = 3,
    --收藏品选择界面
    Collection = 4,
    --获取或失去收藏品界面
    BuffOpt = 5,
    --.获取或失去buff界面
    CollectionOpt = 6,
    --事件界面
    Event = 7,
    --商店界面
    Shop = 8
}

seabed.SeabedStepType = {
    --准备阶段
    Dif = 0,
    --选择技能
    Skill = 1,
    --进入玩法
    Finish = 2,
}


seabed.SeabedTaskType = {
    Def = 1,
    High = 2
}

seabed.getSeabedTaskList = function()
    local tab = {}
    tab[seabed.SeabedTaskType.Def] = {
        page = seabed.SeabedTaskType.Def,
        nomalLan = _TT(111060),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_84.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_84.png"),
    }

    tab[seabed.SeabedTaskType.High] = {
        page = seabed.SeabedTaskType.High,
        nomalLan = _TT(111061),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_85.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_85.png"),
    }
    return tab
end

--战斗步骤
seabed.SeabedBattleStep = {
    Formation = 1,
    Buff = 2,
    Collage = 3,
    SelectBuff = 4,
}

seabed.SeabedBattleType = {
    Collage = 1,
    Buff = 2,
    SelectBuff = 3,
}

seabed.getSeabedCollectionList = function()
    local tab = {}
    tab[seabed.SeabedBattleType.Collage] = {
        page = seabed.SeabedBattleType.Collage,
        nomalLan = _TT(111062),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_2.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_2.png"),
    }

    tab[seabed.SeabedBattleType.Buff] = {
        page = seabed.SeabedBattleType.Buff,
        nomalLan = _TT(111063),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_74.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_74.png"),
    }
    return tab
end

seabed.SeabedEventType = {
    Def = 0,
    Cycle = 1,
    Fight = 2,
    Shop = 3,
    SelectBuff = 4,
}


