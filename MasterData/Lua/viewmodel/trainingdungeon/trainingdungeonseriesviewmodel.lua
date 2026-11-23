

if TrainingDungeonHelper==nil then
    require("ViewModel/TrainingDungeon/TrainingDungeonHelper")
end

local color1 = UnityEngine.Color(38/255.0,36/255.0,41/255.0,1)
local color2 = UnityEngine.Color(89/255.0,90/255.0,90/255.0,1)

local this = {
    vm=nil,
    data= {
        dungeonGroupMap = {},
        curSeriesType = 1,
        curSelectSeriesID = "",
        seriesUnlockTipsMap = {},

        norList = nil,
        specialList = nil,
        
        seriesAnimIndex = 0,
        dungeonGroupAnimIndex = 0,

        goDungeonGroupContent = nil,
        
        newDungeonGroupIndex = nil,

        allGetStarCount = nil,
        allCanGetStarCount = nil,
        
        debugUnlockAll = false,
        
        dungeonGroupDesc = "",
        dungeonGroupDescIndex = 0,
        dungeonGroupDescLength = 0,
        
        endTime = 0,
        
        isShowEffect = {},
    },
    goSeriesContentTr = nil,
};

local data = {
    seriesNorActive = false,
    seriesNorList = {{id = "", title = "", titleColor = color2, lock = false, select = false, animationName = "", showTime1 = false, showTime2 = false}},
    seriesSpecialActive = false,
    seriesSpecialList = {{id = "", title = "", titleColor = color2, lock = false, select = false, animationName = "", showTime1 = false, showTime2 = false}},
    dungeonGroupName_1 = "", 
    dungeonGroupName_2 = "",
    dungeonGroupDesc = "",
    dungeonGroupList = {{ id = "", seriesId = "", name = "",  numStr = "", animationName = "", bgImg = DefaultSprite,
                          getStar_1 = false, getStar_2 = false, getStar_3 = false,
                          getStarEff_1 = false, getStarEff_2 = false, getStarEff_3 = false,
                          isNewUnlock = false, lockEffect = false, islock = false,
                          isNewGetAll = false, getAllEffect = false, isGetAllStar = false,
                          getStarCount = 0, newGetStarCount = 0, isPass = false, 
                          showEffect_zhong = false, 
                        }},
    rewardProcessStr = "",
    dungeonGroupAlpha = 0.0,
    showRewardRed = false,
    debugBtnActive = false,
    timerText = "",
}

local command = {
    seriesTypeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index = tonumber(param)
            if this.data.curSeriesType == index then
                return
            end
            if index == 2 and #this.data.specialList <= 0 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrainingDungeonSeriesViewModel_3"))
                return
            end
            
            this.data.curSeriesType = index
            this.vm.data.seriesNorActive = this.data.curSeriesType == 1
            this.vm.data.seriesSpecialActive = this.data.curSeriesType == 2 or this.data.curSeriesType == 3

            if this.vm.data.seriesSpecialActive then
                this.data.curSelectSeriesID = this.vm.data.seriesSpecialList[1].id
            elseif this.vm.data.seriesNorActive then
                this.data.curSelectSeriesID = this.vm.data.seriesNorList[1].id
            end
            
            this.SwitchSeries(true)
        end
    },
    subSeriesBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index = tonumber(param) + 1
            local seriesId = ""
            if this.data.curSeriesType == 1 then
                seriesId = this.data.norList[index].id
            elseif this.data.curSeriesType == 2 or this.data.curSeriesType == 3 then
                seriesId = this.data.specialList[index].id
            end
            local tipStr = this.data.seriesUnlockTipsMap[seriesId]
            if not IsNullOrEmpty(tipStr) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr);
                return
            end
            if seriesId == this.data.curSelectSeriesID then
                return
            end
            this.data.curSelectSeriesID = seriesId
            this.SwitchSeries(true)
        end
    },
    dungeonGroupItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index = tonumber(param) + 1
            if this.vm.data.dungeonGroupList[index].islock then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrainingDungeonSeriesViewModel_0"));
                return
            end
            local dungeonGroupId = this.data.dungeonGroupMap[this.data.curSelectSeriesID][index].id
            LuaMgr.ShowLuaPanel(UIName.TrainingDungeonViewModel, dungeonGroupId)
            TrainingDungeonHelper.SaveDungeonGroupStatus(this.data.dungeonGroupMap)
        end
    },
    rewardBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.TrainingRewardPopupViewModel, this.data.curSelectSeriesID, this.MoveDungeonListToIndex)
        end
    },
    shopBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            FeatureManager.GotoPanel("3301");
        end
    },
    debugBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if LuaMgr.IsDebug() then
                this.data.debugUnlockAll = true
                this.Refresh()
            end
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm=vm
        this.goSeriesContentTr = vm.behaviour.transform:Find("root/Middle/seriesType/SeriesScrollView/Viewport/goSeriesContent"):GetComponent("RectTransform")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if this.vm.behaviour.Params.Length > 0 then
            TrainingDungeonHelper.lastSelectSeriesID = this.vm.behaviour.Params[0]
        end
        this.Init()
        this.Refresh()
        PlayerAssistMgr.UpdateFriendList2();
        LuaMgr.AddTimer(TimerConst.TrainingDungeonSeriesLeftTime, this.UpdateTimer, 1, -1, true);
        LuaMgr.RemoveUIEventListener(UIEventConst.TrainingGetReward, this.RefreshRewardRed);
        LuaMgr.AddUIEventListener(UIEventConst.TrainingGetReward, this.RefreshRewardRed);
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveTimer(TimerConst.TrainingDungeonSeriesMoveTo)
        LuaMgr.RemoveTimer(TimerConst.TrainingDungeonSeriesGroupItemShow)
        LuaMgr.RemoveTimer(TimerConst.TrainingDungeonSeriesTypeShow)
        LuaMgr.RemoveTimer(TimerConst.TrainingDungeonSeriesGroupItemEffectShow)
        LuaMgr.RemoveTimer(TimerConst.TrainingDungeonSeriesGroupItemEffectShowEnd)
        LuaMgr.RemoveTimer(TimerConst.TrainingDungeonSeriesLeftTime)
        LuaMgr.RemoveUIEventListener(UIEventConst.TrainingGetReward, this.RefreshRewardRed);
        this.data.curSelectSeriesID = ""
        HeroParameter.EmptyBattlePrepareParam()
        HeroParameter.EmptyTrainingParam()
    end,
    before_destroy=function(vm)
        this.data=nil;
    end
}

this.Init = function()
    if this.data.goDungeonGroupContent == nil then
        local uiLink = this.vm.behaviour.gameObject:GetComponent("UILink");
        this.data.goDungeonGroupContent = uiLink:Get("goDungeonGroupContent"):GetComponent("RectTransform")
    end
end

this.Refresh = function()
    this.SetSeriesDungeonGroupList()
    this.SetSeriesList()
    this.SwitchSeries(false)
    this.CheckReconnect()
    this.RefreshRewardRed()

    this.vm.data.debugBtnActive = LuaMgr.IsDebug()
end

this.SetSeriesList = function()
    this.CheckSeriesUnlock()
    this.data.norList = {}
    this.data.specialList = {}
    local cfgTrainingSeries = ConfigMgr.Config.TrainingSeriesMap
    local cfgTrainingDungeonGroups = ConfigMgr.Config.TrainingCpointMap
    local completedAreaEvents = DataMgr.Player.completedAreaEvents

    for k, seriesCfg in pairs(cfgTrainingSeries) do
    local curTimestamp = LuaMgr.Timestamp();
        local endTimeStatus = seriesCfg.EndTime > curTimestamp
        if seriesCfg.EndTime == 0 then
            endTimeStatus = true
        end
        if seriesCfg.OpenTime < curTimestamp and endTimeStatus then
            local seriesItem = {
                id = seriesCfg.Id,
                title = LuaMgr.GetLangText(seriesCfg.NameLan),
                lock = this.data.seriesUnlockTipsMap[seriesCfg.Id] ~= nil,
                select = false,
                color = color2;
                dungeonList = {},
                animationName = "ani_goSeriesSpecialItem_002",
                showTime1 = false,
                showTime2 = false,
            }
            
            if seriesCfg.Type == 1 then
                table.insert(this.data.norList, seriesItem)
            elseif seriesCfg.Type == 2 or seriesCfg.Type == 3 then
                local leftTime = seriesCfg.EndTime - curTimestamp
                local showTime1 = leftTime >= 7 * 24 * 60* 60
                seriesItem.showTime1 = showTime1
                seriesItem.showTime2 = not showTime1
                table.insert(this.data.specialList, seriesItem)
            end
        end
    end
    table.sort(this.data.norList, function(a, b) return a.id < b.id end)
    table.sort(this.data.specialList, function(a, b) return a.id < b.id end)
    this.vm.data.seriesNorList = this.data.norList
    this.vm.data.seriesSpecialList = this.data.specialList
end

this.SetSeriesDungeonGroupList = function()
    local cfgTrainingDungeonGroups = ConfigMgr.Config.TrainingCpointMap
    local trainingRecords = DataMgr.Player.TrainingRecords
    local tempDungeonGroupMap = {}
    for k, dungeonGroupCfg in pairs(cfgTrainingDungeonGroups) do
        local seriesId = dungeonGroupCfg.SeriesId
        if tempDungeonGroupMap[seriesId] == nil then
            tempDungeonGroupMap[seriesId] = {}
        end

        local getStarCount = 0
        if trainingRecords[k] ~= nil then
            getStarCount = trainingRecords[k].StarCount
        end

        local dungeonGroupItem = {
            id = dungeonGroupCfg.Id,
            seriesId = seriesId,
            name = LuaMgr.GetLangText(dungeonGroupCfg.NameLan),
            numStr = "0",
            animationName = "ani_goDungeonGroupItem_002",
            getStar_1 = getStarCount >= 1,
            getStar_2 = getStarCount >= 2,
            getStar_3 = getStarCount >= 3,
            getStarEff_1 = false,
            getStarEff_2 = false,
            getStarEff_3 = false,
            isNewUnlock = false,
            lockEffect = false,
            islock = false,
            isNewGetAll = false,
            getAllEffect = false,
            isGetAllStar = getStarCount == 3,
            getStarCount = getStarCount,
            newGetStarCount = 0,
            isPass = trainingRecords[k] ~= nil,
            bgImg = this.GetDungeonBgImg(dungeonGroupCfg.LevelBG),
            showEffect_zhong = false,
        }
        table.insert(tempDungeonGroupMap[seriesId], dungeonGroupItem)
    end
    this.SortDungeonGroupListMap(tempDungeonGroupMap)
    this.CheckNewEffect(tempDungeonGroupMap)
    this.data.dungeonGroupMap = tempDungeonGroupMap
    this.vm.data.dungeonGroupAlpha = 0.0
end

this.SortDungeonGroupListMap = function(tempDungeonGroupMap)
    this.data.newDungeonGroupIndex = {}
    this.data.allGetStarCount = {}
    this.data.allCanGetStarCount = {}
    for k, v in pairs(tempDungeonGroupMap) do
        table.sort(v, function(a, b) return a.id < b.id end)

        local allGetStarCount = 0
        local allCanGetStarCount = 0
        for i = 1, #v do
            v[i].islock = i > 1 and not v[i - 1].isPass
            v[i].numStr = i < 10 and "0" .. tostring(i) or tostring(i)
            if v[i].isPass then
                this.data.newDungeonGroupIndex[k] = i
                if i < #v then
                    this.data.newDungeonGroupIndex[k] = i + 1
                end
            end
            allGetStarCount = allGetStarCount + v[i].getStarCount
            allCanGetStarCount = allCanGetStarCount + 3
            this.data.allGetStarCount[k] = allGetStarCount
            this.data.allCanGetStarCount[k] = allCanGetStarCount
        end
    end
end


this.CheckNewEffect = function(tempDungeonGroupMap)
    this.data.isShowEffect = {}
    for k, v in pairs(tempDungeonGroupMap) do
        local isShowEffect = false
        for i = 1, #v do
            if TrainingDungeonHelper.CheckDungeonGroupUnlockNew(v[i]) then
                v[i].isNewUnlock = true
                v[i].lockEffect = false
                v[i].islock = true
                isShowEffect = true
            end
            if TrainingDungeonHelper.CheckDungeonGroupGetAllStarNew(v[i]) then
                v[i].isNewGetAll = true
                v[i].getAllEffect = false
                v[i].isGetAllStar = false
                isShowEffect = true
            end
            local newGetStarCount, getStarCount = TrainingDungeonHelper.CheckDungeonGroupGetStarNew(v[i])
            if newGetStarCount > 0 then
                v[i].newGetStarCount = newGetStarCount
                v[i].tempGetStarCount = getStarCount
                v[i].getStar_1 = getStarCount >= 1
                v[i].getStar_2 = getStarCount >= 2
                v[i].getStar_3 = getStarCount >= 3
                isShowEffect = true
            end
        end
        this.data.isShowEffect[k] = isShowEffect
    end
    TrainingDungeonHelper.ClearOldDungeonGroupData()
end

this.SwitchSeries = function(immediate)
    if IsNullOrEmpty(this.data.curSelectSeriesID) then
        if not IsNullOrEmpty(TrainingDungeonHelper.lastSelectSeriesID) then
            local cfgTrainingSeries = ConfigMgr.Config.TrainingSeriesMap[TrainingDungeonHelper.lastSelectSeriesID]
            if cfgTrainingSeries.EndTime < LuaMgr.Timestamp() then
                TrainingDungeonHelper.lastSelectSeriesID = ""
            else
                this.data.curSelectSeriesID = TrainingDungeonHelper.lastSelectSeriesID
                this.data.curSeriesType = cfgTrainingSeries.Type
            end
        end
        if IsNullOrEmpty(TrainingDungeonHelper.lastSelectSeriesID) then
            if #this.data.norList > 0 then
                this.data.curSelectSeriesID = this.vm.data.seriesNorList[1].id
                this.data.curSeriesType = 1
            elseif #this.data.specialList > 0 then
                this.data.curSelectSeriesID = this.vm.data.seriesSpecialList[1].id
                this.data.curSeriesType = 2
            end
        end
    end

    TrainingDungeonHelper.lastSelectSeriesID = this.data.curSelectSeriesID
    this.vm.data.seriesNorActive = this.data.curSeriesType == 1
    this.vm.data.seriesSpecialActive = this.data.curSeriesType == 2 or this.data.curSeriesType == 3
    
    for i, v in ipairs(this.vm.data.seriesNorList) do
        v.select = v.id == this.data.curSelectSeriesID
    end
    for i, v in ipairs(this.vm.data.seriesSpecialList) do
        v.select = v.id == this.data.curSelectSeriesID
    end

    for i, v in ipairs(this.vm.data.dungeonGroupList) do
        v.animationName = "ani_goDungeonGroupItem_002"
    end
    
    local cfgTrainingSeries = ConfigMgr.Config.TrainingSeriesMap[this.data.curSelectSeriesID]
    local SeriesName = LuaMgr.GetLangText(cfgTrainingSeries.NameLan)
    this.vm.data.dungeonGroupName_1 = string.sub(SeriesName, 1, 6)
    this.vm.data.dungeonGroupName_2 = string.sub(SeriesName, 7,  #SeriesName)
    this.vm.data.dungeonGroupDesc = ""
    this.vm.data.dungeonGroupList = this.data.dungeonGroupMap[this.data.curSelectSeriesID]
    this.vm.data.rewardProcessStr = string.format("<color=#f4f0e5>%d</color>/%d", this.data.allGetStarCount[this.data.curSelectSeriesID], this.data.allCanGetStarCount[this.data.curSelectSeriesID])
    LuaMgr.AddTimer(TimerConst.TrainingDungeonSeriesMoveTo, this.MoveToNewDungeonGroup, 0.05, -1, immediate)

    if not immediate then
        this.data.seriesAnimIndex = 1
        LuaMgr.AddTimer(TimerConst.TrainingDungeonSeriesTypeShow, this.OnSeriesTypeShow, 0.1, -1, false)
    end

    this.SetSeriesDungeonGroupContent(LuaMgr.GetLangText(cfgTrainingSeries.DescLan))
    this.data.endTime = cfgTrainingSeries.EndTime
    this.UpdateTimer()
    this.RefreshRewardRed()
    
    RectTool.RebuildLayoutImmediate(this.goSeriesContentTr)
    LuaMgr.NextFrame(function()
        RectTool.RebuildLayoutImmediate(this.goSeriesContentTr)
    end)
end

this. MoveToNewDungeonGroup = function()
    if this.data.goDungeonGroupContent.childCount > 0 then
        local moveIndex = this.data.newDungeonGroupIndex[this.data.curSelectSeriesID]
        if moveIndex == nil or moveIndex < 4 then
            moveIndex = 1
        elseif moveIndex >= 4 then
            moveIndex = 4
        end
        for i = 1, #this.vm.data.dungeonGroupList do
            this.vm.data.dungeonGroupList[i].showEffect_zhong = false
        end
        LuaMgr.RemoveTimer(TimerConst.TrainingDungeonSeriesMoveTo)
        LuaMgr.NextFrame(function()
            this.MoveDungeonListToIndex(moveIndex)
            this.vm.data.dungeonGroupAlpha = 1.0

            for i = moveIndex, 1, -1 do
                this.vm.data.dungeonGroupList[i].animationName = "ani_goDungeonGroupItem_001"
                if not this.vm.data.dungeonGroupList[i].islock then
                    this.vm.data.dungeonGroupList[i].showEffect_zhong = this.data.curSeriesType == 2 or this.data.curSeriesType == 3
                end
            end
            this.data.dungeonGroupAnimIndex = moveIndex + 1
            LuaMgr.AddTimer(TimerConst.TrainingDungeonSeriesGroupItemShow, this.OnSeriesGroupItemShow, 0.1, -1, false)
        end)
    end
end

this.OnSeriesGroupItemShow = function()
    if this.data.dungeonGroupAnimIndex <= #this.vm.data.dungeonGroupList then
        this.vm.data.dungeonGroupList[this.data.dungeonGroupAnimIndex].animationName = "ani_goDungeonGroupItem_001"
        if not this.vm.data.dungeonGroupList[this.data.dungeonGroupAnimIndex].islock then
            this.vm.data.dungeonGroupList[this.data.dungeonGroupAnimIndex].showEffect_zhong = this.data.curSeriesType == 2 or this.data.curSeriesType == 3
        end
    end
    this.data.dungeonGroupAnimIndex = this.data.dungeonGroupAnimIndex + 1
    if this.data.dungeonGroupAnimIndex > #this.vm.data.dungeonGroupList then
        LuaMgr.RemoveTimer(TimerConst.TrainingDungeonSeriesGroupItemShow)
        if this.data.isShowEffect[this.data.curSelectSeriesID] then
            LuaMgr.AddTimer(TimerConst.TrainingDungeonSeriesGroupItemEffectShow, this.OnSeriesGroupItemEffectShow , 0.5, 1, false)
            this.data.isShowEffect[this.data.curSelectSeriesID] = false
        end
    end
end

this.OnSeriesGroupItemEffectShow = function()
    for i = 1, #this.vm.data.dungeonGroupList do
        if this.vm.data.dungeonGroupList[i].isNewUnlock then
            this.vm.data.dungeonGroupList[i].lockEffect = true
            this.vm.data.dungeonGroupList[i].islock = false
        end
        if this.vm.data.dungeonGroupList[i].isNewGetAll then
            this.vm.data.dungeonGroupList[i].getAllEffect = true
        end
        if this.vm.data.dungeonGroupList[i].newGetStarCount > 0 then
            local allGetStarCount = this.vm.data.dungeonGroupList[i].tempGetStarCount + this.vm.data.dungeonGroupList[i].newGetStarCount
            this.vm.data.dungeonGroupList[i].getStarEff_1 = this.vm.data.dungeonGroupList[i].tempGetStarCount < 1 and allGetStarCount > 0
            this.vm.data.dungeonGroupList[i].getStarEff_2 = this.vm.data.dungeonGroupList[i].tempGetStarCount < 2 and allGetStarCount > 1
            this.vm.data.dungeonGroupList[i].getStarEff_3 = this.vm.data.dungeonGroupList[i].tempGetStarCount < 3 and allGetStarCount > 2
        end
    end
    LuaMgr.AddTimer(TimerConst.TrainingDungeonSeriesGroupItemEffectShowEnd, this.OnSeriesGroupItemEffectShowEnd , 0.6, 1, false)
end

this.OnSeriesGroupItemEffectShowEnd = function()
    for i = 1, #this.vm.data.dungeonGroupList do
        if this.vm.data.dungeonGroupList[i].isNewUnlock then
            this.vm.data.dungeonGroupList[i].isNewUnlock = false
            this.vm.data.dungeonGroupList[i].lockEffect = false
            this.vm.data.dungeonGroupList[i].islock = false
            this.vm.data.dungeonGroupList[i].showEffect_zhong = this.data.curSeriesType == 2 or this.data.curSeriesType == 3
            this.data.dungeonGroupMap[this.data.curSelectSeriesID][i].isNewUnlock = false
            this.data.dungeonGroupMap[this.data.curSelectSeriesID][i].lockEffect = false
            this.data.dungeonGroupMap[this.data.curSelectSeriesID][i].islock = false
        end
        if this.vm.data.dungeonGroupList[i].isNewGetAll then
            this.vm.data.dungeonGroupList[i].isNewGetAll = false
            this.vm.data.dungeonGroupList[i].getAllEffect = false
            this.vm.data.dungeonGroupList[i].isGetAllStar = true
            this.data.dungeonGroupMap[this.data.curSelectSeriesID][i].isNewGetAll = false
            this.data.dungeonGroupMap[this.data.curSelectSeriesID][i].getAllEffect = false
            this.data.dungeonGroupMap[this.data.curSelectSeriesID][i].isGetAllStar = true
        end
        if this.vm.data.dungeonGroupList[i].newGetStarCount > 0 then
            local allGetStarCount = this.vm.data.dungeonGroupList[i].tempGetStarCount + this.vm.data.dungeonGroupList[i].newGetStarCount
            this.vm.data.dungeonGroupList[i].newGetStarCount = 0
            this.vm.data.dungeonGroupList[i].getStarEff_1 = false
            this.vm.data.dungeonGroupList[i].getStarEff_2 = false
            this.vm.data.dungeonGroupList[i].getStarEff_3 = false
            this.vm.data.dungeonGroupList[i].getStar_1 = allGetStarCount >= 1
            this.vm.data.dungeonGroupList[i].getStar_2 = allGetStarCount >= 2
            this.vm.data.dungeonGroupList[i].getStar_3 = allGetStarCount >= 3
            this.data.dungeonGroupMap[this.data.curSelectSeriesID][i].newGetStarCount = 0
            this.data.dungeonGroupMap[this.data.curSelectSeriesID][i].tempGetStarCount = 0
            this.data.dungeonGroupMap[this.data.curSelectSeriesID][i].getStar_1 = allGetStarCount >= 1
            this.data.dungeonGroupMap[this.data.curSelectSeriesID][i].getStar_2 = allGetStarCount >= 2
            this.data.dungeonGroupMap[this.data.curSelectSeriesID][i].getStar_3 = allGetStarCount >= 3
        end
    end
end

this.OnSeriesTypeShow = function()
    if this.data.seriesAnimIndex <= #this.vm.data.seriesNorList then
        this.vm.data.seriesNorList[this.data.seriesAnimIndex].animationName = "ani_goSeriesSpecialItem_001"
    end
    if this.data.seriesAnimIndex <= #this.vm.data.seriesSpecialList then
        this.vm.data.seriesSpecialList[this.data.seriesAnimIndex].animationName = "ani_goSeriesSpecialItem_001"
    end
    this.data.seriesAnimIndex = this.data.seriesAnimIndex + 1
    if this.data.seriesAnimIndex > #this.vm.data.seriesNorList and this.data.seriesAnimIndex > #this.vm.data.seriesSpecialList then
        LuaMgr.RemoveTimer(TimerConst.TrainingDungeonSeriesTypeShow)
    end
end

this.CheckSeriesUnlock = function()
    local cfgTrainingSeries = ConfigMgr.Config.TrainingSeriesMap
    local cfgTrainingDungeonGroups = ConfigMgr.Config.TrainingCpointMap
    local trainingRecords = DataMgr.Player.TrainingRecords
    this.data.seriesUnlockTipsMap = {}

    if this.data.debugUnlockAll then
        return
    end
    for k, seriesCfg in pairs(cfgTrainingSeries) do
        local key = seriesCfg.Unlock[2]
        if not IsNullOrEmpty(key) then
            local isUnlock = trainingRecords[key] ~= nil
            if not isUnlock then
                this.data.seriesUnlockTipsMap[k] = string.format(LuaMgr.GetLangText("TrainingDungeonSeriesViewModel_1"), LuaMgr.GetLangText(cfgTrainingSeries[cfgTrainingDungeonGroups[key].SeriesId].NameLan))
            end
        end
    end
end

this.MoveDungeonListToIndex = function(index)
    local contentWidth = this.data.goDungeonGroupContent.rect.width
    local posX = -273 * (index - 1)
    if -posX > contentWidth - 981 then
        posX = 981 - contentWidth
    end
    this.data.goDungeonGroupContent.anchoredPosition = Vector2(posX, 0)
end

this.SetSeriesDungeonGroupContent = function(content)
    this.vm.data.dungeonGroupDesc = ""
    this.data.dungeonGroupDesc = content
    this.data.dungeonGroupDescIndex = 0
    this.data.dungeonGroupDescLength = LuaMgr.GetStringLength(content)
    LuaMgr.RemoveTimer(TimerConst.TrainingDungeonSeriesContentShow, this.OnSeriesDungeonGroupContentShow)
    LuaMgr.AddTimer(TimerConst.TrainingDungeonSeriesContentShow, this.OnSeriesDungeonGroupContentShow, 0.02, -1, true)
end

this.OnSeriesDungeonGroupContentShow = function()
    this.data.dungeonGroupDescIndex = this.data.dungeonGroupDescIndex + 1
    this.vm.data.dungeonGroupDesc = LuaMgr.Substring(this.data.dungeonGroupDesc, this.data.dungeonGroupDescIndex)
    if this.data.dungeonGroupDescIndex >= this.data.dungeonGroupDescLength then
        LuaMgr.RemoveTimer(TimerConst.TrainingDungeonSeriesContentShow, this.OnSeriesDungeonGroupContentShow)
    end
end

this.CheckReconnect = function()
    local training = DataMgr.Player.Training
    if training ~= nil and training.CPointId ~= nil and training.DungeonId ~= nil then
        this.data.trainingDungeonGroupCfg = ConfigMgr.Config.TrainingCpointMap[training.CPointId]
        if this.data.trainingDungeonGroupCfg == nil then
            return
        end
        if training.DungeonId ~= this.data.trainingDungeonGroupCfg.DungeonId[2] then
            LuaDebug.error("不能重连第一关！")
            return
        end
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, LuaMgr.GetLangText("TrainingDungeonSeriesViewModel_2"), function()
            BattlePrepareMgr.TrainingDungeonEnterBattle(training.CPointId, 2, {{}, training.Members})
        end, function()
            ApiMgr.Request("training/cancel", {},true,function(result)
                
            end,nil,true)
        end)
    end
end

this.RefreshRewardRed = function()
    local dungeonRed = HeroRedDataHelper.GetTrainingDungeonRewardRed(this.data.curSelectSeriesID)
    local starRed = HeroRedDataHelper.GetTrainingStarRewardRed(this.data.curSelectSeriesID)
    this.vm.data.showRewardRed = dungeonRed + starRed > 0
end

this.GetDungeonBgImg = function(imgStr)
    if IsNullOrEmpty(imgStr) then
        imgStr = "ui_jx_gk1"
    end
    return LuaMgr.GetSprite("TrainingDungeon", imgStr)
end

this.UpdateTimer = function()
    if this.data.endTime <= 0 then
        return
    end
    local leftTime = this.data.endTime - LuaMgr.Timestamp()
    if leftTime < 0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TrainingDungeonSeriesViewModel_4"));
        DataMgr.FrushPlayerData(function()
            LuaMgr.Back()
        end);
        return
    end
    local d, h, m = GetTimeDHM(leftTime)
    local timeStr = ""
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("2121"));
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
    end
    this.vm.data.timerText = string.format(LuaMgr.GetLangText("TrainingDungeonSeriesViewModel_5"), timeStr)
end

return vm({
    data = data,
    command = command,
    hook = hook
})