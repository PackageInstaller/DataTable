CrisisContract3Mgr = {}

local this = {
selectMembers = {},
assistMembers = {},

    curBattleScore = 0,
    PlayerPrefsKey = "",
    SavedContractPlotRecords = nil,
    SavedContractPlotCount = 0,
};

CrisisContract3Mgr.GetPlotConfig = function(plotId)
    local config = nil
    local contractPlotCfgs = ConfigMgr.Config.Contract3Plots
    for i, v in ipairs(contractPlotCfgs) do
        if v.Id == plotId then
            config = v
            break
        end
    end
    return config
end

CrisisContract3Mgr.GetBuffGroupConfig = function(groupId)
    local config = nil
    local contractBuffCfg = ConfigMgr.Config.Contract3Buffs
    for i, v in ipairs(contractBuffCfg) do
        if v.Id == groupId then
            config = v
            break
        end
    end
    return config
end

CrisisContract3Mgr.GetCurPlotScore = function(plotId)
    if IsNull(DataMgr.Player.contract3Plot.contractNewPlotRecords) or IsNull(DataMgr.Player.contract3Plot.contractNewPlotRecords[plotId]) then
        return 0
    end
    return DataMgr.Player.contract3Plot.contractNewPlotRecords[plotId].maxCredit
end

CrisisContract3Mgr.GetHistoryPlotScore = function(plotId)
    if IsNull(this.SavedContractPlotRecords) or IsNull(this.SavedContractPlotRecords[plotId]) then
        return 0
    end
    return this.SavedContractPlotRecords[plotId].maxCredit
end

CrisisContract3Mgr.SavePlotScore = function(score)
    this.curBattleScore = score
    this.SavedContractPlotRecords = table.Copy(DataMgr.Player.contract3Plot.contractNewPlotRecords)
    this.SavedContractPlotCount = DataMgr.Player.contract3Plot.contractPlotCount
end

CrisisContract3Mgr.GetThisTimePlotScore = function()
    return this.curBattleScore
end

CrisisContract3Mgr.IsShowNoBattleCountTips = function()
    local leftTimes = ConfigMgr.Config.constants.Contract3Limit - this.SavedContractPlotCount
    return leftTimes <= 0
end

CrisisContract3Mgr.GetTotalScore = function()
    if IsNull(DataMgr.Player.contract3Plot.contractPlotTotalCredit) then
        return 0
    end

    return DataMgr.Player.contract3Plot.contractPlotTotalCredit
end

CrisisContract3Mgr.GetDungeonUnlockTime = function(plotId)
    local startTime = 0
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.crisiscontract3)
    if activityData ~= nil then
        startTime = activityData.startTime
    end
    local cfg = CrisisContract3Mgr.GetPlotConfig(plotId)
    if TableIsNull(cfg) then
        return 0
    end
    local delayTime = cfg.Delay * 24 * 60 * 60
    local leftTime = startTime + delayTime
    return leftTime
end

CrisisContract3Mgr.CheckDungeonRewardRed = function()
    local redCount = 0
    local contractPlotCfgs = ConfigMgr.Config.Contract3Plots
    for i, v in ipairs(contractPlotCfgs) do
        if CrisisContract3Mgr.CheckDungeonRewardRedByCfg(v) then
            redCount = 1
            break
        end
    end
    return redCount
end

CrisisContract3Mgr.CheckDungeonRewardRedByPlotId = function(plotId)
    local plotCfg = CrisisContract3Mgr.GetPlotConfig(plotId)
    return CrisisContract3Mgr.CheckDungeonRewardRedByCfg(plotCfg)
end

CrisisContract3Mgr.CheckDungeonRewardRedByCfg = function(plotCfg)
    local curScore = CrisisContract3Mgr.GetCurPlotScore(plotCfg.Id)
    local creditList = plotCfg.Credit
    for i, v in ipairs(creditList) do
        if curScore >= v then
            local key = string.format("%s_%s", plotCfg.Id, v)
            local isFinished = CrisisContract3Mgr.CheckDungeonRewardIsDown(key)
            if not isFinished then
                return true
            end
        end
    end
    return false
end

CrisisContract3Mgr.CheckDungeonRewardIsDown = function(key)
    if IsNull(DataMgr.Player.contract3Plot.contractNewPlotRewards) or IsNull(DataMgr.Player.contract3Plot.contractNewPlotRewards[key]) then
        return false
    end
    return DataMgr.Player.contract3Plot.contractNewPlotRewards[key] ~= nil
end

CrisisContract3Mgr.GetAllBuffListByPlotId = function(plotId)
    local buffList = {}
    local contractPlotCfg = CrisisContract3Mgr.GetPlotConfig(plotId)
    if contractPlotCfg ~= nil then
        for i, v in ipairs(contractPlotCfg.EnemyOption) do
            local buffItem = {
                Id = v,
                Level = 0,
                MaxLevel = CrisisContract3Mgr.GetBuffMaxLevel(v),
                BuffInfo = CrisisContract3Mgr.GetBuffInfoByLevel(v, 0)
            }
            if not TableIsNull(buffItem.BuffInfo) then
                table.insert(buffList, buffItem)
            end
        end
    end
    return buffList
end

CrisisContract3Mgr.GetChooseBuffListByPlotId = function(plotId)
    if IsNullOrEmpty(this.PlayerPrefsKey) then
        this.PlayerPrefsKey = "Contract3PlotBuffs" .. DataMgr.Player.uid
    end
    local buffListStr = PlayerPrefs.GetString(this.PlayerPrefsKey .. plotId, "")

    local buffList = {}
    if not IsNullOrEmpty(buffListStr) then
        buffList = CrisisContract3Mgr.DecodeBuffStr(buffListStr)
    end
    return buffList
end

CrisisContract3Mgr.DecodeBuffStr = function(buffStr)
    local buffList = {}
    if IsNullOrEmpty(buffStr) then
        return buffList
    end
    local list = NumTool.split(buffStr, ",");
    for i, v in ipairs(list) do
        if not IsNullOrEmpty(v) then
            local buffInfo = NumTool.split(v, "|");
            local id = buffInfo[1]
            local level = tonumber(buffInfo[2])
            local buffItem = {
                Id = id,
                Level = level,
                MaxLevel = CrisisContract3Mgr.GetBuffMaxLevel(id),
                BuffInfo = CrisisContract3Mgr.GetBuffInfoByLevel(id, level)
            }
            table.insert(buffList, buffItem)
        end
    end
    return buffList
end

CrisisContract3Mgr.EncodeBuffStr = function(buffList)
    local buffListStr = ""
    local len = #buffList
    for i, v in ipairs(buffList) do
        if v.Level > 0 then
            local buffStr = string.format("%s|%s", v.Id, v.Level)
            buffListStr = buffListStr .. buffStr .. ","
        end
    end
    return buffListStr
end

CrisisContract3Mgr.SaveChooseBuffList = function(plotId, buffList)
    local buffListStr = CrisisContract3Mgr.EncodeBuffStr(buffList)
    PlayerPrefs.SetString(this.PlayerPrefsKey .. plotId, buffListStr)
    PlayerPrefs.Save()
end

CrisisContract3Mgr.GetBuffInfoByLevel = function(buffGroupId, level)
    local buffInfo = nil
    local contractBuffCfg = CrisisContract3Mgr.GetBuffGroupConfig(buffGroupId)
    if contractBuffCfg ~= nil then
        local tempLevel = level == 0 and 1 or level
        local buffId = contractBuffCfg.GroupBuff[tempLevel]
        buffInfo = CrisisContract3Mgr.GetBuffGroupNameAndDesc(buffId)
        buffInfo.Score = 0
        buffInfo.AttrStr = ""
        if level > 0 then
            buffInfo.Score = contractBuffCfg.Credit[level]
            local addAttrNum = contractBuffCfg.Percentage[level]
            local addAttrType = contractBuffCfg.Type
            if addAttrNum ~= nil then
                buffInfo.AttrStr = tostring(addAttrNum)
                if addAttrType == 2 then
                    buffInfo.AttrStr = buffInfo.AttrStr .. "%"
                end
            end
        end
    end
    return buffInfo
end

CrisisContract3Mgr.GetBuffGroupNameAndDesc = function(buffId)
    local re = {
        BuffId = buffId,
        Icon = DefaultSprite,
        Desc = "",
        Name = "",
    }
    local cfg = CrisisContract3Mgr.GetBuffDescCfg(buffId)
    if cfg ~= nil then
        re.Icon = LuaMgr.GetSprite("BuffIcon", cfg.BuffIcon)
        re.Desc = LuaMgr.GetLangText(cfg.BuffDesLan)
        re.Name = LuaMgr.GetLangText(cfg.BuffNameLan);
    end
    return re
end

CrisisContract3Mgr.GetBuffDescCfg = function(buffId)
    local cfg = nil
    local buffGroupCfgs = ConfigMgr.Config.Contract3BuffDesc
    for i, v in ipairs(buffGroupCfgs) do
        if v.BuffId == buffId then
            cfg = v
            break
        end
    end
    return cfg
end

CrisisContract3Mgr.GetBuffMaxLevel = function(buffGroupId)
    local maxLevel = 0
    local contractBuffCfg = CrisisContract3Mgr.GetBuffGroupConfig(buffGroupId)
    if contractBuffCfg ~= nil then
        maxLevel = contractBuffCfg.Initial
    end
    return maxLevel
end

CrisisContract3Mgr.GetCurScoreDiffAddition = function(curScore)
    local buffReinfMap = ConfigMgr.Config.Contract3BuffReinfMap
    local maxReinf = nil
    for k, v in pairs(buffReinfMap) do
        if curScore >= v.Credit and (maxReinf == nil or maxReinf.Credit < v.Credit) then
            maxReinf = v
        end
    end
    return maxReinf
end



CrisisContract3Mgr.GetRewards = function(awardIds, callback)
    ApiMgr.Request("contract3_plot/get_rewards", { rewardIds = awardIds }, true, callback, nil, true, true);
end

CrisisContract3Mgr.GetLockMembersAndHelps = function(plotId)
    local members = {};
    local helps = {};
    local plotRecords = DataMgr.Player.contract3Plot.contractNewPlotRecords
    if not IsNull(plotRecords) then
        local record = plotRecords[plotId];
        if not IsNull(record) then
            if not IsNull(record.help) then
                helps = record.help;
            end
            if not IsNull(record.members) then
                members = record.members;
            end
        end
    end
    return members, helps
end

CrisisContract3Mgr.GetAnotherPlotId = function(plotId)
    local anotherPlotId = ""
    local plotCfg = CrisisContract3Mgr.GetPlotConfig(plotId)
    if TableIsNull(plotCfg) then
        return anotherPlotId
    end
    local seriesid = plotCfg.SeriesId
    local contractPlotCfgs = ConfigMgr.Config.Contract3Plots
    for i, v in ipairs(contractPlotCfgs) do
        if v.SeriesId == seriesid and v.Id ~= plotCfg.Id then
            anotherPlotId = v.Id
            break
        end
    end
    return anotherPlotId
end

CrisisContract3Mgr.GetLeftTimeStr = function(time)
    local day, hour, minute = GetTimeDHM(time)
    local timeStr = ""
    if IsNullOrEmpty(day) then
        timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10209"].NameLan), hour, minute)
    else
        timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10208"].NameLan), day, hour)
    end
    return timeStr
end

CrisisContract3Mgr.GetPlotIndex = function(plotId)
    local indexStr = ""
    local contractPlotCfgs = ConfigMgr.Config.Contract3Plots
    local len = #contractPlotCfgs
    for i = 1, 10 do
        if contractPlotCfgs[i].Id == plotId then
            if i < 10 then
                indexStr = string.format(LuaMgr.GetLangText("CrisisContract2Mgr_0"), i)
            else
                indexStr = string.format(LuaMgr.GetLangText("CrisisContract2Mgr_1"), i)
            end
        end
    end
    return indexStr
end

CrisisContract3Mgr.GetMedalList = function()
    local medalConfigs = ConfigMgr.Config.Medals
    local tempList = {}
    for k, v in pairs(medalConfigs) do
        if v.Activity == "4006" then
            local item = {
                icon = LuaMgr.GetSprite("ZhanXunIcon", v.Id),
                name = LuaMgr.GetLangText(v.NameLan),
                desc = LuaMgr.GetLangText(v.DesLan),
                remark = LuaMgr.GetLangText(v.RemarksLan),
                target = 0
            }
            if not TableIsNull(v.Condition) and not TableIsNull(v.Condition[1]) and v.Condition[1].UnlockType == 110 then
                item.target = tonumber(v.Condition[1].ElementID)
            end
            table.insert(tempList, item)
        end
    end
    return tempList
end