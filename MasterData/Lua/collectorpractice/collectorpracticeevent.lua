
CollectorPracticeEvent = {};
local this = {};
CollectorPracticeEvent.GMEvent = nil
CollectorEventType = {

    Puzzle = 3,
    Answer = 2,
    Card = 4

}

CollectorPracticeEvent.SetEvent = function(id, funs)
    this.funs = funs
    CollectorPracticeEvent.Id = id
    local intertConfig = ConfigMgr.Config.InternEventKV[id]






    CollectorPracticeEvent.OpenMiniGame(intertConfig, id)

end

CollectorPracticeEvent.OpenMiniGame = function(intertConfig, id)
    if not LuaMgr.IsPanelOpen(UIName.CollectorPracticeMainSceneViewModel) then
        print("CollectorPracticeMainSceneViewModel is close ")
        return
    end
    
    local currentThemId = CollectorPracticeMgr.ThemData.mapType
    local eventType = intertConfig.EventType
    local functionName = "MiniGameEven_" .. intertConfig.EventType
    if CollectorPracticeEvent[functionName] ~= nil then
        CollectorPracticeEvent.GMEvent = nil
        CollectorPracticeEvent[functionName](intertConfig.EventType, currentThemId)
    else
        local MapeventData = ConfigMgr.Config.EventStoryMap
        local evenMaps = false
        for key, value in pairs(MapeventData) do
            if eventType == value.EventType then
                evenMaps = true
                break
            end
        end
        if not evenMaps then
            if CollectorPracticeEvent.GMEvent ~= nil then
                CollectorPracticeEvent.CommonEvent(id)
            end
        else
            CollectorPracticeEvent.GMEvent = nil
            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeMapEventViewModel, currentThemId, eventType, intertConfig.Id)
        end





    end
end

CollectorPracticeEvent.OpenMiniGameByEventId = function(eventId,UseItem,forceOpen)
    local currentThemId = CollectorPracticeMgr.ThemData.mapType
    local eventType=nil;
    if ConfigMgr.Config.EventStoryMap[eventId]~=nil then
        eventType=ConfigMgr.Config.EventStoryMap[eventId].EventType
    else
        eventType=ConfigMgr.Config.InternEventKV[eventId].EventType
    end
    
    local functionName = "MiniGameEven_" .. eventType
    if CollectorPracticeEvent[functionName] ~= nil then
        CollectorPracticeEvent.GMEvent = nil
CollectorPracticeMgr.ForceAddEventListener()
        CollectorPracticeEvent[functionName](eventType, currentThemId)
    else
        local MapeventData = ConfigMgr.Config.EventStoryMap
        local evenMaps = false
if ConfigMgr.Config.EventStoryMap[eventId]~=nil then
            evenMaps = true
        end
        if not evenMaps then
            if CollectorPracticeEvent.GMEvent ~= nil then
                CollectorPracticeEvent.CommonEvent(eventId)
            end
        else
            CollectorPracticeEvent.GMEvent = nil
            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeMapEventViewModel, currentThemId, eventType, eventId,UseItem,forceOpen)
        end
    end
end

CollectorPracticeEvent.closeEvent = function(id)

end

CollectorPracticeEvent.NovelEvent = function()

end


CollectorPracticeEvent.MiniGameEven_2 = function(type, themId)
    local currentThemId = themId
    local paramEventid = type
    local Result
    local data = { EventType = paramEventid, ThemeId = currentThemId }
    local Url = "monopoly/get_question"
    ApiMgr.Request(Url, data, true,
    function(result)
        Result = result
        LuaMgr.ShowLuaPanel(UIName.MiniGameAnswerViewModel, currentThemId, paramEventid)
    end,
    function(failCode)
        print("EnterDungeonError,ErrorCode:", failCode)
    end,
    true
    )

end



CollectorPracticeEvent.MiniGameEven_5 = function(type, themId)
    local currentThemId = themId
    local paramEventid = type
    local Result
    local data = { EventType = paramEventid, ThemeId = currentThemId }
    local Url = "fish/get_id"
    ApiMgr.Request(Url, data, true,
            function(result)
                Result = result
                LuaMgr.ShowLuaPanel(UIName.MiniGameFishViewModel, currentThemId, paramEventid)
            end,
            function(failCode)
                print("EnterDungeonError,ErrorCode:", failCode)
            end,
            true
    )

end



CollectorPracticeEvent.MiniGameEven_4 = function(type, themId)
    local currentThemId = themId
    local paramEventid = type
    local Result
    local data = { EventType = paramEventid, ThemeId = currentThemId }
    local Url = "monopoly/flipcard/get"
    ApiMgr.Request(Url, data, true,
    function(result)
        Result = result
        LuaMgr.ShowLuaPanel(UIName.MiniGameCardViewModel, result, currentThemId, paramEventid)
    end,
    function(failCode)
        print("EnterDungeonError,ErrorCode:", failCode)
    end,
    true
    )

end


CollectorPracticeEvent.MiniGameEven_3 = function(type, themId)
    local currentThemId = themId

    local paramEventid = type
    local data = { EventType = type, ThemeId = currentThemId }
    local Url = "puzzle/get_id"
    ApiMgr.Request(Url, data, true,
    function(result)
        local re = json.decode(result)
        local puzzleId = re.result.CurId
        LuaMgr.ShowLuaPanel(UIName.MiniGamePuzzleViewModel, currentThemId, paramEventid, puzzleId)

    end,
    function(failCode)
        print("EnterDungeonError,ErrorCode:", failCode)
    end,
    true
    )

end


CollectorPracticeEvent.MiniGameEven_19 = function(type, themId)




    LuaMgr.ShowLuaPanel(UIName.MiniGameSportsExpertsViewModel, themId, type)
end


CollectorPracticeEvent.MiniGameEven_10 = function(type, themId)
    local nowRefrestTime = DataMgr.Player.practicesStage.refreshTime;
    for key, value in pairs(ConfigMgr.Config.RelicsMap) do
if DataMgr.Player.relics ~= nil and DataMgr.Player.relics[value.RelicsId] ~= nil and DataMgr.Player.relics[value.RelicsId].Time > nowRefrestTime then
            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeFinishEventViewModel, themId, type,true,nowRefrestTime)
            return;
        end
    end

LuaMgr.InvokeUIEventListeners(UIEventConst.CollectorRandomRewardRefush);
    
end



CollectorPracticeEvent.MiniGameEven_9 = function(type, themId)
    print("themId"..tostring(themId))
    CollectorPracticeMgr.isByBattleViewModel=true;
   local stageId = DataMgr.Player.stageTreasure.StageId
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = stageId
    enterDungeonParams.dungeonId = stageId
    enterDungeonParams.themeId=themId
    enterDungeonParams.eventType=type

    local extraList={};
    table.insert(extraList,themId);
    table.insert(extraList,tostring(type));
    
    enterDungeonParams.extraParams=extraList
    
    BattlePrepareMgr.BattlePrepare(enterDungeonParams)
    
end


CollectorPracticeEvent.MiniGameEven_21 = function(type, themId)
    print("themId"..tostring(themId))
    CollectorPracticeMgr.isByBattleViewModel=true;
    local stageId = DataMgr.Player.stageTreasure.StageId
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = stageId
    enterDungeonParams.dungeonId = stageId
    enterDungeonParams.themeId=themId
    enterDungeonParams.eventType=type

    local extraList={};
    table.insert(extraList,themId);
    table.insert(extraList,tostring(type));
    if not IsNull(DataMgr.Player.practices.buffIds) then
        for i, v in ipairs(DataMgr.Player.practices.buffIds) do
            table.insert(extraList, v)
        end
    end

    enterDungeonParams.extraParams=extraList

    BattlePrepareMgr.BattlePrepare(enterDungeonParams)
end


CollectorPracticeEvent.CommonEvent = function(tabid)
    local intertConfig = ConfigMgr.Config.InternEventKV[tabid]
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("CollectorPracticeEvent_0") .. intertConfig.Id);
    CollectorPracticeEvent.GMEvent()
end