-- 团战阶段
guildWar.GuildWarState = {
    GuildWarSignUp = 0, -- 准备(报名)阶段
    GuildWarSignFail = 1, -- 报名失败
    GuildWarMatch= 2, --匹配中
    GuildWarStart = 3, -- 开始阶段
    GuildWarMatchAndSettle = 4, -- 匹配结算
    GuildWarSettle = 5, -- 结算阶段
}

-- 获取建筑名字
guildWar.GuildWarGetBuildName = function(type)
    local name = ""
    if type == 1 then
        name = _TT(149101)
    elseif type == 2 then
        name = _TT(149102)
    elseif type == 3 then
        name = _TT(149103)
    elseif type == 4 then
        name = _TT(149104)
    end
    return name
end

-- 是否显示血条
guildWar.GuildWarCanShowSlider = function()
    return true
end

--是否可以报名
guildWar.guildWarCanSignUp = function()
    local state = guildWar.GuildWarManager:getGuildWarState()
    if state == guildWar.GuildWarState.GuildWarSignUp then
        return true
    end
    return false
end

--是否可以请求敌人数据
guildWar.GuildWarCanReqEnemy = function()
    local state = guildWar.GuildWarManager:getGuildWarState()
    if state == guildWar.GuildWarState.GuildWarStart then
        return true
    end
    return false
end

--是否已经有血条的阶段了
guildWar.GuildWarNotHpInfo = function()
    local state = guildWar.GuildWarManager:getGuildWarState()
    return state ~= guildWar.GuildWarState.GuildWarStart
end
-- 结算状态
guildWar.ResultState = {
    -- 胜利
    WIN = 1,
    -- 失败
    LOSE = 2,
    -- 推动退出的失败
    LOSE_QUIT = 3, -- 前端不使用这个  后端已经暂位  不理就行
    -- 平局
    DRAW = 4
}

-- 战斗类型
guildWar.BattleType = {
    -- 进攻 胜利
    ATK_WIN = 1,
    -- 进攻 失败
    ATK_LOSE = 2,
    -- 进攻 平局
    ATK_DRAW = 3,

    -- 防守 胜利
    DEF_WIN = 4,
    -- 防守 失败
    DEF_LOSE = 5,
    -- 防守 平局
    DEF_DRAW = 6
}

guildWar.GetBattleString = function(result)
    local string = ""
    if result == guildWar.BattleType.ATK_WIN then
        string = _TT(149125)
    elseif result == guildWar.BattleType.ATK_LOSE then
        string = _TT(149126)
    elseif result == guildWar.BattleType.ATK_DRAW then
        string = _TT(149127)
    elseif result == guildWar.BattleType.DEF_WIN then
        string = _TT(149128)
    elseif result == guildWar.BattleType.DEF_LOSE then
        string = _TT(149129)
    elseif result == guildWar.BattleType.DEF_DRAW then
        string = _TT(149130)
    end
    return string
end

--是否可以操作入驻 撤离
guildWar.GetSelfCanOpt = function()
    return guild.GuildManager:getSelfIsGuildLeader()
end

guildWar.TabType = {
    Rank = 1,
    Award = 2
}

guildWar.GetTabeList = function()
    local tab = {}
    tab[guildWar.TabType.Rank] = {
        page = guildWar.TabType.Rank,
        nomalLan = _TT(149131),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_2.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_2.png")
    }
    tab[guildWar.TabType.Award] = {
        page = guildWar.TabType.Award,
        nomalLan = _TT(149132),
        nomalLanEn = "",
        nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_2.png"),
        selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_2.png")
    }
    return tab
end

guildWar.GetBuildHPState = function(nowHp,maxHp)
    local curHpPro = nowHp / maxHp
    if nowHp == 0 then
        return 3
    else
        local pro = sysParam.SysParamManager:getValue(SysParamType.GUILDFIGHT_NEED_PRO) / 100
        if curHpPro >= pro then
            return  1
        else
            return 2
        end
    end
end

--建筑的状态
guildWar.BuildHPState = {
    --损毁
    DIE = 3,
    --损坏
    DAM = 2,
    --良好
    GOOD = 1,
}

guildWar.GetDefHPState = function()
    return 1
end