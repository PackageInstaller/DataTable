guild.GuildJoinType = {
    Join = 1,--加入
    Create = 2--创建
}

guild.getGuildJoinList = function()
    local tab = {}
    tab[guild.GuildJoinType.Join] = {
        page = guild.GuildJoinType.Join,
        nomalLan = _TT(94567),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_69.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_69.png"),
    }
    tab[guild.GuildJoinType.Create] = {
        page = guild.GuildJoinType.Create,
        nomalLan = _TT(94515),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_70.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_70.png"),
    }
    return tab
end

guild.GuildManagerType = {
    Manager = 1, --成员管理
    Request = 2, --申请管理
}

guild.getGuildManagerList = function()
    local tab = {}
    tab[guild.GuildManagerType.Manager] = {
        page = guild.GuildManagerType.Manager,
        nomalLan = _TT(94537),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_72.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_72.png"),
    }
    tab[guild.GuildManagerType.Request] = {
        page = guild.GuildManagerType.Request,
        nomalLan = _TT(94538),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_73.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_73.png"),
    }
    return tab
end

guild.GuildChairmanType = {
    Manager = 1, --成员管理
    Request = 2, --申请管理
}
guild.getGuildChairmanList = function()
    local tab = {}
    tab[guild.GuildChairmanType.Manager] = {
        page = guild.GuildChairmanType.Manager,
        nomalLan = _TT(94537),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_72.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_72.png"),
    }
    tab[guild.GuildChairmanType.Request] = {
        page = guild.GuildChairmanType.Request,
        nomalLan = _TT(94538),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_73.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_73.png"),
    }
    return tab
end

guild.GuildMemberType = {
    Member = 1, --成员列表
}

guild.getGuildMemberList = function()
    local tab = {}
    tab[guild.GuildMemberType.Member] = {
        page = guild.GuildMemberType.Member,
        nomalLan = _TT(94544),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_71.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_71.png"),
    }
    return tab
end

guild.GuildBossSeasonState =
{
    NoStart = 0, --未开始
    Init = 1, --初始化
    Start = 2, --开始
    Lock = 3, --锁定
    Settlement = 4, --结算
}

guild.GuildJobType = {
    Default = 0,--成员
    Leader = 1,--会长
    Chairman = 2,--副会长
}

guild.getGuildJobName = function(job)
    local name = ""
    if job == guild.GuildJobType.Default then
        name = _TT(94523)
    elseif job == guild.GuildJobType.Leader then
        name = _TT(94524)
    elseif job == guild.GuildJobType.Chairman then
        name = _TT(94989)
    end
    return name
end 
