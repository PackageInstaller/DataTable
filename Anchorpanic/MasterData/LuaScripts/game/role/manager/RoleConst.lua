role.RoleInfoTab = {
    RoleInfo = 1, --信息
    QualitySetting = 2, --图像
    SoundSetting = 3, --声音
    OtherSetting = 4, --声音
    ExchangeCodeTabView = 6, --兑换码
    ManualPanel = 7
}

-- 角色属性 key-value
role.AttrKey = {

    -- //////////////////////////////////////////////////
    -- // 玩家属性相关
    -- //////////////////////////////////////////////////
    -- 玩家等级
    PLAYER_LEVEL = 600,
    -- 玩家vip等级
    PLAYER_VIP_LEVEL = 601,
    -- 玩家名字
    PLAYER_NAME = 602,
    -- 玩家签名
    PLAYER_AUTOGRAPH = 603,
    -- 玩家头像
    PLAYER_HEAD = 604,
    -- 玩家头像框
    PLAYER_HEAD_FRAME = 605,
    -- 玩家称号
    PLAYER_TITLE = 606,
    -- 玩家经验
    PLAYER_EXP = 607,
    -- 玩家经验最大值
    PLAYER_MAX_EXP = 608,

    -- 玩家钛金石
    PLAYER_ITIANIUM = 611,
    -- 玩家金币
    PLAYER_GOLD_COIN = 612,
    -- 玩家竞技币
    PLAYER_ARENA_COIN = 613,
    -- 玩家装饰币
    PLAYER_DECORATE_COIN = 614,
    -- 玩家英雄全局经验
    PLAYER_HERO_GLOBAL_EXP = 615,
    -- 战勋
    PLAYER_HERO_ZHAN_XUN = 616,
    -- 看板娘id
    PLAYER_SHOW_BOARD_HERO = 617,
    -- 玩家无限币
    PLAYER_INFINITECITY_COIN = 618,
    -- 玩家声望
    PLAYER_PRESTIGE_COIN = 619,
    -- 玩家研究所全局经验
    PLAYER_COVENANT_HELPER_EXP = 620,
    -- 玩家声望经验
    PLAYER_PRESTIGE_EXP = 621,
    -- 玩家声望经验上限
    PLAYER_PRESTIGE_MAX_EXP = 622,
    -- 玩家声望等阶
    PLAYER_PRESTIGE_STAGE = 623,
    -- 玩家充值货币钛石
    PLAYER_PAY_ITIANIUM = 624,
    --函数币
    PLAYER_ROGUELIKE_FUNCTION = 626,
    --肉鸽货币
    PLAYER_ROGUELIKE_COIN = 627,
    --使徒之证
    PLAYER_APOSTLES_COIN = 628,
    --时装币
    PLAYER_FASHION_COIN = 629,
    --1.1活动货币
    PLAYER_MAIN_ACTIVITY_COIN = 630,

    --巅峰竞技场
    PVP_HELL_COIN = 631,
    --公会货币
    PLAYER_GUILD_COIN = 632,

    --新无限城货币
    DOUNDLESS_COIN = 633,

    CHAT_BUBBLE_TID = 634, --聊天气泡使用中id

    HAPPYFARM_COIN = 635, --开心农场货币

    GUILDWAR_COIN = 636, --公会战货币
}

role.getPageName = function(cusPageType)
    local name = ""
    if cusPageType == role.RoleInfoTab.RoleInfo then
        name = _TT(25116)--"个人主页"
    elseif cusPageType == role.RoleInfoTab.ExchangeCodeTabView then
        name = _TT(25118)--"兑换码"
    elseif cusPageType == role.RoleInfoTab.QualitySetting then
        name = _TT(62059)--"图像"
    elseif cusPageType == role.RoleInfoTab.SoundSetting then
        name = _TT(62060)--"声音"
    elseif cusPageType == role.RoleInfoTab.OtherSetting then
        name = _TT(62003)--"其他"
    elseif cusPageType == role.RoleInfoTab.ManualPanel then
        name = _TT(70004)--"档案"
    end
    return name
end

role.getPageIcon = function(cusPageType)
    local icon = ""
    if cusPageType == role.RoleInfoTab.RoleInfo then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_25.png") --"个人主页"
    elseif (cusPageType == role.RoleInfoTab.Setting) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_10.png")--"设置"
    elseif cusPageType == role.RoleInfoTab.ExchangeCodeTabView then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_21.png")--"兑换码"
    elseif cusPageType == role.RoleInfoTab.QualitySetting then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_16.png")--"图像"
    elseif cusPageType == role.RoleInfoTab.SoundSetting then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_18.png")--"声音"
    elseif cusPageType == role.RoleInfoTab.OtherSetting then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_17.png")--"其他"
    elseif cusPageType == role.RoleInfoTab.ManualPanel then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_15.png")--"档案"
    end
    return icon
end

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(62060):"声音"
语言包: _TT(62059):"图像"
语言包: _TT(62003):"其他"
]]
