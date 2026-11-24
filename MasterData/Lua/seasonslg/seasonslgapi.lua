
SeasonSLGAPI = {

}

local lastAskMapStateTime = 0;


SeasonSLGAPI.OnAskSeasonalStory=function(gridId,storyId,optionIndex,callBack)
    local askData={
        GridId=tostring(gridId),
        StoryId=storyId,
        Option=tostring(optionIndex),
        TimedEventId=SeasonSLGEventMgr.curTimedEventId,
    }
    ApiMgr.Request("seasonal/story",askData,true,function(re)
        SeasonSLGMapMgr.CheckShowRewards(re);
        if callBack~=nil then
            callBack();
        end
    end,nil,true)
end


SeasonSLGAPI.OnAskSeasonalSweep=function(gridId,sweepId,count,members,callBack)
    local askData={
        GridId=tostring(gridId),
        SweepId=sweepId,
        Count=count,
        Members=members,
        TimedEventId=SeasonSLGEventMgr.curTimedEventId,
    }
    ApiMgr.Request("seasonal/sweep",askData,true,function(re)
        SeasonSLGMapMgr.CheckShowRewards(re);
        if callBack~=nil then
            callBack();
        end
    end,nil,true)
end

SeasonSLGAPI.OnAskResourceUpLevel=function(gridId,callBack)
    local askData={
        GridId=tostring(gridId),
        TimedEventId=SeasonSLGEventMgr.curTimedEventId,
    }
    ApiMgr.Request("seasonal/resource/levelup",askData,true,function(re)
        SeasonSLGMapMgr.CheckShowRewards(re);
        if callBack~=nil then
            callBack();
        end
    end,nil,true)
end


SeasonSLGAPI.OnAskResourceDispatch=function(gridId,resourceId,timeHour,members,callBack)
    local askData={
        GridId=tostring(gridId),
        ResourceId=resourceId,
        TimeHour=timeHour,
        Members=members,
    }
    ApiMgr.Request("seasonal/resource/dispatch",askData,true,function(repJson)
        local re=json.decode(repJson);
        local data=json.encode(re.result.Reward);
        LuaMgr.ShowItemRewared(data);
        if callBack~=nil then
            callBack(re.result.Progress);
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGBlockDispatchStatusChange);
    end,nil,true)
end


SeasonSLGAPI.OnAskCancleDispatch=function(gridId,resourceId,callBack)
    local askData={
        GridId=tostring(gridId),
        ResourceId=resourceId,
    }
    ApiMgr.Request("seasonal/resource/cancel",askData,true,function(repJson)
        if callBack~=nil then
            callBack();
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGBlockDispatchStatusChange);
    end,nil,true)
end


SeasonSLGAPI.OnAskResourceDispatchReward=function(grids,callBack)
    local askData={


        Grids = grids,
    }
    ApiMgr.Request("seasonal/resource/reward",askData,true,function(repJson)
        local re=json.decode(repJson);
        local data=json.encode(re.result.Reward);
        LuaMgr.ShowItemRewared(data);
        if callBack~=nil then
            callBack();
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGBlockDispatchStatusChange);

    end,nil,true)
end



SeasonSLGAPI.OnAskResourceDispatchProgress=function(gridId,resourceId,callBack)
    local askData={
        GridId=tostring(gridId),
        ResourceId=resourceId,
    }
    ApiMgr.Request("seasonal/resource/progress",askData,true,function(re)
        local re=json.decode(re);
        if callBack~=nil then
            callBack(re.result);
        end
    end,nil,true)
end


SeasonSLGAPI.OnAskDispatch=function(gridId,guardId1,guardId2,members1,members2,callBack)
    local askData={
        GridId=tostring(gridId),
        GuardId1=guardId1,
        GuardId2=guardId2,
        Members1=members1,
        Members2=#members2>0 and members2 or nil,
        TimedEventId=SeasonSLGEventMgr.curTimedEventId,
    }
    ApiMgr.Request("seasonal/guard",askData,true,function(re)
        SeasonSLGMapMgr.CheckShowRewards(re);
        if callBack~=nil then
            callBack();
        end
    end,nil,true)
end


SeasonSLGAPI.OnAskDispatchProgress=function(gridId,guardId2,callBack)
    local askData={
        GridId=tostring(gridId),
        GuardId=guardId2,
    }
    ApiMgr.Request("seasonal/guard/progress",askData,true,function(re)
        local re=json.decode(re);
        if callBack~=nil then
            callBack(re.result.Progress,re.result.Guild);
        end
    end,nil,true)
end




SeasonSLGAPI.OnAskPackUp=function(gridId,packUpId,time,callBack)
    local askData={
        GridId=tostring(gridId),
        PackUpId=packUpId,
        TimedEventId=SeasonSLGEventMgr.curTimedEventId,
        CompleteTime=time,
    }
    ApiMgr.Request("seasonal/packUp",askData,true,function(re)
        SeasonSLGMapMgr.CheckShowRewards(re);
        if callBack~=nil then
            callBack();
        end
    end,nil,true)
end


SeasonSLGAPI.OnAskBossRank=function(gridId,bossId,callBack)
    local askData={
        GridId=tostring(gridId),
        BossId=bossId,
    }
    ApiMgr.Request("seasonal/boss/rank",askData,true,function(re)
        local re=json.decode(re);
        if callBack~=nil then
            callBack(re.result);
        end
    end,nil,true)
end


SeasonSLGAPI.OnAskBossBattleComplete=function(gridId,callBack)
    local askData={
        GridId=tostring(gridId),
    }
    ApiMgr.Request("seasonal/battle/complete",askData,true,function(re)
        local re=json.decode(re);
        if callBack~=nil then
            callBack(re.result);
        end
    end,nil,true)
end


SeasonSLGAPI.OnAskTaskReward=function(taskIds,callBack)
    local askData={}
    if type(taskIds) == "table"  then
        askData.TaskIds = taskIds
    elseif type(taskIds) == "string" then
        askData.TaskId = taskIds
    else
        LuaDebug.error("SeasonSLGAPI.OnAskTaskReward 206 参数错误：" .. debug.traceback())
        return
    end
    ApiMgr.Request("seasonal/task",askData,true,function(re)
        SeasonSLGMapMgr.CheckShowRewards(re);
        if callBack~=nil then
            callBack(re);
        end
    end,nil,true)
end


SeasonSLGAPI.OnAskTimeEventDungeonProgress=function(gridId,eventId,callBack)
    local askData={
        GridId=gridId,
        EventId=eventId
    }
    ApiMgr.Request("seasonal/world/dungeon/progress",askData,true,function(re)
        local re=json.decode(re);
        if callBack~=nil then
            callBack(re.result.Progress);
        end
    end,nil,true)
end


SeasonSLGAPI.OnAskTimeEventDungeonReward=function(gridId,eventId,callBack)
    local askData={
        GridId=gridId,
        EventId=eventId
    }
    ApiMgr.Request("seasonal/world/dungeon/reward",askData,true,function(re)
        SeasonSLGMapMgr.CheckShowRewards(re);
        if callBack~=nil then
            callBack();
        end
    end,nil,true)
end


SeasonSLGAPI.OnAskTimeEventDispatch=function(gridId,guardId,timeHour,members,callBack)
    local askData={
        GridId=gridId,
        GuardId=guardId,
        Members=members,
        TimeHour=timeHour
    }
    ApiMgr.Request("seasonal/world/guard",askData,true,function(re)
        local re=json.decode(re);



        SeasonSLGAPI.UpdateEventProgressLocal(tostring(gridId),re.result.Progress,re.result.BossStage);
        if callBack~=nil then
            callBack(re.result.Progress);
        end
    end,nil,true)
end


SeasonSLGAPI.OnAskTimeEventDispatchCancel=function(gridId,guardId,callBack)
    local askData={
        GridId=gridId,
        GuardId=guardId,
    }
    ApiMgr.Request("seasonal/world/guard/cancel",askData,true,function(re)
        if callBack~=nil then
            callBack();
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGBlockDispatchStatusChange);
    end,nil,true)
end

SeasonSLGAPI.OnAskTimeEventDispatchProgress=function(gridId,eventId,callBack)
    local askData={
        GridId=gridId,
        GuardId=eventId
    }
    ApiMgr.Request("seasonal/world/guard/progress",askData,true,function(re)
        local re=json.decode(re);
        if callBack~=nil then
            callBack(re.result.Progress);
        end
    end,nil,true)
end

SeasonSLGAPI.OnAskTimeEventDispatchReward=function(grids,callBack)
    local askData={


        Grids = grids,

    }
    ApiMgr.Request("seasonal/world/guard/reward",askData,true,function(re)
        SeasonSLGMapMgr.CheckShowRewards(re);
        if callBack~=nil then
            callBack();
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGBlockDispatchStatusChange);
    end,nil,true)
end

SeasonSLGAPI.OnAskDispatchRewardMerge=function(worldDispatchGrids,resourceGrids,callBack)
    local askData={
        GuardGrids=worldDispatchGrids,
        ResourceGrids=resourceGrids,
    }
    ApiMgr.Request("seasonal/dispatch/reward/merge",askData,true,function(re)
        SeasonSLGMapMgr.CheckShowRewards(re);
        if callBack~=nil then
            callBack();
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGBlockDispatchStatusChange);
    end,nil,true)
end

SeasonSLGAPI.OnAskTimeEventBuild=function(gridId,buildId,itemId,itemCount,timeEventId,callBack)
    local askData={
        GridId=gridId,
        BuildId=buildId,
        ItemId=itemId,
        ItemCount=itemCount,
        TimedEventId=timeEventId,
    }
    ApiMgr.Request("seasonal/world/build",askData,true,function(re)
        local re=json.decode(re);
        local data=json.encode(re.result.Reward);
        LuaMgr.ShowItemRewared(data);

        SeasonSLGAPI.UpdateEventProgressLocal(tostring(gridId),re.result.Progress,re.result.BossStage);
        if callBack~=nil then
            callBack(re.result.Progress);
        end
    end,nil,true)
end

SeasonSLGAPI.OnAskTimeEventBuildProgress=function(gridId,eventId,callBack)
    local askData={
        GridId=gridId,
        BuildId=eventId
    }
    ApiMgr.Request("seasonal/world/build/progress",askData,true,function(re)
        local re=json.decode(re);
        if callBack~=nil then
            callBack(re.result.Progress);
        end
    end,nil,true)
end


SeasonSLGAPI.OnAskTimeEventBuildReward=function(gridId,eventId,callBack)
    local askData={
        GridId=gridId,
        BuildId=eventId
    }
    ApiMgr.Request("seasonal/world/build/reward",askData,true,function(re)
        SeasonSLGMapMgr.CheckShowRewards(re);
        if callBack~=nil then
            callBack();
        end
    end,nil,true)
end

SeasonSLGAPI.GetMisinterDebuffGridMap = function(timedEventProgress)
    if SeasonSLGMapMgr.CheckExistValidConfig() == false then
        return {}
    end
    local keyParts = {}
    for gridId, timedData in pairs(timedEventProgress or {}) do
        local attackConfig = timedData ~= nil and timedData.Config or nil
        if attackConfig ~= nil and attackConfig.SeasonalPersonalDeBuff ~= nil and #attackConfig.SeasonalPersonalDeBuff > 0 then
            table.insert(keyParts, tostring(gridId) .. ":" .. tostring(timedData.TimeEventID) .. ":" .. tostring(attackConfig.ShowIcon or 0))
        end
    end
    table.sort(keyParts)
    local key = table.concat(keyParts, "|")
    if SeasonSLGAPI._misinterDebuffKey == key and SeasonSLGAPI._misinterDebuffGridMap ~= nil then
        return SeasonSLGAPI._misinterDebuffGridMap
    end
    local result = {}
    local smallGrid = {}
    local bossGrid = {}
    for _, value in pairs(SeasonSLGMapMgr.Constants().SeasonalDebuffGridSmall or {}) do smallGrid[value] = true end
    for _, value in pairs(SeasonSLGMapMgr.Constants().SeasonalDeBuffGrid or {}) do bossGrid[value] = true end
    for _, timedData in pairs(timedEventProgress or {}) do
        local attackConfig = timedData ~= nil and timedData.Config or nil
        if attackConfig ~= nil and attackConfig.SeasonalPersonalDeBuff ~= nil and #attackConfig.SeasonalPersonalDeBuff > 0 then
            local neighbors = SeasonSLGMapMgr.GetNeighborDataByIndex(tostring(timedData.GridID))
            local affected = attackConfig.ShowIcon == 1 and bossGrid or smallGrid
            for neighborIndex, neighborData in pairs(neighbors or {}) do
                if affected[neighborIndex] == true and neighborData ~= nil then result[tostring(neighborData.index)] = true end
            end
        end
    end
    SeasonSLGAPI._misinterDebuffKey = key
    SeasonSLGAPI._misinterDebuffGridMap = result
    return result
end

SeasonSLGAPI.OnAskUpdateMapState=function(success,failed,isRetry,checkNotice)
    if SeasonSLGMapMgr.CheckExistValidConfig() == false then
        return
    end


    local now=UnityEngine.Time.realtimeSinceStartup;
    if lastAskMapStateTime>0 and now-lastAskMapStateTime<3 then
        if success ~= nil then
            success(SeasonSLGMapMgr.MapStateData)
        end
        return;
    end
    lastAskMapStateTime=now;
    local askData={
    }
    ApiMgr.RequestByLua("seasonal/map/state",askData,true,function(orginRes)
        local decodeRes=json.decode(orginRes);

        local previousMapStateData = SeasonSLGMapMgr.MapStateData;
        local previousEventProgress = previousMapStateData and previousMapStateData.EventProgress or nil;
        local previousTimedEventProgress = previousMapStateData and previousMapStateData.TimedEventProgress or nil;
        SeasonSLGMapMgr.MapStateData=decodeRes.result;
        SeasonSLGMapMgr.MapStateData.OldEventProgress = previousEventProgress;
        SeasonSLGMapMgr.MapStateData.OldTimedEventProgress = previousTimedEventProgress;
        SeasonSLGMapMgr.MapStateData.EventProgress = SeasonSLGAPI.GetMapStateData(decodeRes.result.GridProgress, 2)
        SeasonSLGMapMgr.MapStateData.TimedEventProgress = SeasonSLGAPI.GetMapStateData(decodeRes.result.TimedEvents, 3)
        SeasonSLGMapMgr.MapStateData.AllMisinterBuff = decodeRes.result.WorldAttackBuff



         local misinterDebuffGridMap = SeasonSLGAPI.GetMisinterDebuffGridMap(SeasonSLGMapMgr.MapStateData.TimedEventProgress)

        SeasonSLGMapMgr.eventProgressDirty=true;
        local latestProgress=SeasonSLGMapMgr.latestEventProgress;
        if latestProgress~=nil then
            for gridId,localData in pairs(latestProgress) do
                if localData~=nil and localData.Progress~=nil then

                    local newData=SeasonSLGMapMgr.MapStateData.EventProgress[gridId];
                    if newData==nil then
                        newData={Progress=localData.Progress};
                        SeasonSLGMapMgr.MapStateData.EventProgress[gridId]=newData;
                    elseif newData.Progress==nil then
                        newData.Progress=localData.Progress;
                    elseif newData.Progress<localData.Progress then

                        if not misinterDebuffGridMap[tostring(gridId)] then
                            newData.Progress=localData.Progress;
                        end
                    end


                    if localData.BossStage~=nil and not IsNull(localData.BossStage) then
                        local bossId=localData.BossStage.BossId;
                        local newBoss=SeasonSLGMapMgr.MapStateData.BossStage and SeasonSLGMapMgr.MapStateData.BossStage[bossId];
                        local isOverride=false;
                        if newBoss==nil then

                            isOverride=true;
                        else
                            local newStage=newBoss.Stage or 0;
                            local newProgress=newBoss.Progress or 0;
                            local localStage=localData.BossStage.Stage or 0;
                            local localProgress=localData.BossStage.Progress or 0;
                            if localStage>newStage or (localStage==newStage and localProgress>newProgress) then

                                isOverride=true;
                            end
                        end
                        if isOverride then
                            if SeasonSLGMapMgr.MapStateData.BossStage==nil then
                                SeasonSLGMapMgr.MapStateData.BossStage={};
                            end
                            SeasonSLGMapMgr.MapStateData.BossStage[bossId]=localData.BossStage;
                        end
                    end
                end
            end
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGUpdateMapState, SeasonSLGMapMgr.MapStateData)

        if SeasonSLGTimeEventMgr ~= nil and SeasonSLGTimeEventMgr.TryBackfillNoticeRecord ~= nil then
            SeasonSLGTimeEventMgr.TryBackfillNoticeRecord()
        end
        local nowTime = LuaMgr.Timestamp()
        if checkNotice then
            SeasonSLGTimeEventMgr.CheckEventNotice(nowTime)
        end
        if success then
            success(SeasonSLGMapMgr.MapStateData)
        end






    end,nil,false,false)
end

SeasonSLGAPI.OnAskTechActivate = function(techID, callBack)
    local data = {}
    data.TechId = techID
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("请求错误:" .. res.code)
            return
        end
        if callBack ~= nil then
            callBack(techID)
        end
    end
    ApiMgr.Request("seasonal/tech/unlock", data, true, onSucc, nil, false)
end

SeasonSLGAPI.OnAskCommonRank = function(callBack)
    local data = {}
    local onSucc = function(result)
        local res = json.decode(result)
        if callBack ~= nil then
            callBack(res.result.RankData)
        end
    end
    ApiMgr.Request("seasonal/common/rank", data, true, onSucc, nil, false)
end


SeasonSLGAPI.OnAskBlockUnlockByPower = function(gridId,callBack)
    local data = {
        GridId=gridId
    }
    local onSucc = function(result)
        local re = json.decode(result)

        local data=json.encode(re.result.Reward);
        if callBack ~= nil then
            callBack(data)
        end
    end
    ApiMgr.Request("seasonal/active", data, true, onSucc, nil, true)
end




SeasonSLGAPI.UpdateEventProgressLocal = function(gridId,progress,bossStage)
    if SeasonSLGMapMgr.MapStateData.EventProgress == nil then
        SeasonSLGMapMgr.MapStateData.EventProgress = {}
    end
    local progressData = SeasonSLGMapMgr.MapStateData.EventProgress[tostring(gridId)]
    if progressData == nil then
        progressData = {}
        progressData.Progress = 0
        SeasonSLGMapMgr.MapStateData.EventProgress[tostring(gridId)] = progressData
    end
    if progressData.Progress < progress then
        progressData.Progress = progress
        progress = progressData.Progress
    end

    local latestData = {
        Progress = progress,
        BossStage = bossStage,
    }
    SeasonSLGMapMgr.latestEventProgress[tostring(gridId)] = latestData
    if not IsNull(bossStage) then
        if SeasonSLGMapMgr.MapStateData.BossStage==nil then
            SeasonSLGMapMgr.MapStateData.BossStage={};
        end
        SeasonSLGMapMgr.MapStateData.BossStage[bossStage.BossId] = bossStage
    end

    SeasonSLGMapMgr.eventProgressDirty=true;


    DataMgr.playerDataVersion = (DataMgr.playerDataVersion or 0) + 1;
    LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGUpdateMapState)
end

SeasonSLGAPI.OnAskBlockUnlockProgress = function(gridId,callBack)
    local data = {
        GridId=gridId
    }
    local onSucc = function(result)
        local re = json.decode(result)

        SeasonSLGAPI.UpdateEventProgressLocal(tostring(gridId),re.result.Progress,re.result.BossStage);
        if callBack ~= nil then
            callBack(re.result)
        end
    end
    ApiMgr.Request("seasonal/grid/progress", data, true, onSucc, nil, true,false)
end

SeasonSLGAPI.OnAskSeasonalPlayerImage = function(characterId,skinId,callBack)
    local data = {
        SeasonalImage=characterId,
        SeasonalImageSkin=skinId,
    }
    local onSucc = function(result)
        if callBack ~= nil then
            callBack()
        end
    end
    ApiMgr.Request("seasonal/image", data, true, onSucc, nil, true)
end


SeasonSLGAPI.OnAskSeasonalMisinter = function(data, callBack)
    local onSucc = function(result)
        if callBack ~= nil then
            callBack()
        end
    end
    local askData={
        AttackGrid=data
    }
    ApiMgr.Request("seasonal/world/attack", askData, true, onSucc, nil, false)
end


SeasonSLGAPI.OnAskTopRankReward = function(title,desc,gridId)
    local onSucc = function(result)
        SeasonSLGMapMgr.CheckShowRewardsNew(result,title,desc);
    end
    ApiMgr.Request("seasonal/grid/rewards", {GridId = tostring(gridId)}, true, onSucc, nil, true)
end


SeasonSLGAPI.OnAskAddGridProgress = function(datas, callback)
    local onSucc = function(result)
        if callback ~= nil then
            callback()
        end
    end
    local data = {}
    data.GridIds = datas
    ApiMgr.Request("admin/seasonal/grid/progress", data, true, onSucc, nil, true)
end

SeasonSLGAPI.OnAskClearMisinter = function(callback)
    local onSucc = function(result)
        if callback ~= nil then
            callback()
        end
    end
    ApiMgr.Request("admin/seasonal/reset/timed", {}, true, onSucc, nil, true)
end


SeasonSLGAPI.OnAskAddTechPoint = function(callback)
    local onSucc = function(result)
        if callback ~= nil then
            callback()
        end
    end
    local data = {}
    data.Count = 10000
    ApiMgr.Request("admin/seasonal/guild/point", data, true, onSucc, nil, true)
end







SeasonSLGAPI.GetMapStateData = function(orginData, step)
    local dataDic = {}
    if type(orginData) ~= "table" then
        return dataDic
    end
    if step == 2 then


        local _diagSum = 0;
        for i = 1, #orginData, step do
            local data = {}
            data.GridID = tostring(orginData[i])
            data.Progress = orginData[i + 1]
            dataDic[data.GridID] = data
            _diagSum = _diagSum + (tonumber(orginData[i]) or 0) * 31 + (tonumber(orginData[i + 1]) or 0);
        end
        SeasonSLGAPI.lastGridProgressChecksum = _diagSum;
    elseif step == 3 then
        for i = 1, #orginData, step do
            local data = {}
            data.GridID = tostring(orginData[i])




            if orginData[i + 1] ~= nil then
                data.TimeEventID = tostring(orginData[i + 1]);
            end
            data.Progress = tonumber(orginData[i + 2]) or 0
            local cfgWorldAttack=ConfigMgr.Config.SeasonalGridWorldAttackMap[data.TimeEventID]
            if cfgWorldAttack ~= nil then
                data.EventType = SeasonSLGConst.GridFuncType.Misinter
                data.Config = cfgWorldAttack
            end
            if data.GridID ~= 0 then
                dataDic[data.GridID] = data
            end
        end
    end
    return dataDic
end



SeasonSLGAPI.OnAskSeasonalCharacterTalent = function(characterId,talentId,success)
    local data={
        SeasonalCharacterId=characterId,
        SeasonalTalentId=talentId
    }
    ApiMgr.Request("seasonal/character/talent", data, true, success, nil, true)
end



SeasonSLGAPI.OnAskDebugUnLockGrid = function(gridIds,success)
    ApiMgr.Request("admin/seasonal/grid/progress", {GridIds = gridIds}, true, success, nil, true)
end


SeasonSLGAPI.OnAskClaimChest = function(gridId, callBack)
    local data = {
        GridId = tostring(gridId)
    }
    local onSucc = function(result)
        local re = json.decode(result)
        if callBack ~= nil then
            callBack(re.result.Reward or re.result)
        end
    end
    local onFailed = function()

        local mockReward = SeasonSLGMapMgr.GetMockChestReward()
        if callBack ~= nil then
            callBack(mockReward)
        end
    end

    ApiMgr.Request("seasonal/chest/claim", data, true, onSucc, onFailed, false)
end


return SeasonSLGAPI