CrisisContract2Mgr = {}

local this = {
selectMembers = {},
assistMembers = {},
    curBattleScore = 0,
    PlayerPrefsKey = "",
    SavedContractPlotRecords = nil,
    SavedContractPlotCount = 0,
};

CrisisContract2Mgr.GetPlotConfig = function(plotId)
    local config = nil
    local contractPlotCfgs = ConfigMgr.Config.ContractPlots
    for i, v in ipairs(contractPlotCfgs) do
        if v.Id == plotId then
            config = v
            break
        end
    end
    return config
end

CrisisContract2Mgr.GetBuffGroupConfig = function(groupId)
    local config = nil
    local contractBuffCfg = ConfigMgr.Config.ContractBuffs
    for i, v in ipairs(contractBuffCfg) do
        if v.Id == groupId then
            config = v
            break
        end
    end
    return config
end

CrisisContract2Mgr.GetCurPlotScore = function(plotId)
    if IsNull(DataMgr.Player.contractPlotRecords) or IsNull(DataMgr.Player.contractPlotRecords[plotId]) then
        return 0
    end
    return DataMgr.Player.contractPlotRecords[plotId].maxCredit
end

CrisisContract2Mgr.GetHistoryPlotScore = function(plotId)
    if IsNull(this.SavedContractPlotRecords) or IsNull(this.SavedContractPlotRecords[plotId]) then
        return 0
    end
    return this.SavedContractPlotRecords[plotId].maxCredit
end

CrisisContract2Mgr.SavePlotScore = function(score)
    this.curBattleScore = score
    this.SavedContractPlotRecords = table.Copy(DataMgr.Player.contractPlotRecords)
    this.SavedContractPlotCount = DataMgr.Player.contractPlotCount
end

CrisisContract2Mgr.GetThisTimePlotScore = function()
    return this.curBattleScore
end

CrisisContract2Mgr.IsShowNoBattleCountTips = function()
    local leftTimes = ConfigMgr.Config.constants.ContractLimit - this.SavedContractPlotCount
    return leftTimes <= 0
end

CrisisContract2Mgr.GetTotalScore = function()
    if IsNull(DataMgr.Player.contractPlotTotalCredit) then
        return 0
    end

    return DataMgr.Player.contractPlotTotalCredit
end

CrisisContract2Mgr.GetDungeonUnlockTime = function(plotId)
    local startTime = 0
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.crisiscontract2)
    if activityData ~= nil then
        startTime = activityData.startTime
    end
    local cfg = CrisisContract2Mgr.GetPlotConfig(plotId)
    if TableIsNull(cfg) then
        return 0
    end
    local delayTime = cfg.Delay * 24 * 60 * 60
    local leftTime = startTime + delayTime
    return leftTime
end

CrisisContract2Mgr.CheckDungeonRewardRed = function()
    local redCount = 0
    local contractPlotCfgs = ConfigMgr.Config.ContractPlots
    for i, v in ipairs(contractPlotCfgs) do
        if CrisisContract2Mgr.CheckDungeonRewardRedByCfg(v) then
            redCount = 1
            break
        end
    end
    return redCount
end

CrisisContract2Mgr.CheckDungeonRewardRedByPlotId = function(plotId)
    local plotCfg = CrisisContract2Mgr.GetPlotConfig(plotId)
    return CrisisContract2Mgr.CheckDungeonRewardRedByCfg(plotCfg)
end

CrisisContract2Mgr.CheckDungeonRewardRedByCfg = function(plotCfg)
    local curScore = CrisisContract2Mgr.GetCurPlotScore(plotCfg.Id)
    local creditList = plotCfg.Credit
    for i, v in ipairs(creditList) do
        if curScore >= v then
            local key = string.format("%s_%s", plotCfg.Id, v)
            local isFinished = CrisisContract2Mgr.CheckDungeonRewardIsDown(key)
            if not isFinished then
                return true
            end
        end
    end
    return false
end

CrisisContract2Mgr.CheckDungeonRewardIsDown = function(key)
    if IsNull(DataMgr.Player.contractPlotRewards) or IsNull(DataMgr.Player.contractPlotRewards[key]) then
        return false
    end
    return DataMgr.Player.contractPlotRewards[key] ~= nil
end

CrisisContract2Mgr.GetAllBuffListByPlotId = function(plotId)
    local enemyBuff = {}
    local selfBuff = {}
    local contractPlotCfg = CrisisContract2Mgr.GetPlotConfig(plotId)
    if contractPlotCfg ~= nil then
        for i, v in ipairs(contractPlotCfg.EnemyOption) do
            local buffItem = {
                Id = v,
                Level = 0,
                MaxLevel = CrisisContract2Mgr.GetBuffMaxLevel(v),
                BuffInfo = CrisisContract2Mgr.GetBuffInfoByLevel(v, 0)
            }
            if not TableIsNull(buffItem.BuffInfo) then
                table.insert(enemyBuff, buffItem)
            end
        end
        for i, v in ipairs(contractPlotCfg.SelfOption) do
            local buffItem = {
                Id = v,
                Level = 0,
                MaxLevel = CrisisContract2Mgr.GetBuffMaxLevel(v),
                BuffInfo = CrisisContract2Mgr.GetBuffInfoByLevel(v, 0)
            }
            if not TableIsNull(buffItem.BuffInfo) then
                table.insert(selfBuff, buffItem)
            end
        end
    end
    return enemyBuff, selfBuff
end

CrisisContract2Mgr.GetChooseBuffListByPlotId = function(plotId)
    if IsNullOrEmpty(this.PlayerPrefsKey) then
        this.PlayerPrefsKey = "ContractPlotBuffs" .. DataMgr.Player.uid
    end
    local buffListStr = PlayerPrefs.GetString(this.PlayerPrefsKey .. plotId, "")

    local selfBuff = {}
    local enemyBuff = {}
    if not IsNullOrEmpty(buffListStr) then
        local list = NumTool.split(buffListStr, ";");
        if #list > 0 then
            selfBuff = CrisisContract2Mgr.DecodeBuffStr(list[1])
        end
        if #list > 1 then
            enemyBuff = CrisisContract2Mgr.DecodeBuffStr(list[2])
        end
    end
    return selfBuff, enemyBuff
end

CrisisContract2Mgr.DecodeBuffStr = function(buffStr)
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
                MaxLevel = CrisisContract2Mgr.GetBuffMaxLevel(id),
                BuffInfo = CrisisContract2Mgr.GetBuffInfoByLevel(id, level)
            }
            table.insert(buffList, buffItem)
        end
    end
    return buffList
end

CrisisContract2Mgr.EncodeBuffStr = function(buffList)
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

CrisisContract2Mgr.SaveChooseBuffList = function(plotId, enemyBuff, selfBuff)
    local selfBuffStr = CrisisContract2Mgr.EncodeBuffStr(selfBuff)
    local enemyBuffStr = CrisisContract2Mgr.EncodeBuffStr(enemyBuff)
    local buffListStr = string.format("%s;%s", selfBuffStr, enemyBuffStr)
    PlayerPrefs.SetString(this.PlayerPrefsKey .. plotId, buffListStr)
    PlayerPrefs.Save()
end

CrisisContract2Mgr.GetBuffInfoByLevel = function(buffGroupId, level)
    local buffInfo = nil
    local contractBuffCfg = CrisisContract2Mgr.GetBuffGroupConfig(buffGroupId)
    if contractBuffCfg ~= nil then
        local tempLevel = level == 0 and 1 or level
        local buffId = contractBuffCfg.GroupBuff[tempLevel]
        buffInfo = CrisisContract2Mgr.GetBuffGroupNameAndDesc(buffId)
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

CrisisContract2Mgr.GetBuffGroupNameAndDesc = function(buffId)
    local re = {
        BuffId = buffId,
        Icon = DefaultSprite,
        Desc = "",
        Name = "",
    }
    local buffGroupCfgs = ConfigMgr.Config.ContractBuffDesc
    for i, v in ipairs(buffGroupCfgs) do
        if v.BuffId == buffId then
            re.Icon = LuaMgr.GetSprite("BuffIcon", v.BuffIcon)
            re.Desc = LuaMgr.GetLangText(v.BuffDesLan)
            re.Name = LuaMgr.GetLangText(v.BuffNameLan);
        end
    end
    return re
end

CrisisContract2Mgr.GetBuffMaxLevel = function(buffGroupId)
    local maxLevel = 0
    local contractBuffCfg = CrisisContract2Mgr.GetBuffGroupConfig(buffGroupId)
    if contractBuffCfg ~= nil then
        maxLevel = contractBuffCfg.Initial
    end
    return maxLevel
end



CrisisContract2Mgr.GetRewards = function(awardIds, callback)
    ApiMgr.Request("contract_plot/get_rewards", { rewardIds = awardIds }, true, callback, nil, true, true);
end

CrisisContract2Mgr.GetLockMembersAndHelps = function(plotId)
    local members = {};
    local helps = {};
    local plotRecords = DataMgr.Player.contractPlotRecords
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

CrisisContract2Mgr.GetAnotherPlotId = function(plotId)
    local anotherPlotId = ""
    local plotCfg = CrisisContract2Mgr.GetPlotConfig(plotId)
    if TableIsNull(plotCfg) then
        return anotherPlotId
    end
    local seriesid = plotCfg.SeriesId
    local contractPlotCfgs = ConfigMgr.Config.ContractPlots
    for i, v in ipairs(contractPlotCfgs) do
        if v.SeriesId == seriesid and v.Id ~= plotCfg.Id then
            anotherPlotId = v.Id
            break
        end
    end
    return anotherPlotId
end

CrisisContract2Mgr.GetLeftTimeStr = function(time)
    local day, hour, minute = GetTimeDHM(time)
    local timeStr = ""
    if IsNullOrEmpty(day) then
        timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10209"].NameLan), hour, minute)
    else
        timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10208"].NameLan), day, hour)
    end
    return timeStr
end

CrisisContract2Mgr.GetPlotIndex = function(plotId)
    local indexStr = ""
    local contractPlotCfgs = ConfigMgr.Config.ContractPlots
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

CrisisContract2Mgr.GetMedalList = function()
    local medalConfigs = ConfigMgr.Config.Medals
    local tempList = {}
    for k, v in pairs(medalConfigs) do
        if v.Activity == "4005" then
            local item = {
                icon = LuaMgr.GetSprite("ZhanXunIcon", v.Id),
                name = LuaMgr.GetLangText(v.NameLan),
                desc = LuaMgr.GetLangText(v.DesLan),
                remark = LuaMgr.GetLangText(v.RemarksLan),
                target = 0
            }
            if not TableIsNull(v.Condition) and not TableIsNull(v.Condition[1]) and v.Condition[1].UnlockType == 101 then
                item.target = tonumber(v.Condition[1].ElementID)
            end
            table.insert(tempList, item)
        end
    end
    return tempList
end