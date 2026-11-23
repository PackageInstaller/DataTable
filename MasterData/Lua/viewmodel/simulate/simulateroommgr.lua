require("ViewModel/Simulate/SimulateSceneMgr")
SimulateRoomMgr = {
Build_FourName={},

    isHideInfo=false;
};

local this = {
    sceneName="JS_Activity01_01";
};


SimulateRoomMgr.Open=function()
    LuaMgr.SceneSwitchMark();
    LuaMgr.LoadScene(this.sceneName, nil, this.InitData);
end


this.InitData=function()
    this.cfgSIMArchitectMap=ConfigMgr.Config.SimulateArchitectMap;
    this.cfgSIMConstants=ConfigMgr.Config.SimulateConstants;
    local nameStr=ConfigMgr.LangGlobal("28103")
    SimulateRoomMgr.Build_FourName=NumTool.split(nameStr,"_")
    SimulateSceneMgr.InitData();
    LuaMgr.ShowLuaPanel(UIName.SimulateRoomViewModel)
end


SimulateRoomMgr.Clear=function()
   
end



SimulateRoomMgr.CheckBuildingIsUnLock=function(buildId)
    return not IsNull(DataMgr.Player.SimulateArchitect.SimulateBuilds) and DataMgr.Player.SimulateArchitect.SimulateBuilds[buildId]~=nil;
end


SimulateRoomMgr.GetBuildingMaxLevel=function(buildId,index)
    if ConfigMgr.Config.SimulateArchitectMap[buildId]==nil then
        return nil;
    end
    local Limit=ConfigMgr.Config.SimulateArchitectMap[buildId].Limit;
    if index==nil then
        return #Limit[1]
    else
        return #Limit[index];
    end
end

SimulateRoomMgr.GetBuildingStarIndex=function(buildId)
    local buildData=DataMgr.Player.SimulateArchitect.SimulateBuilds[buildId]
    local touristsPro=buildData.TouristsValue/SimulateRoomMgr.GetBuildingMaxFansByLevel(buildId,2,buildData.Level);
    local satisfiesPro=buildData.SatisfiesValue/SimulateRoomMgr.GetBuildingMaxFansByLevel(buildId,3,buildData.Level);
    local visitsPro=buildData.VisitsValue/SimulateRoomMgr.GetBuildingMaxFansByLevel(buildId,4,buildData.Level);
    local starIndex=1;
    if touristsPro>0.99 then
        starIndex=starIndex+1;
    end
    if satisfiesPro>0.99 then
        starIndex=starIndex+1;
    end
    if visitsPro>0.99 then
        starIndex=starIndex+1;
    end
    return starIndex;
end


SimulateRoomMgr.GetBuildingMaxFans=function(buildId,index)
    if ConfigMgr.Config.SimulateArchitectMap[buildId]==nil then
        return 0;
    end
    index=index==nil and 1 or index;
    local simulateArchitect=ConfigMgr.Config.SimulateArchitectMap[buildId]
    local baseValue=simulateArchitect.BaseLimit[index];
    local limitList=simulateArchitect.Limit[index]
    for i,v in ipairs(limitList) do
        baseValue=baseValue+v;
    end
    return baseValue;
end



SimulateRoomMgr.GetBuildingMaxFansByLevel=function(buildId,index,level)
    if ConfigMgr.Config.SimulateArchitectMap[buildId]==nil then
        return 0;
    end
    index=index==nil and 1 or index;
    local simulateArchitect=ConfigMgr.Config.SimulateArchitectMap[buildId]
    local baseValue=simulateArchitect.BaseLimit[index];
    local limitList=simulateArchitect.Limit[index];
    for i=1,level,1 do
        if i<=#limitList then
            baseValue=baseValue+limitList[i];
        end
    end
    return baseValue;
end


SimulateRoomMgr.GetBuildingFansByLevel=function(buildId,index,level)
    if ConfigMgr.Config.SimulateArchitectMap[buildId]==nil then
        return 0;
    end
    index=index==nil and 1 or index;
    local simulateArchitect=ConfigMgr.Config.SimulateArchitectMap[buildId]
    index=index>#simulateArchitect.Limit[index] and #simulateArchitect.Limit[index] or index
    local limitList=simulateArchitect.Limit[index];
    return limitList[level];
end


SimulateRoomMgr.GetBuildingBaseFansByLevel=function(buildId,index,level)
    if ConfigMgr.Config.SimulateArchitectMap[buildId]==nil then
        return 0;
    end
    index=index==nil and 1 or index;
    local simulateArchitect=ConfigMgr.Config.SimulateArchitectMap[buildId]
    local limitList=simulateArchitect.Value[index];
    level=level>#limitList and #limitList or level;
    return limitList[level];
end



SimulateRoomMgr.GetAllBuildingFans=function()
    if IsNull(DataMgr.Player.SimulateArchitect) or IsNull(DataMgr.Player.SimulateArchitect.SimulateBuilds) then
        return 0
    end
    local simulateBuilds=DataMgr.Player.SimulateArchitect.SimulateBuilds;
    local maxFans=0;
    for i,v in pairs(simulateBuilds) do
        maxFans=maxFans+v.StageValue
    end
    return maxFans;
end


SimulateRoomMgr.GetBuildingThemeNameAndLevel=function(buildId)
    local dataBuilding=DataMgr.Player.SimulateArchitect.SimulateBuilds[buildId];
    local cfgBuilding=this.cfgSIMArchitectMap[buildId];
    if dataBuilding==nil then

        return cfgBuilding.Icon[1],1
    end
    local index=1;
    for i,v in ipairs(cfgBuilding.Level) do
        if dataBuilding.Level+1>=v then
            index=index+1;
        end
    end
    index=index>#cfgBuilding.Icon and #cfgBuilding.Icon or index;
    return cfgBuilding.Icon[index],index;
end

SimulateRoomMgr.GetBuildingNameByBuildName=function(buildingId)
    local cfgBuildingInfo=ConfigMgr.Config.SimulateArchitectMap[buildingId];
    if cfgBuildingInfo~=nil then
        return LuaMgr.GetLangText(cfgBuildingInfo.NameLan);
    end
end


SimulateRoomMgr.GetBuildingMaxStageValue=function(level)
    local curSIMDegree=ConfigMgr.Config.SimulateDegreeMap[tostring(level)]
    local nextSIMDegree=ConfigMgr.Config.SimulateDegreeMap[tostring(level+1)];
    if nextSIMDegree==nil then
        nextSIMDegree=curSIMDegree;
    end
    return nextSIMDegree.Para;
end


SimulateRoomMgr.GetEmployeesMaxCount=function()
    return this.cfgSIMConstants.SimulateHireLimit
end


SimulateRoomMgr.GetXCHDActiveStartTime=function()
    local data=DataExHelper.GetDataExByTag(ActivityKey.XCHD)
    if data~=nil then
        return data.startTime
    else
        return nil;
    end
end

SimulateRoomMgr.CheckEmployeeIsNew=function(characterId,tag)
    local key=string.format("%s_%s_%s",DataMgr.Player.uid,characterId,tag);
    local value=UnityEngine.PlayerPrefs.GetInt(key);
    return value==0;
end

SimulateRoomMgr.UpdateEmployeeNew=function(characterId,tag)
    local key=string.format("%s_%s_%s",DataMgr.Player.uid,characterId,tag);
    UnityEngine.PlayerPrefs.SetInt(key,1);
end


SimulateRoomMgr.CheckEmployeeIsUnlock=function(recruitInfo)
    if recruitInfo.Type==0 then
        return true;
    elseif recruitInfo.Type==1 then

        local startTime=SimulateRoomMgr.GetXCHDActiveStartTime()
        if startTime~=nil then
            return LuaMgr.Timestamp()>=startTime+recruitInfo.Unlock*86400
        end
        return false;
    elseif recruitInfo.Type==2 then

        return DataMgr.Player.SimulateArchitect.StageLevel>=recruitInfo.Unlock
    end
end


SimulateRoomMgr.GetLanternMergeItemCount=function(itemId)
    if IsNull(DataMgr.Player.SimulateGame) or IsNull(DataMgr.Player.SimulateGame.Items) or DataMgr.Player.SimulateGame.Items[itemId]==nil then

        return 0
    end
    return DataMgr.Player.SimulateGame.Items[itemId];
end


SimulateRoomMgr.GetLanternCount=function(Id)
    if IsNull(DataMgr.Player.SimulateFlowerLight) or IsNull(DataMgr.Player.SimulateFlowerLight.Light) or DataMgr.Player.SimulateFlowerLight.Light[Id]==nil then
        return -1
    end
    return DataMgr.Player.SimulateFlowerLight.Light[Id]
end


SimulateRoomMgr.CheckLanternTypeUnLock=function(Id)
    if IsNull(DataMgr.Player.SimulateFlowerLight) or IsNull(DataMgr.Player.SimulateFlowerLight.LightTyp)  then
        return false
    end
    return DataMgr.Player.SimulateFlowerLight.LightTyp[Id]~=nil;
end


SimulateRoomMgr.GetLanternPartCount=function(Id)
    if IsNull(DataMgr.Player.SimulateFlowerLight) or IsNull(DataMgr.Player.SimulateFlowerLight.LightPart) or DataMgr.Player.SimulateFlowerLight.LightPart[Id]==nil then
        return 0
    end
    return DataMgr.Player.SimulateFlowerLight.LightPart[Id]
end


SimulateRoomMgr.OpenBlessingPanel=function()
    SimulateRoomMgr.OnAskOnAskBlessingPrayList(function()
        LuaMgr.ShowLuaPanel(UIName.SimulateBlessingListViewModel);
    end)
end


SimulateRoomMgr.GetEventUnlockTime = function(eventType)
    local eventList = SimulateRoomMgr.GetEventList(eventType);
    if (#eventList > 0) then
        return eventList[1].StartTime - LuaMgr.Timestamp();
    end
    return 0;
end


SimulateRoomMgr.IsEventUnlock = function(eventType)
    if (SimulateRoomMgr.GetEventUnlockTime(eventType) > 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ConfigGuoBaoMgr_0"));
        return false;
    end
    return true;
end


SimulateRoomMgr.GetEventList = function(eventType)
    local eventList = {};
    for _, v in pairs(ConfigMgr.Config.SimulateEventMap) do
        if (v.EventType == eventType) then
            table.insert(eventList, v);
        end
    end
    table.sort(eventList, function(a, b) return tonumber(a.Id)<tonumber(b.Id) end);
    return eventList;
end


SimulateRoomMgr.CheckFinishEvent = function(id)
    local finishEvent = DataMgr.Player.SimulateGame.EventMap;
    if (not IsNull(finishEvent)) then
        return finishEvent[id]~=nil;
    end
    return nil;
end

SimulateRoomMgr.GetManageDailyCount=function()
    if DataMgr.Player.dailyCount["SimulateDailyCount"]==nil then
        return 0
    end
    return DataMgr.Player.dailyCount["SimulateDailyCount"];
end


SimulateRoomMgr.CheckTriggerAddDailyRewardCount=function()
    if DataMgr.Player.SimulateArchitect.TechTree["7"]~=nil then
        local addCountStr= ConfigMgr.Config.SimulateTechMap["7"].Para[1];
        return tonumber(addCountStr);
    end
    return 0
end


SimulateRoomMgr.CheckTriggerReduceTimeSec=function()
    if DataMgr.Player.SimulateArchitect.TechTree["8"]~=nil then
        local reduceMinStr= ConfigMgr.Config.SimulateTechMap["8"].Para[1];
        return tonumber(reduceMinStr)*60;
    end
    return 0
end


SimulateRoomMgr.CheckTriggerReduceCostEmployee=function()
    if DataMgr.Player.SimulateArchitect.TechTree["10"]~=nil then
        local reduceCost= ConfigMgr.Config.SimulateTechMap["10"].Para[1];
        local valueFloat=tonumber(reduceCost)/10000
        return valueFloat;
    end
    return 0
end


SimulateRoomMgr.CheckTriggerAddLikeCount=function()
    if DataMgr.Player.SimulateArchitect.TechTree["11"]~=nil then
        local addCountStr= ConfigMgr.Config.SimulateTechMap["11"].Para[1];
        return tonumber(addCountStr);
    end
    return 0
end













SimulateRoomMgr.OnAskIdleRewards=function(callBack)
    ApiMgr.Request("simulatearchitect/idleReward",{},true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result.Reward);
        LuaMgr.ShowItemRewared(data);
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end


SimulateRoomMgr.OnAskBuildingUpLevel=function(buildId,callBack)
    local askData={Id=buildId}
    ApiMgr.Request("simulatearchitect/buildLv",askData,true,function(result)
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end


SimulateRoomMgr.OnAskBuildingThreeRange=function(buildId,type,callBack)
    local askData={
        Id=buildId,
        Typ=type,
    }
    ApiMgr.Request("simulatearchitect/threeRange",askData,true,function(result)
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end

SimulateRoomMgr.OnAskHire=function(characterId,callBack)
    local askData={
        Id=characterId,
    }
    ApiMgr.Request("simulatearchitect/hire",askData,true,function(result)
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end


SimulateRoomMgr.OnAskEmployees=function(employees,callBack)
    local askData={
        Employees=employees,
    }
    ApiMgr.Request("simulatearchitect/employees",askData,true,function(result)
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end

SimulateRoomMgr.OnAskStart=function(callBack)
    ApiMgr.Request("simulatearchitect/start", {},true,function(result)
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end


SimulateRoomMgr.OnAskSettlement=function(callBack)
    ApiMgr.Request("simulatearchitect/settlement", {},true,function(result)
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end


SimulateRoomMgr.OnAskConfirmEvent=function(isAccept,callBack)
    local askData={Accept=isAccept}
    ApiMgr.Request("simulatearchitect/confirmEvent", askData,true,function(result)
        local re = json.decode(result)
        local data = json.encode(re.result.Reward)
        LuaMgr.ShowItemRewared(data)
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end


SimulateRoomMgr.OnAskExchangeLightPart=function(id,count,callBack)
    local askData={Id=id,Count=count}
    ApiMgr.Request("simulatearchitect/exchangeLightPart", askData,true,function(result)
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end

SimulateRoomMgr.OnAskMakeLight=function(lightId,count,callBack)
    local askData={LightId=lightId,Count=count}
    ApiMgr.Request("simulatearchitect/makeLight", askData,true,function(result)
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end


SimulateRoomMgr.OnAskOrderRefresh=function(orderId,callBack)
    local askData={Id=orderId}
    ApiMgr.Request("simulatearchitect/order_refresh", askData,true,function(result)
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end


SimulateRoomMgr.OnAskOrderRefuse=function(orderId,callBack)
    local askData={Id=orderId}
    ApiMgr.Request("simulatearchitect/order_refuse", askData,true,function(result)
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end


SimulateRoomMgr.OnAskOrderFinish=function(orderIds,costDic,callBack)
    local askData={Ids=orderIds,Cost=costDic}
    ApiMgr.Request("simulatearchitect/order_finish", askData,true,function(result)
        local re = json.decode(result)
        local data = json.encode(re.result)
        LuaMgr.ShowItemRewared(data)
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end


SimulateRoomMgr.OnAskSaleLight=function(isUp,blockId,lightId,count,callBack)
    local askData={Up=isUp,BlockId=blockId,Id=lightId,Count=count}
    ApiMgr.Request("simulatearchitect/saleLight", askData,true,function(result)
        local re = json.decode(result)
        local data = json.encode(re.result)
        LuaMgr.ShowItemRewared(data)
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end


SimulateRoomMgr.OnAskLightReward=function(ids,callBack)
    local askData={BlockId=ids}
    ApiMgr.Request("simulatearchitect/lightReward", askData,true,function(result)
        local re = json.decode(result)
        local data = json.encode(re.result.Reward)
        LuaMgr.ShowItemRewared(data)
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end


SimulateRoomMgr.OnAskBlessingPray=function(ids,callBack)
    local askData={Ids=ids}
    ApiMgr.Request("simulatearchitect/pray", askData,true,function(result)
        local re = json.decode(result)
        local data = json.encode(re.result.Reward)
        LuaMgr.ShowItemRewared(data)
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end


SimulateRoomMgr.OnAskOnAskBlessingPrayList=function(callBack)
    ApiMgr.Request("simulatearchitect/prayList", {},true,function(result)
        local re = json.decode(result)
        if(callBack~=nil) then
            SimulateRoomMgr.BlessList=re.result.List;
            callBack();
        end
    end,nil,true)
end


SimulateRoomMgr.OnAskOnAskBlessingPrayLike=function(uid,callBack)
    local askData={Uid=uid}
    ApiMgr.Request("simulatearchitect/prayLike", askData,true,function(result)
        local re = json.decode(result)
        local data = json.encode(re.result.Reward)
        LuaMgr.ShowItemRewared(data)
        if(callBack~=nil) then
            callBack(re.result.List);
        end
    end,nil,true)
end



SimulateRoomMgr.OnAskOnAskBlessingRiddle=function(id,callBack)
    local askData={Id=id}
    ApiMgr.Request("simulatearchitect/riddle", askData,true,function(result)
        local re = json.decode(result)
        local data = json.encode(re.result)
        LuaMgr.ShowItemRewared(data)
        if(callBack~=nil) then
            callBack();
        end
    end,nil,true)
end


SimulateRoomMgr.OnAskFinishEvent = function(id, callback)
    ApiMgr.Request("simulatearchitect/finishEvent", {Id=id}, true, callback, nil, true, true);
end


SimulateRoomMgr.OnAskCatchGame = function(id,materials,callback)
    local askData={Id=id,Materials=materials}
    ApiMgr.Request("simulatearchitect/catchgame", askData, true, callback, nil, true, true);
end


SimulateRoomMgr.OnAskTechTree = function(id,callback)
    local askData={Id=id}
    ApiMgr.Request("simulatearchitect/techTree", askData, true, callback, nil, true, true);
end


SimulateRoomMgr.OnAskDailyRandomReward = function(callback)
    ApiMgr.Request("simulatearchitect/randomReward", {}, true, function(result)
        local re = json.decode(result)
        local data = json.encode(re.result.Reward)
        LuaMgr.ShowItemRewared(data)
        if(callback~=nil) then
            callback();
        end
    end, nil, true, true);
end



SimulateRoomMgr.CheckTaskRed=function()
    local taskRed=0;
    this.taskList=DataExHelper.Check_ConfigQuestEventByText("XCRWTASK")
    if #this.taskList>0 then
        for i,v in ipairs(this.taskList) do
            if DataMgr.Player.quests[v.id]~=nil and DataMgr.Player.quests[v.id].state==2 then
                taskRed=1;
                break;
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("17307", taskRed)
    return taskRed;
end


SimulateRoomMgr.CheckDropGameRed=function()
    local dropGameRed=0;
    local build_1001=nil;
    if not IsNull(DataMgr.Player.SimulateArchitect.SimulateBuilds) then
        if DataMgr.Player.SimulateArchitect.SimulateBuilds["1001"]~=nil then
            build_1001=DataMgr.Player.SimulateArchitect.SimulateBuilds["1001"];
        end
    end
    for i,v in pairs(ConfigMgr.Config.SimulateCatchGameMap) do
        local levelRed=0;
        local historyValue=PlayerPrefs.GetInt(DataMgr.Player.uid .. "Simulate_DropGame_"..v.Id);

        if historyValue==0 then
            if IsNull(DataMgr.Player.SimulateGame.UnlockMap) or DataMgr.Player.SimulateGame.UnlockMap[v.Id]==nil then
                if v.Type==0 then

                    levelRed=1;
                elseif v.Type==1 then
                    if build_1001~=nil and build_1001.Level>tonumber(v.Unlock) then
                        levelRed=1;
                    end

                elseif v.Type==2 then

                    if not IsNull(DataMgr.Player.SimulateGame.UnlockMap) and DataMgr.Player.SimulateGame.UnlockMap[v.Unlock]~=nil then
                        levelRed=1;
                    end
                end
            else
                levelRed=0;
            end
        else
            levelRed=0;
        end
        dropGameRed=dropGameRed+levelRed
        RedMgr.Singleton:UpdateClientRedData("17308_"..v.Id, levelRed)
    end
    RedMgr.Singleton:UpdateClientRedData("17308", dropGameRed)
    return dropGameRed;
end



SimulateRoomMgr.CheckTechTreeRed=function()
    local treeRed=0;
    if RedMgr.Singleton:CheckRedCondition("17309") then
        local dataTechTree=DataMgr.Player.SimulateArchitect.TechTree
        for i,v in pairs(ConfigMgr.Config.SimulateTechMap) do
            if IsNull(dataTechTree) or dataTechTree[v.Id]==nil then
                if v.Unlock[1]=="0" then
                    treeRed=1
                    break
                elseif v.Unlock[1]=="1" and #v.Unlock>1 then
                    local preId=v.Unlock[2]
                    if not IsNull(dataTechTree) and dataTechTree[preId]~=nil then
                        treeRed=1
                        break
                    end
                end
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("17309", treeRed)
    return treeRed;
end


SimulateRoomMgr.CheckSimulateRed=function()
    local simulateRed=0;
    local curSIMDegree=ConfigMgr.Config.SimulateDegreeMap[tostring(DataMgr.Player.SimulateArchitect.StageLevel)]
    if DataMgr.Player.SimulateArchitect.IdleTime>0 then
        local idleDurSec=LuaMgr.Timestamp()-DataMgr.Player.SimulateArchitect.IdleTime
        if idleDurSec>=curSIMDegree.AccumulateLimit*60*60 then
            simulateRed=1;
        end
    end
    RedMgr.Singleton:UpdateClientRedData("17310", simulateRed)
    return simulateRed;
end



SimulateRoomMgr.CheckRiddlesRed=function()
    local riddleRed=0;
    for i,v in pairs(ConfigMgr.Config.SimulateRiddleMap) do
        local red_v=0;
        if RedMgr.Singleton:CheckRedCondition("17313_"..v.Id) then

            if IsNull(DataMgr.Player.SimulateGame.RiddleMap) or DataMgr.Player.SimulateGame.RiddleMap[v.Id]==nil then

                if v.Type==0 then
                    red_v=1;
                elseif v.Type==1 then
                    if LuaMgr.Timestamp()>SimulateRoomMgr.GetXCHDActiveStartTime()+v.Unlock*24*60*60 then
                        red_v=1;
                    end
                end
            end
        end
        RedMgr.Singleton:UpdateClientRedData("17313_"..v.Id, red_v)
        riddleRed=riddleRed+red_v;
    end
    RedMgr.Singleton:UpdateClientRedData("17313", riddleRed)
    return riddleRed;
end

SimulateRoomMgr.CheckLightMakeRed=function()
    local lightRed=0;
    for i,v in pairs(ConfigMgr.Config.SimulateMergeMap) do
        if SimulateRoomMgr.GetLanternPartCount(v.Id)==0 then
            local red_v=1;
            for p,m in ipairs(v.Merge) do
                local count=SimulateRoomMgr.GetLanternMergeItemCount(m.id)
                if count<m.count then
                    red_v=0;
                    break;
                end
            end
            if red_v>0 then
                lightRed=1;
                break
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("17317", lightRed)
    return lightRed;
end

SimulateRoomMgr.LightCollectRewardsRed=function()
    local collectRed=0;
    local questList=DataExHelper.Check_ConfigQuestEventByText("XCRW")
    for i,v in ipairs(questList) do
        if DataMgr.Player.quests[v.id]~=nil and DataMgr.Player.quests[v.id].state==2 then
            collectRed=1;
            break;
        end
    end
    RedMgr.Singleton:UpdateClientRedData("17318", collectRed)
    return collectRed;
end