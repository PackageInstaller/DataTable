require("ViewModel/Dungeon66/Dungeon66PrepareChallengeItem")
require("ViewModel/Dungeon66/Dungeon66PrepareCharacterItem")
require("ViewModel/Dungeon66/Dungeon66PrepareEnemyItem")
require("ViewModel/Dungeon66/Dungeon66PrepareConditionItem")

local this = {
    levelData = nil,
    index = 0,
    dungeonConfig = nil,
    monsterList = nil,
    challengesList = nil,
    enemysList = nil,
    conditionWinList = nil,
    conditionLoseList = nil,
    characterList = nil,
    characterDatas = nil,
    characterIndex = 0,
    heroTips = "",
};

local objs = {

    typeText = { path = "root/Middle/Title/Type", type = "Text" },
    nameText = { path = "root/Middle/Title/Name", type = "Text" },
    assistGO = { path = "root/Middle/Title/Assist", type = "GameObject" },
    assistText = { path = "root/Middle/Title/Assist/Text", type = "Text" },
    assistCountGO = { path = "root/Middle/Title/AssistCount", type = "GameObject" },
    assistCountText = { path = "root/Middle/Title/AssistCount/Text", type = "Text" },
    characterItem = { path = "template/CharacterItem", type = "GameObject" },
    charactersListTF = { path = "root/Middle/Characters/List", type = "Transform" },
    charactersBg1 = { path = "root/Middle/Characters/BG/BG1", type = "Button" },
    charactersBg2 = { path = "root/Middle/Characters/BG/BG2", type = "Button" },
    charactersBg3 = { path = "root/Middle/Characters/BG/BG3", type = "Button" },
    charactersBg4 = { path = "root/Middle/Characters/BG/BG4", type = "Button" },
    charactersBg5 = { path = "root/Middle/Characters/BG/BG5", type = "Button" },
    charactersBg6 = { path = "root/Middle/Characters/BG/BG6", type = "Button" },
    clearBtn = { path = "root/Middle/Characters/Clear", type = "Button" },
    quickBtn = { path = "root/Middle/Characters/Quick", type = "Button" },
    unLockBtn = { path = "root/Middle/Characters/UnLock", type = "Button" },
    talentTreeBtn = { path = "root/Middle/Characters/TalentTreeBtn", type = "Button" },
    tips = { path = "root/Middle/Characters/Tips/Text", type = "Text" },
    level = { path = "root/Right/Info/Level/Text", type = "Text" },
    helpBtn = { path = "root/Right/Info/Help", type = "Button" },
    challengeItem = { path = "template/ChallengeItem", type = "GameObject" },
    challengesListTF = { path = "root/Right/Info/Challenges/List", type = "Transform" },
    enemyItem = { path = "template/EnemyItem", type = "GameObject" },
    enemysBtn = { path = "root/Right/Info/Enemys", type = "Button" },
    enemysListTF = { path = "root/Right/Info/Enemys/List", type = "Transform" },
    buffText = { path = "root/Right/Info/Buff/ScrollView/Viewport/Content", type = "Text" },
    startBtn = { path = "root/Right/Info/Start", type = "Button" },
    conditionItem = { path = "template/ConditionItem", type = "GameObject" },
    conditionGO = { path = "root/Right/Condition", type = "GameObject" },
    conditionTF = { path = "root/Right/Condition", type = "RectTransform" },
    conditionMaskBtn = { path = "root/Right/Condition/Mask", type = "Button" },
    conditionWinTF = { path = "root/Right/Condition/Group/Win", type = "RectTransform" },
    conditionWinListTF = { path = "root/Right/Condition/Group/Win/List", type = "Transform" },
    conditionLoseTF = { path = "root/Right/Condition/Group/Lose", type = "RectTransform" },
    conditionLoseListTF = { path = "root/Right/Condition/Group/Lose/List", type = "Transform" },
    noBuffTips = { path = "root/NoBuffTips", type = "GameObject" },
    noBuffTipsOn = { path = "root/NoBuffTips/Middle/Bg/Toggle/On", type = "GameObject" },
    noBuffTipsOff = { path = "root/NoBuffTips/Middle/Bg/Toggle/Off", type = "GameObject" },
    noBuffTipsToggleBtn = { path = "root/NoBuffTips/Middle/Bg/Toggle", type = "Button" },
    noBuffTipsConfirmBtn = { path = "root/NoBuffTips/Middle/ConfirmBtn", type = "Button" },
    noBuffTipsCancelBtn = { path = "root/NoBuffTips/Middle/CancelBtn", type = "Button" },
};


this.OnBack = function()
    if (this.conditionGO.activeSelf) then
        this.SetConditions(false);
    elseif (this.noBuffTips.activeSelf) then
        this.SetTechUnlockTips(false)
    else
        LuaMgr.Back();
    end
end


this.SetData = function()
    this.level.text = this.dungeonConfig.levelShow;
    local nameStr = "";
    if (this.index == 1) then
        nameStr = LuaMgr.GetLangText("Dungeon66PrepareViewModel_0");
    else
        nameStr = LuaMgr.GetLangText("Dungeon66PrepareViewModel_1");
    end
    local str = string.format(LuaMgr.GetLangText("Dungeon66PrepareViewModel_2"), this.levelData.index, nameStr);
    local curSeriesId=TrainingCampMgr.GetCurWheelSeriesID();
    local campSeries = TrainingCampMgr.GetCampSeries(curSeriesId);
    this.typeText.text = LuaMgr.GetLangText(campSeries.NameLan)
    this.nameText.text = str;
    this.heroTips = str .. LuaMgr.GetLangText("Dungeon66PrepareViewModel_3");
    if (not this.vm.behaviour.IsPop) then
        PlayerAssistMgr.UpdateFriendList2(this.SetCharacters);
    else
        this.SetCharacters();
    end
    this.SetAssist();
    this.SetChallenges();
    this.SetEmemys();
    this.SetBuff();
    
    SetActive(this.noBuffTipsOn, false)
    SetActive(this.noBuffTipsOff, true)
    SetActive(this.noBuffTips, false)
end


this.SetCharacters = function()
    this.characterList:Clear();
    if (HeroParameter.battleMembers ~= nil) then
        TrainingCampMgr.SetSelectMembers(HeroParameter.battleMembers);
        TrainingCampMgr.SetAssistMembers(PlayerAssistMgr.assistMembers);
        HeroParameter.EmptyDungeon66Param();
    end
    local memberList = TrainingCampMgr.GetSelectMembers();
    local len = #memberList;
    if (len > 0) then
        local listData;
        this.characterDatas = {};
        for i = 1, len do
            listData = UIListData.GetData(this.characterItem, "Dungeon66PrepareCharacterItem", {id=memberList[i], isShow=false});
            table.insert(this.characterDatas, listData);
        end
        this.characterList:SetData(this.characterDatas);
        this.characterIndex = 1;
        LuaMgr.AddTimer(TimerConst.Dungeon66PrepareCharacterDelay, this.OnCharacterDelay, 0.09, -1, true);
    end
end


this.OnCharacterDelay = function()
    this.characterDatas[this.characterIndex].data.isShow = true;
    this.characterList:Refresh();
    this.characterIndex = this.characterIndex + 1;
    if (this.characterIndex > #this.characterDatas) then
        LuaMgr.RemoveTimer(TimerConst.Dungeon66PrepareCharacterDelay);
        this.characterDatas = nil;
    end
end


this.SetAssist = function()
    if (PlayerAssistMgr.IsOpen() and this.dungeonConfig.isSupport > 0) then
        local count = TrainingCampMgr.GetAssistMemberCount();
        this.assistText.text = count .. "/" .. this.dungeonConfig.supportNum;
        SetActive(this.assistGO, true);
        local remainAssistCount = PlayerAssistMgr.RemainAssistCount();
        local totalBorrowLimit = ConfigMgr.Config.FriendConstants.TotalBorrowLimit;
        this.assistCountText.text = string.format("<color=#eccc38>%d</color>/%d", remainAssistCount, totalBorrowLimit);
        SetActive(this.assistCountGO, true);
    else
        SetActive(this.assistGO, false);
        SetActive(this.assistCountGO, false);
    end
end


this.SetChallenges = function()
    this.challengesList:Clear();
    local challenges = ConfigMgr.Config.levelChallenges[this.dungeonConfig.id];
    if (challenges == nil) then return end
    
    local listData;
    local listDatas = {};
    local challengesMap = ConfigMgr.Config.challengesMap;
    for _, v in pairs(challenges) do
        local challenge = challengesMap[v];
        if (challenge ~= nil) then
            if (not challenge.hideDes) then
                local content = LuaMgr.GetLangText(challenge.desLan);
                if (content:find("{", 1, true) ~= nil) then
                    content = LuaMgr.FindAndReplace(content, "{", "");
                end
                if (content:find("}", 1, true) ~= nil) then
                    content = LuaMgr.FindAndReplace(content, "}", "");
                end
                local isComplete = DataMgr.Player.completedTags[v] ~= nil;
                listData = UIListData.GetData(this.challengeItem, "Dungeon66PrepareChallengeItem", {content=content, isComplete=isComplete});
                table.insert(listDatas, listData);
            end
        end
    end
    this.challengesList:SetData(listDatas);
end


this.SetEmemys = function()
    this.enemysList:Clear();
    this.SetMonsterIdList();
    local listData;
    local listDatas = {};
    local monsterMap = ConfigMgr.Config.monsterMap;
    for _, v in ipairs(this.monsterList) do
        local monster = monsterMap[v];
        if (monster ~= nil and not monster.hideShowinfo) then
            listData = UIListData.GetData(this.enemyItem, "Dungeon66PrepareEnemyItem", monster);
            table.insert(listDatas, listData);
            if (#listDatas >= 3) then
                break;
            end
        end
    end
    this.enemysList:SetData(listDatas);
end


this.SetBuff = function()
    local buff = this.levelData.config["BuffShow" .. this.index .. "Lan"];
    if (IsNullOrEmpty(buff)) then return end
    
    this.buffText.text = LuaMgr.GetLangText(buff);
end


this.SetMonsterIdList = function()
    if (this.monsterList == nil) then
        local str = LuaMgr.UpdateMonsterIdList(this.dungeonConfig.flowScript);
        this.monsterList = json.decode(str);
    end
end


this.SetConditions = function(status)
    this.conditionWinList:Clear();
    this.conditionLoseList:Clear();
    if (status) then
        local victoryStr = LuaMgr.GetLangText(this.dungeonConfig.victoryTitleLan);
        local battleTurnEnds = NumTool.split(this.dungeonConfig.battleTurnEnd, ';');
        if (battleTurnEnds ~= nil and #battleTurnEnds == 2) then
            battleTurnEnd = tonumber(battleTurnEnds[2]);
        end
        if (battleTurnEnd > 0) then
            victoryStr = victoryStr .. "1_" .. string.format(LuaMgr.GetLangText('LangGlobalLan_LangGlobal_name_5068'), battleTurnEnd);
        end
        local winListDatas = {};
        local loseListDatas = {};
        local list = NumTool.split(victoryStr, ';');
        for _, v in ipairs(list) do
            if (IsNullOrEmpty(v)) then break end
            
            local temps = NumTool.split(v, '_');
            listData = UIListData.GetData(this.conditionItem, "Dungeon66PrepareConditionItem", {type=temps[1], content=temps[2]});
            if (temps[1] == "0") then
                table.insert(winListDatas, listData);
            else
                table.insert(loseListDatas, listData);
            end
        end
        this.conditionWinList:SetData(winListDatas);
        this.conditionLoseList:SetData(loseListDatas);
        local winHeight = 40 + #winListDatas * 46 - 6;
        local loseHeight = 40 + #loseListDatas * 46 - 6;
        this.conditionWinTF.sizeDelta = Vector2(400, winHeight);
        this.conditionLoseTF.sizeDelta = Vector2(400, loseHeight);
        this.conditionTF.sizeDelta = Vector2(446, 55 + winHeight + loseHeight);
    end
    SetActive(this.conditionGO, status);
end


this.ClickCharacter = function(index)
    HeroParameter.EmptyDungeon66Param();
    PlayerAssistMgr.CheckDungeonIsSupportShare66(this.levelData.config);
    PlayerAssistMgr.CheckDungeonIsSupportAssist(this.dungeonConfig, this.index);
    local assistMembers = TrainingCampMgr.GetAssistMembers();
    PlayerAssistMgr.SetAssistMembers(assistMembers);
    local selectMembers = TrainingCampMgr.GetSelectMembers();
    local dungeonIndex = this.index == 1 and 2 or 1;
    local dungeonId = this.levelData.config.DungeonId[dungeonIndex];
    local filterMembers = TrainingCampMgr.GetLockMembers(this.levelData.config.SeriesId, dungeonId,nil);
    local heroId = nil;
    if (index > 0) then
        heroId = selectMembers[index];
    elseif (#selectMembers > 0) then
        heroId = selectMembers[1];
    end
    HeroParameter.SaveDungeon66Param(selectMembers, filterMembers, index == 0, 6, this.heroTips, heroId);
    FeatureManager.GotoPanel("1004");
end


this.OnClickCharacter1 = function()
    this.ClickCharacter(1);
end


this.OnClickCharacter2 = function()
    this.ClickCharacter(2);
end


this.OnClickCharacter3 = function()
    this.ClickCharacter(3);
end


this.OnClickCharacter4 = function()
    this.ClickCharacter(4);
end


this.OnClickCharacter5 = function()
    this.ClickCharacter(5);
end


this.OnClickCharacter6 = function()
    this.ClickCharacter(6);
end


this.OnClickClear = function()
    TrainingCampMgr.SetSelectMembers(nil);
    TrainingCampMgr.SetAssistMembers(nil);
    PlayerAssistMgr.ClearAssistMembers();
    this.SetCharacters();
end


this.OnClickQuick = function()
    this.ClickCharacter(0);
end


this.OnClickUnLock=function()
    local curSeriesId=TrainingCampMgr.GetCurWheelSeriesID();
    if curSeriesId==nil then
        print("lose config for curSeries")
        return
    end;
    local campSeries = TrainingCampMgr.GetCampSeries(curSeriesId);
    local memberList = TrainingCampMgr.GetSelectMembers();
    local maxStar=TrainingCampMgr.GetTotalStar(campSeries.ID);
    if  #memberList==0 or maxStar==0 then
       LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("23762"));
        return;
    end
    LuaMgr.ShowLuaPanel(UIName.ConfirmTipViewModel,LuaMgr.GetLangText("Dungeon66PrepareViewModel_5"),ConfigMgr.LangGlobal("23751"),function()
        TrainingCampMgr.UnlockMembers(this.dungeonConfig.id,this.levelData.config.ID,function()
            this.OnClickClear();
            this.SetChallenges();
        end)
    end,nil)
end


this.OnClickTech = function()
    LuaMgr.ShowLuaPanel(UIName.Dungeon66TechViewModel)
end


this.OnClickNoBuffTipsToggle = function()
    SetActive(this.noBuffTipsOn, not this.noBuffTipsOn.activeSelf)
    SetActive(this.noBuffTipsOff, not this.noBuffTipsOff.activeSelf)
end


this.OnClickNoBuffTipsConfirm = function()
    this.SetTechUnlockTips(false)
    this.StartFunc()
end


this.OnClickNoBuffTipsCancel = function()
    this.SetTechUnlockTips(false)
    LuaMgr.ShowLuaPanel(UIName.Dungeon66TechViewModel)
end


this.OnClickHelp = function()
    this.SetConditions(true);
end


this.OnClickEnemys = function()
    LuaMgr.ShowLuaPanel(UIName.BattlePrepareEnemyViewModel, this.dungeonConfig, this.monsterList);
end

this.StartFunc = function()
    local selectMembers = TrainingCampMgr.GetSelectMembers();
    this.EnterDungeon(this.dungeonConfig.id, selectMembers);
end


this.OnClickStart = function()
    if this.CheckShowTips() then
        this.SetTechUnlockTips(true)
    else
        this.StartFunc()
    end
end

this.CheckShowTips = function()
    if TrainingCampMgr.CheckIsCanUnlockTech() then
        local curDataStr = os.date("%Y-%m-%d", LuaMgr.Timestamp())
        local savedDataStr = PlayerPrefs.GetString(DataMgr.Player.uid .. "_Dungeon66DailyUnlockTips", "")
        return savedDataStr ~= curDataStr
    end
    return false
end

this.SetTechUnlockTips = function(isOn)
    if isOn then
        SetActive(this.noBuffTipsOn, false)
        SetActive(this.noBuffTipsOff, true)
    else
        if this.noBuffTipsOn.activeSelf then
            local curDataStr = os.date("%Y-%m-%d", LuaMgr.Timestamp())
            PlayerPrefs.SetString(DataMgr.Player.uid .. "_Dungeon66DailyUnlockTips", curDataStr);
            PlayerPrefs.Save();
        end
    end
    SetActive(this.noBuffTips, isOn)
end


this.OnClickConditionMask = function()
    this.SetConditions(false);
end



this.EnterDungeon = function(dungeonId, members)
    local len = #members;
    if (len <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("Dungeon66PrepareViewModel_4"));
        return;
    end
    local memberDic = {};
    local helpDic = {};
    for i = 1, len do
        local id = members[i];
        local index = tostring(i - 1);
        memberDic[index] = id;
        if (PlayerAssistMgr.IsAssistMember(id)) then
            helpDic[index] = PlayerAssistMgr.GetAssistMemberUid(id);
        else
            helpDic[index] = "";
        end
    end
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
    enterDungeonParams.eventId = dungeonId;
    enterDungeonParams.dungeonId = dungeonId;
    enterDungeonParams.members = memberDic;
    enterDungeonParams.helps = helpDic;
    enterDungeonParams.extraParams = {"trainingcamp", this.levelData.config.ID};
    local buffList = TrainingCampMgr.GetInEffectTechBuffList()
    for i, v in ipairs(buffList) do
        table.insert(enterDungeonParams.extraParams, v)
    end
    BattlePrepareMgr._enterDungeonParams = enterDungeonParams;
    LuaMgr.SceneSwitchMark({UIName.Dungeon66PrepareViewModel});
    PlayerAreaMgr.SetAreaDungeonId("-1");
    ApiMgr.Request("enter_dungeon", enterDungeonParams, true, function(result)
        local re = json.decode(result);
        local data = json.encode(re.result);
        LuaMgr.EnterBattle(data, -1);
    end, function(code) end, true);
end




local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.clearBtn, this.OnClickClear);
        LuaMgr.AddClick(this.quickBtn, this.OnClickQuick);
        LuaMgr.AddClick(this.helpBtn, this.OnClickHelp);
        LuaMgr.AddClick(this.enemysBtn, this.OnClickEnemys);
        LuaMgr.AddClick(this.startBtn, this.OnClickStart);
        LuaMgr.AddClick(this.conditionMaskBtn, this.OnClickConditionMask);
        LuaMgr.AddClick(this.charactersBg1, this.OnClickCharacter1);
        LuaMgr.AddClick(this.charactersBg2, this.OnClickCharacter2);
        LuaMgr.AddClick(this.charactersBg3, this.OnClickCharacter3);
        LuaMgr.AddClick(this.charactersBg4, this.OnClickCharacter4);
        LuaMgr.AddClick(this.charactersBg5, this.OnClickCharacter5);
        LuaMgr.AddClick(this.charactersBg6, this.OnClickCharacter6);
        LuaMgr.AddClick(this.unLockBtn,this.OnClickUnLock);
        LuaMgr.AddClick(this.talentTreeBtn,this.OnClickTech);
        LuaMgr.AddClick(this.noBuffTipsToggleBtn,this.OnClickNoBuffTipsToggle);
        LuaMgr.AddClick(this.noBuffTipsConfirmBtn,this.OnClickNoBuffTipsConfirm);
        LuaMgr.AddClick(this.noBuffTipsCancelBtn,this.OnClickNoBuffTipsCancel);
        this.challengesList = UIListView.New(this.challengesListTF);
        this.enemysList = UIListView.New(this.enemysListTF);
        this.conditionWinList = UIListView.New(this.conditionWinListTF);
        this.conditionLoseList = UIListView.New(this.conditionLoseListTF);
        this.characterList = UIListView.New(this.charactersListTF);
        RedMgr.Singleton:RegisterViewModel(UIName.Dungeon66PrepareViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.levelData = vm.behaviour.Params[0];
        this.index = vm.behaviour.Params[1];
        local dungeonId = this.levelData.config.DungeonId[this.index];
        this.dungeonConfig = ConfigMgr.Config.dungeonMap[dungeonId];
        this.SetData();
        HeroRedDataHelper.SetDungeon66Red();
        RedMgr.Singleton:Refresh();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.Dungeon66PrepareCharacterDelay);
        this.levelData = nil;
        this.dungeonConfig = nil;
        this.monsterList = nil;
        this.challengesList:Clear();
        this.enemysList:Clear();
        this.conditionWinList:Clear();
        this.conditionLoseList:Clear();
        this.characterList:Clear();
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.clearBtn, this.OnClickClear);
        LuaMgr.RemoveClick(this.quickBtn, this.OnClickQuick);
        LuaMgr.RemoveClick(this.helpBtn, this.OnClickHelp);
        LuaMgr.RemoveClick(this.enemysBtn, this.OnClickEnemys);
        LuaMgr.RemoveClick(this.startBtn, this.OnClickStart);
        LuaMgr.RemoveClick(this.conditionMaskBtn, this.OnClickConditionMask);
        LuaMgr.RemoveClick(this.charactersBg1, this.OnClickCharacter1);
        LuaMgr.RemoveClick(this.charactersBg2, this.OnClickCharacter2);
        LuaMgr.RemoveClick(this.charactersBg3, this.OnClickCharacter3);
        LuaMgr.RemoveClick(this.charactersBg4, this.OnClickCharacter4);
        LuaMgr.RemoveClick(this.charactersBg5, this.OnClickCharacter5);
        LuaMgr.RemoveClick(this.charactersBg6, this.OnClickCharacter6);
        LuaMgr.RemoveClick(this.noBuffTipsToggleBtn,this.OnClickNoBuffTipsToggle);
        LuaMgr.RemoveClick(this.noBuffTipsConfirmBtn,this.OnClickNoBuffTipsConfirm);
        LuaMgr.RemoveClick(this.noBuffTipsCancelBtn,this.OnClickNoBuffTipsCancel);
        UIListView.ClearItem("Dungeon66PrepareChallengeItem");
        UIListView.ClearItem("Dungeon66PrepareEnemyItem");
        UIListView.ClearItem("Dungeon66PrepareConditionItem");
        UIListView.ClearItem("Dungeon66PrepareCharacterItem");
        RedMgr.Singleton:RemoveViewModel(UIName.Dungeon66PrepareViewModel);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})