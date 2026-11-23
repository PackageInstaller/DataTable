require("Waterlily/WaterlilyConst")
PlayerWaterlilyMgr = {}

local this = {
isInit = false,
levelType = 0,
bPlay = false,
};

PlayerWaterlilyMgr.Init = function()
    if (this.isInit) then return end
    this.isInit = true;
end

PlayerWaterlilyMgr.Clear = function()
    this.isInit = false;
end


PlayerWaterlilyMgr.GetGameRewardsData = function()
    if not IsNull(DataMgr.Player.AnswerQuestion) and not IsNull(DataMgr.Player.AnswerQuestion.AnswerRewards) then
        return DataMgr.Player.AnswerQuestion.AnswerRewards
    else
        return {}
    end
end

PlayerWaterlilyMgr.Answer = function(_id,_answer)
    ApiMgr.Request("answerQuestion/answer", {Id = _id, Answer = tostring(_answer)}, true, this.AnswerResponse, nil, true, true);
end

this.AnswerResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        LuaMgr.InvokeUIEventListeners(UIEventConst.ZGCXMsgShow, data.result.Items);
    end
end

PlayerWaterlilyMgr.CheckFinish = function(_config)
    local isFinish = false
    if (_config.type == WaterlilyLevel2NumType.Fushua or _config.type == WaterlilyLevel2NumType.MainLine or _config.type == WaterlilyLevel2NumType.Hard) then
        local record = DataMgr.Player.dungeonRecords[_config.eventParam];
        if (record ~= nil and record.completeCount > 0) then
            isFinish = true
        end
    elseif (_config.type == WaterlilyLevel2NumType.Juqing) then
        isFinish = DataHelper.CheckNovelComplete(_config.id);
    else
        local rewardData = PlayerWaterlilyMgr.GetGameRewardsData();
        if (rewardData ~= nil and rewardData[_config.eventParam] ~= nil) then
            isFinish = true
        end
    end
    return isFinish
end

PlayerWaterlilyMgr.CheckUnlock = function(_config)
    if _config.unlockParam == nil or _config.unlockParam == "" then
        return true
    end
    local isUnlock = false
    if (_config.type == WaterlilyLevel2NumType.Fushua or _config.type == WaterlilyLevel2NumType.MainLine or _config.type == WaterlilyLevel2NumType.Hard) then
        local record = DataMgr.Player.dungeonRecords[_config.unlockParam];
        if (record ~= nil and record.completeCount > 0) then
            isUnlock = true
        end
    elseif (_config.type == WaterlilyLevel2NumType.Juqing) then
        isUnlock = DataHelper.CheckNovelComplete(_config.unlockParam);
    else
        local rewardData = PlayerWaterlilyMgr.GetGameRewardsData();
        if (rewardData ~= nil and rewardData[_config.unlockParam] ~= nil) then
            isUnlock = true
        end
    end
    return isUnlock
end


PlayerWaterlilyMgr.SetPlayerAnimation = function(_bPlay)
    this.bPlay = _bPlay
end

PlayerWaterlilyMgr.GetPlayerAnimation = function()
    return this.bPlay
end

PlayerWaterlilyMgr.SetSelectedType = function(_type)
    this.selectedType = _type
end

PlayerWaterlilyMgr.GetSelectedType = function()
    return this.selectedType
end

PlayerWaterlilyMgr.SetCurTap = function(_tap)
    this.curTap = _tap
end

PlayerWaterlilyMgr.GetCurTap = function()
    return this.curTap
end

PlayerWaterlilyMgr.SetChallengeLastPaget = function (page)
    PlayerWaterlilyMgr.challengeLastPage = page
end

PlayerWaterlilyMgr.GetChallengeLastPaget = function ()
    return PlayerWaterlilyMgr.challengeLastPage
end



PlayerWaterlilyMgr.CheckEntranceRedDot = function()
    local bStory = PlayerWaterlilyMgr.CheckTaskRedDot()
    if bStory then
        return 1
    else
        return 0
    end
end

PlayerWaterlilyMgr.CheckTaskRedDot = function()
    local existRed = false
    for key, value in pairs(WaterlilyConst.DaliyTipRedID) do
        if RedMgr.Singleton:CheckRedCondition(value) then
            local redNum = PlayerWaterlilyMgr.CheckGuessAllFinishRedNum(value)
            RedMgr.Singleton:UpdateClientRedData(value, redNum)
            if redNum > 0 then
                existRed = true
            end
        end
    end
    return existRed
end

PlayerWaterlilyMgr.CheckGuessAllFinishRedNum = function(redID)
    local groupType = WaterlilyLevelType.Repeat
    local groupID = ""
    if redID == WaterlilyConst.DaliyTipRedID.Guess then
        groupType = WaterlilyLevelType.Repeat
        groupID = "40803"
    elseif redID == WaterlilyConst.DaliyTipRedID.Level then
        groupType = WaterlilyLevelType.Main
    elseif redID == WaterlilyConst.DaliyTipRedID.SandTable then
        groupType = WaterlilyLevelType.Repeat
        groupID = "40801"
    end
    local configList = nil
    if groupID == "" then
        configList = DataExHelper.EX_GetEventListByArea(groupType)
    else
        local configListGroup = DataExHelper.EX_GetEventMapByArea(groupType)
        configList = configListGroup[groupID]
    end
    local isAllFinish = false
    if configList ~= nil then
        isAllFinish = true
        for key, config in pairs(configList) do
            local isFinish = PlayerWaterlilyMgr.CheckFinish(config)
            if isFinish == false then
                isAllFinish = false
                break
            end
        end
    end
    return isAllFinish == true and 0 or 1
end


