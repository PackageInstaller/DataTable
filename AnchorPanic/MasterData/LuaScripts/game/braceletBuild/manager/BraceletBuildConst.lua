-- 装备培养类型
braceletBuild.BuildTabType = {
    -- 强化
    STRENGTHEN = 1,
    -- 精炼
    REFINE = 2,
    --赋能
    EMPOWER = 3,
}

braceletBuild.getBuildName = function(cusTabType)
    local name = ""
    if (cusTabType == braceletBuild.BuildTabType.REFINE) then
        name = _TT(4330) -- "精炼"
    elseif (cusTabType == braceletBuild.BuildTabType.STRENGTHEN) then
        name = _TT(4331) -- "强化"
    elseif (cusTabType == braceletBuild.BuildTabType.EMPOWER) then
        name = _TT(93115) -- "赋能"
    end
    return name
end

braceletBuild.getBuildIcon = function(cusTabType)
    local icon = ""
    if (cusTabType == braceletBuild.BuildTabType.REFINE) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_40.png")
    elseif (cusTabType == braceletBuild.BuildTabType.STRENGTHEN) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_39.png")
    elseif (cusTabType == braceletBuild.BuildTabType.EMPOWER) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_36.png")
    end
    return icon
end

braceletBuild.strengthenState = {
    CanNotStrengthen = 1, --无法强化
    Strengthen = 2, --强化
    BreakUp = 3, --突破
    MaxLvl = 4, --最大等级
}

braceletBuild.color = {
    Yellow = 1, --无法强化
    Strengthen = 2, --强化
    BreakUp = 3, --突破
    MaxLvl = 4, --最大等级
}

--手环颜色
braceletBuild.getBracelectsColor = function(type)
    if type == ColorType.ORANGE then
        return "fd9b34ff"
    elseif type == ColorType.BLUE then
        return "2a9effff"
    elseif type == ColorType.VIOLET then
        return "f16de3ff"
    end
end
