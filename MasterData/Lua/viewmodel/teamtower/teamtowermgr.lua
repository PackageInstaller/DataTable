TeamTowerMgr = 
{
    activityGroupId = 5160,
    key = "team_tower",
    equippedBuffList = {},
    equippedBuffKey = "TeamTowerEquippedBuffIds",
}
local this = 
{
}

function table.deepCopy(obj, seen)

    seen = seen or {}
    if type(obj) ~= "table" then
        return obj
    end
    if seen[obj] then
        return seen[obj]
    end

    local new_table = {}
    seen[obj] = new_table


    for k, v in pairs(obj) do
        new_table[table.deepCopy(k, seen)] = table.deepCopy(v, seen)
    end
    

    return new_table
end


TeamTowerMgr.Init = function()
    TeamTowerMgr.equippedBuffList = {}
    local buffListStr = PlayerPrefs.GetString(DataMgr.Player.uid .. TeamTowerMgr.equippedBuffKey)
    local canSelectBuffCount = ConfigMgr.Config.TeamTowerConstants.BattleSelectBuff;
    if IsNullOrEmpty(buffListStr) then
        for i = 1, canSelectBuffCount do
            table.insert(TeamTowerMgr.equippedBuffList,"");
        end
    else
        local buffIds = NumTool.split(buffListStr,';')
        for i, v in ipairs(buffIds) do
            if i > canSelectBuffCount then
                return;
            end
            table.insert(TeamTowerMgr.equippedBuffList,v);
        end
    end
end

TeamTowerMgr.GetTeamTowerData = function()
    local data = {};
    if not IsNull(DataMgr.Player.TeamTower) and not IsNull(DataMgr.Player.TeamTower) then
        data = DataMgr.Player.TeamTower
    end
    return data;
end

TeamTowerMgr.ChooseBuff = function(choose,success,fail)
    local askData = { Choose = {} }
    for i, v in pairs(choose) do
        if v ~= nil and ConfigHelper.GetTableLength(v) > 0 then
            askData.Choose[i] = v;
        end
    end
    ApiMgr.Request("teamTower/chooseBuff", askData, true, success, fail,false,nil);
end

TeamTowerMgr.GetReward = function(ids,success,fail)
    local askData = { Ids = ids }
    ApiMgr.Request("teamTower/reward", askData, true, success, fail,false,nil);
end

TeamTowerMgr.GetLockMembers = function()
    local members = {};
    local data = TeamTowerMgr.GetTeamTowerData()
    if not IsNull(data) then
        if not IsNull(data.TiredCharacter) then
            for i, v in pairs(data.TiredCharacter) do
                if TeamTowerMgr.CheckCharacterTired(i) <= 0 then
                    members[i] = "";
                end 
            end
        end
    end
    return members
end


TeamTowerMgr.CheckCharacterTired = function(id)
    local data = TeamTowerMgr.GetTeamTowerData()
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
    local normalConfig = ConfigMgr.Config.TeamTowerConstants.CharacterNormalTired;
    return normalConfig - times;
end


TeamTowerMgr.GetCurChallengeFloor = function()
    local data = TeamTowerMgr.GetTeamTowerData()
    local towerId = TeamTowerMgr.GetCurChallengeTowerId()
    if not IsNullOrEmpty(towerId) then
        local config = ConfigMgr.Config.TeamTowerFloorMap[towerId];
        if not IsNull(config) then
            if config.GroupID == "3" then
                return tostring(ConfigMgr.Config.TeamTowerConstants.LoopFloorStartNumber + (data.TowerCount - 30 + 1) * 10)
            else
                return tostring(config.DisplayFloor)
            end
        end
    end
    return "0"
end

TeamTowerMgr.GetRewardState = function(towerId)
    local data = TeamTowerMgr.GetTeamTowerData()
    return data.Reward[towerId]
end

TeamTowerMgr.GetCurChallengeTowerId = function()
    local data = TeamTowerMgr.GetTeamTowerData()
    if IsNullOrEmpty(data.TowerId) then
        return "1001"
    else
        return data.TowerId
    end
end

TeamTowerMgr.EquipBuff = function(ids)
    TeamTowerMgr.equippedBuffList = ids;
    local cache = ""
    for i, v in ipairs(TeamTowerMgr.equippedBuffList) do
        if i == #TeamTowerMgr.equippedBuffList then
            cache = cache .. v;
        else
            cache = cache .. v .. ';';
        end
    end
    PlayerPrefs.SetString(DataMgr.Player.uid .. TeamTowerMgr.equippedBuffKey,cache)
    LuaMgr.InvokeUIEventListeners(UIEventConst.OnTeamTowerEquipBuff);
end

TeamTowerMgr.GetTeamTowerId = function()
    local config = ConfigMgr.Config.TeamTowerMap;
    for i, v in pairs(config) do
        if v.ActivityGroup == TeamTowerMgr.activityGroupId then
            return v.Id
        end
    end
    return ""
end

TeamTowerMgr.TestFunction = function()

end