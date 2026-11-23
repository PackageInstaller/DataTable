PlayerGuildMgr = {}

PlayerGuildMgr.GuildRefreshSuccessCallBack = nil
PlayerGuildMgr.GuildRefreshFailCallBack = nil
PlayerGuildMgr.FirstEnter = true

PlayerGuildMgr.red_17830_noGuild = 0;
PlayerGuildMgr.red_17831_sign = 0;
PlayerGuildMgr.red_17832_apply = 0;
PlayerGuildMgr.red_17833_levelUp = 0;
PlayerGuildMgr.red_17836_build1 = 0;

local this =
{
    GuildConfig = nil,
    GuildBuildConfig = nil,
    GuildSignRewardConfig = nil,
    GuildFunctionConfig = nil,
    GuildJobCountLimitDic = nil,
    level = 1,
    GuildJobChangePermission = false,
    GuildAnnounceChangePermission = false,
    GuildApplyHandlePermission = false,
    GuildKickOutPermission = false,
    GuildLevelUpPermission = false,
    GuildJobChangeList = {},

    GuildInfo = {
        job = 1,
        guildLevel = 1,
        guildName = "",
        guildAnnounce = "",
        leaderName = "",
        guildHonor = "",
        levelLimit = 0,
        needApprove = false,
        msg = {{msg = ""}},
        memberList = {
            { name = "", playerId = "", job = 1, level = 0, totalContribution = 0, weekContribution = 0, onLine = true, offLineTime = 1, avatar = "", avatarFrame = "", sex = 1, motto = ""}
        },
        applyList = {
            { name = "", playerId = "", level = 0, avatar = "", avatarFrame = "", sex = 1, motto = ""},
        },
    },
}

PlayerGuildMgr.sortType =
{
    status = 1,
    job = 2,
    level = 3,
    totalContribution = 4,
    weekContribution = 5,
}

PlayerGuildMgr.GuildList =
{
    {name = "1111111111",id = 0,guildLevel = "1",guildMember = 200,applyLevelCondition = 0,notice = "1111111",chiefName = "222"},
    {name = "2222222222",id = 0,guildLevel = "1",guildMember = 10,applyLevelCondition = 10,notice = "222222",chiefName = "222"},
    {name = "1111112222", id = 0, guildLevel = "1", guildMember = 10, applyLevelCondition = 10, notice = "1111122222", chiefName = "222"},
}

PlayerGuildMgr.Init = function()
    PlayerGuildMgr.GuildRefreshSuccessCallBack = nil
    PlayerGuildMgr.GuildRefreshFailCallBack = nil
    local serverList=json.decode(LuaMgr.serverList);
    local serverTimeStamp=tonumber(serverList.data.Time);
    local date = LuaMgr.GetUnitxDate(serverTimeStamp)
    local lastLogin = PlayerPrefs.GetString("guildEnter"..DataMgr.Player.uid, "")
    PlayerGuildMgr.FirstEnter = lastLogin ~= date
    PlayerPrefs.SetString("guildEnter"..DataMgr.Player.uid, date)
    this.GuildInfo = nil
    this.InitConfig()

    PlayerGuildMgr.red_17830_noGuild = 0;
    PlayerGuildMgr.red_17831_sign = 0;
    PlayerGuildMgr.red_17832_apply = 0;
    PlayerGuildMgr.red_17833_levelUp = 0;
    PlayerGuildMgr.red_17836_build1 = 0;

    PlayerGuildMgr.AddTimer()
end

PlayerGuildMgr.AddTimer = function()
    LuaMgr.RemoveTimer(TimerConst.RefreshGuildInfoTimer);
    local heartbeatInterval = ConfigMgr.Config.constants.heartbeatInterval;
    if (heartbeatInterval <= 0) then
        heartbeatInterval = 180;
    end
    LuaMgr.AddUIEventListener(UIEventConst.HeartBeat,PlayerGuildMgr.Refresh);

end

PlayerGuildMgr.Refresh = function()
    PlayerGuildMgr.RefreshGuildInfo(nil,nil)
end

PlayerGuildMgr.RemoveTimer = function()

    LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, PlayerGuildMgr.Refresh)
end

PlayerGuildMgr.RefreshGuildInfo = function(success,fail)
    PlayerGuildMgr.GetGuildInfo(function(result)
        if result==nil then return end;
        local re=json.decode(result);
        if re.result.guildId == "" then
            if fail ~= nil then
               fail() 
            end
            return;
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.UpdateGuild)
        this.InitGuildInfo(re.result)
        if success ~= nil then
            success()
        end
        PlayerGuildMgr.UpdateRedStatus()
    end,nil)
end

PlayerGuildMgr.HaveGuild = function()
    return not TableIsNull(this.GuildInfo)
end

PlayerGuildMgr.Clear = function()

end

this.InitGuildInfo = function(info)
    local tempGuildInfo = {};
    tempGuildInfo.guildLevel = info.level;
    tempGuildInfo.guildName = info.name;
    tempGuildInfo.guildAnnounce = info.notice;
    tempGuildInfo.leaderName = info.chiefName;
    tempGuildInfo.guildHonor = tostring(info.honor);
    tempGuildInfo.levelLimit = info.levelLimit;
    tempGuildInfo.needApprove = info.needApprove;
    
    local tempMsgList = {}
    if type(info.dynamicInfoList) == "table" and not TableIsNull(info.dynamicInfoList) then
        for i = 1, #info.dynamicInfoList do
            local msg = info.dynamicInfoList[i];
            local str = "";
if msg.type == 1 then
                str = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30182"),msg.name);
elseif msg.type == 2 then
                str = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30183"),msg.name);
elseif msg.type == 3 then
                str = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30184"),msg.name);
elseif msg.type == 4 then
                str = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30185"),msg.name,msg.parameter);
elseif msg.type == 5 then
                str = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30260"),msg.name,msg.parameter,PlayerGuildMgr.GetJobName(msg.extra_parameter[1]));
            end
            local msgInfo = {msg = str}
            table.insert(tempMsgList,msgInfo);
        end
    end

    tempGuildInfo.msg = tempMsgList;
    tempGuildInfo.memberList = info.members;
    tempGuildInfo.applyList = info.applyList;

    for i = 1, #tempGuildInfo.memberList do
        if tempGuildInfo.memberList[i].playerId == DataMgr.Player.uid then
            tempGuildInfo.job = tempGuildInfo.memberList[i].job;
            break
        end
    end

    this.GuildInfo = tempGuildInfo
    this.InitCurLevelInfo(info.level)
    PlayerGuildMgr.ResetMemberList()
    this.InitPermission()
    PlayerGuildMgr.UpdateRedStatus()
    if PlayerGuildMgr.GuildRefreshSuccessCallBack ~= nil then
        PlayerGuildMgr.GuildRefreshSuccessCallBack();
    end
end

PlayerGuildMgr.UpdateRedStatus = function()
    if PlayerGuildMgr.FirstEnter and (DataMgr.Player.guildData == nil or DataMgr.Player.guildData.guildId == "") then
        PlayerGuildMgr.red_17830_noGuild = 1;
    else
        PlayerGuildMgr.red_17830_noGuild = 0;
    end
    
    if DataMgr.Player.guildData.sign == false and DataMgr.Player.guildData ~= nil and DataMgr.Player.guildData.guildId ~= "" then
        PlayerGuildMgr.red_17831_sign = 1;
    else
        PlayerGuildMgr.red_17831_sign = 0;
    end
    
    if this.GuildInfo ~= nil and this.GuildApplyHandlePermission and #this.GuildInfo.applyList > 0 then
        PlayerGuildMgr.red_17832_apply = 1;
    else
        PlayerGuildMgr.red_17832_apply = 0;
    end

    if this.GuildInfo ~= nil and PlayerGuildMgr.CanLevelUp() then
        PlayerGuildMgr.red_17833_levelUp = 1;
    else
        PlayerGuildMgr.red_17833_levelUp = 0;
    end

    RedMgr.Singleton:UpdateClientRedData("17831",PlayerGuildMgr.red_17831_sign);
    RedMgr.Singleton:UpdateClientRedData("17832",PlayerGuildMgr.red_17832_apply);
    RedMgr.Singleton:UpdateClientRedData("17833",PlayerGuildMgr.red_17833_levelUp);
    RedMgr.Singleton:UpdateClientRedData("17830",PlayerGuildMgr.red_17831_sign + PlayerGuildMgr.red_17833_levelUp + PlayerGuildMgr.red_17832_apply + PlayerGuildMgr.red_17830_noGuild);



    RedMgr.Singleton:UpdateClientRedData("17836",PlayerGuildMgr.red_17832_apply);
end

PlayerGuildMgr.CheckMainRed = function()
    if PlayerGuildMgr.FirstEnter and (DataMgr.Player.guildData == nil or DataMgr.Player.guildData.guildId == "") then
        PlayerGuildMgr.red_17830_noGuild = 1;
    else
        PlayerGuildMgr.red_17830_noGuild = 0;
    end
    return PlayerGuildMgr.red_17831_sign + PlayerGuildMgr.red_17833_levelUp + PlayerGuildMgr.red_17832_apply + PlayerGuildMgr.red_17830_noGuild
end

this.InitConfig = function()
    this.GuildConfig = { };
    this.GuildSignRewardConfig = {};
    this.GuildFunctionConfig = {};
    this.GuildJobCountLimitDic = {};
    this.GuildBuildConfig = { };
    for k, v in pairs(ConfigMgr.Config.GuildMap) do
        this.GuildConfig[v.level] = v;
    end
    
    for k, v in pairs(ConfigMgr.Config.SignInRewardMap) do
        this.GuildSignRewardConfig[v.Id] = v;
    end

    for k, v in pairs(ConfigMgr.Config.GuildFunctionMap) do
        this.GuildFunctionConfig[v.id] = v;
        if (not IsNullOrEmpty(v.building)) and v.building == "1" then
            this.GuildBuildConfig[v.buildingID] = v;
        end
    end
end

this.InitCurLevelInfo = function(level)
    this.level = level;
    this.GuildJobCountLimitDic = {};
    local config = PlayerGuildMgr.GetGuildConfigByLevel(level)
    if config ~= nil then
        for i = 1, #config.position do
            local jobLimit = split(config.position[i],";");
            this.GuildJobCountLimitDic[jobLimit[1]] = jobLimit[2];
        end
    end
end

this.InitPermission = function()
    this.GuildJobChangePermission = false;
    this.GuildAnnounceChangePermission = false;
    this.GuildApplyHandlePermission = false;
    this.GuildKickOutPermission = false;
    this.GuildLevelUpPermission = false;
    local job = this.GuildInfo.job;
    local constant = ConfigMgr.Config.constants;
    for i = 1, #constant.GuildApplyHandlePermission do
        if constant.GuildApplyHandlePermission[i] == job then
            this.GuildApplyHandlePermission = true;
            break;
        end
    end

    for i = 1, #constant.GuildAnnounceChangePermission do
        if constant.GuildAnnounceChangePermission[i] == job then
            this.GuildAnnounceChangePermission = true;
            break;
        end
    end

    for i = 1, #constant.GuildKickOutPermission do
        if constant.GuildKickOutPermission[i] == job then
            this.GuildKickOutPermission = true;
            break;
        end
    end

    for i = 1, #constant.GuildLevelUpPermission do
        if constant.GuildLevelUpPermission[i] == job then
            this.GuildLevelUpPermission = true;
            break;
        end
    end

    this.GuildJobChangeList = {};
    
    for i = 1, #constant.GuildJobChangePermission do
        if i == job then
            this.GuildJobChangePermission = true;
            for j = 1, #constant.GuildJobChangePermission[i] do
                table.insert(this.GuildJobChangeList,constant.GuildJobChangePermission[i][j])
            end
        end
    end
end

PlayerGuildMgr.IsGuildBuildUnLock = function(buildingId)
    if this.GuildBuildConfig[buildingId] ~= nil then
        local config = this.GuildBuildConfig[buildingId]
        if config.unseal == "0" then
            return false;
        end
        if IsNullOrEmpty(config.unlock) then
            return true
        end
        if tonumber(config.unlock) <= this.GuildInfo.guildLevel then
            return true
        end
    end
    return false
end

PlayerGuildMgr.GuildBuildConfig = function()
    return this.GuildBuildConfig;
end

PlayerGuildMgr.GetGuildLevelUpPermission = function()
    return this.GuildLevelUpPermission;
end

PlayerGuildMgr.GetGuildKickOutPermission = function()
    return this.GuildKickOutPermission;
end

PlayerGuildMgr.GetGuildAnnounceChangePermission = function()
    return this.GuildAnnounceChangePermission;
end

PlayerGuildMgr.GetGuildApplyHandlePermission = function()
    return this.GuildApplyHandlePermission;
end

PlayerGuildMgr.GetGuildJobChangePermission = function()
    return this.GuildJobChangePermission;
end

PlayerGuildMgr.GetGuildChangeJobList = function()
    return this.GuildJobChangeList;
end

PlayerGuildMgr.GetGuildConfigByLevel = function(level)
    if this.GuildConfig[tostring(level)] ~= nil then
        return this.GuildConfig[tostring(level)];
    else
        return nil;
    end
end

PlayerGuildMgr.GetGuildSignRewardConfigById = function(id)
    if this.GuildSignRewardConfig[id] ~= nil then
        return this.GuildSignRewardConfig[id];
    else
        LuaDebug.error("log：错误的签到奖励id：" .. id);
        return nil;
    end
end

PlayerGuildMgr.GetGuildFunctionConfigById = function(id)
    if this.GuildFunctionConfig[id] ~= nil then
        return this.GuildFunctionConfig[id];
    else
        LuaDebug.error("log：错误的公会功能id：" .. id);
        return nil
    end
end

PlayerGuildMgr.ResetMemberList = function()
    table.sort(PlayerGuildMgr.GuildInfo().memberList, function(a, b)
        if a.onLine ~= b.onLine then
            return a.onLine;
        end
        if a.job ~= b.job then
            return (a.job > b.job);
        end
        if a.level ~= b.level then
            return (a.level < b.level);
        end
        if a.totalContribution ~= b.totalContribution then
            return (a.totalContribution < b.totalContribution);
        end
        if a.weekContribution ~= b.weekContribution then
            return (a.weekContribution < b.weekContribution);
        end
    end)
end

PlayerGuildMgr.SortBy = function(type,order)
    PlayerGuildMgr.ResetMemberList();
    table.sort(PlayerGuildMgr.GuildInfo().memberList, function(a, b)
        if type == PlayerGuildMgr.sortType.status then
            if a.onLine ~= b.onLine then
                return ((a.onLine and 1 or -1) * order) > 0;
            else
                return ((b.offLineTime - a.offLineTime) * order) > 0;
            end
        elseif a.job ~= b.job and type == PlayerGuildMgr.sortType.job then
            return ((a.job - b.job) * order) > 0;
        elseif a.level ~= b.level and type == PlayerGuildMgr.sortType.level then
            return ((b.level - a.level) * order) > 0;
        elseif a.weekContribution ~= b.weekContribution and type == PlayerGuildMgr.sortType.weekContribution then
            return ((b.weekContribution - a.weekContribution) * order) > 0;
        elseif a.totalContribution ~= b.totalContribution and type == PlayerGuildMgr.sortType.totalContribution then
            return ((b.totalContribution - a.totalContribution) * order) > 0;
        end
    end)
end

PlayerGuildMgr.GetGuildMaxLevel = function()
    local length = ConfigHelper.GetTableLength(ConfigMgr.Config.GuildMap)
    return length;
end

PlayerGuildMgr.CanLevelUp = function()
    if not GetGuildLevelUpPermission then
        return false
    end
    if this.GuildInfo.guildLevel >= PlayerGuildMgr.GetGuildMaxLevel() then
        return false
    end
    local item = PlayerGuildMgr.GetGuildConfigByLevel(tostring(this.GuildInfo.guildLevel)).consume;
    local count = DataHelper.GetItemCountById(item.id);
    if count > item.count then
        return true
    end
    return false
end

function PlayerGuildMgr.GuildInfo()
    return this.GuildInfo;
end

function PlayerGuildMgr.GetGuildInfo(success,fail)
    local askData = {};
    ApiMgr.Request("guild/get_guild_info", askData, true, success, fail, false,false)
end

function PlayerGuildMgr.GetGuildList(success)
    local askData = {};
    ApiMgr.Request("guild/get_guild_list", askData, true, function(result)
        if result==nil then return end;
        local re=json.decode(result);
        PlayerGuildMgr.GuildList = re.result.guild_list;
        if success ~= nil then
            success();
        end
    end, nil, true,false)
end

function PlayerGuildMgr.GetGuildFilterList(success,filter)
    local askData = {};
    askData.Name = filter
    ApiMgr.Request("guild/query_guild", askData, true, function(result)
        if result==nil then return end;
        local re=json.decode(result);
        PlayerGuildMgr.GuildList = re.result.List;
        if success ~= nil then
            success();
        end
    end, nil, true,false)
end


function PlayerGuildMgr.CreateGuild(name,needApprove,levelLimit,success)
    local askData = 
    {
        name = name,
        need_approve = needApprove,
        level_limit = levelLimit
    };
    ApiMgr.Request("guild/create_guild", askData, true, function(result)
        if result==nil then
            return
        end;
        local re=json.decode(result);
        this.InitGuildInfo(re.result);
        if success ~= nil then
            success();
        end
    end, function()
        PlayerGuildMgr.RefreshGuildInfo(nil,nil)
    end, true,false)
end


function PlayerGuildMgr.Apply (guildId,success,fail)
    local askData = {guild_id = guildId};
    ApiMgr.Request("guild/join_guild", askData, true,function(result)
        if result==nil then
            return 
        end;
        local re=json.decode(result);
        if re.result.guildId ~= "" then
            this.InitGuildInfo(re.result);
            if success ~= nil then
                success(true);
            end
        else
            if success ~= nil then
                success(false);
            end
        end
    end, fail, true,false)
end


function PlayerGuildMgr.QuickApply(success,fail)
    local askData = {};
    ApiMgr.Request("guild/quick_join", askData, true, function(result)
        if result==nil then

            return
        end;
        local re=json.decode(result);
        if re.result.guildId ~= "" then
            this.InitGuildInfo(re.result);
            if success ~= nil then
                success(true);
            end
        else
            if success ~= nil then
                success(false);
            end
        end
    end, fail, true,false)
end


function PlayerGuildMgr.AgreePlayerApply(playerId,success)
    local askData =
    {
        player_id = playerId
    };
    ApiMgr.Request("guild/agree_player_apply", askData, true, function(result)
        if result==nil then
            return
        end;
        local re=json.decode(result);
        this.InitGuildInfo(re.result);
        if success ~= nil then
            success();
        end
    end, function(errorCode)
        PlayerGuildMgr.RefreshGuildInfo(nil,nil)
        if errorCode == 10001 then
            LuaMgr.HidePanels();
            LuaMgr.ShowLuaPanel(UIName.MainPageViewModel);
        end
    end, true,false)
end


function PlayerGuildMgr.RefusePlayerApply(playerId,success)
    local askData =
    {
        player_id = playerId
    };
    ApiMgr.Request("guild/refusal_player_apply", askData, true, function(result)
        if result==nil then
            return
        end;
        local re=json.decode(result);
        this.InitGuildInfo(re.result);
        if success ~= nil then
            success();
        end
    end, function()
        PlayerGuildMgr.RefreshGuildInfo(nil,nil)
    end, true,false)
end


function PlayerGuildMgr.KickOut(playerId,success)
    local askData = {
        player_id = playerId
    };
    ApiMgr.Request("guild/remove_guild", askData, true, function(result)
        if result==nil then
            return
        end;
        local re=json.decode(result);
        this.InitGuildInfo(re.result);
        if success ~= nil then
            success();
        end
    end, function()
        PlayerGuildMgr.RefreshGuildInfo(nil,nil)
    end, true,false)
end


function PlayerGuildMgr.Disband(name,success)
    local askData = {};
    ApiMgr.Request("guild/disband_guild", askData, true, success, function()
        PlayerGuildMgr.RefreshGuildInfo(nil,nil)
    end, true,false)
end


function PlayerGuildMgr.SignIn(success,fail)
    local askData = {};
    ApiMgr.Request("guild/guild_sign", askData, true, success, function()
        PlayerGuildMgr.RefreshGuildInfo(nil,nil)
    end, true,false)
end


function PlayerGuildMgr.Exit(success)
    local askData = {};
    ApiMgr.Request("guild/exit_guild", askData, true, function(result)
        this.GuildInfo = nil;
        if success ~= nil then
            success();
        end
    end, function(errorCode)
        PlayerGuildMgr.RefreshGuildInfo(nil,nil)
        if errorCode == 10002 or errorCode == 10025 then
            LuaMgr.HidePanels();
            LuaMgr.ShowLuaPanel(UIName.MainPageViewModel);
        end
    end, true,false)
end


function PlayerGuildMgr.ChangeAnnounce(announce,success)
    local askData = {notice = announce}
    ApiMgr.Request("guild/modify_notice", askData, true, function(result)
        if result==nil then
            return
        end;
        local re=json.decode(result);
        this.InitGuildInfo(re.result);
        if success ~= nil then
            success();
        end
    end, function()
        PlayerGuildMgr.RefreshGuildInfo(nil,nil)
    end, true,false)
end


function PlayerGuildMgr.LevelUp(success)
    local askData = {};
    ApiMgr.Request("guild/upgrade_guild", askData, true, function(result)
        if result==nil then
            return
        end;
        local re=json.decode(result);
        this.InitGuildInfo(re.result);
        PlayerGuildMgr.RefreshGuildInfo(nil,nil)
        if success ~= nil then
            success();
        end
    end, function()
        PlayerGuildMgr.RefreshGuildInfo(nil,nil)
    end, true,false)
end


function PlayerGuildMgr.TransferGuild(playerId,success)
    local askData = {
        player_id = playerId
    };
    ApiMgr.Request("guild/transfer_guild", askData, true, function(result)
        if result==nil then
            return
        end;
        local re=json.decode(result);
        this.InitGuildInfo(re.result);
        if success ~= nil then
            success();
        end
    end, function()
        PlayerGuildMgr.RefreshGuildInfo(nil,nil)
    end, true,false)
end


function PlayerGuildMgr.ChangeJob(id,job,success)
    local askData = {player_id = id,job = job};
    ApiMgr.Request("guild/modify_member_job", askData, true, function(result)
        if result==nil then
            return
        end;
        local re=json.decode(result);
        this.InitGuildInfo(re.result);
        if success ~= nil then
            success();
        end
    end, function()
        PlayerGuildMgr.RefreshGuildInfo(nil,nil)
    end, true,false)
end


function PlayerGuildMgr.ChangeJoinCondition(levelLimit,needApprove,success)
    local askData = {levelLimit = levelLimit,needApprove = needApprove};
    ApiMgr.Request("guild/modify_join_condition", askData, true, function(result)
        if result==nil then
            return
        end;
        local re=json.decode(result);
        this.InitGuildInfo(re.result);
        if success ~= nil then
            success();
        end
    end, function()
        PlayerGuildMgr.RefreshGuildInfo(nil,nil)
    end, true,false)
end

function PlayerGuildMgr.GetJobName(job)
    if tonumber(job) == 1 then
        return LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30223");
    elseif tonumber(job) == 2 then
        return LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30224");
    elseif tonumber(job) == 3 then
        return LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30225");
    elseif tonumber(job) == 4 then
        return LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30226");
    end
end 