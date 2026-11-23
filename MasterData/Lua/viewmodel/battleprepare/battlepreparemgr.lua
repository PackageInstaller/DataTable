BattlePrepareMgr = {
_enterDungeonParams = nil,
    formationId = "",
    memberDic = { },
    isEnterBattle = false,
    isLeveling=false,
    isLeveling_teaching=false;
    isLeveling_test = false;
    
    levelingData={
        characterDataMap = {}
    },
isRogue=false,
}
local _areaEvent = {}
local _filters = {}

BattlePrepareMgr.BattleType={
    Area = 1,
    Daily = 2,
    HZJ=3,
    Branch =4,
    Climbtower=5,
    Delegate=6,
    Travel=7,
    NianBeast=8,
}

BattlePrepareMgr.LockFormation={
    ["YX2"]="teamsYX",
}

BattlePrepareMgr.Init=function()
    
    
end 

BattlePrepareMgr.IsLeveling=function()
    return BattlePrepareMgr.isLeveling
end

BattlePrepareMgr.BattlePrepare = function(enterParams, filters)
    if type(enterParams) == "string" then
        enterParams = json.decode(enterParams)
    end
    BattlePrepareMgr._enterDungeonParams = enterParams
    if enterParams.isleveling~=nil and enterParams.isleveling then
        BattlePrepareMgr.isLeveling=true;
        BattlePrepareMgr.InitLevelingData();
    else
        BattlePrepareMgr.isLeveling=false;
    end
   

    _areaEvent.id = enterParams.eventId
    _areaEvent.eventParam = enterParams.dungeonId
    _areaEvent.type = 2
    
    if filters ~= nil then
        _filters = filters
    end
    
    LuaMgr.ShowLuaPanel("BattlePrepareViewModel", _areaEvent)
end

BattlePrepareMgr.IsMoreMod = function()
    return BattlePrepareMgr.IsActivityDungeon("moremod")
end

BattlePrepareMgr.IsActivityDungeon = function(activityId)
    if BattlePrepareMgr._enterDungeonParams == nil then
        return false
    end
    for i, v in ipairs(BattlePrepareMgr._enterDungeonParams.extraParams or {}) do
        if v == activityId then
            return true
        end
    end
    return false
end

BattlePrepareMgr.InitLevelingData = function()
    BattlePrepareMgr.levelingData = {}
    BattlePrepareMgr.levelingData.characterDataMap = {}
    BattlePrepareMgr.levelingData.equipmentDataMap = {}
    for i, v in ipairs(ConfigMgr.Config.HeroModules) do
        BattlePrepareMgr.levelingData.characterDataMap[v.CharacterId] = json.decode(LuaMgr.GetHeroModelCharacter(v.CharacterId))
        local equipmentData = json.decode(LuaMgr.GetHeroModelEquipment(v.CharacterId))
        if not IsNullOrEmpty(equipmentData) and BattlePrepareMgr.levelingData.equipmentDataMap[equipmentData.id] == nil then
            BattlePrepareMgr.levelingData.equipmentDataMap[equipmentData.id] = equipmentData
        end
    end
end



BattlePrepareMgr.LevelingWeek_CheckJointCharacter=function(id)
    if DataMgr.Player.moreModAssist==nil then return false end;
    for i,v in pairs(DataMgr.Player.moreModAssist) do
        if i==id then
            return true,v;
        end
    end
end


BattlePrepareMgr.EnterBattle = function(memberDic, formationId, avgParam)
    if BattlePrepareMgr._enterDungeonParams == nil then
        return
    end
    BattlePrepareMgr.isEnterBattle = true
    BattlePrepareMgr._enterDungeonParams.members = memberDic
    BattlePrepareMgr._enterDungeonParams.teamId = formationId

    if not TableIsNull(BattlePrepareMgr._enterDungeonParams.extraParams) and
            BattlePrepareMgr._enterDungeonParams.extraParams[1] == "wood_training" then
        local helpDic = {};
        for k, id in pairs(memberDic) do
            if (PlayerAssistMgr.IsAssistMember(id)) then
                helpDic[k] = PlayerAssistMgr.GetAssistMemberUid(id);
            else
                helpDic[k] = "";
            end
        end
        BattlePrepareMgr._enterDungeonParams.helps = helpDic;
    end
    

    HeroParameter.changeAfterTeam = nil

    local isNovelModel=PlayerAreaMgr.GetAreaModel()==AreaModel.Novel
    if isNovelModel then

        local cfgDungeon=ConfigMgr.Config.dungeonMap[BattlePrepareMgr._enterDungeonParams.dungeonId];
        if cfgDungeon~=nil and not IsNull(cfgDungeon.easyBuff) and #cfgDungeon.easyBuff>0 then
            BattlePrepareMgr._enterDungeonParams.storyMode=true;
            if IsNull(BattlePrepareMgr._enterDungeonParams.extraParams) then
                BattlePrepareMgr._enterDungeonParams.extraParams={};
            end
            table.insert(BattlePrepareMgr._enterDungeonParams.extraParams,"novel_1");
        end
    end
    if BattlePrepareMgr.isRogue then
        if IsNull(BattlePrepareMgr._enterDungeonParams.extraParams) then
            BattlePrepareMgr._enterDungeonParams.extraParams={};
        end
        RogueExploreMgr.CheckEnterBattleByExtraParams(BattlePrepareMgr._enterDungeonParams.extraParams);
    end
    if avgParam ~= nil and avgParam ~= "" then
        LuaMgr.SceneSwitchMark(_filters)
        local param = json.encode(BattlePrepareMgr._enterDungeonParams)
        LuaMgr.PlayNovel(avgParam, param)
    else
        LuaMgr.SetCurTeamId(formationId)

        ApiMgr.Request("enter_dungeon",BattlePrepareMgr._enterDungeonParams,true,function(result)
            local re = json.decode(result)
            local data=json.encode(re.result);
            BattlePrepareMgr.CheckLogBiliEvent(re.result.dungeonId,re.result.battleRecordId)
            LuaMgr.SceneSwitchMark(_filters)
            LuaMgr.EnterBattle(data, formationId);
        end,function(failCode)
            BattlePrepareMgr.EnterBattleFail(failCode)
        end,true);
    end
end

local CheckFixLaw=function(fixList,lawId)
    for i,v in ipairs(fixList) do
        if v==lawId then
            return true;
        end
    end
    return false;
end

BattlePrepareMgr.CheckLogBiliEvent=function(dungeonId,battleId)
    local extraList=BattlePrepareMgr._enterDungeonParams.extraParams;
    local fixList={};
    local expendList={};
    local fixItem={};
    if extraList~=nil and #extraList>0 and extraList[1]=="moremod" then
        local cfgfixBuff=ConfigMgr.Config.moreModLawMap;
        local fixLawList=ConfigMgr.Config.screenLawMap[dungeonId].LawFixed;
        for i=3,#extraList,1 do
            local extraId=extraList[i];
            if extraId~="" then
                fixItem={
                    buff_id=extraId;
                    buff_type=cfgfixBuff[extraId].LawType;
                    buff_name=LuaMgr.GetLangText(cfgfixBuff[extraId].LawNameLan);
                };
                if(CheckFixLaw(fixLawList,extraList[i])) then
                    table.insert(fixList,fixItem);
                else
                    table.insert(expendList,fixItem);
                end
            end
        end
        local data= {
            stage_uid = battleId,
            cp_param = "",
            fix_buff = fixList,
            expand_buff = expendList
        }
        DataReportMgr.RequestBiliData("donggu_buff_select",data,nil,nil);
    end
    
end
    

BattlePrepareMgr.EnterBattleFail = function(code)

    if code == 31 then
        LuaMgr.InvokeUIEventListeners(UIEventConst.EnterBattleDailyError)
    end
    

    if code == 100 then
        LuaMgr.InvokeUIEventListeners(UIEventConst.EnterBattleTowerError)
    end
    BattlePrepareMgr.isEnterBattle = false
end





BattlePrepareMgr.GetMemberList = function()
    local memberList = {}
    for k, v in pairs(BattlePrepareMgr.memberDic) do
        table.insert(memberList, v)
    end
    return memberList
end

BattlePrepareMgr.GetDefaultEnterDungeonParams = function()
    local param = {
        eventId = "",
        dungeonId = "",
        battleType = "",
        activeInfo = {
            activeId = "",
            dailyActiveId = "",
        },
        extraParams = nil,
        isActive = false,
        members = {},
        teamId = "",
        themeId="",
        eventType=0,
    }
    return param
end

BattlePrepareMgr.EnterBattlePrepare = function(id, eventParam, type)
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = id
    enterDungeonParams.dungeonId = eventParam
    enterDungeonParams.battleType=type==nil and "" or tostring(type);
    BattlePrepareMgr.BattlePrepare(enterDungeonParams)
end

BattlePrepareMgr.ClimbtowerEnterBattlePrepare = function(dungeonId, type, chapterId)
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = dungeonId
    enterDungeonParams.dungeonId = dungeonId
    
    local extraList = {}
    if type == "deconstruction" then
        table.insert(extraList, type)
        table.insert(extraList, chapterId)
    elseif type == "simulationTraining" then
        table.insert(extraList, type)
    end
    enterDungeonParams.extraParams = extraList
    BattlePrepareMgr.BattlePrepare(enterDungeonParams)
end




BattlePrepareMgr.TrainingDungeonEnterBattle = function(DungeonGroupID, dungeonIndex, memberDics)
    local trainingDungeonGroupCfg = ConfigMgr.Config.TrainingCpointMap[DungeonGroupID]
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    local dungeonId     = trainingDungeonGroupCfg.DungeonId[dungeonIndex]
    local dungeonCount  = #trainingDungeonGroupCfg.DungeonId
    enterDungeonParams.eventId = dungeonId
    enterDungeonParams.dungeonId = dungeonId

    local members = memberDics[dungeonIndex]
    enterDungeonParams.members = members

    local helpDic = {};
    for k, v in pairs(members) do
        local uid = PlayerAssistMgr.GetAssistCharacterUID(v)
        if uid then
            helpDic[k] = uid
        else
            helpDic[k] = "";
        end
    end
    enterDungeonParams.helps = helpDic
    enterDungeonParams.teamId = tostring(dungeonIndex)
    local extraList = {}
    if TrainingDungeonHelper.IsTraining2DungeonGroup(DungeonGroupID) then
        table.insert(extraList, "training2")
    else
        table.insert(extraList, "training")
    end
    table.insert(extraList, DungeonGroupID)
    local memberStr = ""
    for i = 1, #trainingDungeonGroupCfg.DungeonId do
        local memberLength = ConfigHelper.GetTableLength(memberDics[i])
        for j = 1, memberLength do
            local member = memberDics[i][tostring(j - 1)]
            if not IsNullOrEmpty(member) then
                memberStr = memberStr .. member
            end
            if j ~= memberLength then
                memberStr = memberStr .. "|"
            end
        end
        if i ~= #trainingDungeonGroupCfg.DungeonId then
            memberStr = memberStr .. ","
        end
    end
    table.insert(extraList, memberStr)
    table.insert(extraList, trainingDungeonGroupCfg.GroupBuff1[1] .. "|" .. trainingDungeonGroupCfg.GroupBuff1[2])
    table.insert(extraList, trainingDungeonGroupCfg.GroupBuff2[1] .. "|" .. trainingDungeonGroupCfg.GroupBuff2[2])
    if not TableIsNull(trainingDungeonGroupCfg.GroupBuff3) then
        table.insert(extraList, trainingDungeonGroupCfg.GroupBuff3[1] .. "|" .. trainingDungeonGroupCfg.GroupBuff3[2])
    else
        table.insert(extraList, "")
    end
    table.insert(extraList, TrainingDungeonHelper.GetChallengeStr(trainingDungeonGroupCfg.Challenge1, LuaMgr.GetLangText(trainingDungeonGroupCfg.Challenge1DesLan), dungeonCount))
    table.insert(extraList, TrainingDungeonHelper.GetChallengeStr(trainingDungeonGroupCfg.Challenge2, LuaMgr.GetLangText(trainingDungeonGroupCfg.Challenge2DesLan), dungeonCount))
    table.insert(extraList, TrainingDungeonHelper.GetChallengeStr(trainingDungeonGroupCfg.Challenge3, LuaMgr.GetLangText(trainingDungeonGroupCfg.Challenge3DesLan), dungeonCount))



    enterDungeonParams.extraParams = extraList
    BattlePrepareMgr._enterDungeonParams = enterDungeonParams

    if TrainingDungeonHelper.IsTraining2DungeonGroup(DungeonGroupID) then

    else
        _filters = {UIName.TrainingDungeonViewModel}
    end
    BattlePrepareMgr.EnterBattle(memberDics[dungeonIndex], tostring(dungeonIndex))
end

BattlePrepareMgr.GetEnterParamEventId = function()
    local eventID = ""
    if BattlePrepareMgr._enterDungeonParams ~= nil then
        eventID = BattlePrepareMgr._enterDungeonParams.eventId
    end
    return eventID
end

BattlePrepareMgr.GetEnterParamThemeId = function()
    local themeId = ""
    if BattlePrepareMgr._enterDungeonParams ~= nil then
        themeId = BattlePrepareMgr._enterDungeonParams.themeId
    end
    return themeId
end


BattlePrepareMgr.GetEnterDungeonParams = function()
    local jsonStr = json.encode(BattlePrepareMgr._enterDungeonParams)
	return jsonStr
end

BattlePrepareMgr.GetEnterDungeonParamsObj = function ()
    return BattlePrepareMgr._enterDungeonParams
end



BattlePrepareMgr.MoreModGetCharacterBattleCount=function(characterId)
    local count=0;
    local dungeons=DataMgr.Player.moreModData.Dungeons;
    if BattlePrepareMgr.isLeveling_teaching then
        dungeons=DataMgr.Player.guideMoreModData.Dungeons;
    end
    local battleCount=0;
    local remainBattleCount=0
    if not BattlePrepareMgr.isLeveling_test and not IsNull(dungeons) then
        for i,v in pairs(dungeons) do
            if not IsNull(v.RoleSheet) and (v.RoleSheet[characterId]~=nil) then
                battleCount=battleCount+1;
            end
        end
    end
    local rare=ConfigMgr.Config.characterTable[characterId].rare;
    for i,v in ipairs(ConfigMgr.Config.moreModConstants.RareNumLimit) do
        if v[1]==rare then
            if DataMgr.Player.characters[characterId]~=nil then
                count=count+v[2];
            end
            if DataMgr.Player.moreModAssist[characterId]~=nil then
                count=count+v[2];
            end
            remainBattleCount=count-battleCount;
            if remainBattleCount<0 then 
                remainBattleCount=0 
            end;
        end
    end
    return battleCount,remainBattleCount;
end
    

BattlePrepareMgr.MoreModCharacterHasBattleRecord=function(characterId)
    local roleSheet=BattlePrepareMgr.MoreModRoleSheet();
    if not IsNull(roleSheet) then
        return roleSheet[characterId]~=nil;
    end
    return false;
end


BattlePrepareMgr.MoreModRoleSheet=function()
    local dungeonId=BattlePrepareMgr._enterDungeonParams.extraParams[2];
    if  IsNull(DataMgr.Player.moreModData) or DataMgr.Player.moreModData==nil or 
            IsNull( DataMgr.Player.moreModData.Dungeons) or DataMgr.Player.moreModData.Dungeons[dungeonId]==nil then
        if DataMgr.Player.guideMoreModData.Dungeons[dungeonId]==nil then

            return {};
        end
        return DataMgr.Player.guideMoreModData.Dungeons[dungeonId].RoleSheet
    else
        return DataMgr.Player.moreModData.Dungeons[dungeonId].RoleSheet;
    end
end

BattlePrepareMgr.MoreModCheckmemberDic=function(isPop)
    local suspendList={}
    local memberDic={}
    local index=0;
    for i=1,6 do
        local member = BattlePrepareMgr.memberDic[tostring(i - 1)]
        if not IsNullOrEmpty(member) then
            local battleCount,reBattleCount=BattlePrepareMgr.MoreModGetCharacterBattleCount(member);

            if reBattleCount>0 or  BattlePrepareMgr.MoreModCharacterHasBattleRecord(member) then
                memberDic[tostring(index)]=member
                index=index+1;
            else
                table.insert(suspendList,member)
            end
        end
    end
    local key=DataMgr.Player.uid.."MOREMODE_SUSPEND"
    if isPop~=nil and  not isPop and  #suspendList>0 and UnityEngine.PlayerPrefs.GetInt(key)==0 then
        LuaMgr.ShowLuaPanel(UIName.AreaSqualSuspendTipViewModel,suspendList)
    end
    return memberDic;
end

BattlePrepareMgr.CheckConsumeOtherCondition=function()

    if BattlePrepareMgr._enterDungeonParams.battleType==tostring(BattlePrepareMgr.BattleType.Travel) and  DataMgr.Player.travel~=nil and DataMgr.Player.travel.TotalCount>0 then
        return true,0;
    end
    return false, 0;
end

BattlePrepareMgr.SetAreaDailyWeekEquipTurn = function (curEquipWeekIndex)
    BattlePrepareMgr.curEquipWeekIndex = curEquipWeekIndex
end


BattlePrepareMgr.AreaDailyWeekEquip=function(dungeonId)
    if IsNull(ConfigMgr.Config.dailyActiveMap) or ConfigMgr.Config.dailyActiveMap["100003"]==nil then
        return false,nil,nil;
    end 
    if dungeonId~=ConfigMgr.Config.dailyActiveMap["100003"].pointTurn[1][1] then
        return false,nil,nil;
    end
    local curEquipWeekIndex=BattlePrepareMgr.curEquipWeekIndex
    if curEquipWeekIndex == nil then
        LuaDebug.error("BattlePrepareMgr.AreaDailyWeekEquip error:" .. debug.traceback())
        return false, nil, nil
    end
    if dungeonId==ConfigMgr.Config.dailyActiveMap["100003"].pointTurn[1][1] then
        local showTurn=ConfigMgr.Config.dailyActiveMap["100003"].showTurn[curEquipWeekIndex]
        local dropShow=ConfigMgr.Config.dailyActiveMap["100003"].dropTurn[curEquipWeekIndex]
        local str="";
        for i,v in ipairs(showTurn) do
            if i==#showTurn then
                str=str..v
            else
                str=str..v..";";
            end

        end
        return true,str,dropShow;
    end
    return false,nil,nil;
    
end


BattlePrepareMgr.GetFastBattleCount=function(dungeonId)

    if DataExHelper.Check_TravelRunning() then
        local cfgTravelLevelMap={}
        for i, v in ipairs(ConfigMgr.Config.activityMapEventList) do
            if v.area == "Travel" and v.type == 2 and not IsNullOrEmpty(v.groupId) then
                cfgTravelLevelMap[v.eventParam]=v;
            end
        end
        if cfgTravelLevelMap[dungeonId]~=nil then
            return DataMgr.Player.travel.TotalCount
        end
    end

    return nil;
end




BattlePrepareMgr.NeedLockFormation=function ()
    if BattlePrepareMgr._enterDungeonParams == nil then
        return false,nil;
    end
    if BattlePrepareMgr._enterDungeonParams.panelExtendParams~=nil and BattlePrepareMgr._enterDungeonParams.panelExtendParams.type~=nil then
        if BattlePrepareMgr.LockFormation[BattlePrepareMgr._enterDungeonParams.panelExtendParams.type]~=nil then
           return true,BattlePrepareMgr.LockFormation[BattlePrepareMgr._enterDungeonParams.panelExtendParams.type];
        else
            return false,nil;
        end
    end
    return false,nil;
end





BattlePrepareMgr.NeedLockCharacter=function ()
    if BattlePrepareMgr._enterDungeonParams == nil then
        return false,nil;
    end
    if BattlePrepareMgr._enterDungeonParams.panelExtendParams~=nil and BattlePrepareMgr._enterDungeonParams.panelExtendParams.isLockCharacter~=nil then
        return BattlePrepareMgr._enterDungeonParams.panelExtendParams.isLockCharacter,BattlePrepareMgr._enterDungeonParams.panelExtendParams.lockCharacterList
    end
    return false,nil;
end

BattlePrepareMgr.CheckMemberInvalid = function(member)
    local team=DataMgr.Player.teams[BattlePrepareMgr.formationId];
    if BattlePrepareMgr.IsMoreMod() or team == nil or team.members == nil then
        return ""
    end
    for i, v in pairs(team.members) do
        if v == member then
            local heroData = DataMgr.Player.characters[v]
            if heroData == nil and (team.helps == nil or team.helps[i] == nil or IsNullOrEmpty(team.helps[i])) then
                return ""
            end
        end
    end
    return member
end

BattlePrepareMgr.CheckAndSaveTeam = function(pParam, pResponse)
    if (pParam.members ~= nil and (pParam.battleType == nil or pParam.battleType ~= "moreMod")) then

        for i, v in pairs(pParam.members) do
            local heroData = DataMgr.Player.characters[v]
            if heroData == nil and (pParam.helps == nil or pParam.helps[i] == nil or IsNullOrEmpty(pParam.helps[i])) then
                LuaDebug.error("save_team error!, Invalid members parameter")
                return
            end
        end
    end

    local originTeamData = DataMgr.Player.teams[tostring(pParam.teamId)]
    if originTeamData ~= nil then
        if pParam.name == nil then
            pParam.name = originTeamData.name
        end
        if pParam.teamWeapon == nil then
            pParam.teamWeapon = originTeamData.teamWeapon
        end
    end
    
    ApiMgr.Request("save_team", pParam, true, pResponse, null, true)
end

BattlePrepareMgr.Clear = function()
    BattlePrepareMgr.levelingData={};
    BattlePrepareMgr._enterDungeonParams = nil
    BattlePrepareMgr.isLeveling=false;
    BattlePrepareMgr.isRogue=false;
end