




FeatureManager = {}

FeatureManager.backPackLableIndex = 1
FeatureManager.ShowCardVideoKey = "SHOW_CARD_VIDEO"


function FeatureManager.GotoPanel(panelId, tabID, itemId, needCount)
    if not panelId or panelId == "" then
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", LuaMgr.GetLangText("FeatureManager_0"));
        return false;
    end
    local value = ConfigInterfaceMgr.GetInterfaceById(panelId);
    if (value ~= nil) then
        if FeatureManager.CheckFeatureStatus(value) then
            if itemId ~= nil and itemId ~= "" then
                PlayerItemMgr.SetTipsItem(itemId, needCount, value.screen);
            end
            if value.screen=="AreaDailyViewModel" then
                HeroParameter.EmptyDailyFB();
            end

            if value.scene=="Foundation" then
                FoundationMgr.Open(value.tab, value.screen);
            elseif value.scene=="Farm" then
                FarmRoom.Open();
            elseif value.scene=="GuoBao" then
                GuoBaoMgr.Open();
            elseif value.scene=="JS_Activity01_01" then
                SimulateRoomMgr.Open();
            else
                if (IsNullOrEmpty(tabID)) then
                    tabID = value.tab;
                end
                if (IsNullOrEmpty(tabID)) then
                    if IsLua(value.screen) then
                        LuaMgr.ShowLuaPanel(value.screen);
                    else
                        LuaMgr.ShowPanel(value.screen);
                    end
                else
                    if IsLua(value.screen) then
                        LuaMgr.ShowLuaPanel(value.screen, tabID);
                    else
                        LuaMgr.ShowPanel(value.screen, tabID);
                    end
                end
            end
            return true;
        else

            local tipStr = FeatureManager.TipStr(panelId);
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr);
        end
    end
    return false;
end


function FeatureManager.IsLock(panelId)
    local value = ConfigInterfaceMgr.GetInterfaceById(panelId);
    if (value ~= nil) then
        return not FeatureManager.CheckFeatureStatus(value);
    end
    return false;
end


function FeatureManager.TipStr(panelId)
    local value = ConfigInterfaceMgr.GetInterfaceById(panelId);
    if (value ~= nil) then
        if value.id == panelId then
            local tipStr = ""
            if value.OpenCondition[1] == "1" then
                tipStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2128"].NameLan),value.OpenCondition[2])
            elseif value.OpenCondition[1] == "2" then
                local areaEvent = ConfigMgr.Config.areaEvents[value.OpenCondition[2]]
                if areaEvent.type == 1 then
                    local text = LuaMgr.GetLangText(ConfigMgr.Config.narrativeMap[areaEvent.eventParam].nameLan)
                    tipStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2138"].NameLan),text)
                elseif areaEvent.type == 2 then
                    local text = LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[areaEvent.eventParam].NameLan)
                    tipStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2134"].NameLan),text)
                end
            elseif value.OpenCondition[1] == "3" then
                tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2135"].NameLan)
            elseif value.OpenCondition[1] == "4" then
                tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2061"].NameLan)
            elseif value.OpenCondition[1] == "8" then
                tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7023"].NameLan)
            elseif value.OpenCondition[1] == "9" then
                local config = PlayerFoundationMgr.GetBuildingConfigByGroup(value.OpenCondition[2]);
                if (config ~= nil and PlayerFoundationMgr.IsUpLevel(config.Id)) then
                    tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6118"].NameLan)
                else
                    tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6956"].NameLan) 
                end
            elseif value.OpenCondition[1] == "10" then
                tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10203"].NameLan)
            end
            return tipStr;
        end
    end
    return "";
end


function FeatureManager.CheckFeatureStatus(panelInfo)
    local isCan = true
    if #panelInfo.OpenCondition == 0 then
        isCan = true
    else
        local len = #panelInfo.OpenCondition
        local i = 1
        while i <= len do
            if panelInfo.OpenCondition[i] == "1" then
                isCan = DataMgr.Player.level >= tonumber(panelInfo.OpenCondition[i+1]) and isCan
            elseif panelInfo.OpenCondition[i] == "2" then
                local areaEvent = DataMgr.Player.completedAreaEvents[panelInfo.OpenCondition[i+1]];
                isCan = areaEvent ~= nil and isCan ;
            elseif panelInfo.OpenCondition[i] == "3" then
                isCan = false
            elseif panelInfo.OpenCondition[i] == "4" then
                if DataMgr.Player.areaMaps[panelInfo.tab] == nil then
                    isCan = false
                else
isCan =PlayerAreaMgr.CheckAreaUnlock(panelInfo.tab)  and isCan
                end
            elseif panelInfo.OpenCondition[i] == "8" then
                isCan =ActivityMgr.ActivityRuning(panelInfo.OpenCondition[i+1]) and isCan
            elseif panelInfo.OpenCondition[i] == "9" then
                isCan = FeatureManager.CheckFoundationBuildingStatus(panelInfo.OpenCondition[i+1]) and isCan
            elseif panelInfo.OpenCondition[i] == "10" then
                isCan=FeatureManager.CheckActivityBattleLevelStatus(panelInfo.OpenCondition[i+1]) and isCan
            elseif panelInfo.OpenCondition[i] == "11" then
                isCan=FeatureManager.CheckActivityState(panelInfo.OpenCondition[i+1]) and isCan
            elseif panelInfo.OpenCondition[i] == "12" then
                isCan=FeatureManager.CheckDateState(panelInfo.OpenCondition[i+1]) and isCan
            else
                isCan = false;
            end
            i = i + 2
        end
    end
    return isCan
end


function FeatureManager.CheckActivityBattleLevelStatus(activityArea)
    local activityInfo=nil;
    for i,v in ipairs(ConfigMgr.Config.activityMapList) do
        if v.area==activityArea then
            activityInfo=v;
            break
        end
    end
    if activityInfo==nil then
        return false
    end
    local curTime=LuaMgr.Timestamp();
    if activityInfo.openDate<=curTime and activityInfo.closeDate>curTime then
        return true;
    end
    return false;
end

function FeatureManager.CheckActivityState(activityKey)
    if activityKey==nil then
        return false;
    end
    return ActivityMgr.ActivityRuning(activityKey)
end

function FeatureManager.CheckDateState(timeStr)
    local curTime = LuaMgr.Timestamp() 
    local pattern = "(%d+)%-(%d+)%-(%d+)/(%d+):(%d+):(%d+)"
    local year, month, day, hour, min, sec = timeStr:match(pattern)
    
    local targetTime = BeijingTimeToTimeStamp(year, month, day, hour, min, sec)

    return targetTime <= curTime
end


function FeatureManager.CheckFoundationBuildingStatus(group)
    local config = PlayerFoundationMgr.GetBuildingConfigByGroup(group);
    if (config ~= nil) then
        if (not PlayerFoundationMgr.IsUpLevel(config.Id)) then
            return true;
        end
    end
    return false;
end


function FeatureManager.GetPanelInfo(panelId)
    return ConfigInterfaceMgr.GetInterfaceById(panelId);
end

function FeatureManager.GotoViewModel(panelId, itemId, needCount)
    local interface = ConfigInterfaceMgr.GetInterfaceById(panelId);
    if (interface ~= nil) then
        if (interface.scene ~= "") then
            if interface.scene=="Foundation" then
                if (FeatureManager.IsLock("1302")) then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1302"));
                else
                    FeatureManager.GotoPanel(interface.id, interface.tab, itemId, needCount);
                end
            elseif interface.scene=="GuoBao" then
                FeatureManager.GotoPanel(interface.id, interface.tab);
            elseif interface.scene=="Climbtower" then
                if FeatureManager.IsLock("1044") then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1044"));
                else
                    LuaMgr.SceneSwitchMark();
                    LuaMgr.LoadScene(interface.scene, nil, function()
                        FeatureManager.GotoPanel(interface.id,interface.tab, itemId);
                    end);
                end
            elseif interface.scene=="AreaMap" then
                LuaMgr.ShowLuaPanel(UIName.AreaMapViewModel, interface.tab, panelId)
            elseif interface.scene=="Farm" then
                FeatureManager.GotoPanel(interface.id);
            else
                LuaMgr.LoadScene(interface.scene, nil, function()
                    FeatureManager.GotoPanel(interface.id,interface.tab, itemId);
                end);
            end
        else
            FeatureManager.GotoPanel(interface.id, interface.tab, itemId, needCount);
        end
    end
end




FeatureManager.UnifyVerControls = function(tableName,tableValue)
    if IsNullOrEmpty(tableValue) then return true end
    local isBanned = true
    local startTime,endTime = nil,nil
    local content = nil
    local nowTime = nil
    for i = 1, #ConfigMgr.Config.Triggers do
        isBanned = ConfigMgr.Config.Triggers[i].Isbanned
        if isBanned then
            startTime = ConfigMgr.Config.Triggers[i].StartTime
            endTime = ConfigMgr.Config.Triggers[i].EndTime
            for j = 1, #ConfigMgr.Config.Triggers[i].Content do
                content = ConfigMgr.Config.Triggers[i].Content[j]
                if content[1] == tableName and content[2] == tableValue then
                    nowTime = LuaMgr.Timestamp()
                    if nowTime > startTime and (endTime <= 0 or nowTime < endTime) then
                        return false
                    end
                end
            end
        end
    end
    return true
end

FeatureManager.ClearParameter = function()
    FeatureManager.backPackLableIndex = 1
end

FeatureManager.ShowCardPoolPanel = function(cardPoolID)
    local limitCardpoolDatas = ConfigHelper.GetCurLimitCardPoolsData()
    if limitCardpoolDatas == nil or #limitCardpoolDatas == 0 then
        LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.ExtractCardViewModel", cardPoolID)
    else
        local callback = function()
           LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.ExtractCardViewModel", cardPoolID)
        end
        local firstData = limitCardpoolDatas[1]
        local cardPoolIndex = 0
        for key, value in pairs(limitCardpoolDatas) do
            if value.id == cardPoolID then
                firstData = value
                break
            end
            cardPoolIndex = cardPoolIndex + 1
        end
        if firstData == nil or type(firstData.openShow) ~= "table" or firstData.openShow[1] == nil then
            LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.ExtractCardViewModel", cardPoolID)
            return
        end
        local archiveKey = DataMgr.Player.uid .. FeatureManager.ShowCardVideoKey .. cardPoolID
        local isShowFlag = PlayerPrefs.GetInt(archiveKey) == 1
        if isShowFlag == true then
            LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.ExtractCardViewModel", cardPoolID)
            return
        end
        local data = {}
        data.callback = callback
        data.videoName = firstData.openShow[1]
        data.cardPoolIndex = cardPoolIndex
        LuaMgr.ShowLuaPanel(UIName.ExtractCardPreVideoPanel, data)
        PlayerPrefs.SetInt(archiveKey, 1)
    end
end

