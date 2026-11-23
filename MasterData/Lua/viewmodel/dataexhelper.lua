
DataExHelper = {
    activityMapEventMap=nil;
}



function DataExHelper.Check_ConfigQuestEventByGroupId(groupId)
    local cfgQuestEvent=ConfigMgr.Config.questEvent;
    local cfgTar_questEvent={};
    for i,v in pairs(cfgQuestEvent) do
        if v.groupId==groupId then
            table.insert(cfgTar_questEvent,v);
        end
    end
    table.sort(cfgTar_questEvent,function (a,b)
        return tonumber(a.id) < tonumber(b.id)
    end)   
    return cfgTar_questEvent;
end

function DataExHelper.Check_ConfigQuestEventByEventType(groupId,event)
    local cfgQuestEvent=ConfigMgr.Config.questEvent;
    local cfgTar_questEvent={};
    for i,v in pairs(cfgQuestEvent) do
        if v.groupId == groupId and v.eventType==event then
            table.insert(cfgTar_questEvent,v);
        end
    end
    table.sort(cfgTar_questEvent,function (a,b)
        return tonumber(a.id) < tonumber(b.id)
    end)
    return cfgTar_questEvent;
end


function DataExHelper.Check_ConfigQuestEventByText(activityText)
    local cfgQuestEvent=ConfigMgr.Config.questEvent;
    if type(cfgQuestEvent)~="table" then
        return {}
    end
    local cfgTar_questEvent={};
    if not IsNull(cfgQuestEvent) then
        for i,v in pairs(cfgQuestEvent) do
            if v.text==activityText then
                table.insert(cfgTar_questEvent,v);
            end
        end
    end
    table.sort(cfgTar_questEvent,function (a,b)
        return tonumber(a.id) < tonumber(b.id)
    end)   
    return cfgTar_questEvent;
end



function DataExHelper.Check_DataExByGroupId(groudId)
    local quests=DataMgr.Player.quests;
    local tar_Quests={};
    for i,v in pairs(quests) do
        if v.group==groudId then
            table.insert(tar_Quests,v);
        end
    end
    return tar_Quests;
end




function DataExHelper.Check_RuningByGroupId(groupId)
    local quests=DataMgr.Player.quests;
    for i,v in pairs(quests) do
        if v.group==groupId then
            return true;
        end
    end
    return false;
end






function DataExHelper.Check_RewardState(id)
    local dataQuests=DataMgr.Player.quests;
    local state=nil;
    local eventState=dataQuests[id];
    if(eventState==nil) then
        state=-1;
    else
        state=eventState.state;
    end
    return state;
end







function DataExHelper.GetDataExByTag(tag)
    local groupId = ActivityMgr.groupKeyList[tag]
    return DataMgr.Player.variables[groupId]
end


 function DataExHelper.Check_LuckDrawRunning()
     local groupId = ActivityMgr.groupKeyList["draw"]
     return DataMgr.Player.variables[groupId]~=nil;
 end

function DataExHelper.Check_SnacksOnLineRunning()
    local groupId = ActivityMgr.groupKeyList["onlinereward"]
    if DataMgr.Player.variables[groupId]==nil then
        return false
    end
    local cfgOnLineReward = ConfigMgr.Config.onlineReward;
    if (#cfgOnLineReward == 0) then
        return false
    end
    local dataOnlineReward = DataMgr.Player.onlineReward;
    if (dataOnlineReward.RewardID == 0) then
        return false;
    end
    return true
end



function DataExHelper.Check_NewYearRunning()
    local groupId = ActivityMgr.groupKeyList["newYear"]
    return  DataMgr.Player.variables[groupId]~=nil;
end


function DataExHelper.Check_InitialchargeRunning()
    local groupId = ActivityMgr.groupKeyList["initialcharge"]
    if DataMgr.Player.variables[groupId]==nil then
        return false
    end
   local lock= FeatureManager.IsLock("1200") or FeatureManager.IsLock("1210"); 
    if lock then return false end;
    
    local fristPay=ConfigMgr.Config.activityGroup["103"].system;
    if fristPay==nil or fristPay[2]==0 then
        return false
    end
    local cfgMissionMap={};
    for i,v in pairs(ConfigMgr.Config.missionMap) do
        if fristPay[2]==3001001 and v.type==ShopTaskType.firstPay then
            cfgMissionMap[v.id]=v;
        elseif fristPay[2]==3001101 and v.type==ShopTaskType.newfirstPay then
            cfgMissionMap[v.id]=v;
        end
    end
    local missions=DataMgr.Player.fundMissions;
    if IsNull(missions) or missions==nil or NumTool.GetLen(missions)==0 then
        return true
    end;
    local fristMission={};
    for i,v in pairs(cfgMissionMap) do
        if missions[v.id]~=nil then
            table.insert(fristMission,missions[v.id]);
        end
    end
    if #fristMission==0 then return true end;
    for i,v in ipairs(fristMission) do
        if not v.completed then
            return true
        end
    end
    return false
end



function DataExHelper.Check_JobInRunning()
    local groupId = ActivityMgr.groupKeyList["entry"]
    if IsNull(DataMgr.Player.variables) then

        print("player data is error :variables is nil")
        return false
    end;
    local data=DataMgr.Player.variables[groupId];

    if data==nil or data.clientFished then return false end;


    if DataExHelper.Check_SignInNewRuning() then
        return true
    end

local missions=DataMgr.Player.missions;
    for i,v in pairs(missions) do

        if v["501"]~=nil then
            for p,m in pairs(v["501"]) do
                if not m.completed then
                    return true;
                end
            end
        end

        if v["502"]~=nil then
            for p,m in pairs(v["502"]) do
                if not m.completed then
                    return true;
                end
            end
        end
    end

    local dunRecords=DataMgr.Player.dungeonRecords
    local teachingEvents={}
    if not IsNull(ConfigMgr.Config.areaEvents) then
        for i,v in pairs(ConfigMgr.Config.areaEvents) do
            if v~=nil then
                if v.category==8 then
                    table.insert(teachingEvents,v);
                elseif v.category==9 then
                    table.insert(teachingEvents,v);
                end
            end
        end
    end
    for i,v in ipairs(teachingEvents) do
        if dunRecords[v.id]==nil or dunRecords[v.id].completeCount==0 then
            return true;
        end
    end

    local climbDungeon={}
    for i,v in ipairs(ConfigMgr.Config.activityMapEventList) do
        if v.area=="entry" and v.type==2 then
            table.insert(climbDungeon,ConfigMgr.Config.dungeonMap[v.eventParam])
        end
    end
    for i,v in ipairs(climbDungeon) do
        if dunRecords[v.id]==nil or dunRecords[v.id].completeCount==0 then
            return true;
        end
    end
    

    local dataEntryEvents=DataMgr.Player.activityMaps["entry"].activityEvents;
    for i,v in ipairs(ConfigMgr.Config.activityMapEventList) do
        if v.area=="entry" and v.type==1 and (dataEntryEvents[v.id]==nil or not dataEntryEvents[v.id].complete) then
           return true
        end
    end
    if not data.clientFished and LuaMgr.IsPanelOpen(UIName.MainPageViewModel) then
        LuaMgr.ShowLuaPanel(UIName.JoinJobEndViewModel)
        local ids=NumTool.split(groupId,".");
        if #ids>1 then
            local askData={groupId=tonumber(ids[2])}
            ApiMgr.Request("ex/update_finished",askData,true,nil,nil,true)
        end
    end
    return false
end


function DataExHelper.Check_ChanganRunning()
    local groupId = ActivityMgr.groupKeyList["changan"]
    return DataMgr.Player.variables[groupId]~=nil;
end



function DataExHelper.Check_TravelRunning()
    local groupId = ActivityMgr.groupKeyList["travel"]
    return DataMgr.Player.variables[groupId]~=nil;
end



function DataExHelper.Check_FarmRunning()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.Seed]
    return DataMgr.Player.variables[groupId]~=nil;
end



function DataExHelper.Check_FlowerRuning()
    local groupId = ActivityMgr.groupKeyList["huazhao"]
    return DataMgr.Player.variables[groupId]~=nil;
end




function DataExHelper.Check_TrafficPermintRuning()
    local groupId = ActivityMgr.groupKeyList["pass"]
    return DataMgr.Player.variables[groupId]~=nil;
end



function DataExHelper.Check_CollectActivity()

    local groupId = ActivityMgr.groupKeyList["collect"]
    if DataMgr.Player.variables[groupId] == nil then
        return false
    end
    if LuaMgr.Timestamp() >= DataMgr.Player.variables[groupId].delTime then
        return false
    end
    return true
end



function DataExHelper.Check_BuyHeroActivity()
    local groupId = ActivityMgr.groupKeyList["buyHero"]
    if DataMgr.Player.variables[groupId] == nil then return false end
    if LuaMgr.Timestamp() >= DataMgr.Player.variables[groupId].delTime then
        return false
    end
    return true
end



function DataExHelper.Check_HeroBranchActivity()
    local groupId = ActivityMgr.groupKeyList["Story1"]
    if DataMgr.Player.variables[groupId] == nil then return false end
    if LuaMgr.Timestamp() >= DataMgr.Player.variables[groupId].delTime then
        return false
    end
    return true
end



function DataExHelper.Check_CelebrationActivity()
    local groupId = ActivityMgr.groupKeyList["celebration"]
    if DataMgr.Player.variables[groupId] == nil then return false end
    local activityData = DataExHelper.Check_ConfigQuestEventByGroupId(800)
    local tempData = DataMgr.Player.quests[activityData[1].id]
    if tempData == nil then return end
    if tempData.state == 3 then return false end
    if LuaMgr.Timestamp() >= DataMgr.Player.variables[groupId].delTime then
        return false
    end
    return true
end



function DataExHelper.Check_TourismRuning();
    local cfgYunyou
    for i,v in pairs(ConfigMgr.Config.activityGroup) do
        if v.key==ActivityKey.yunyou then
            cfgYunyou=v;
            break
        end
    end
    local activeType=cfgYunyou.system[2]
    local prefix="sys.1."..activeType;
    local variables=DataMgr.Player.variables;
    if variables[prefix]~=nil then
        return variables[prefix],tostring(activeType);
    end
    return nil;
    
end
    



function DataExHelper.Check_SignInNewRuning()
    local runing=false;
    local groupId = ActivityMgr.groupKeyList[ActivityKey.checkIn7]
    if DataMgr.Player.variables[groupId]==nil then
        return runing;
    end
    local checkInList={};
    local quests=DataMgr.Player.quests;
    for i,v in pairs(quests) do
        if v.group==101 then
            table.insert(checkInList,v);
        end
    end
    if #checkInList>0 then
        for i,v in ipairs(checkInList) do
            if v.state~=3 then
                runing=true;
                break;
            end
        end
    end
    return runing;
end

function DataExHelper.Check_CDKeyRuning()
    if DataMgr.Player.focusWXStatus~=nil and DataMgr.Player.focusWXStatus==1 then
        return false;
    end
    local isChannel=false;
    local channel=LuaMgr.GetChanel();
    local cfgGroup=ConfigMgr.Config.activityGroup
    local cfgCDKey=nil
    for i,v in pairs(cfgGroup) do
        if v.key=="cdkey" and v.open then
            cfgCDKey=v;
            break
        end
    end
    if cfgCDKey~=nil then
        local cfgChannels=NumTool.split(cfgCDKey.channel,";")
        for i,v in ipairs(cfgChannels) do
            if v==channel then
                isChannel=true;
            end
        end
    end
    local groupId = ActivityMgr.groupKeyList["cdkey"]
    local isCDKeyData= DataMgr.Player.variables~=nil and DataMgr.Player.variables[groupId]~=nil;
    return isCDKeyData and isChannel;
end

function DataExHelper.Check_UpactorA0093()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.UpactorA0093];
    return DataMgr.Player.variables[groupId]~=nil;
end

function DataExHelper.Check_UpactorV0076()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.UpactorV0076];
    return DataMgr.Player.variables[groupId]~=nil;
end

function DataExHelper.Check_Upactor(key)
    local groupId = ActivityMgr.groupKeyList[key];
    if DataMgr.Player.variables[groupId]==nil then
        return false;
    end
    local curCards= ConfigHelper.GetCurCardPoolsData()
    if key==ActivityKey.UpactorOne then
        return  #curCards>0
    elseif key==ActivityKey.UpactorTwo then
        return  #curCards>1
    elseif key==ActivityKey.UpactorThree then
        return  #curCards>2
    elseif key==ActivityKey.UpactorFour then
        return  #curCards>3
    else
        return false;
    end
end

function DataExHelper.Check_LimitCharacter(key)
    local groupId = ActivityMgr.groupKeyList[key];
    if DataMgr.Player.variables[groupId]==nil then
        return false;
    end
    local curCards= ConfigHelper.GetCurLimitCardPoolsData()
    local cardPoolId = ""
    for i,v in pairs(ConfigMgr.Config.activityGroup) do
        if v.key == key then
            cardPoolId = v.IconPanel[1]
            break
        end
    end
    for i, v in ipairs(curCards) do
        if v.id == cardPoolId then
            return true
        end
    end
    return false
end


function DataExHelper.Check_NianBeast()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.NianBeast];
    return DataMgr.Player.variables[groupId]~=nil;
end


function DataExHelper.Check_WalkMount()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.walkmount];
    return DataMgr.Player.variables[groupId]~=nil;
end


function DataExHelper.Check_DaQin()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.daqin];
    return DataMgr.Player.variables[groupId]~=nil;
end


function DataExHelper.Check_GuoBao()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.GuoBao];
    return DataMgr.Player.variables[groupId]~=nil;
end


function DataExHelper.Check_SGY()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.SGY];
    return DataMgr.Player.variables[groupId]~=nil;
end


function DataExHelper.Check_SummerCamp()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.SummerCamp];
    return DataMgr.Player.variables[groupId]~=nil;
end


function DataExHelper.Check_QuestionnaireSurvey()
    if TableIsNull(ConfigMgr.Config.QuestionnaireMap) then
        return false
    else
        local isShow = false
        for key,value in pairs(ConfigMgr.Config.QuestionnaireMap) do
            if LuaMgr.Timestamp() >= value.startTime and LuaMgr.Timestamp() < value.endTime and 
                    not DataExHelper.Check_QuestionnaireSurveyState(key) then
                isShow = true
                break
            end
        end
        return isShow
    end
end


function DataExHelper.CheckYearGift(tag)
    local isRuning = DataExHelper.CommonActivityCheck(tag)
    if isRuning == true then
        return DataMgr.Player.AnniversaryRecharge2.View == true
    end
    return false
end


function DataExHelper.Check_QuestionnaireSurveyState(key)
    local isShow = false
    for i = 1, #NoticeMgr.questionnaireData do
        if NoticeMgr.questionnaireData[i] == key then
            isShow = true
            break
        end
    end
    return isShow
end


function DataExHelper.Check_Sailing()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.sailing];
    return DataMgr.Player.variables[groupId]~=nil;
end


function DataExHelper.Check_Music()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.musicYDW];
    return DataMgr.Player.variables[groupId]~=nil;
end

function DataExHelper.Check_BossChallenge()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.BossChallenge];
    return DataMgr.Player.variables[groupId]~=nil;
end


function DataExHelper.Check_ComeBackActivity()
    local backPlayer,variables = nil,nil
    if DataMgr.Player.backPlayer == nil or DataMgr.Player.backPlayer.startTime <= 0 then
        backPlayer = false
    else
        backPlayer = true
    end
    local groupId = ActivityMgr.groupKeyList[ActivityKey.backPlayer]
    local timestamp = LuaMgr.Timestamp()
    if DataMgr.Player.variables[groupId] == nil or timestamp > DataMgr.Player.variables[groupId].delTime then
        variables = false
    else
        variables = true
    end
    return backPlayer and variables
end

function DataExHelper.Check_ComeBackLetter()
    local backPlayer = DataMgr.Player.backPlayer
    if not backPlayer.tabUnlock.backLetter then
        return false
    end
    local tabKey = "backLetter"
    local missionId = nil
    if not TableIsNull(ConfigMgr.Config.BackPlayerTaskMap) then
        for key,value in pairs(ConfigMgr.Config.BackPlayerTaskMap) do
            if value.tab == tabKey and value.type == "454" then
                missionId = key
                break
            end
        end
    end
    if IsNullOrEmpty(missionId) then
        return false
    end
    local tempData = DataMgr.Player.backPlayerMissions[tabKey][missionId]
    if TableIsNull(tempData) then
        return false
    end
    return not tempData.completed
end


function DataExHelper.CommonFinishActivityCheck(tag)
    local groupId = ActivityMgr.groupKeyList[tag]
    if DataMgr.Player.variables[groupId] == nil then 
        LuaDebug.error("Error,This activity is not OPEN,must check activity active");
        return true;
    end
    
    local id=string.sub(groupId,7,#groupId);
    local activityData = DataExHelper.Check_ConfigQuestEventByGroupId(tonumber(id))
    for index, value in ipairs(activityData) do
        local tempData = DataMgr.Player.quests[value.id]
if tempData == nil then return true end
if tempData.state ~= 3 then return false end
if LuaMgr.Timestamp() >= DataMgr.Player.variables[groupId].delTime then
            return true
        end
    end
return true
end


function DataExHelper.CommonCanFinishActivityCheck(tag)
    local groupId = ActivityMgr.groupKeyList[tag]
if DataMgr.Player.variables[groupId] == nil then return false end
    local id=string.sub(groupId,7,#groupId);
    local activityData = DataExHelper.Check_ConfigQuestEventByGroupId(tonumber(id))
    for index, value in ipairs(activityData) do
        local tempData = DataMgr.Player.quests[value.id]
if tempData == nil then return false end
if tempData.state == 2 then return true end
if LuaMgr.Timestamp() >= DataMgr.Player.variables[groupId].delTime then
            return false
        end
    end
return false
end

function DataExHelper.Check_BrilliantGift()
    if not DataExHelper.CommonActivityCheck(ActivityKey.BrilliantGift) then
        return false;
    end
    local popList=DataExHelper.Check_ConfigQuestEventByText("BrilliantGiftPop")
    if IsNull(popList) or #popList==0 then return false end;
    for i,v in ipairs(popList) do
        if DataMgr.Player.quests[v.id]~=nil and DataMgr.Player.quests[v.id].state==2 then
            return true;
        end
    end
    return false;
end


function DataExHelper.Check_YPS()
    if not DataExHelper.CommonActivityCheck(ActivityKey.YPS) then
        return false;
    end
    local popList=DataExHelper.Check_ConfigQuestEventByText("MScheckIn")
    if IsNull(popList) or #popList==0 then return false end;
    for i,v in ipairs(popList) do
        if DataMgr.Player.quests[v.id]~=nil and DataMgr.Player.quests[v.id].state==2 then
            return true;
        end
    end
    return false;
end

function DataExHelper.GetActivityGroup(tag)
    local groupId = ActivityMgr.groupKeyList[tag]
    if not IsNullOrEmpty(groupId) then
        return groupId
    end
    return nil
end


function DataExHelper.CommonActivityCheck(tag)
    local groupId = ActivityMgr.groupKeyList[tag];
    local variables = nil
    if not IsNullOrEmpty(groupId) then
        variables = DataMgr.Player.variables[groupId]
    end
    if not TableIsNull(variables) then
        local nowTime = LuaMgr.Timestamp()
        if nowTime >= variables.startTime and nowTime < variables.delTime then
            return true
        end
    end
    return false
end

function DataExHelper.GetActivityTimeData(tag)
    local groupId = ActivityMgr.groupKeyList[tag];
    local variables = nil
    if not IsNullOrEmpty(groupId) then
        variables = DataMgr.Player.variables[groupId] 
    end
    local data = {}
    if variables ~= nil then
        data.Value = variables.value
        data.StartTime = variables.startTime
        data.UpdateTime = variables.updateTime
        data.ExpireTime = variables.expireTime
        data.DelTime = variables.delTime
        data.ClientFished = variables.clientFished
    end
    return data
end


function DataExHelper.EX_Sign(groud_id,callBack)
    local askData={groupId=groud_id};
    ApiMgr.Request("ex/sign", askData, true, function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if(callBack~=nil) then
            callBack();
        end
    end, nil, false);
end


function DataExHelper.EX_RepairSign(questId,callBack)
    local askData={QuestId=questId};
    ApiMgr.Request("ex/repair_sign", askData, true, function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if(callBack~=nil) then
            callBack();
        end
    end, nil, false);
end


function DataExHelper.EX_RefreshTask(quests,callBack)
    local askData={QuestId=quests};
    ApiMgr.Request("ex/refresh_task", askData, true, function(result)
        if(callBack~=nil) then
            callBack();
        end
    end, nil, false);
end


function DataExHelper.EX_GetGroupAward(groupId,callBack)
    local askData={groupId=groupId}
    ApiMgr.Request("ex/get_group_award", askData, true, function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if(callBack~=nil) then
            callBack();
        end
    end, nil, true);
end




function DataExHelper.EX_GetAwardData(quest_Id,callBack)
    local askData={questId=quest_Id}
    ApiMgr.Request("ex/get_award", askData, true, function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        if(callBack~=nil) then
            callBack(data);
        end
    end, nil, true);
end




function DataExHelper.EX_GetAward(quest_Id,callBack)
    local askData={questId=quest_Id}
    ApiMgr.Request("ex/get_award", askData, true, function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if(callBack~=nil) then
            callBack();
        end
    end, nil, true);
end


function DataExHelper.EX_GetAwards(quest_Ids,callBack)
    local askData={questIds=quest_Ids}
    ApiMgr.Request("ex/get_award", askData, true, function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if(callBack~=nil) then
            callBack();
        end
    end, nil, true);
end


function DataExHelper.EX_ShopConvert(quest_Id,count,callBack)
    local askData={questId=quest_Id,count=count}
    ApiMgr.Request("ex/shop_convert", askData, true, function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if(callBack~=nil) then
            callBack();
        end
    end, nil, true);
end




function DataExHelper.EX_ComeBackComplete(id,tab,callBack)
    local tempData = {id = id,tab = tab}
    ApiMgr.Request("back/get_mission_award", tempData, true, function(result)
        local re = json.decode(result)
        local data = json.encode(re.result)
        LuaMgr.ShowItemRewared(data)
        if(callBack ~= nil) then
            callBack()
        end
    end, nil, true)
end


function DataExHelper.EX_GetGroupListByArea(area)
    local groupList={}
    for i,v in ipairs(ConfigMgr.Config.activityMapGroupList) do
        if v.area==area then
            table.insert(groupList,v);
        end
    end
    return groupList;
end

function DataExHelper.EX_GetEventMapByArea(area)
    local eventMap={}
    for i,v in ipairs(ConfigMgr.Config.activityMapEventList) do
        if v.area==area then
            if eventMap[v.groupId]==nil then
                eventMap[v.groupId]={}
            end
            table.insert(eventMap[v.groupId],v);
        end
    end
    return eventMap;
end


function DataExHelper.EX_GetEventListByArea(area)
    local event;
    local eventList = {};
    local activityMapEventList = ConfigMgr.Config.activityMapEventList;
    local len = #activityMapEventList;
    for i = 1, len do
        event = activityMapEventList[i]; 
        if (event.area == area) then
            table.insert(eventList, event);
        end
    end
    return eventList;
end



function DataExHelper.EX_CheckLocalRunning(ActivityKey)
    local groupId = ActivityMgr.groupKeyList[ActivityKey];
    if groupId==nil then 
        return false
    end;
    local var= DataMgr.Player.variables[groupId];
    return var.expireTime>LuaMgr.Timestamp();
end






function DataExHelper.GetDungeonDecordRating(eventParam)
    local dungeonData = DataMgr.Player.dungeonRecords[eventParam]
    if dungeonData ~= nil then
        if dungeonData.historyRating == "S" then
            return 1
        elseif dungeonData.historyRating == "A" then
            return 2
        elseif dungeonData.historyRating == "B" then
            return 3
        end
    end
    return 0
end

function DataExHelper.GetActivityMapEventMap()
    if DataExHelper.activityMapEventMap~=nil then
        return DataExHelper.activityMapEventMap;
    end
    DataExHelper.activityMapEventMap={}
    for i,v in ipairs(ConfigMgr.Config.activityMapEventList) do
        DataExHelper.activityMapEventMap[v.id]=v;
    end
    return DataExHelper.activityMapEventMap;
end



function DataExHelper.GetMedalList(activityGroup)
    if DataExHelper.MedalConfigs == nil then
        DataExHelper.MedalConfigs = {}
    end
    local medalConfigs = ConfigMgr.Config.Medals
    local tempList = {}
    for k, v in pairs(medalConfigs) do
        if v.Activity == activityGroup then
            local item = {
                id = v.Id,
                icon = LuaMgr.GetSprite("ZhanXunIcon", v.Id),
                name = LuaMgr.GetLangText(v.NameLan),
                desc = LuaMgr.GetLangText(v.DesLan),
                remark = LuaMgr.GetLangText(v.RemarksLan),
            }
            table.insert(tempList, item)
        end
    end
    DataExHelper.MedalConfigs[activityGroup] = tempList
    return tempList
end

function DataExHelper.GetMedalFinishCount(activityGroup)
    local medalList = DataExHelper.GetMedalList(activityGroup)
    if medalList == nil then
        return 0
    end
    local finishMedalCount = 0
    for i, v in ipairs(medalList) do
        local curScore = DataExHelper.GetTotalScore(v.id)
        if curScore.Current >= curScore.Target then
            finishMedalCount = finishMedalCount + 1
        end
    end
    return finishMedalCount
end

function DataExHelper.GetTotalScore(id)
    if IsNull(DataMgr.Player.MedalStepMap[id]) then
        return { Current = 0, Target = 1 }
    end
    return DataMgr.Player.MedalStepMap[id]
end


function DataExHelper.GetActivityTimeStr(key)
    local d, h, m = 0, 0, 0
    local timeStr = "";
    if DataExHelper.CommonActivityCheck(key) then
        local daqin = DataExHelper.GetDataExByTag(key);
        local time = daqin.expireTime - LuaMgr.Timestamp();
        d, h, m = GetTimeDHM(time);
    end
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"));
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
    end
    return timeStr
end



return DataExHelper