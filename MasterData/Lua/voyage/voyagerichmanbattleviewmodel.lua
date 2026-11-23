require("Voyage/VoyageRichManBattleCharacterItem")
require("Voyage/VoyageRichManBattleEnemyItem")
require("Voyage/VoyageRichManBattleJobItem")
require("Voyage/VoyageRichManBattleConditionItem")

local this = {
    characterList = nil,
    enemyDetailsList = nil,
    jobsList = nil,
    conditionList = nil,
    isWin = false,
    portConfig = nil,
    dungeonId = "",
    members = nil,
    enterDungeon = nil,
    monsterIds = nil,
    winCondition = nil,
    loseCondition = nil,
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    characterListTF = { path = "root/Middle/CharacterList", type = "Transform" },
    characterItem = { path = "template/CharacterItem", type = "GameObject" },
    enemyDetailsBtn = { path = "root/Right/Group/EnemyDetails", type = "Button" },
    enemyDetailsListTF = { path = "root/Right/Group/EnemyDetails/List", type = "Transform" },
    enemyItem = { path = "template/EnemyItem", type = "GameObject" },
    jobsListTF = { path = "root/Right/Group/Jobs/List", type = "Transform" },
    jobItem = { path = "template/JobItem", type = "GameObject" },
    conditionListTF = { path = "root/Right/Group/Condition/List", type = "Transform" },
    conditionItem = { path = "template/ConditionItem", type = "GameObject" },
    conditionWin = { path = "root/Right/Group/Condition/Win", type = "GameObject" },
    conditionWin2 = { path = "root/Right/Group/Condition/Win2", type = "GameObject" },
    conditionWin2Btn = { path = "root/Right/Group/Condition/Win2", type = "Button" },
    conditionLose = { path = "root/Right/Group/Condition/Lose", type = "GameObject" },
    conditionLose2 = { path = "root/Right/Group/Condition/Lose2", type = "GameObject" },
    conditionLose2Btn = { path = "root/Right/Group/Condition/Lose2", type = "Button" },
    battleTF = { path = "root/Right/Group/Battle", type = "Transform" },
    battleBtn = { path = "root/Right/Group/Battle", type = "Button" },
    mopUpGO = { path = "root/Right/Group/MopUp", type = "GameObject" },
    mopUpBtn = { path = "root/Right/Group/MopUp", type = "Button" },
};


this.SetData = function()
    this.InitCondition();
    this.SetCondition(true);
    this.SetEnemyDetails();
    this.SetJobs();
    this.SetCharacters();
    this.CheckMopUp();
end


this.InitCondition = function()
    this.winCondition = {};
    this.loseCondition = {};
    local dungeonConfig = ConfigMgr.Config.dungeonMap[this.dungeonId];
    if (dungeonConfig == nil) then return end
    
    local str = LuaMgr.GetLangText(dungeonConfig.victoryTitleLan);
    local strs = NumTool.split(str, ';');
    local len = #strs;
    for i = 1, len do
        local items = NumTool.split(strs[i], '_');
        if (items[1] == "0") then
            table.insert(this.winCondition, items[2]);
        else
            table.insert(this.loseCondition, items[2]);
        end
    end
end


this.SetCondition = function(isWin)
    this.isWin = isWin;
    local condition;
    if (isWin) then
        SetActive(this.conditionWin, true);
        SetActive(this.conditionWin2, false);
        SetActive(this.conditionLose, false);
        SetActive(this.conditionLose2, true);
        condition = this.winCondition;
    else
        SetActive(this.conditionWin, false);
        SetActive(this.conditionWin2, true);
        SetActive(this.conditionLose, true);
        SetActive(this.conditionLose2, false);
        condition = this.loseCondition;
    end
    this.conditionList:Clear();
    local listData;
    local listDatas = {};
    local len = #condition;
    for i = 1, len do
        listData = UIListData.GetData(this.conditionItem, "VoyageRichManBattleConditionItem", {text=condition[i], isWin=isWin});
        table.insert(listDatas, listData);
    end
    this.conditionList:SetData(listDatas);
end


this.SetEnemyDetails = function()
    this.enemyDetailsList:Clear();
    local monsterStr = LuaMgr.UpdateMonsterIdList(this.dungeonId);
    if (IsNullOrEmpty(monsterStr)) then return end

    this.monsterIds = json.decode(monsterStr);
    if (this.monsterIds == nil) then return end
    
    local len = #this.monsterIds;
    if (len <= 0) then return end

    local monster;
    local listData;
    local listDatas = {};
    local monsterMap = ConfigMgr.Config.monsterMap;
    len = len > 3 and 3 or len;
    for i = 1, len do
        monster = monsterMap[this.monsterIds[i]];
        if (monster ~= nil and not monster.hideShowinfo) then
            listData = UIListData.GetData(this.enemyItem, "VoyageRichManBattleEnemyItem", monster);
            table.insert(listDatas, listData);
        end
    end
    this.enemyDetailsList:SetData(listDatas);
end


this.SetJobs = function()
    this.jobsList:Clear();
    local len = #this.portConfig.JobPrefer;
    if (len <= 0) then return end
    
    local listData;
    local listDatas = {};
    for i = 1, len do
        listData = UIListData.GetData(this.jobItem, "VoyageRichManBattleJobItem", this.portConfig.JobPrefer[i]);
        table.insert(listDatas, listData);
    end
    this.jobsList:SetData(listDatas);
end


this.SetCharacters = function()
    this.characterList:Clear();
    local listData;
    local listDatas = {};
    for _, v in pairs(this.members) do
        if (v.HP > 0) then
            listData = UIListData.GetData(this.characterItem, "VoyageRichManBattleCharacterItem", v);
            table.insert(listDatas, listData);
        end
    end
    this.characterList:SetData(listDatas);
end


this.OnCharacter = function(args)
    local item = args[0];
    if (not VoyageRichManMgr.HasBattleMember(item.data.ID)) then
        local dungeonConfig = ConfigMgr.Config.dungeonMap[this.dungeonId];
        if (dungeonConfig == nil) then return end

        local battleMembers = VoyageRichManMgr.GetBattleMembers();
        if (battleMembers == nil) then return end

        local count = NumTool.GetLen(battleMembers);
        if (count >= dungeonConfig.outRoleNum) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("VoyageRichManBattleViewModel_2"));
            return;
        end
    end
    VoyageRichManMgr.BattleMember(item.data);
    item:SetSelectLight();
end


this.CheckMopUp = function()
    local hasRecord = VoyageRichManMgr.HasRecord(this.dungeonId);
    if (hasRecord) then
        this.battleTF.localPosition = Vector3(64, -282, 0);
        SetActive(this.mopUpGO, true);
    else
        this.battleTF.localPosition = Vector3(0, -282, 0);
        SetActive(this.mopUpGO, false);
    end
end


this.OnClickEnemyDetails = function()
    LuaMgr.ShowLuaPanel(UIName.VoyageRichManEnemyViewModel, this.portConfig, this.monsterIds);
end


this.CheckBattle = function()
    local battleMembers = VoyageRichManMgr.GetBattleMembers();
    if (battleMembers == nil) then return end

    local count = NumTool.GetLen(battleMembers);
    if (count <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("VoyageRichManBattleViewModel_0"));
        return;
    end
    this.enterDungeon(this.dungeonId, battleMembers);
end


this.OnClickBattle = function()
    this.CheckBattle();
end


this.OnClickMopUp = function()
    PlayerVoyageMgr.EnterLeaveDungeon(this.dungeonId, this.EnterLeaveDungeonResponse);
end


this.OnClickConditionWin = function()
    this.SetCondition(true);
end


this.OnClickConditionLose = function()
    this.SetCondition(false);
end


this.EnterLeaveDungeonResponse = function(result)
    LuaMgr.HidePanel(UIName.VoyageRichManBattleViewModel);
    PlayerVoyageMgr.SetRollDiceCount(true);
    LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManShowDice);
    VoyageRichManMgr.SetWait(false);
    VoyageRichManMgr.CheckCorsair();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.enemyDetailsBtn, this.OnClickEnemyDetails);
        LuaMgr.AddClick(this.battleBtn, this.OnClickBattle);
        LuaMgr.AddClick(this.conditionWin2Btn, this.OnClickConditionWin);
        LuaMgr.AddClick(this.conditionLose2Btn, this.OnClickConditionLose);
        LuaMgr.AddClick(this.mopUpBtn, this.OnClickMopUp);
        this.characterList = UIListView.New(this.characterListTF);
        this.enemyDetailsList = UIListView.New(this.enemyDetailsListTF);
        this.jobsList = UIListView.New(this.jobsListTF);
        this.conditionList = UIListView.New(this.conditionListTF);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.VoyageRichManBattleCharacter, this.OnCharacter);
        VoyageRichManSceneMgr.SetDrag(false);
        this.portConfig = vm.behaviour.Params[0];
        this.dungeonId = vm.behaviour.Params[1];
        this.members = vm.behaviour.Params[2];
        this.enterDungeon = vm.behaviour.Params[3];
        this.SetData();
        this.animator.AnimationName = "ani_VoyageRichManBattlePanel_root";
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageRichManBattleCharacter, this.OnCharacter);
        this.characterList:Clear();
        this.enemyDetailsList:Clear();
        this.jobsList:Clear();
        this.conditionList:Clear();
        this.portConfig = nil;
        this.members = nil;
        this.enterDungeon = nil;
        this.monsterIds = nil;
        VoyageRichManSceneMgr.SetDrag(true);
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.enemyDetailsBtn, this.OnClickEnemyDetails);
        LuaMgr.RemoveClick(this.battleBtn, this.OnClickBattle);
        LuaMgr.RemoveClick(this.mopUpBtn, this.OnClickMopUp);
        UIListView.ClearItem("VoyageRichManBattleCharacterItem");
        UIListView.ClearItem("VoyageRichManBattleEnemyItem");
        UIListView.ClearItem("VoyageRichManBattleJobItem");
        UIListView.ClearItem("VoyageRichManBattleConditionItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})