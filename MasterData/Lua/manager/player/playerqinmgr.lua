PlayerQinMgr = {}

local this = {
isInit = false,
stageId = 0,
settlementType = 0,
isFastBattle = false,
fastBattleKey = "",
battleCountry = 0,
levelType = 0,
bGetReward = false,
};

PlayerQinMgr.Init = function()
    if (this.isInit) then return end
    
    this.isInit = true;
    this.fastBattleKey = "QinSurveyFastBattle_" .. DataMgr.Player.uid;
    this.isFastBattle = PlayerPrefs.GetInt(this.fastBattleKey, 0) == 0;
end

PlayerQinMgr.Clear = function()
    this.isInit = false;
end


PlayerQinMgr.IsFastBattle = function()
    return this.isFastBattle;
end


PlayerQinMgr.SetFastBattle = function(isFastBattle)
    this.isFastBattle = isFastBattle;
    PlayerPrefs.SetInt(this.fastBattleKey, isFastBattle and 0 or 1);
end


PlayerQinMgr.GetActivityMapEvent = function(type, id)
    local daqin = DataMgr.Player.activityMaps[type];
    if (daqin ~= nil) then
        return daqin.activityEvents[id];
    end
    return nil;
end


PlayerQinMgr.EnterStageHeroChoice = function(stageId)
    this.stageId = stageId;
    HeroParameter.EmptyQinParam();
    HeroParameter.SaveQinParam(this.OnEnterStageHeroChoice);
    FeatureManager.GotoPanel("1004");
end


this.OnEnterStageHeroChoice = function()
    local members,num = this.GetSurveyMembers(HeroParameter.battleMembers);
    if(num <= 0)then return end
    PlayerQinMgr.EnterStage(this.stageId, members);
    LuaMgr.NextFrame(HeroParameter.EmptyQinParam);
end


PlayerQinMgr.EnterStage = function(stageId, members)
    ApiMgr.Request("qin/explore/enterStage", {StageId=stageId, Members=members}, true, this.EnterStageResponse, nil, true, true);
end


this.EnterStageResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        PlayerQinMgr.SetPlayAudio(true)
        LuaMgr.ShowLuaPanel(UIName.QinSurveyViewModel);
    end
end


this.GetSurveyMembers = function(memberList)
    local member;
    local character;
    local attrStr;
    local attrMap;
    local equipStr;
    local hp;
    local members = {};
    local attrs = HeroMgr.GetMainAttrList();
    local attrKeys = this.GetAttrKeys(attrs);
    local len = #memberList;
    for i = 1, len do
        member = memberList[i];
        character = DataMgr.Player.characters[member];
        if (character.wear ~= "") then
            equipStr = json.encode(DataMgr.Player.equipments[character.wear]);
            attrStr = LuaMgr.GetCharacterPropertyCopy(member, equipStr, attrKeys);
        else
            attrStr = LuaMgr.GetCharacterPropertyCopy(member, "", attrKeys);
        end
        attrMap = json.decode(attrStr);
        hp = tonumber(attrMap["Hp"]);
        members[member] = {ID=member, HP=hp, MaxHP=hp};
    end
    return members,len;
end


this.GetAttrKeys = function(attrs)
    local attrKeys = {};
    local len = #attrs;
    for i = 1, len do
        attrKeys[i] = attrs[i].id;
    end
    return attrKeys;
end


PlayerQinMgr.Explore = function(position)
    ApiMgr.Request("qin/explore/explore", {Position=position}, true, this.ExploreResponse, nil, true, true);
end


this.ExploreResponse = function(result)
    LuaMgr.InvokeUIEventListeners(UIEventConst.QinSurveyMapRefresh);
    if (not PlayerQinMgr.IsMemberLive()) then
        PlayerQinMgr.Settlement(QinSurveyResultType.Lose);
    end
end


PlayerQinMgr.IsUnExplore = function()
    local grid;
    local qinMap = DataMgr.Player.Qin.QinMap;
    local len = #qinMap;
    for i = 1, len do
        grid = qinMap[i];
        if (grid.State == QinSurveyState.Can or grid.State == QinSurveyState.Stop) then
            return true;
        end
        if (grid.State == QinSurveyState.Already) then
            if (grid.Typ ~= QinSurveyGrid.None
                    or grid.Typ ~= QinSurveyGrid.Start
                    or grid.Typ ~= QinSurveyGrid.End
                    or grid.Typ ~= QinSurveyGrid.Monster) then
                return true;
            end
        end
    end
    return false;
end


PlayerQinMgr.IsUnExplore = function()
    local grid;
    local qinMap = DataMgr.Player.Qin.QinMap;
    local len = #qinMap;
    for i = 1, len do
        grid = qinMap[i];
        if (grid.State == QinSurveyState.Can or grid.State == QinSurveyState.Stop) then
            return true;
        end
        if (grid.State == QinSurveyState.Already) then
            if (grid.Typ ~= QinSurveyGrid.None
                    or grid.Typ ~= QinSurveyGrid.Start
                    or grid.Typ ~= QinSurveyGrid.End
                    or grid.Typ ~= QinSurveyGrid.Monster) then
                return true;
            end
        end
    end
    return false;
end


PlayerQinMgr.IsKillBoss = function()
    local grid;
    local qinMap = DataMgr.Player.Qin.QinMap;
    local len = #qinMap;
    for i = 1, len do
        grid = qinMap[i];
        if (grid.Typ == QinSurveyGrid.Boss and grid.State == QinSurveyState.Get) then
            return true;
        end
    end
    return false;
end


PlayerQinMgr.IsChallengeBoss = function()
    return DataMgr.Player.Qin.ChallengeBoss;
end


PlayerQinMgr.Settlement = function(type)
    this.settlementType = type;
    ApiMgr.Request("qin/explore/settlement", {}, true, this.SettlementResponse, nil, true, true);
end


this.SettlementResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        if (this.settlementType == QinSurveyResultType.Win) then
            LuaMgr.ShowLuaPanel(UIName.QinSurveyResultViewModel, this.settlementType, data.result.Rewards);
        elseif (this.settlementType == QinSurveyResultType.Lose) then
            LuaMgr.ShowLuaPanel(UIName.QinSurveyResultViewModel, this.settlementType);
        elseif (this.settlementType == QinSurveyResultType.Quit
                or this.settlementType == QinSurveyResultType.Leave) then
            LuaMgr.ShowLuaPanel(UIName.QinLevelViewModel, 2);
        end
    end
end


PlayerQinMgr.UseTools = function(itemId, index)
    ApiMgr.Request("qin/explore/useTools", {ItemId=itemId, Index=index}, true, this.UseToolsResponse, nil, true, true);
end


this.UseToolsResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        LuaMgr.HidePanel(UIName.QinSurveyResultViewModel);
        LuaMgr.InvokeUIEventListeners(UIEventConst.QinSurveyUseTools, data.result);
    end
end


PlayerQinMgr.EnterDungeon = function(dungeonId, members, index)
    local memberDic = {};
    local i = 0;
    for k, v in pairs(members) do
        if (v.HP > 0) then
            memberDic[tostring(i)] = k;
            i = i + 1;
        end
    end
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
    enterDungeonParams.eventId = dungeonId;
    enterDungeonParams.dungeonId = dungeonId;
    enterDungeonParams.members = memberDic;
    enterDungeonParams.extraParams = {"DQ", tostring(index),"NEED_SEND_ROLEHPMAP"};
    BattlePrepareMgr._enterDungeonParams = enterDungeonParams;
    LuaMgr.SceneSwitchMark();
    LuaMgr.SetCurTeamId(BattlePrepareMgr.formationId)
    PlayerAreaMgr.SetAreaDungeonId("-1");
    ApiMgr.Request("enter_dungeon", enterDungeonParams, true, function(result)
        LuaMgr.HidePanel(UIName.QinSurveyResultViewModel);
        local re = json.decode(result);
        local data = json.encode(re.result);
        LuaMgr.EnterBattle(data, -1);
    end, function(code) end, true);
end


PlayerQinMgr.EnterLeaveDungeon = function(dungeonId, index)
    ApiMgr.Request("enter_leave_dungeon", {dungeonId=dungeonId, extraParams={"DQ",tostring(index)}}, true, this.EnterLeaveDungeonResponse, nil, true, true);
end


this.EnterLeaveDungeonResponse = function(result)
    LuaMgr.InvokeUIEventListeners(UIEventConst.QinSurveyMapRefresh);
end


PlayerQinMgr.GetBoxToolsCount = function(id)
    local stageId = DataMgr.Player.Qin.StageId;
    local explore = DataMgr.Player.Qin.Explore[stageId];
    if (explore.Tools ~= nil) then
        local count = explore.Tools[id];
        return count == nil and 0 or count;
    end
    return 0;
end


PlayerQinMgr.GetToolsCount = function(id)
    local tools = DataMgr.Player.Qin.Tools;
    if (tools ~= nil) then
        local count = tools[id];
        return count == nil and 0 or count;
    end
    return 0;
end


PlayerQinMgr.GetMonster = function(index)
    return DataMgr.Player.Qin.MonsterMap[tostring(index)];
end


PlayerQinMgr.IsMemberLive = function()
    local members = DataMgr.Player.Qin.Members;
    for _, v in pairs(members) do
        if (v.HP > 0) then
            return true;
        end
    end
    return false;
end


PlayerQinMgr.DrawReward = function(groupId, count, callback)
    ApiMgr.Request("draw/drawReward", {Group=groupId, Count=count}, true, callback, nil, true);
end


PlayerQinMgr.SetBattleCountry = function(battleCountry)
    this.battleCountry = battleCountry;
end


PlayerQinMgr.GetBattleCountry = function()
    return this.battleCountry;
end


PlayerQinMgr.ExchangeChar = function(callback)
    ApiMgr.Request("qin/exchangeChar", {}, true, callback, nil, true, true);
end


PlayerQinMgr.GetSurveyBuffsID = function()
    local buffStr = "";
    local buffIds = DataMgr.Player.Qin.BuffIds;
    local len = #buffIds;
    if (len > 0) then
        local buff;
        for i = 1, len do
            buff = ConfigQinMgr.GetBuff(buffIds[i]);
            buffStr = buffStr .. buff.Id .. ",";
        end
        buffStr = string.sub(buffStr, 1, string.len(buffStr) - 1);
    end
    return buffStr;
end


PlayerQinMgr.GetMonsterHp = function(dungeonId)
    local qin = DataMgr.Player.Qin;
    if (qin ~= nil) then
        local monsterMap = qin.MonsterMap;
        if (monsterMap ~= nil and not IsNull(monsterMap)) then
            for _, v in pairs(monsterMap) do
                if (v.MonsterId == dungeonId) then
                    return v.MonsterHurt;
                end
            end
        end
    end
    return 0;
end


PlayerQinMgr.SetLevelType = function(levelType)
    
    this.levelType = tostring(levelType);
end


PlayerQinMgr.GetLevelType = function()
    return  tonumber(this.levelType);
end


PlayerQinMgr.SetOldQuest = function(quest)
    this.questData = table.Copy(quest)  
end


PlayerQinMgr.GetOldQuest = function()
    return this.questData;
end


PlayerQinMgr.SetPlayAudio = function(bPlay)
    this.bPlay = bPlay
end


PlayerQinMgr.GetPlayAudio = function()
    return this.bPlay;
end


PlayerQinMgr.SetPlayQinLevelItemAnimationId = function(id)
    if(this.playAniId == nil)then
        this.playAniId = {}
    end
    this.playAniId[id] = true
end


PlayerQinMgr.GetPlayQinLevelItemAnimationId = function()
    return this.playAniId;
end

PlayerQinMgr.ClearPlayQinLevelItemAnimationId = function()
    this.playAniId = nil
end


PlayerQinMgr.SetEffectFlyPos = function(type,pos)
    if(this.effectFlyPosTab == nil)then
        this.effectFlyPosTab = {}
    end
    this.effectFlyPosTab[type] = pos  
end


PlayerQinMgr.GetEffectFlyPos = function(type)
    if(this.effectFlyPosTab == nil)then
        return Vector2.zero
    end
    return this.effectFlyPosTab[type]
end


PlayerQinMgr.SetPlayDissolve = function(bPlay)
    this.PlayDissolve = bPlay
end


PlayerQinMgr.GetPlayDissolve = function()
    return this.PlayDissolve;
end

PlayerQinMgr.SetCanGetReward = function(bCan)   
    if(bCan and not this.bGetReward )then
        this.bGetReward = bCan
        this.delay = coroutine_runner.start(function()       
            coroutine_runner.wait(1.5)
            this.bGetReward = false       
        end) 
        return
    end
    if(not bCan and  this.delay ~= nil)then
        if this.delay ~= nil then           
            coroutine_runner.stop(this.delay)
        end
    end
    this.bGetReward = bCan
end


PlayerQinMgr.GetCanGetReward = function()
    return this.bGetReward;
end