
local this = {

}

SeasonSLGEventMgr = {
   curGridIndex=nil;
   bossRankMap={},
   bossContinueData=nil;
   WORLDPROGRESS="WORLDPROGRESS",
   curTimedEventId="";
   boss2Param=nil;
   isUnlockPower=false;
    pendingStoryResult=nil;
   dispatchMembers={};

}

SeasonSLGEventMgr.Clear=function()
    SeasonSLGEventMgr.bossContinueData=nil;
    SeasonSLGEventMgr.curGridIndex=nil;
    SeasonSLGEventMgr.boss2Param=nil;
    SeasonSLGEventMgr.pendingStoryResult=nil;
end


SeasonSLGEventMgr.GetGridEventProgress=function(index,isTimeCoverEvent)

    local gridData=DataMgr.Player.SeasonalGrid[tostring(index)]
    if isTimeCoverEvent and SeasonSLGMapMgr.timeEventGridMap[tostring(index)]~=nil then
        gridData=DataMgr.Player.SeasonalTimedEvent[tostring(index)]
    end
    if gridData==nil then
        return 0;
    else
        return gridData.Status;
    end
end


SeasonSLGEventMgr.DOGridEventContinue=function()
    if SeasonSLGEventMgr.curGridIndex~=nil then
        SeasonSLGEventMgr.DOGridEvent(SeasonSLGEventMgr.curGridIndex);
    end
end

SeasonSLGEventMgr.DOGridFunction=function(param)
    if IsNull(param) or #param==0 then
        return
    end
    if param[1]=="1" then
        SeasonSLGEventMgr.DOEventStory(param[2]);
    elseif param[1]=="2" then
        SeasonSLGEventMgr.DOEventDungeon(param[1],param[2]);
    elseif param[1]=="3" then
        SeasonSLGEventMgr.DOEventSweep(param[2]);
    elseif param[1]=="4" then
        SeasonSLGEventMgr.DOEventResource(param);
    elseif param[1]=="5" then
        LuaDebug.error("类型5 守护派遣 已废弃:"..tostring(SeasonSLGEventMgr.curGridIndex));

    elseif param[1]=="6" then
        SeasonSLGEventMgr.DOEventMiniGame(param);
    elseif param[1]=="7" then
        SeasonSLGEventMgr.DOEventBoss(param);
    elseif param[1]=="8" then
        SeasonSLGEventMgr.DOEventLimitDungeon(param);
    elseif param[1]=="9" then
        SeasonSLGEventMgr.DOEventLimitBuild(param);
    elseif param[1]=="10" then
        SeasonSLGEventMgr.DOEventLimitDispatch(param);
    elseif param[1]=="11" then
        SeasonSLGEventMgr.DOEventMisinter(param);
    elseif param[1]=="14" then
        SeasonSLGEventMgr.DOEventQuickBattle(param[1],param[2]);
    end
end

SeasonSLGEventMgr.DOGridEvent=function(index)
    LuaDebug.error("GridIndex:"..index);
    if this.clickBlockLock == true then
        return
    end
    SeasonSLGMapMgr.SetLastClickGridIndex(index)
    this.clickBlockLock = true
    SeasonSLGEventMgr.ResetOpenPopupFlag()





    local cfgGrid=table.Copy(SeasonSLGMapMgr.gridMap[tostring(index)]);
    local curProIndex = 0
    if cfgGrid==nil then return end;
    if not IsNullOrEmpty(cfgGrid.Connect) and tonumber(cfgGrid.Connect)~=index then
        index=tonumber(cfgGrid.Connect);

        cfgGrid=SeasonSLGMapMgr.gridMap[tostring(index)];
    end


    local timedProgressData=SeasonSLGMapMgr.GetGridMisinterData(index);
    local isTimeCover = false
    if timedProgressData~=nil then
        isTimeCover = true

        local attackFunction={}
        attackFunction[1]="11"
        attackFunction[2]=timedProgressData.TimeEventID
        cfgGrid.EventList=cfgGrid.EventList;
        cfgGrid.Function=attackFunction;
        SeasonSLGEventMgr.curTimedEventId=timedProgressData.TimeEventID;
    else
        SeasonSLGEventMgr.curTimedEventId=""
    end
    SeasonSLGEventMgr.curGridIndex=index;
    if isTimeCover then
        SeasonSLGEventMgr.DOGridFunction(cfgGrid.Function);
        return;
    end
    if not IsNull(cfgGrid.EventStory) and #cfgGrid.EventStory > 0 then
        if DataMgr.Player.SeasonalStory[tostring(index)] == nil then
            SeasonSLGEventMgr.DOGridFunction(cfgGrid.EventStory);
            return
        end
    end
    local unlock=SeasonSLGMapMgr.CheckBlockEventsIsComplete(tostring(index),isTimeCover);
    if unlock or #cfgGrid.EventList <= 0 then
        if IsNull(cfgGrid.Function) or #cfgGrid.Function==0 then

            if not IsNullOrEmpty(cfgGrid.CostType) and curProIndex==0 then
                SeasonSLGEventMgr.DOEventCostType(cfgGrid.CostType);
            end
            return
        end
        SeasonSLGEventMgr.DOGridFunction(cfgGrid.Function);
        return;
    end
    if IsNull(cfgGrid.EventList) then
        LuaDebug.error("cfgGrid.EventList is nil:"..index)
        return
    end
    local curEvent=cfgGrid.EventList[curProIndex+1]
    local evetType,eventId=curEvent[1],curEvent[2];
    local doCallBack=function()
        SeasonSLGEventMgr.DOGridFunction(curEvent);
    end
    if curProIndex==0 and (evetType == "1") then
        local gridName=SeasonSLGMapMgr.GetGridName(index);
        local des=LuaMgr.GetLangText("SeasonSLGEventMgr_0")
        local btnName=LuaMgr.GetLangText("SeasonSLGEventMgr_1")
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventCommonPopupViewModel,gridName,des,btnName,doCallBack)
    else
        doCallBack();
    end
end


SeasonSLGEventMgr.ResetOpenPopupFlag = function()
    if this.openPopupTween ~= nil then
        this.openPopupTween:Kill()
    end
    this.openPopupTween = DOTWeen:Sequence()
    local callback = function()
        this.clickBlockLock = false
    end
    this.openPopupTween:AppendInterval(0.5):OnComplete(callback)
end

SeasonSLGEventMgr.DOEventCostType=function(costTypeId)
    if SeasonSLGEventMgr.isUnlockPower then return end;
    SeasonSLGEventMgr.isUnlockPower=true;
    SeasonSLGAPI.OnAskBlockUnlockByPower(tostring(SeasonSLGEventMgr.curGridIndex),function(dataStr)
        LuaMgr.InvokeUIEventListeners(UIEventConst.SLGSeasonMapCostPower,SeasonSLGEventMgr.curGridIndex,costTypeId,dataStr);
    end);
end


SeasonSLGEventMgr.DOEventChest=function(index)
    if not SeasonSLGMapMgr.CanClaimChest() then
        local maxLimit = SeasonSLGMapMgr.GetChestDailyMax()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(LuaMgr.GetLangText("SeasonSLGEventMgr_11"), maxLimit, maxLimit))
        return
    end
    SeasonSLGAPI.OnAskClaimChest(index, function(rewardData)
        SeasonSLGMapMgr.OnClaimChestSuccess(index, rewardData)
        local rewardJson = json.encode(rewardData.Reward or rewardData)
        LuaMgr.ShowItemRewared(rewardJson)

        LuaMgr.InvokeUIEventListeners(UIEventConst.SLGSeasonMapUnLock, index)
    end)
end

SeasonSLGEventMgr.UpdateUnLockProgress=function()
    LuaMgr.InvokeUIEventListeners(UIEventConst.SLGSeasonMapUnLock,SeasonSLGEventMgr.curGridIndex);
end


SeasonSLGEventMgr.DOEventStory=function(eventId)
    local eventStory=ConfigMgr.Config.SeasonalEventStoryMap[eventId];
    if eventStory==nil then
        LuaDebug.error("eventStory is nil:"..eventId)
        return
    end;
    LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventStoryPopupViewModel,eventId)
end

SeasonSLGEventMgr.DOEventDungeon=function(eventType,eventId)
    local eventDungeon=ConfigMgr.Config.SeasonalEventDungeonMap[eventId]
    if eventDungeon==nil then
        LuaDebug.error("eventDungeon is nil:"..eventId)
        return;
    end




    SeasonSLGAPI.OnAskBlockUnlockProgress(tostring(SeasonSLGEventMgr.curGridIndex),function(re)
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventNormalGridViewModel,eventType,eventId,re)
    end)
end

SeasonSLGEventMgr.DOEventSweep=function(eventId)
    local eventSweep=ConfigMgr.Config.SeasonalEventSweepMap[eventId]
    if eventSweep==nil then
        LuaDebug.error("eventSweep is nil:"..eventId)
        return;
    end
    LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventSweepPopupViewModel,eventId)
end


SeasonSLGEventMgr.DOEventResource=function(param)





    SeasonSLGAPI.OnAskBlockUnlockProgress(tostring(SeasonSLGEventMgr.curGridIndex),function(re)
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventResUpLevelPopupViewModel,param[2],re)
    end)
end

SeasonSLGEventMgr.DOEventDispatch=function(param)

    SeasonSLGAPI.OnAskDispatchProgress(tostring(SeasonSLGEventMgr.curGridIndex),param[3],function(progress,guildName)
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventDispatchInfoPopupViewModel,param[2],param[3],progress,guildName)
    end)
end

SeasonSLGEventMgr.DOEventMiniGame=function(param)
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSLGEventMgr_2"))
    SeasonSLGMapMgr.UpdateMapGridState();



end


SeasonSLGEventMgr.DOEventEmpty=function(param)

end


SeasonSLGEventMgr.DOEventLimitDungeon=function(param)
    local gridId=tostring(SeasonSLGEventMgr.curGridIndex);
    local wordDungeon=ConfigMgr.Config.SeasonalGridWorldDungeonMap[param[2]]
    if wordDungeon==nil then
        return
    end
    local title=ConfigMgr.LangGlobal(wordDungeon.Name)
    local des=ConfigMgr.LangGlobal(wordDungeon.Desc)
    local buttonName=LuaMgr.GetLangText("SeasonSLGEventMgr_3");
    local remainTime=0;
    if #param>2 then
        gridId=param[3];
    end
    local dataTimeEvent=DataMgr.Player.SeasonalTimedEvent[gridId]
    if dataTimeEvent~=nil then
        remainTime=dataTimeEvent.ExpireTime-LuaMgr.Timestamp();
    end

        if #param>2 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSLGEventMgr_4"));
            return;
        end




        SeasonSLGAPI.OnAskBlockUnlockProgress(tostring(gridId),function(re)
            LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventLimitDungeonViewModel,param[1],param[2],re)
        end)



end


SeasonSLGEventMgr.DOEventQuickBattle=function(eventType,eventId)
    local eventDungeon=ConfigMgr.Config.SeasonalEventDungeonMap[eventId]
    if eventDungeon==nil then
        LuaDebug.error("eventDungeon is nil:"..eventId)
        return;
    end
    SeasonSLGAPI.OnAskBlockUnlockProgress(tostring(SeasonSLGEventMgr.curGridIndex),function(re)
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventQuickBattleGridViewModel,eventType,eventId,re)
    end)
end



SeasonSLGEventMgr.DOEventMisinter=function(param)
    local gridId=tostring(SeasonSLGEventMgr.curGridIndex);

    local attackCfg=ConfigMgr.Config.SeasonalGridWorldAttackMap[param[2]]
            or ConfigMgr.Config.SeasonalGridWorldAttackMap[tostring(param[2])]
    if attackCfg==nil then
        return
    end
    SeasonSLGAPI.OnAskUpdateMapState(function(re)
        local lastMisinterGridIndex = SeasonSLGMapMgr.GetLastMinimapGrid()
        if lastMisinterGridIndex == nil then
            LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventMisinterBefallViewModel,param[1],param[2],re)
        else
            SeasonSLGMapMgr.SetLastMinimapGrid(nil)
        end
    end)
end


SeasonSLGEventMgr.CheckValidMisinter = function()
    local allMapData = SeasonSLGMapMgr.MapStateData
    if allMapData == nil then
        return false
    end
    if allMapData.TimedEventProgress == nil then
        return false
    end
    for key, value in pairs(allMapData.TimedEventProgress) do
        local config=value.Config
        if config==nil and value.TimeEventID~=nil then

            config=ConfigMgr.Config.SeasonalGridWorldAttackMap[value.TimeEventID]
                    or ConfigMgr.Config.SeasonalGridWorldAttackMap[tostring(value.TimeEventID)];
        end
        if config ~= nil and value.Progress < config.SeasonalMonsterHP then
            return true
        end
    end
    return false
end

SeasonSLGEventMgr.GetMisinterBulletin = function(isAll)
    local datas = {}
    local mapStateData = SeasonSLGMapMgr.MapStateData
    if mapStateData == nil then
        return datas
    end
    local progressMapDatas = mapStateData.TimedEventProgress
    if progressMapDatas == nil then
        return datas
    end
    for key, progressMapData in pairs(progressMapDatas) do

        local attackConfig = progressMapData.Config
        if attackConfig == nil and progressMapData.TimeEventID ~= nil then
            attackConfig = ConfigMgr.Config.SeasonalGridWorldAttackMap[progressMapData.TimeEventID]
                    or ConfigMgr.Config.SeasonalGridWorldAttackMap[tostring(progressMapData.TimeEventID)]
        end
        if attackConfig ~= nil then
            local isFinish = progressMapData.Progress >= attackConfig.SeasonalMonsterHP
            if (isAll == true or attackConfig.EventLevel >= 10) and isFinish == false then
                local data = {}
                local name = LuaMgr.GetLangText(attackConfig.NameLan)
                local row, col = SeasonSLGMapMgr.GetBlockLocByIndex(tonumber(progressMapData.GridID))
                data.desc = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35152"), col, row, name)

                local idNumber = string.match(tostring(progressMapData.TimeEventID), "(%d+)$")
                data.sort = tonumber(idNumber)
                table.insert(datas, data)
            end
        end
    end
    return datas
end




SeasonSLGEventMgr.DOEventLimitDispatch=function(param)
    local gridId=tostring(SeasonSLGEventMgr.curGridIndex);
    local wordDispatch=ConfigMgr.Config.SeasonalGridWorldGuardMap[param[2]]
    if wordDispatch==nil then
        return
    end
    local title=ConfigMgr.LangGlobal(wordDispatch.Name)
    local des=ConfigMgr.LangGlobal(wordDispatch.Desc)
    local buttonName=LuaMgr.GetLangText("SeasonSLGEventMgr_6");
    local remainTime=0;
    if #param>2 then
        gridId=param[3];
    end
    local dataTimeEvent=DataMgr.Player.SeasonalTimedEvent[gridId]
    if dataTimeEvent~=nil then
        remainTime=dataTimeEvent.ExpireTime-LuaMgr.Timestamp();
    end

        if #param>2 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSLGEventMgr_7"));
            return;
        end




        SeasonSLGAPI.OnAskBlockUnlockProgress(tostring(gridId),function(re)
            LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventLimitDispatchViewModel,param[2],re)
        end)


end

SeasonSLGEventMgr.DOEventLimitBuild=function(param)
    local gridId=tostring(SeasonSLGEventMgr.curGridIndex);
    local wordBuild=ConfigMgr.Config.SeasonalGridWorldBuildMap[param[2]]
    if wordBuild==nil then
        LuaDebug.error("error SeasonalGridWorldBuildMap gridid:"..tostring(SeasonSLGEventMgr.curGridIndex) .. "--buildId:" .. tostring(param[2]));
        return
    end
    local title=ConfigMgr.LangGlobal(wordBuild.Name)
    local des=ConfigMgr.LangGlobal(wordBuild.Desc)
    local buttonName=LuaMgr.GetLangText("SeasonSLGEventMgr_8");
    local remainTime=0;
    if #param>2 then
        gridId=param[3];
    end
    local dataTimeEvent=DataMgr.Player.SeasonalTimedEvent[gridId]
    if dataTimeEvent~=nil then
        remainTime=dataTimeEvent.ExpireTime-LuaMgr.Timestamp();
    end

        if #param>2 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSLGEventMgr_9"));
            return;
        end




        SeasonSLGAPI.OnAskBlockUnlockProgress(tostring(gridId),function(re)
            LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventLimitBuildViewModel,param[2],re)
        end)


end


SeasonSLGEventMgr.DOEventBoss=function(param)
    SeasonSLGAPI.OnAskBossRank(SeasonSLGEventMgr.curGridIndex,param[2],function(data)
        if SeasonSLGEventMgr.bossRankMap[tostring(SeasonSLGEventMgr.curGridIndex)]==nil then
            SeasonSLGEventMgr.bossRankMap[tostring(SeasonSLGEventMgr.curGridIndex)]={};
        end
        SeasonSLGEventMgr.bossRankMap[tostring(SeasonSLGEventMgr.curGridIndex)]=data;
        local gridBossCfg=ConfigMgr.Config.SeasonalGridBOSSMap[param[2]]
        if gridBossCfg==nil then return end;
        SeasonSLGEventMgr.curBossId=gridBossCfg.Id;
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBossPopupInfoViewModel,param[1],param[2]);










    end)
end


SeasonSLGEventMgr.GetGridResLevel=function(gridIndex)

    local dataRes=DataMgr.Player.SeasonalResource[tostring(gridIndex)]
    if dataRes==nil then
        return 1
    else
        return dataRes.Level;
    end
    return 1;
end

SeasonSLGEventMgr.GetDispatchData=function(gridIndex)
    local dispatchData=DataMgr.Player.SeasonalGuard[tostring(gridIndex)]
    return dispatchData;
end

SeasonSLGEventMgr.GetIndexByArray=function(array,value)
    local index=0;
    for i,v in ipairs(array) do
        if value>=tonumber(v) then
            index=index+1;
        end
    end
    return index;
end

SeasonSLGEventMgr.CheckDispatchTimedEvent=function(index)
    local timedProgress=SeasonSLGMapMgr.MapStateData.TimedEventProgress[tostring(index)];
    if timedProgress~=nil then
        SeasonSLGEventMgr.curTimedEventId=timedProgress.TimeEventID;
    else
        SeasonSLGEventMgr.curTimedEventId="";
    end
end


SeasonSLGEventMgr.GetProductAddByHeroLevel=function(heroList,extraLevel,extraLevelReward)
    local productDic={};
    for i,v in ipairs(heroList) do
        local level=SeasonSLGMapMgr.GetCharacterLevel(v);
        local index=SeasonSLGEventMgr.GetIndexByArray(extraLevel,level);
        if index>0 then
            local productItem=extraLevelReward[index]
            if productDic[productItem.id]==nil then
                productDic[productItem.id]={id=productItem.id,count=0};
            end
            productDic[productItem.id].count=productDic[productItem.id].count+productItem.count;
        end
    end
    return productDic;
end

SeasonSLGEventMgr.GetProductAddByHeroSeasonLevel=function(heroList,extraSeasonalLevel,extraSeasonalLevelReward)
    local productDic={};
    for i,v in ipairs(heroList) do
        local level=SeasonSLGMapMgr.GetCharacterSeasonLevel(v);
        local index=SeasonSLGEventMgr.GetIndexByArray(extraSeasonalLevel,level);
        if index>0 then
            local productItem=extraSeasonalLevelReward[index]
            if productDic[productItem.id]==nil then
                productDic[productItem.id]={id=productItem.id,count=0};
            end
            productDic[productItem.id].count=productDic[productItem.id].count+productItem.count;
        end
    end
    return productDic;
end


SeasonSLGEventMgr.GetProductAddByHeroRareLevel=function(heroList,rareLevel,extraRareReward)
    local productDic={};
    for i,v in ipairs(heroList) do
        local level=HeroMgr.GetHeroNowRare(v);
        local index=SeasonSLGEventMgr.GetIndexByArray(rareLevel,level);
        if index>0 then
            local productItem=extraRareReward[index]
            if productDic[productItem.id]==nil then
                productDic[productItem.id]={id=productItem.id,count=0};
            end
            productDic[productItem.id].count=productDic[productItem.id].count+productItem.count;
        end
    end
    return productDic;
end

SeasonSLGEventMgr.GetProductByBuff=function(itemIdList)
    local addValue=0;
    local activeProductBuffDic={};
    for i,v in pairs(DataMgr.Player.SeasonalProduceBuff) do
        for _i,_v in ipairs(v) do
            if activeProductBuffDic[_v.BuffId]==nil then
                activeProductBuffDic[_v.BuffId]={};
            end
            table.insert(activeProductBuffDic[_v.BuffId],i);
        end
    end
    for i,v in pairs(ConfigMgr.Config.SeasonalProduceBuffMap) do
        local isFind=NumTool.FindIndex(itemIdList,v.Type[1])>0;
        if isFind and activeProductBuffDic[v.Id]~=nil  then
            addValue=addValue+v.Para1[1];
        end
    end
    return addValue/10000;
end


SeasonSLGEventMgr.GetDispatchHeroList=function(outGridId)
    local heroList={};

























    return heroList;
end

SeasonSLGEventMgr.GetDisPatchStatus = function(members, produceTime)
    local dispatchStatus = SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_No
    local curTime = LuaMgr.Timestamp()
    if  not IsNull(members) and #members > 0 and produceTime > 0 then
        local leftTime = produceTime - curTime
        if leftTime > 0 then
            dispatchStatus = SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_Ing
        else
            dispatchStatus = SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_Reward
        end
    end
    return dispatchStatus
end


SeasonSLGEventMgr.GetDispatchMembers=function()
    local membersDic={};
    for _,v in pairs(DataMgr.Player.SeasonalResource) do
        if not IsNull(v.Members) then
            for _,m in ipairs(v.Members) do
                membersDic[m] = m
            end
        end
    end
    for _,v in pairs(DataMgr.Player.SeasonalWorldGuard) do
        if not IsNull(v.Members) then
            for _,m in ipairs(v.Members) do
                    membersDic[m] = m
            end
        end
    end
    SeasonSLGEventMgr.dispatchMembers=membersDic;
    return membersDic;
end

SeasonSLGEventMgr.GetTiredCharacter=function()
    local actors = SeasonSLGMapMgr.GetActors()
    local membersDic={}
    local remainDic = {}
    for k, v in pairs(actors) do
        local c = SeasonSLGMapMgr.CheckCharacterTired(v)
        if c <= 0 then
            membersDic[v] = 1;
        else
            remainDic[v] = c
        end
    end
    return membersDic,remainDic
end


SeasonSLGEventMgr.GetQuickBattleCDCharacter=function()
    local membersDic={}
    local remainDic = {}
    local records = DataMgr.Player.SeasonalQuickBattleRecords
    if records == nil then
        return membersDic,remainDic
    end
    local cd = SeasonSLGMapMgr.Constants().SeasonalBattleCD or 0
    local now = LuaMgr.Timestamp()
    for characterId, lastTime in pairs(records) do
        local c = lastTime + cd - now
        if c > 0 then
            membersDic[characterId] = c
            remainDic[characterId] = c
        end
    end
    return membersDic,remainDic
end

SeasonSLGEventMgr.GetDispatchTaskList=function()
    local taskDispatchList={};
    local dataGuard=nil;
    for i,v in pairs(SeasonSLGMapMgr.DispatchGridMap or {}) do
        if SeasonSLGMapMgr.CheckBlockIsUnLock(v.Id)  then
            local dataGrid=DataMgr.Player.SeasonalGrid[v.Id]
            if dataGrid~=nil then
                if dataGrid.Status>=#v.EventList and not IsNull(v.Function) and #v.Function>=2 and v.Function[1]=="5" then

                    dataGuard=DataMgr.Player.SeasonalGuard[v.Id];
                    if dataGuard~=nil then
                        local data = dataGuard
                        if IsNull(data.Members1)  then
                            data.Members1 = nil
                        end
                        if IsNull(data.Members2)  then
                            data.Members2 = nil
                        end
                        table.insert(taskDispatchList,{gridId=v.Id,data=data})

                    else
                        table.insert(taskDispatchList,{gridId=v.Id,data={Id1="",Id2="",Members1=nil,Members2=nil}})
                    end
                    dataGuard=nil;
                end
            end
        end
    end
    return taskDispatchList;
end

SeasonSLGEventMgr.GetLockMembers=function(gridId,groupId,dungeonId)
    local membersDic={};
    local tiredCharacter = SeasonSLGMapMgr.GetCurSeasonActorTried()
    if not IsNull(tiredCharacter) then
        for i, v in pairs(tiredCharacter) do
            if SeasonSLGMapMgr.CheckCharacterTired(i) <= 0 then
                membersDic[i] = 1;
            end
        end
    end

    local dataGridBoss=DataMgr.Player.SeasonalBoss[tostring(gridId)]
    if dataGridBoss==nil or IsNull(dataGridBoss.Battles) or dataGridBoss.GroupId~=groupId or IsNullOrEmpty(dataGridBoss.DungeonGroupId) then
        return membersDic
    end

    for i,v in pairs(dataGridBoss.Battles) do
        if v.DungeonGroupId~=dungeonId then
            for _i,_v in pairs(v.Members) do
                membersDic[_v]=_v;
            end
        end
    end
   return membersDic;
end

SeasonSLGEventMgr.GetLockMembersAndHelps=function(grid_bossDungeonId)
    local members={};
    local helps={};
    local array=NumTool.split(grid_bossDungeonId,"_");
    if #array~=2 then
        return members,helps;
    end
    local dataGridBoss=DataMgr.Player.SeasonalBoss[array[1]]
    if dataGridBoss==nil or IsNull(dataGridBoss.Battles) or dataGridBoss.Battles[array[2]]==nil or IsNullOrEmpty(dataGridBoss.DungeonGroupId) then
        return members,helps;
    end
    local battleData=dataGridBoss.Battles[array[2]];
    return battleData.Members,battleData.Helps;
end

SeasonSLGEventMgr.BossDungeonCheckContinue=function()
    if SeasonSLGEventMgr.bossContinueData==nil then
        return;
    end

    if SeasonSLGEventMgr.bossContinueData.viewName==UIName.SeasonSlGEventBossContinueInfoViewModel then
        local bossData=DataMgr.Player.SeasonalBoss[tostring(SeasonSLGEventMgr.curGridIndex)]
        if bossData==nil or IsNull(bossData) or IsNullOrEmpty(bossData.DungeonGroupId)  then
            return;
        end
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBossContinueInfoViewModel,SeasonSLGEventMgr.bossContinueData.data.eventType,
                SeasonSLGEventMgr.bossContinueData.data.bossId,SeasonSLGEventMgr.bossContinueData.data.groupId)
    elseif SeasonSLGEventMgr.bossContinueData.viewName==UIName.SeasonSlGEventBossPopupInfoViewModel then
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBossPopupInfoViewModel,SeasonSLGEventMgr.bossContinueData.data.eventType,
                SeasonSLGEventMgr.bossContinueData.data.bossId);
    end

end





SeasonSLGEventMgr.CheckPopUpWorldProgressTip=function()
    local key=DataMgr.Player.uid..SeasonSLGEventMgr.WORLDPROGRESS;
    local lastWorldStr=PlayerPrefs.GetString(key)
    local lastWorldProgress=IsNullOrEmpty(lastWorldStr) and -1 or tonumber(lastWorldStr);
    local curWoldProgress=SeasonSLGMapMgr.GetBoss2ChallengeProgress();
    if curWoldProgress>lastWorldProgress then
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBoss2WorldBuffProgressInfoViewModel,lastWorldProgress,curWoldProgress);
        PlayerPrefs.SetString(key,tostring(curWoldProgress));
    end
end


SeasonSLGEventMgr.GetProgressName=function(heatProgress)
    local num1=math.floor(heatProgress/SeasonSLGMapMgr.Constants().SeasonalBossHeatProgress);
    local num2=math.floor(heatProgress%SeasonSLGMapMgr.Constants().SeasonalBossHeatProgress/100);
    local des=string.format(LuaMgr.GetLangText("SeasonSLGEventMgr_10"),NumTool.GetMaxNum(num1+1),num2);
    return des;
end

SeasonSLGEventMgr.CheckLimitEventRewardIsComplete=function(key)
    return DataMgr.Player.SeasonalRewardRecords[key]~=nil;
end

SeasonSLGEventMgr.SetIsShowHomeNovel = function(isShow)
    if isShow then

        local key = DataMgr.Player.uid .. "SeasonSLGHomeNovel"
        if PlayerPrefs.GetInt(key) == 1 then
            return
        end
        PlayerPrefs.SetInt(key, 1)
    end
    this.isShowHomeNovel = isShow
end

SeasonSLGEventMgr.GetIsShowHomeNovel = function()
    return this.isShowHomeNovel
end


SeasonSLGEventMgr.TryShowStoryResult = function()
    local pending = SeasonSLGEventMgr.pendingStoryResult
    if pending == nil then
        return
    end
    SeasonSLGEventMgr.pendingStoryResult = nil
    local eventStory = ConfigMgr.Config.SeasonalEventStoryMap[pending.storyId]
    if eventStory == nil then
        return
    end

    if DataMgr.Player.SeasonalStory[tostring(pending.gridIndex)] == nil then
        return
    end

    local rewardList = eventStory.Reward
    if pending.optionIndex == 2 then
        rewardList = eventStory.Reward2
    elseif pending.optionIndex == 3 then
        rewardList = eventStory.Reward3
    end
    if IsNull(rewardList) or #rewardList == 0 then
        return
    end
    local title = LuaMgr.GetLangText(eventStory.NameLan)

    local subDesStr = LuaMgr.GetLangText(eventStory.SubDescLan)
    local subDes = NumTool.split(subDesStr, "|")
    local desc = pending.optionIndex > #subDes and subDes[1] or subDes[pending.optionIndex]
    LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventResultPopup, title, desc, rewardList,SeasonSLGMapMgr.EventResultType.pureReward)
end

SeasonSLGEventMgr.GetBlockCostItem=function(gridId)
    local cfgGrid=SeasonSLGMapMgr.gridMap[gridId]
    if cfgGrid==nil then return nil end;
    local cfgCostReward= ConfigMgr.Config.SeasonalCostRewardMap[cfgGrid.CostType];
    return cfgCostReward.CostResource[1];
end

SeasonSLGEventMgr.GetPlayerTotalScore=function()
    local totalScore=0;
    local dataGridBoss=DataMgr.Player.SeasonalBoss[tostring(SeasonSLGEventMgr.curGridIndex)]
    if dataGridBoss then
        if not IsNull(dataGridBoss.Battles) then
            for k, v in pairs(dataGridBoss.Battles) do
                totalScore = totalScore + v.Damage
            end
        end
    end
    return totalScore;
end

SeasonSLGEventMgr.GetPlayerMaxScore=function(bossID)
    local totalScore=0;
    if bossID and DataMgr.Player.SeasonalBossMaxDamage[bossID] then
        totalScore= DataMgr.Player.SeasonalBossMaxDamage[bossID]
    end
    return totalScore;
end

SeasonSLGEventMgr.ConvertDamageScore=function(damge)
    return math.ceil(damge * 0.01)
end

return SeasonSLGEventMgr