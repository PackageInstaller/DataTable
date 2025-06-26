task.AchievementTab = {
    -- 成就预览
    PREVIEW = 0,
    -- 剧情挑战
    STORY = 1,
    -- 养成达人
    DEVELOPMENT = 2,
    -- 英雄之路
    HERO = 3,
    -- 其他成就
    OTHER = 4,
}
task.getIconPath = function(cusPageType)
    local iconPath = ""
    if (cusPageType == task.AchievementTab.PREVIEW) then
        iconPath = UrlManager:getIconPath("tabIcon/tabIcon_4.png")--"成就预览"
    elseif (cusPageType == task.AchievementTab.STORY) then
        iconPath = UrlManager:getIconPath("tabIcon/tabIcon_4.png")--"剧情挑战"
    elseif (cusPageType == task.AchievementTab.DEVELOPMENT) then
        iconPath = UrlManager:getIconPath("tabIcon/tabIcon_3.png")--"养成达人"
    elseif (cusPageType == task.AchievementTab.HERO) then
        iconPath = UrlManager:getIconPath("tabIcon/tabIcon_1.png")--"英雄之路"
    elseif (cusPageType == task.AchievementTab.OTHER) then
        iconPath = UrlManager:getIconPath("tabIcon/tabIcon_2.png")--"其他成就"
    end
    return iconPath
end

task.getPageName = function(cusPageType)
    local name = ""
    if (cusPageType == task.AchievementTab.PREVIEW) then
        name = _TT(36509)--"成就预览"
    elseif (cusPageType == task.AchievementTab.STORY) then
        name = _TT(36510)--"剧情挑战"
    elseif (cusPageType == task.AchievementTab.DEVELOPMENT) then
        name = _TT(36511)--"养成达人"
    elseif (cusPageType == task.AchievementTab.HERO) then
        name = _TT(36512)--"英雄之路"
    elseif (cusPageType == task.AchievementTab.OTHER) then
        name = _TT(36513)--"其他成就"
    end
    return name
end

task.getPageNameEn = function(cusPageType)
    local name = ""
    if (cusPageType == task.AchievementTab.PREVIEW) then
        name = "Achievement overview"
    elseif (cusPageType == task.AchievementTab.STORY) then
        name = "Plot challenge"
    elseif (cusPageType == task.AchievementTab.DEVELOPMENT) then
        name = "Develop a master"
    elseif (cusPageType == task.AchievementTab.HERO) then
        name = "Heroic road"
    elseif (cusPageType == task.AchievementTab.OTHER) then
        name = "Other achievements"
    end
    return name
end

--[[ 替换语言包自动生成，请勿修改！
]]