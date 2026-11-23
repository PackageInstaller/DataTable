require("ViewModel/XingHaiXuYu/Data/XingHaiConst")
XingHaiData = {}

XingHaiData.CheckActivityRunning = function(actKey)
    if not DataExHelper.CommonActivityCheck(ActivityKey.NewCelebration) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return false
    end
    return true
end

XingHaiData.GetRemainTimeStr = function()
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.NewCelebration)
    local time = activityData.expireTime - LuaMgr.Timestamp()
    if time <= 0 then
        return LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_18344")
    end
    local timeStr = ""
    local d, h, m = GetTimeDHM(time)
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"))
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"))
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"))
    end
    return timeStr
end

XingHaiData.GetShopFeedDatas = function()
    if XingHaiData.QuestCelebrationRecharge == nil then
        XingHaiData.QuestCelebrationRecharge = DataExHelper.Check_ConfigQuestEventByText(XingHaiConst.QuestCelebrationRecharge)
    end
    local quests = DataMgr.Player.quests
    local len = #XingHaiData.QuestCelebrationRecharge
    local allDatas = {}
    local totalProgress = 0
    local canGetCount = 0
    for i = 1, len do
        local questConfig = XingHaiData.QuestCelebrationRecharge[i]
        local questData = quests[questConfig.id]
        local data = {}
        data.config = questConfig
        data.rewards = questConfig.showReward
        data.goalProgress = questConfig.progress
        data.status = questData and questData.state or (CommonRewardItem.Status.None + 1)
        data.questData = questData
        if data.status > 1 then
            totalProgress = totalProgress + 1
        end
        if (data.status - 1) == CommonRewardItem.Status.CanGet then
            canGetCount = canGetCount + 1
        end
        table.insert(allDatas, data)
    end
    return allDatas, totalProgress, canGetCount
end


XingHaiData.GetPassData = function()
    XingHaiData.cfgThemePass = {}
    XingHaiData.allRewardDatas = {}

    for i, v in pairs(DataMgr.Player.passesMultiple) do
        if ConfigMgr.Config.PassesMap[v.id].type == 4 then
            XingHaiData.cfgThemePass = ConfigMgr.Config.PassesMap[v.id]
            XingHaiData.dataPasses = v
            break
        end
    end

    local allTaskDatas = {}
    if XingHaiData.cfgThemePass.Id then
        local missions = DataMgr.Player.passesMissionsMultiple[XingHaiData.cfgThemePass.Id]
        if missions then
            allTaskDatas = missions.period
        end
    end
    if not IsNull(XingHaiData.cfgThemePass.Charge1) and #XingHaiData.cfgThemePass.Charge1 > 0 then
        XingHaiData.chargeId = XingHaiData.cfgThemePass.Charge1[1]
    end

    local isBuyHeighPass = not IsNull(XingHaiData.dataPasses) and XingHaiData.dataPasses.payRecord[XingHaiData.chargeId] ~= nil
    local haveCanGetReward = false
    if XingHaiData.cfgThemePass.Id ~= nil and type(DataMgr.Player.passesRewardsMultiple) == "table" and type(DataMgr.Player.passesRewardsMultiple[XingHaiData.cfgThemePass.Id]) == "table" then
        local curTime = LuaMgr.Timestamp()
        for i, v in pairs(DataMgr.Player.passesRewardsMultiple[XingHaiData.cfgThemePass.Id]) do
            local data = {}
            data.rewardData = ConfigMgr.Config.PassesRewardMap[v.id]
            data.Id = data.rewardData.Id
            local taskData = allTaskDatas[data.rewardData.TaskId]
            data.normalStatus = CommonRewardItem.Status.None
            data.heighStatus = isBuyHeighPass and CommonRewardItem.Status.None or CommonRewardItem.Status.Lock
            if type(taskData) == "table" then
                if taskData.completed then
                    if v.freeReceiveTime == 0 then
                        data.normalStatus = CommonRewardItem.Status.CanGet
                        haveCanGetReward = true
                    else
                        data.normalStatus = CommonRewardItem.Status.Got
                    end
                else
                    data.normalStatus = CommonRewardItem.Status.Lock
                end
                if isBuyHeighPass == true then
                    if taskData.completed then
                        if v.payReceiveTime == 0 then
                            data.heighStatus = CommonRewardItem.Status.CanGet
                            haveCanGetReward = true
                        else
                            data.heighStatus = CommonRewardItem.Status.Got
                        end
                    else
                        data.heighStatus = CommonRewardItem.Status.Lock
                    end
                end
            end
            table.insert(XingHaiData.allRewardDatas, data)
        end
    end
    local func = function(a, b)
        return a.Id < b.Id
    end
    table.sort(XingHaiData.allRewardDatas, func)
    local data = {
        dataPasses = XingHaiData.dataPasses,
        allRewardDatas = XingHaiData.allRewardDatas,
        chargeId = XingHaiData.chargeId,
        cfgThemePass = XingHaiData.cfgThemePass,
        isBuyHeighPass = isBuyHeighPass,
        haveCanGetReward = haveCanGetReward
    }
    return data
end

XingHaiData.TongXingFreeReward = function()
    if XingHaiData.QuestCelebrationFree == nil then
        XingHaiData.QuestCelebrationFree = DataExHelper.Check_ConfigQuestEventByText(XingHaiConst.CelebrationFree)
    end
    local quests = DataMgr.Player.quests
    local questConfig = XingHaiData.QuestCelebrationFree[1]
    local questData = quests[questConfig.id]
    local data = {}
    data.config = questConfig
    data.rewards = questConfig.showReward
    data.goalProgress = questConfig.progress
    data.status = questData and questData.state or (CommonRewardItem.Status.None + 1)
    data.questData = questData
    if (data.status - 1) == CommonRewardItem.Status.Got then
        return true, data
    end
    return false, data
end


XingHaiData.PlaySound = function(name)
    local path = string.format("%sDaQin/%s.mp3", Path.audio_PATH, name)
    AudioMgr.Singleton:PlayUISFX(path)
end

XingHaiData.CheckEnoughXingZhiCehuiItem = function()
    local needItem = ConfigMgr.Config.BangGameConstants["BangCost"][1]
    local needCount = needItem.count
    local ownerCount = PlayerItemMgr.GetItemCountById(needItem.id)
    return ownerCount >= needCount
end

XingHaiData.GetXingZhiCeHuiData = function()
    local curScore = DataMgr.Player.BumperGame.Progress
    local goalScore = ConfigMgr.Config.BangGameConstants["RandomNeed"][1].count
    local curGotNum = DataMgr.Player.BumperGame.DailyUseCount or 0
    local maxGotNum = ConfigMgr.Config.constants.RandomGiftLimit
    local canGet = curScore >= goalScore and curGotNum < maxGotNum
    local data = {
        curScore = curScore,
        goalScore = goalScore,
        canGet = canGet
    }
    return data
end

XingHaiData.SaveCeHuiPlayerPrefs = function(isOn)
    if XingHaiData.randomAwardArchivesKey == nil then
        XingHaiData.randomAwardArchivesKey = DataMgr.Player.uid .. "XINGHAIXUYU_CEHUI_TOGGLE"
    end
    PlayerPrefs.SetInt(XingHaiData.randomAwardArchivesKey, isOn == true and 1 or 0)
    PlayerPrefs.Save()
end

XingHaiData.GetCeHuiPlayerPrefs = function()
    if XingHaiData.randomAwardArchivesKey == nil then
        XingHaiData.randomAwardArchivesKey = DataMgr.Player.uid .. "XINGHAIXUYU_CEHUI_TOGGLE"
    end
    return PlayerPrefs.GetInt(XingHaiData.randomAwardArchivesKey) == 1
end



XingHaiData.RedType = {
    ShangTingHuiKui = "16880",
    ShiJianShaLou = "16881",
    XingZhiCeHui_Reward = "16882",
    XingZhiCeHui_Home = "16883",
    LiangChenYuanJing = "16884",
    TongXingZhiYuan = "16885"
}

XingHaiData.CheckRed = function()
    local _, __, shangTingHuiKuiNum = XingHaiData.GetShopFeedDatas()
    local redNum1 = shangTingHuiKuiNum
    RedMgr.Singleton:UpdateClientRedData(XingHaiData.RedType.ShangTingHuiKui, redNum1)

    local passData = XingHaiData.GetPassData()
    local redNum2 = passData.haveCanGetReward == true and 1 or 0
    RedMgr.Singleton:UpdateClientRedData(XingHaiData.RedType.ShiJianShaLou, redNum2)

    local xingzhicehuiData = XingHaiData.GetXingZhiCeHuiData()
    local redNum3 = xingzhicehuiData.canGet == true and 1 or 0
    RedMgr.Singleton:UpdateClientRedData(XingHaiData.RedType.XingZhiCeHui_Reward, redNum3)

    local redNum4 = 0
    if RedMgr.Singleton:CheckRedCondition(XingHaiData.RedType.XingZhiCeHui_Home) and XingHaiData.CheckEnoughXingZhiCehuiItem() == true then
        redNum4 = 1
    end
    RedMgr.Singleton:UpdateClientRedData(XingHaiData.RedType.XingZhiCeHui_Home, redNum3 + redNum4)

    local isGot, _ = XingHaiData.TongXingFreeReward()
    local redNum5 = 0
    if isGot == false then
        redNum5 = 1
        RedMgr.Singleton:UpdateClientRedData(XingHaiData.RedType.TongXingZhiYuan, 1)
    else
        RedMgr.Singleton:UpdateClientRedData(XingHaiData.RedType.TongXingZhiYuan, 0)
    end
    
    local redNum6 = HeroRedDataHelper.GetTurnOverMissionRed()
    RedMgr.Singleton:UpdateClientRedData(XingHaiData.RedType.LiangChenYuanJing, redNum6)

    return redNum1 + redNum2 + redNum3 + redNum4 + redNum5 + redNum6
end

