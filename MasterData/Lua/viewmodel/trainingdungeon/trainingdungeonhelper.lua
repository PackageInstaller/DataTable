



TrainingDungeonHelper={}

local dungeonGroupMap = nil
local lastSelectSeriesID = nil

TrainingDungeonHelper.GetChallengeStatus = function(challengeParam, dungeonCount)
    if challengeParam == nil or #challengeParam < 3 then
        return false
    end


    local flag = tonumber(challengeParam[1])
    local t = true
    if flag == 2 then
        t = false
    end

    for i = 1, dungeonCount do
        local challengeCompletes = DataMgr.Player.completedTags[challengeParam[i + 1]] ~= nil
        if flag == 1 then
            t = t and challengeCompletes
        elseif flag == 2 then
            t = t or challengeCompletes
        end
    end

    return t









end

TrainingDungeonHelper.GetChallengeStr = function(challenge, challengeDesc, dungeonCount)
    local str = ""
    for i = 1, #challenge do
        str = str .. challenge[i] .. ","
    end
    str = str .. challengeDesc .. ","
    local challengeStatus = TrainingDungeonHelper.GetChallengeStatus(challenge, dungeonCount) and "1" or "2"
    str = str .. challengeStatus
    return str
end

TrainingDungeonHelper.CheckOpenTime = function()
    local TrainingSeriesOpenTime = ConfigMgr.Config.constants.TrainingSeriesOpen
    if TrainingSeriesOpenTime ~= nil and TrainingSeriesOpenTime - LuaMgr.Timestamp() <= 0 then
        return true
    end
    return false
end

TrainingDungeonHelper.SaveDungeonGroupStatus = function(map)
    dungeonGroupMap = map
end


TrainingDungeonHelper.CheckDungeonGroupUnlockNew = function(newDungeonGroup)
    if dungeonGroupMap == nil or next(dungeonGroupMap) == nil then
        return false
    end
    local oldDungeonGroup = TrainingDungeonHelper.GetOldDungeonGroup(newDungeonGroup)
    if oldDungeonGroup == nil then
        return
    end
    if oldDungeonGroup.islock and not newDungeonGroup.islock then
        return true
    end
    return false
end


TrainingDungeonHelper.CheckDungeonGroupGetStarNew = function(newDungeonGroup)
    if dungeonGroupMap == nil or next(dungeonGroupMap) == nil then
        return 0, 0
    end
    local oldDungeonGroup = TrainingDungeonHelper.GetOldDungeonGroup(newDungeonGroup)
    if oldDungeonGroup == nil then
        return
    end
    if oldDungeonGroup.getStarCount < newDungeonGroup.getStarCount then
        return newDungeonGroup.getStarCount - oldDungeonGroup.getStarCount, oldDungeonGroup.getStarCount
    end
    return 0, 0
end


TrainingDungeonHelper.CheckDungeonGroupGetAllStarNew = function(newDungeonGroup)
    if dungeonGroupMap == nil or next(dungeonGroupMap) == nil then
        return false
    end
    local oldDungeonGroup = TrainingDungeonHelper.GetOldDungeonGroup(newDungeonGroup)
    if oldDungeonGroup == nil then
        return
    end
    if not oldDungeonGroup.isGetAllStar and newDungeonGroup.isGetAllStar then
        return true
    end
    return false
end

TrainingDungeonHelper.GetOldDungeonGroup = function(newDungeonGroup)
    local oldDungeonGroup = nil
    for i = 1, #dungeonGroupMap[newDungeonGroup.seriesId] do
        if dungeonGroupMap[newDungeonGroup.seriesId][i].id == newDungeonGroup.id then
            oldDungeonGroup = dungeonGroupMap[newDungeonGroup.seriesId][i]
            break
        end
    end
    return oldDungeonGroup
end

TrainingDungeonHelper.ClearOldDungeonGroupData = function()
    dungeonGroupMap = nil
end

function TrainingDungeonHelper.IsTraining2Series(trainingGroupId)
    if IsNullOrEmpty(trainingGroupId) then
        return false
    end
    local cfg = ConfigMgr.Config.TrainingSeriesMap[trainingGroupId]
    if cfg ~= nil and cfg.Type == 3 then
        return true
    else
        return false
    end
end

function TrainingDungeonHelper.IsTraining2DungeonGroup(dungeonGroupId)
    if IsNullOrEmpty(dungeonGroupId) then
        return false
    end
    local cfg = ConfigMgr.Config.TrainingCpointMap[dungeonGroupId]
    if cfg ~= nil and TrainingDungeonHelper.IsTraining2Series(cfg.SeriesId) then
        return true
    else
        return false
    end
end

return TrainingDungeonHelper;