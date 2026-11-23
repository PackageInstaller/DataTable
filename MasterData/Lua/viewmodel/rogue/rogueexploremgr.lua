
RogueExploreMgr = {
    eventMapByMapId = {},
    isContinue = true;
    isBattleContinue=false;
    eventShopMap={};

    lastPosition=nil;
    selectHeroInfo={};
    selectBuffInfo={};
    exploreTheme=nil;
};

local mapId = "";
local curEventNumber = nil;
local cfgEvent = nil;
local handlerEventList = {};
local curHandlerEvent=nil;

RogueExploreMgr.GetCurMapID = function()
     return mapId;
end

RogueExploreMgr.CurEventNumber=function()
    return curEventNumber;
end

RogueExploreMgr.Init = function()
    HeroParameter.EmptyRogueParam()
    RogueExploreMgr.UpdateMap();
    RogueExploreMgr.Clear();
    RogueExploreMgr.exploreTheme=RogueExploreMgr.GetExploreTheme();
    LuaMgr.ShowLuaPanel(UIName.RogueExploreViewModel)
    RogueExploreMgr.CheckExploreStartEvent();
end

RogueExploreMgr.UpdateMap = function()
    if not IsNull(DataMgr.Player.Rogue) and not IsNull(DataMgr.Player.Rogue.CurrentLocation) then
        mapId=DataMgr.Player.Rogue.CurrentLocation.MapId;
    end
end


RogueExploreMgr.GetExploreTheme=function()
    if IsNull(DataMgr.Player.Rogue) or DataMgr.Player.Rogue.RogueLevel==nil then
        return 1;
    end
    for i,v in ipairs(ConfigMgr.Config.RogueLevels) do
        if DataMgr.Player.Rogue.RogueLevel==v.Level then
            return v.Version;
        end
    end
    return 1;
end


RogueExploreMgr.CheckExploreStartEvent=function()
    if DataMgr.Player.Rogue.InitStatus==0 then return end;
    if not IsNull(DataMgr.Player.Rogue.InitEvents) and #DataMgr.Player.Rogue.InitEvents>0 then
        local initEventList={}
        local startIndex=DataMgr.Player.Rogue.InitStep+1;
        if startIndex<=#DataMgr.Player.Rogue.InitEvents then
            for i=startIndex,#DataMgr.Player.Rogue.InitEvents,1 do
                table.insert(initEventList,DataMgr.Player.Rogue.InitEvents[i])
            end
        end
        if #initEventList>0 then
            curEventNumber = nil;
            handlerEventList = {};
            RogueExploreMgr.isContinue=true;
            LuaMgr.RemoveUpdate(RogueExploreMgr.OnUpdate);
            LuaMgr.AddUpdate(RogueExploreMgr.OnUpdate);
            handlerEventList=initEventList;
        end
    end
end


RogueExploreMgr.ClearHandlerList= function()
    handlerEventList={};
    RogueExploreMgr.isContinue=true;
end


RogueExploreMgr.Clear = function()
    RogueExploreMgr.eventMapByMapId = {};
    RogueExploreMgr.eventShopMap={};
    RogueExploreMgr.eventStateMap={};
    RogueExploreMgr.selectHeroInfo={}
    RogueExploreMgr.selectBuffInfo={};
    RogueExploreMgr.isContinue = true;
    LuaMgr.RemoveUpdate(RogueExploreMgr.OnUpdate);
end


RogueExploreMgr.GetMembers = function()
    local memberIds = {}
    if IsNull(DataMgr.Player.Rogue.Characters) then
        return memberIds
    end ;
    for i,v in pairs(DataMgr.Player.Rogue.Characters) do
        table.insert(memberIds,v.CharacterId)
    end
    return memberIds
end


RogueExploreMgr.GetBuildingsByMapId = function()
    local eventList = {}
    if IsNull(DataMgr.Player.Rogue.Maps) then
        return eventList
    end ;
    local mapValues = DataMgr.Player.Rogue.Maps[mapId];
    if not IsNullOrEmpty(mapValues.MapPoolId) then
        eventList = ConfigMgr.Config.RogueMapEvents[mapValues.MapPoolId]
    end
    if RogueExploreMgr.eventMapByMapId[mapId] == nil then
        RogueExploreMgr.eventMapByMapId[mapId] = {};
        for i, v in pairs(eventList) do
            RogueExploreMgr.eventMapByMapId[mapId][v.EventNumber] = v;
        end
    end
    return eventList;
end


RogueExploreMgr.GetBuildingBGImgById = function()
    local imgName = "";
    if IsNull(DataMgr.Player.Rogue.Maps) then
        return imgName
    end ;
    local mapValues = DataMgr.Player.Rogue.Maps[mapId];
    if not IsNullOrEmpty(mapValues.MapPoolId) then
        return ConfigMgr.Config.RogueMapPools[mapValues.MapPoolId].MapBg;
    end
end


RogueExploreMgr.CheckBuildingIsUnLock = function(eventNumber)
    if IsNull(DataMgr.Player.Rogue.Maps) then
        return false
    end ;
    local mapValues = DataMgr.Player.Rogue.Maps[mapId];
    if IsNull(mapValues.Events) then
        return false;
    end
    return mapValues.Events[eventNumber] ~= nil;
end

RogueExploreMgr.SaveLastBuildingState=function(list)
    RogueExploreMgr.eventStateMap={};
    for i,v in ipairs(list) do
        RogueExploreMgr.eventStateMap[v.data.id]=v.data.isUnlock;
    end
end


RogueExploreMgr.CheckBuildingIsCurrentUnLock=function(eventNumber,unLock)
    if not unLock then
        return false;
    end
    if IsNull(RogueExploreMgr.eventStateMap) or NumTool.GetLen(RogueExploreMgr.eventStateMap)==0 then
        return false;
    end
    if RogueExploreMgr.eventStateMap[eventNumber]~=nil then
        return not RogueExploreMgr.eventStateMap[eventNumber];
    end
    return false;
end


RogueExploreMgr.CheckBuildingIsComplete = function(eventNumber)
    if IsNull(DataMgr.Player.Rogue.Maps) then
        return false
    end ;
    local mapValues = DataMgr.Player.Rogue.Maps[mapId];
    if IsNull(mapValues.Events) or mapValues.Events[eventNumber] == nil then
        return false;
    end
    return mapValues.Events[eventNumber].Status > 1;
end


RogueExploreMgr.GetBuildingLinePoints=function(building)
    local pointsList={}
    if IsNull(building.Unlock) or #building.Unlock == 0 then
       return pointsList;
    end
    for i,v in ipairs(building.Unlock) do
        local eventMap = RogueExploreMgr.eventMapByMapId[mapId];
        if eventMap~=nil and eventMap[v]~=nil then
            local eventCfg=eventMap[v];
            local isUnlock=RogueExploreMgr.CheckBuildingIsUnLock(v);
            local isDone=RogueExploreMgr.CheckBuildingIsComplete(v);
            table.insert(pointsList,{lock=not isDone,isActive=isUnlock;
                                     startPoint=Vector3(building.EventCo[1],building.EventCo[2],0),
                                     endPoint=Vector3(eventCfg.EventCo[1],eventCfg.EventCo[2],0)});
        end
    end
    return pointsList;
end



RogueExploreMgr.GetUnLockLines = function(building)
local lineState = { 0, 0, 0, 0 };
    if IsNull(building.Unlock) or #building.Unlock == 0 then
        return { 0, 0, 0, 0 };
    end
    for i, v in ipairs(building.Unlock) do
        local eventMap = RogueExploreMgr.eventMapByMapId[mapId];
        if eventMap == nil or eventMap[v] == nil then
            LuaDebug.error("eventMap is nil,Error")
        else
            local dir = RogueExploreMgr.GetLineDir(eventMap[v].EventCo, building.EventCo);
            if dir ~= nil then
                local isUnLock = RogueExploreMgr.CheckBuildingIsComplete(v);
                lineState[dir] = isUnLock and 2 or 1;
            else
                LuaDebug.error("dir is Error,Check Config pos")
            end
        end
    end
    return lineState;
end

RogueExploreMgr.GetLineDir = function(tarPos, myPos)
    if tarPos[2] - myPos[2] > 5 then

        return 1
    elseif tarPos[2] - myPos[2] < -5 then

        return 2
    elseif tarPos[1] - myPos[1] < -5 then

        return 3;
    elseif tarPos[1] - myPos[1] > 5 then

        return 4
    end
end

RogueExploreMgr.GetEventIdByEventNumber = function(eventNumber)
    if IsNull(DataMgr.Player.Rogue.Maps) then
        return nil;
    end ;
    local mapValue = DataMgr.Player.Rogue.Maps[mapId];
    if mapValue ~= nil then
        return mapValue.Events[eventNumber].EventId;
    end
    return nil;
end


RogueExploreMgr.CheckCompletedEvent = function(related)
    return true;
end


RogueExploreMgr.GetEventResultData = function(eventNumber)
    if IsNull(DataMgr.Player.Rogue.Maps) or DataMgr.Player.Rogue.Maps[mapId] == nil then
        return nil,nil
    end ;
    local mapEvents = DataMgr.Player.Rogue.Maps[mapId].Events;
    if mapEvents[eventNumber] ~= nil and not IsNull(mapEvents[eventNumber].EventUnits) then
        local curNumMapEvent=mapEvents[eventNumber];
        local eventUnits=curNumMapEvent.EventUnits;
        if eventUnits[curNumMapEvent.Select]~=nil  then
            local eventUnit=eventUnits[curNumMapEvent.Select];
            local curIndex=curNumMapEvent.Step+1;
            curIndex=curIndex>#eventUnit and #eventUnit or curIndex;
            return eventUnit[curIndex],mapEvents[eventNumber].EventId;
        end
        return nil,nil;
    end
    return nil,nil;
end



RogueExploreMgr.GetTeams = function()
    if not IsNull(DataMgr.Player.RogueMembers) then
        return { helps = {}, members = DataMgr.Player.RogueMembers };
    end
    return {};
end


RogueExploreMgr.CheckBuffIsPush=function(buffId)
    if IsNull(DataMgr.Player.Rogue) then
        return false;
    end
    local teamId=DataMgr.Player.Rogue.DefaultTeamId
    local coninitHeroe=nil;
    for i,v in ipairs(ConfigMgr.Config.RogueConinitHeroes) do
        if v.Id==teamId then
            coninitHeroe=v;
        end
    end
    if coninitHeroe==nil then 
        return false 
    end;
    local cfgBuffDes=ConfigMgr.Config.RogueBuffDescMap[buffId]
    for i,v in ipairs(coninitHeroe.Genre) do
        if v==tostring(cfgBuffDes.Genre) then
            return true;
        end
    end
    return false;
end


RogueExploreMgr.CheckBuffInBag=function(buffId)
    if IsNull(DataMgr.Player.Rogue) or IsNull(DataMgr.Player.Rogue.BuffIds) then
        return false;
    end
    for i,v in pairs(DataMgr.Player.Rogue.BuffIds) do
        if buffId==v then
            return true;
        end
    end
    return false;
end

RogueExploreMgr.CheckHeroInBag=function(heroId)
    if IsNull(DataMgr.Player.Rogue) or IsNull(DataMgr.Player.Rogue.Characters) then
        return false;
    end
    for i,v in pairs(DataMgr.Player.Rogue.Characters) do
        if heroId==v.CharacterId then
            return true;
        end
    end
    return false;
end

RogueExploreMgr.GetEventShopConfig=function(shelfId,Id)
    if IsNull(ConfigMgr.Config.RogueEventShops) or ConfigMgr.Config.RogueEventShops[shelfId]==nil then
        return nil;
    end
    if RogueExploreMgr.eventShopMap[shelfId]==nil then
        RogueExploreMgr.eventShopMap[shelfId]={}
        for i,v in ipairs(ConfigMgr.Config.RogueEventShops[shelfId]) do
            RogueExploreMgr.eventShopMap[shelfId][v.Id]=v;
        end
    end
    return RogueExploreMgr.eventShopMap[shelfId][Id]
end


RogueExploreMgr.GetExploreCount=function()
    if IsNull(DataMgr.Player.Rogue) or IsNull(DataMgr.Player.Rogue.Maps) then
        return 0;
    end
    local proIndex=0;
    for i,v in pairs(DataMgr.Player.Rogue.Maps) do
        for _,eventItem in pairs(v.Events) do
            proIndex=proIndex+1;
        end
    end
    return proIndex;
end

RogueExploreMgr.CheckShopRecord=function(key)
    if IsNull(DataMgr.Player.Rogue.ShopRecords) then return false end;
    return DataMgr.Player.Rogue.ShopRecords[key]~=nil ;
end


RogueExploreMgr.CheckIsOpenRefresh=function()
    local teachId=nil;
    for i,v in ipairs(ConfigMgr.Config.RogueTechs) do
        if v.Para[1]=="RogueRefreshUnlock" then
            teachId=v.Id;
        end
    end
    if teachId==nil or IsNull(DataMgr.Player.RogueTech) then
        return false;
    end
    return DataMgr.Player.RogueTech[teachId]~=nil;
end


RogueExploreMgr.CheckIsAddOxygenMaxLimit=function()
    local isUnlockAddOxygenMaxLimit=false;
    for i,v in ipairs(ConfigMgr.Config.RogueTechs) do
        if v.Para[1]=="RogueInitialMoveLimitExtra" and  DataMgr.Player.RogueTech[v.Id]~=nil then
            isUnlockAddOxygenMaxLimit=true;
        end
    end
    if isUnlockAddOxygenMaxLimit then
        return ConfigMgr.Config.RogueConstants.RogueInitialMoveLimitExtra;
    end
    return 0;
end

RogueExploreMgr.CheckIsRefreshAddCount=function()
    local teachIdList={};
    for i,v in ipairs(ConfigMgr.Config.RogueTechs) do
        if v.Para[1]=="RogueExtraRefresh" then
            table.insert(teachIdList,v.Id);
        end
    end
    if #teachIdList==0 or IsNull(DataMgr.Player.RogueTech) then
        return 0;
    end
    local count=0;
    for i,v in ipairs(teachIdList) do
        if DataMgr.Player.RogueTech[v]~=nil then
            count=count+1;
        end
    end
    return count;
end

RogueExploreMgr.CheckShopDiscount=function()
    for i,v in ipairs(ConfigMgr.Config.RogueTechs) do
        if v.Para[1]=="Rogue2ShopDiscount" and  DataMgr.Player.RogueTech[v.Id]~=nil then
            return true;
        end
    end
    return false;
end


RogueExploreMgr.CheckShopExchangelByOxg=function()
    for i,v in ipairs(ConfigMgr.Config.RogueTechs) do
        if v.Para[1]=="Rogue2Exchange" and  DataMgr.Player.RogueTech[v.Id]~=nil then
            return true;
        end
    end
    return false;
end



RogueExploreMgr.CheckShowCharacterExploreLevel=function(CharacterId)
    local showLevel=RogueExploreMgr.GetCharacterExploreLevel(CharacterId);
    if showLevel>0 then
        LuaMgr.InvokeUIEventListeners(UIEventConst.RogueEventTip,showLevel);
    end
end


RogueExploreMgr.GetCharacterExploreLevel=function(CharacterId)
    if IsNull(DataMgr.Player.Rogue.Characters) then
        return 0
    end
    if DataMgr.Player.Rogue.Characters[CharacterId]==nil then
        return 0
    end
    local characterLevel=DataMgr.Player.Rogue.Characters[CharacterId].ExploreLevel;
    local exploreLevel=characterLevel-ConfigMgr.Config.RogueConstants.RogueInitialDiscoverLevel+1;
    return exploreLevel;
end


RogueExploreMgr.CheckEnterBattleByExtraParams=function(extraList)
    table.insert(extraList,"rogue");
    table.insert(extraList,mapId);
    table.insert(extraList,curEventNumber)
    table.insert(extraList,"start")
    local buffList=RogueMgr.GetTalentBuffList();
    if not IsNull(buffList) and  #buffList>0 then
        for i,v in ipairs(buffList) do
            table.insert(extraList,v);
        end
    end
    if IsNull(DataMgr.Player.Rogue) then return end;
    if not IsNull(DataMgr.Player.Rogue.GlobalBuffIds) then
        for i,v in ipairs(DataMgr.Player.Rogue.GlobalBuffIds) do
            table.insert(extraList,v);
        end
    end
    if not IsNull(DataMgr.Player.Rogue.BuffIds) then
        for i,v in ipairs(DataMgr.Player.Rogue.BuffIds) do
            table.insert(extraList,v);
        end
    end
end



RogueExploreMgr.StartBuildingEvent = function(eventNumber)
    if IsNull(DataMgr.Player.Rogue) then return end;
    curEventNumber = eventNumber;
    handlerEventList = {};
    RogueExploreMgr.isContinue=true;
    LuaMgr.RemoveUpdate(RogueExploreMgr.OnUpdate);
    LuaMgr.AddUpdate(RogueExploreMgr.OnUpdate);
    local isHistory,eventUnits=RogueExploreMgr.CheckHandlerHistoryList(eventNumber);
    if isHistory then
        handlerEventList=eventUnits; 
        return
    end
    local eventId = RogueExploreMgr.GetEventIdByEventNumber(eventNumber);
    if IsNullOrEmpty(eventId) then
        return
    end ;
    RogueExploreMgr.CheckBuildingEvent(eventId);
end

RogueExploreMgr.CheckHandlerHistoryList=function(eventNumber)
    local unitsList={};
    if IsNull(DataMgr.Player.Rogue) or IsNull(DataMgr.Player.Rogue.Maps) or DataMgr.Player.Rogue.Maps[mapId]==nil then
        return false,unitsList
    end;
    local mapEvents = DataMgr.Player.Rogue.Maps[mapId].Events;
    if IsNull(mapEvents) or mapEvents[eventNumber]==nil then 
        return false,unitsList;
    end
    local curMapEvent=mapEvents[eventNumber];
    if IsNullOrEmpty(curMapEvent.Select) then
        return false,unitsList
    end
    local eventUnits=curMapEvent.EventUnits[curMapEvent.Select];
    if IsNull(eventUnits) or #eventUnits==0 then
        return nil,unitsList;
    end
    local curIndex=curMapEvent.Step+1;
    curIndex=curIndex>#eventUnits and #eventUnits or curIndex;
    for i=curIndex,#eventUnits,1 do
        table.insert(unitsList,eventUnits[i]);
    end
    return true,unitsList;
end

RogueExploreMgr.CheckBuildingEvent = function(eventId)
    cfgEvent = nil;
    cfgEvent = ConfigMgr.Config.RogueEvents[eventId];
    if cfgEvent == nil then
        LuaDebug.error("No eventId:.."..eventId);
        return 0
    end ;

    if cfgEvent.Trigger == 0 or cfgEvent.Trigger == 1 and RogueExploreMgr.CheckCompletedEvent(cfgEvent.Related) then
        if cfgEvent.IsPop == 0 and cfgEvent.EventPool > 0 then

            RogueMgr.OnAskCompleteEvent(curEventNumber, cfgEvent.Id, nil, RogueExploreMgr.UpdateHandlerList)
            return 1;
        else

            if not LuaMgr.IsPanelOpen(UIName.RogueExploreEventViewModel) then

                LuaMgr.ShowLuaPanel(UIName.RogueExploreEventViewModel, cfgEvent, RogueExploreMgr.EventOptionsCallBack);
            else
                LuaMgr.InvokeUIEventListeners(UIEventConst.RogueUpdateEventOption, cfgEvent, RogueExploreMgr.EventOptionsCallBack)
            end
            return 1
        end
    end
    return 0;
end

RogueExploreMgr.EventOptionsCallBack = function(index)

    local laterEvent=nil;
    if index==1 then
        laterEvent=cfgEvent.LaterEvent1;
    elseif index==2 then
        laterEvent=cfgEvent.LaterEvent2;
    elseif index==3 then
        laterEvent=cfgEvent.LaterEvent3;
    end
    if laterEvent==nil or laterEvent[1][1]=="3" then

        LuaMgr.HidePanel(UIName.RogueExploreEventViewModel)
        return
    end;
    RogueMgr.OnAskCompleteEvent(curEventNumber, cfgEvent.Id,index,function()
        RogueExploreMgr.UpdateHandlerList();
        RogueExploreMgr.isContinue=true;
    end)
end



RogueExploreMgr.UpdateHandlerList=function()
    local isUpdate,unitsList= RogueExploreMgr.CheckHandlerHistoryList(curEventNumber);
    if isUpdate then
        handlerEventList=unitsList;
    end
end

RogueExploreMgr.GetCurHandlerEvent=function()
    return curHandlerEvent;
end

RogueExploreMgr.OnUpdate = function()
    if not RogueExploreMgr.isContinue or #handlerEventList == 0 then
        return ;
    end
    RogueExploreMgr.isContinue = false;
    curHandlerEvent = handlerEventList[1];
    table.remove(handlerEventList, 1);
    if curHandlerEvent.EventType == -1 then

        if IsNull(curHandlerEvent.EventParams) or #curHandlerEvent.EventParams==0 then
            LuaDebug.error("eventType==-1,but eventParams is Error, eventNumber is :"..curEventNumber);
            RogueExploreMgr.isContinue = true;
            return
        end
        local nextEventId=curHandlerEvent.EventParams[2];
        local reRe = RogueExploreMgr.CheckBuildingEvent(nextEventId);
        if reRe == 0 then
            RogueExploreMgr.isContinue = true;
        end
    else
        RogueExploreMgr.HandlerCompleteEvent(curHandlerEvent);
    end
end





















RogueExploreMgr.HandlerCompleteEvent = function(reData)


    if reData==nil then
        LuaDebug.error("reData is nil,eventNumber is :"..curEventNumber);
        return
    end
    RogueExploreMgr.CheckHideEventPanel();

    if reData.EventType == 0 then

        RogueExploreMgr.isContinue = true;
    elseif reData.EventType == 1 then
        RogueExploreMgr.TriggerBattlePrepare(reData.EventParams)
    elseif reData.EventType == 2 then
        RogueExploreMgr.TriggerNovel(reData.EventParams)
    elseif reData.EventType == 3 then
        RogueExploreMgr.TriggerCharacter()
    elseif reData.EventType == 4 then
        RogueExploreMgr.TriggerShop()
    elseif reData.EventType == 5 then
        RogueExploreMgr.TriggerBUFF()
    elseif reData.EventType == 6 or reData.EventType == 8 or reData.EventType == 9 or reData.EventType == 13 then
        RogueExploreMgr.TriggerChangeItem(reData.EventParams)
    elseif reData.EventType == 7 then
        RogueExploreMgr.TriggerExit(reData.EventParams)
        RogueExploreMgr.isContinue = true;
    elseif reData.EventType == 10 then
        RogueExploreMgr.TriggerExploreEnd(nil)
    elseif reData.EventType==14 then

        RogueExploreMgr.TriggerSwitchMap(reData.EventParams)
        RogueExploreMgr.isContinue = true;
    elseif reData.EventType==15 then

        RogueExploreMgr.TriggerPauseEvent(reData.EventParams);
        RogueExploreMgr.isContinue=true;
    end
    if reData.EventType == 0 or reData.EventType == 6 or reData.EventType == 8 or reData.EventType == 9
            or reData.EventType == 11 or reData.EventType == 12 or reData.EventType == 13 or reData.EventType == 14 then
        RogueMgr.OnAskConfrimCharacterOrBUFF(mapId,curEventNumber,"",function()
            if reData.EventType == 9 then

                if DataMgr.Player.Rogue.Oxygen<1 then
                    RogueExploreMgr.TriggerExploreEnd(nil);
                    return;
                end
            end
            if reData.EventType == 11 or reData.EventType == 12 then
                RogueExploreMgr.isContinue=true;
            end
            LuaMgr.InvokeUIEventListeners(UIEventConst.RogueEventType,reData)
        end)
    else
        LuaMgr.InvokeUIEventListeners(UIEventConst.RogueEventType,reData)
    end
end
    

RogueExploreMgr.CheckHideEventPanel = function()
    if LuaMgr.IsPanelOpen(UIName.RogueExploreEventViewModel) then
        LuaMgr.HidePanel(UIName.RogueExploreEventViewModel)
    end
end

RogueExploreMgr.CheckContinue=function()
    RogueExploreMgr.isContinue=true;
end


RogueExploreMgr.TriggerBattlePrepare = function(eventParam)
    local dungeonId = eventParam[1];
    RogueExploreMgr.CheckHideEventPanel();
    BattlePrepareMgr.isRogue = true;
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = dungeonId
    enterDungeonParams.dungeonId = dungeonId
    enterDungeonParams.battleType = "Rogue"
    enterDungeonParams.themeId = "Rogue"
    BattlePrepareMgr.BattlePrepare(enterDungeonParams)
end

RogueExploreMgr.TriggerNovel = function(eventParam)
    RogueExploreMgr.CheckHideEventPanel();
    local novelId = eventParam[1];
    LuaMgr.SetRogueDataByNovel(mapId,curEventNumber)
    LuaMgr.PlayNovel(novelId, function()
        LuaMgr.ShowLuaPanel(UIName.RogueExploreViewModel);
        LuaMgr.SetRogueDataByNovel(nil,nil)
        RogueExploreMgr.isContinue = true;
    end)
end

RogueExploreMgr.TriggerCharacter = function()
    LuaMgr.ShowLuaPanel(UIName.RogueExploreHeroSelectViewModel,curEventNumber)
end

RogueExploreMgr.TriggerShop = function()
    LuaMgr.ShowLuaPanel(UIName.RogueExploreShopViewModel,curEventNumber,function() 
        RogueExploreMgr.isContinue=true;
    end);
end

RogueExploreMgr.TriggerBUFF = function()
    if curEventNumber==nil then
        LuaMgr.ShowLuaPanel(UIName.RogueExploreBuffSelectViewModel);
    else
        LuaMgr.ShowLuaPanel(UIName.RogueExploreBuffSelectViewModel,curEventNumber);
    end
end

RogueExploreMgr.TriggerChangeItem = function(eventParam)

end

RogueExploreMgr.TriggerExit = function(eventParam)

end


RogueExploreMgr.TriggerExploreEnd = function(callBack)
    LuaMgr.HidePanel(UIName.RogueTipsViewModel)
    RogueExploreMgr.ClearHandlerList();
    RogueMgr.OnAskExploreEnd(function()
        HeroParameter.EmptyRogueParam()
        if callBack~=nil then
            callBack();
        end
        LuaMgr.ShowLuaPanel(UIName.RogueResultViewModel,function()
            LuaMgr.ShowLuaPanel(UIName.RogueMain2ViewModel)
        end)
    end)
end


RogueExploreMgr.TriggerSwitchMap=function(eventParam)
    LuaMgr.InvokeUIEventListeners(UIEventConst.RogueSwitchMapStart);
end

RogueExploreMgr.TriggerPauseEvent=function(eventParam)
    
end


return RogueExploreMgr