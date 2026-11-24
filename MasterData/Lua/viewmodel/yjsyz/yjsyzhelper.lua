YJSYZHelper =
{
    activity_group_id = 5170,
    key = "boss_tower",
    rank_data = nil,
    rank_data_timestamp = 0,
}

function YJSYZHelper.get_time_left_str()
    local activity_group_config = ConfigMgr.Config.activityGroup[tostring(YJSYZHelper.activity_group_id)]
    if activity_group_config == nil then
        return LuaMgr.GetLangText("YJSYZHelper_0")
    end

    local end_ts = tonumber(activity_group_config.endTimeUnix or 0)
    local diff = end_ts - LuaMgr.Timestamp()
    if diff <= 0 then
        return LuaMgr.GetLangText("YJSYZHelper_1")
    end

    local day_sec = 24 * 60 * 60
    local hour_sec = 60 * 60
    local days = math.floor(diff / day_sec)
    diff = diff - days * day_sec
    local hours = math.floor(diff / hour_sec)
    diff = diff - hours * hour_sec
    local minutes = math.floor(diff / 60)

    return string.format(LuaMgr.GetLangText("YJSYZHelper_2"), days, hours, minutes)
end

function YJSYZHelper.get_max_score()
    if DataMgr == nil or DataMgr.Player == nil or DataMgr.Player.BossTower == nil then
        return 0
    end

    local max_score = DataMgr.Player.BossTower.MaxScore
    if max_score == nil then
        return 0
    end

    return tonumber(max_score) or 0
end

function YJSYZHelper.get_rank()
    if DataMgr == nil or DataMgr.Player == nil or DataMgr.Player.BossTower == nil then
        return 0
    end

    local rank = DataMgr.Player.BossTower.Rank
    if rank == nil then
        return 0
    end

    return tonumber(rank) or 0
end

function YJSYZHelper.get_rank_list_in_guild()
    local data_list = YJSYZHelper.rank_data
    if data_list == nil then
        return {}
    end

    local list = {}
    for _, v in ipairs(data_list) do
        table.insert(list, YJSYZHelper.convert_rank_data(v))
    end

    return list
end

function YJSYZHelper.get_my_rank_in_guild()
    local data_list = YJSYZHelper.rank_data
    if data_list == nil or DataMgr == nil or DataMgr.Player == nil then
        return {}
    end

    for _, v in ipairs(data_list) do
        if tostring(v.playerId) == tostring(DataMgr.Player.uid) then
            return YJSYZHelper.convert_rank_data(v)
        end
    end

    return {}
end

function YJSYZHelper.convert_rank_data(data)
    local element = {}
    if data == nil then
        return element
    end

    element.rank = data.GuildRank
    element.name = data.name
    element.avatarid = data.avatar
    element.avatarframeid = data.avatarFrame
    element.point = data.MaxScore
    element.hero_list = {}

    if data.Members ~= nil then
        local key_list = {}
        for k, _ in pairs(data.Members) do
            table.insert(key_list, k)
        end

        table.sort(key_list, function(a, b)
            return tostring(a) < tostring(b)
        end)

        for _, key in ipairs(key_list) do
            table.insert(element.hero_list, data.Members[key])
        end
    end

    return element
end

function YJSYZHelper.set_rank_data(data)
    YJSYZHelper.rank_data = data
    YJSYZHelper.rank_data_timestamp = LuaMgr.Timestamp()
end

function YJSYZHelper.has_rank_data_cache()
    if YJSYZHelper.rank_data == nil then
        return false
    end

    return LuaMgr.Timestamp() - (YJSYZHelper.rank_data_timestamp or 0) <= 30
end

function YJSYZHelper.get_rating()
    local max_score = YJSYZHelper.get_max_score()
    local boss_tower_score = ConfigMgr.Config.TeamTowerConstants.BossTowerScore
    if boss_tower_score == nil then
        return 0
    end

    for i, score_range in ipairs(boss_tower_score) do
        if score_range ~= nil then
            local max = tonumber(score_range[1])
            local min = tonumber(score_range[2])
            if max ~= nil and min ~= nil and max_score <= max and max_score >= min then
                return i
            end
        end
    end

    return 0
end

function YJSYZHelper.get_btn_1_reward()

    local arr = {}
    for i, v in ipairs(DataExHelper.Check_ConfigQuestEventByGroupId(5170)) do
        if v.eventType == 850 then
            table.insert(arr, v)
        end
    end
    table.sort(arr, function (a, b)
        return tonumber(a.id) < tonumber(b.id)
    end)
    return arr
end

function YJSYZHelper.get_btn_2_reward()

    local arr = {}
    for i, v in ipairs(DataExHelper.Check_ConfigQuestEventByGroupId(5170)) do
        if v.eventType == 851 then
            table.insert(arr, v)
        end
    end
    table.sort(arr, function (a, b)
        return tonumber(a.id) < tonumber(b.id)
    end)
    return arr
end

function YJSYZHelper.get_btn_3_reward()

    local arr = {}
    for i, v in ipairs(DataExHelper.Check_ConfigQuestEventByGroupId(5170)) do
        if v.eventType == 852 then
            table.insert(arr, v)
        end
    end
    table.sort(arr, function (a, b)
        return tonumber(a.id) < tonumber(b.id)
    end)
    return arr
end

function YJSYZHelper.get_current_dungeon_id()
    local team_tower_floor_id = YJSYZHelper.get_current_team_tower_floor_id()
    if team_tower_floor_id == nil then
        return nil
    end

    local team_tower_floor_config = ConfigMgr.Config.TeamTowerFloorMap[tostring(team_tower_floor_id)]
    if team_tower_floor_config == nil then
        return nil
    end

    return team_tower_floor_config.Dungeon
end

function YJSYZHelper.get_current_team_tower_floor_id()
    if DataMgr == nil or DataMgr.Player == nil or DataMgr.Player.BossTower == nil then
        return nil
    end

    return DataMgr.Player.BossTower.TowerId
end

function YJSYZHelper.get_boss_hp(hexUid)
    if DataMgr == nil or DataMgr.Player == nil or DataMgr.Player.BossTower == nil then
        return 0
    end

    if hexUid == nil then
        return 0
    end

    local boss_hp_map = DataMgr.Player.BossTower.BossHpM
    if boss_hp_map ~= nil and boss_hp_map[tostring(hexUid)] ~= nil then
        return tonumber(boss_hp_map[tostring(hexUid)]) or 0
    end

    local team_tower_floor_id = YJSYZHelper.get_current_team_tower_floor_id()
    local team_tower_floor_config = ConfigMgr.Config.TeamTowerFloorMap[tostring(team_tower_floor_id)]
    if team_tower_floor_config == nil or team_tower_floor_config.BossHp == nil then
        return 0
    end

    for _, v in ipairs(team_tower_floor_config.BossHp) do
        if v ~= nil and tostring(v[1]) == tostring(hexUid) then
            return tonumber(v[2]) or 0
        end
    end

    return 0
end

function YJSYZHelper.get_boss_tower_team_list()


    local list = {}
    if DataMgr == nil or DataMgr.Player == nil or DataMgr.Player.BossTower == nil then
        return list
    end

    local teams = DataMgr.Player.BossTower.Teams
    if teams == nil then
        return list
    end

    local key_list = {}
    for k, _ in pairs(teams) do
        table.insert(key_list, k)
    end

    table.sort(key_list, function(a, b)
        return a < b
    end)

    for _, key in ipairs(key_list) do
        local v = teams[key]
        if v ~= nil then
            local element = {}
            element.score = v.Score
            element.buff_id = v.BuffId
            element.hero_list = {}
            if v.Members ~= nil then
                for _, hero_id in pairs(v.Members) do
                    if hero_id ~= nil then
                        if ConfigMgr.Config.actor[hero_id] then
                            table.insert(element.hero_list, ConfigMgr.Config.actor[hero_id].CharacterId)
                        else
                            table.insert(element.hero_list, hero_id)
                        end
                    end

                end
            end
            table.insert(list, element)
        end
    end

    return list
end

function YJSYZHelper.get_choose_buff_list()
    local list = {}
    if DataMgr == nil or DataMgr.Player == nil or DataMgr.Player.BossTower == nil then
        return list
    end

    local choose_buff_map = DataMgr.Player.BossTower.ChooseBuff
    if choose_buff_map == nil then
        return list
    end

    for k, _ in pairs(choose_buff_map) do
        table.insert(list, tostring(k))
    end

    table.sort(list, function(a, b)
        return tostring(a) < tostring(b)
    end)

    return list
end

function YJSYZHelper.get_assist_hero_id_list()

    local list = {}
    local boss_tower_actor = ConfigMgr.Config.TeamTowerConstants.BossTowerActor
    if boss_tower_actor == nil then
        return list
    end

    for i, v in ipairs(boss_tower_actor) do
        list[i] = v
    end

    return list
end

function YJSYZHelper.get_team_floor_id_list()
    local list = {}
    local floor_map = ConfigMgr.Config.TeamTowerFloorMap
    if floor_map == nil then
        return list
    end

    for k, v in pairs(floor_map) do
        if tostring(v.GroupID) == "517001" and v.Dungeon ~= nil then
            table.insert(list, tostring(k))
        end
    end

    table.sort(list, function(a, b)
        return tostring(a) < tostring(b)
    end)

    return list
end

function YJSYZHelper.get_dungeon_buff_data_list(teamFloorId)
    local list = {}
    local team_floor_config = ConfigMgr.Config.TeamTowerFloorMap[tostring(teamFloorId)]
    if team_floor_config == nil or team_floor_config.Buff == nil then
        return list
    end

    for _, buff_id in ipairs(team_floor_config.Buff) do
        local buff_config = ConfigMgr.Config.TeamTowerBuffDescMap[tostring(buff_id)]
        if buff_config ~= nil then
            local data = {}
            data.buff_icon = buff_config.BuffIcon
            data.buff_name_lan = buff_config.BuffNameLan
            data.buff_des_lan = buff_config.BuffDesLan
            table.insert(list, data)
        end
    end

    return list
end

function YJSYZHelper.GetBossTowerLockBuffID()
    local bossTowerTeam = YJSYZHelper.GetBossTowerTeam()
    local buffID = YJSYZHelper.GetBossTowerBuffID()

    local buffConfig = ConfigMgr.Config.BossTowerBuffMap[buffID]
    if  bossTowerTeam.Lock and buffConfig then
        return buffConfig.LockBuff
    end
    return buffID
end

function YJSYZHelper.GetBossTowerBuffID()
    local bossTowerTeam = YJSYZHelper.get_boss_tower_data()
    local buffID = bossTowerTeam.BuffId or ""
    return buffID
end


function YJSYZHelper.get_boss_tower_data()
    local data = {};
    if not IsNull(DataMgr.Player.BossTower) and not IsNull(DataMgr.Player.BossTower) then
        data = DataMgr.Player.BossTower
    end
    return data;
end

function YJSYZHelper.GetCurChallengeTowerId()
    local data = YJSYZHelper.get_boss_tower_data()
    if IsNullOrEmpty(data.TowerId) then
        return "3001"
    else
        return data.TowerId
    end
end

YJSYZHelper.GetBossTowerId = function()
    local config = ConfigMgr.Config.TeamTowerMap;
    for i, v in pairs(config) do
        if v.ActivityGroup == YJSYZHelper.activity_group_id then
            return v.Id
        end
    end
    return ""
end

YJSYZHelper.GetBossTowerTeam = function()
    local data = YJSYZHelper.get_boss_tower_data()
    if data == nil then
        return
    end

    local teams = data.Teams or {}
    return teams[tostring(data.CrtNo)] or {}
end

YJSYZHelper.GetLockMembersAndHelps = function(Id)
    local members = {}
    local helps = {}
    local data = YJSYZHelper.get_boss_tower_data()
    if data == nil then
        return members, helps
    end

    local teams = data.Teams or {}
    local team = teams[tostring(data.CrtNo)] or {}
    if not IsNull(team.Members) then
         members = team.Members
    end
    if not IsNull(team.Helps) then
        helps = team.Helps
    end
    return members, helps
end

YJSYZHelper.GetFilterMembers = function(plotId)
    local members = {};
    local data = YJSYZHelper.get_boss_tower_data()
    if not IsNull(data) then
        if not IsNull(data.TiredCharacter) then
            for i, v in pairs(data.TiredCharacter) do
                if YJSYZHelper.CheckCharacterTired(i) <= 0 then
                    members[i] = "";
                end
            end
        end
    end
    return members
end

YJSYZHelper.CheckCharacterTired = function(id)
    local data = YJSYZHelper.get_boss_tower_data()
    local times = 0;
    if not IsNull(data) then
        if not IsNull(data.TiredCharacter) then
            if not IsNull(data.TiredCharacter[id]) then
                times = data.TiredCharacter[id]
            end
        end
    end
    local tiredConfig = ConfigMgr.Config.TeamTowerTiredMap[id]
    if not IsNull(tiredConfig) then
        return tiredConfig.Tired - times;
    end
    local normalConfig = ConfigMgr.Config.TeamTowerConstants.BossTowerCharacterTired;
    return normalConfig - times;
end

YJSYZHelper.GetBossTowerCurScore = function()
    local data = YJSYZHelper.get_boss_tower_data()
    if data == nil then
        return 0
    end

    return data.CrtScore
end

return YJSYZHelper