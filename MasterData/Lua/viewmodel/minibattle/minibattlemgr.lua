MiniBattleMgr = {
    activityGroupId = 3090,
    recordedScore = -1
}


MiniBattleMgr.GetRewards = function(awardId, callback)
    ApiMgr.Request("trainingcamp/getRewards", { AwardId = awardId }, true, callback, nil, true, true);
end

MiniBattleMgr.GetLockMembersAndHelps = function(battleId)
    local members = {};
    local helps = {};
    local curMiniBattleData = MiniBattleMgr.GetCurMiniBattleData()
    if not IsNull(curMiniBattleData) then
        local locks = curMiniBattleData.locks;
        if not IsNull(locks) then
            local lock = locks[battleId];
            if not IsNull(lock) then
                if (not IsNull(lock.helps)) then
                    helps = lock.helps;
                end
                if (not IsNull(lock.members)) then
                    members = lock.members;
                end
            end
        end
    end
    return members, helps
end

MiniBattleMgr.GetTotalScore = function()
    local curMiniBattleData = MiniBattleMgr.GetCurMiniBattleData()
    if (IsNull(curMiniBattleData)) then
        return 0
    end

    local score = curMiniBattleData.score;
    if (IsNull(score)) then
        return 0
    end

    return score
end

MiniBattleMgr.GetDungeonScore = function(dungeonId)
    local curMiniBattleData = MiniBattleMgr.GetCurMiniBattleData()
    if (IsNull(curMiniBattleData)) then
        return 0
    end

    local scores = curMiniBattleData.dungeonScore;
    if (IsNull(scores)) then
        return 0
    end

    local score = scores[dungeonId];
    if (IsNull(score)) then
        return 0
    end
    return score
end

MiniBattleMgr.GetCurMiniBattleData = function()
    if (IsNull(DataMgr.Player.MiniBattles)) then
        return
    end
    local curMiniBattleData = DataMgr.Player.MiniBattles[tostring(MiniBattleMgr.activityGroupId)]
    return curMiniBattleData
end

MiniBattleMgr.GetCurMiniBattleCfg = function(index)
    local ConfigList = {}
    for k, v in pairs(ConfigMgr.Config.MiniBattleMap) do
        if v.ActivityGroup == MiniBattleMgr.activityGroupId then
            table.insert(ConfigList, v)
        end
    end
    table.sort(ConfigList, function(a, b)
        return a.ID < b.ID
    end)
    if index == 1 and #ConfigList > 0 then
        return ConfigList[1]
    elseif index == 2 and #ConfigList > 1 then
        return ConfigList[2]
    end
end