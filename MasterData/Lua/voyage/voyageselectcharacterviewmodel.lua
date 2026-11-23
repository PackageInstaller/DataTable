require("Voyage/VoyageSelectCharacterItem")
require("Voyage/VoyageSelectCharacterEnemyItem")
require("Voyage/VoyageSelectCharacterJobItem")
require("Voyage/VoyageSelectCharacterDiceItem")

local this = {
    characterList = nil,
    enemyDetailsList = nil,
    jobsList = nil,
    dicesList = nil,
    portConfig = nil,
    showDices = false,
};

local objs = {
    bgBtn = { path = "root/Bg", type = "Button" },
    leftBg = { path = "root/LeftBg", type = "RectTransform" },
    rightBg = { path = "root/RightBg", type = "RectTransform" },
    infoGO = { path = "root/RightInfo/Info", type = "GameObject" },
    mapImg = { path = "root/RightInfo/Info/Map", type = "RawImage" },
    portName = { path = "root/RightInfo/Info/PortName", type = "Image" },
    enemyDetailsBtn = { path = "root/RightInfo/Info/EnemyDetails", type = "Button" },
    enemyDetailsListTF = { path = "root/RightInfo/Info/EnemyDetails/List", type = "Transform" },
    enemyItem = { path = "template/EnemyItem", type = "GameObject" },
    jobsListTF = { path = "root/RightInfo/Info/Jobs/List", type = "Transform" },
    jobItem = { path = "template/JobItem", type = "GameObject" },
    dice = { path = "root/RightInfo/Info/Dice", type = "GameObject" },
    diceType = { path = "root/RightInfo/Info/Dice/Type", type = "Image" },
    diceName = { path = "root/RightInfo/Info/Dice/Name", type = "Text" },
    diceDesc = { path = "root/RightInfo/Info/Dice/Desc", type = "Text" },
    diceLock = { path = "root/RightInfo/Info/Dice/Lock", type = "GameObject" },
    diceLockMsg = { path = "root/RightInfo/Info/Dice/Lock/Msg", type = "Text" },
    diceSelectBtn = { path = "root/RightInfo/Info/Dice/Select", type = "Button" },
    dices = { path = "root/RightInfo/Info/Dices", type = "GameObject" },
    dicesListTF = { path = "root/RightInfo/Info/Dices/List", type = "Transform" },
    diceItem = { path = "template/DiceItem", type = "GameObject" },
    sailOnBtn = { path = "root/RightInfo/Info/SailOn", type = "Button" },
    characterListGO = { path = "root/Middle/CharacterList", type = "GameObject" },
    characterListTF = { path = "root/Middle/CharacterList", type = "Transform" },
    characterItem = { path = "template/CharacterItem", type = "GameObject" },
    fastFormationGO = { path = "root/Middle/FastFormation", type = "GameObject" },
    fastFormationBtn = { path = "root/Middle/FastFormation", type = "Button" },
};


this.OnBack = function()
    LuaMgr.ShowLuaPanel(UIName.VoyageViewModel, false);
end


this.SetData = function()
    this.SetScreen();
    this.SetInfo();
    this.SetEnemyDetails();
    this.SetJobs();
    this.SetCaptain();
end


this.SetScreen = function()
    local width = LuaMgr.GetScreenAddWidth();
    if (width > 0) then
        local halfWidth = width / 2;
        if (halfWidth > 74) then
            halfWidth = 74;
        end
        local leftBgPos = this.leftBg.anchoredPosition;
        leftBgPos.x = -74 + halfWidth;
        this.leftBg.anchoredPosition = leftBgPos;
        local rightBgPos = this.rightBg.anchoredPosition;
        rightBgPos.x = -316 - halfWidth;
        this.rightBg.anchoredPosition = rightBgPos;
    end
end


this.SetInfo = function()
    this.mapImg.texture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/Voyage/%s.png", this.portConfig.HarborBoard));
    this.portName.sprite = LuaMgr.GetSprite(this.portConfig.ResID, this.portConfig.HarborIcon);
end


this.SetEnemyDetails = function()
    this.enemyDetailsList:Clear();
    local len = #this.portConfig.MonsterID;
    if (len <= 0) then return end
    
    local monster;
    local listData;
    local listDatas = {};
    local monsterMap = ConfigMgr.Config.monsterMap;
    len = len > 3 and 3 or len;
    for i = 1, len do
        monster = monsterMap[this.portConfig.MonsterID[i]];
        if (monster ~= nil and not monster.hideShowinfo) then
            listData = UIListData.GetData(this.enemyItem, "VoyageSelectCharacterEnemyItem", monster);
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
        listData = UIListData.GetData(this.jobItem, "VoyageSelectCharacterJobItem", this.portConfig.JobPrefer[i]);
        table.insert(listDatas, listData);
    end
    this.jobsList:SetData(listDatas);
end


this.SetDices = function()
    this.dicesList:Clear();
    local captains = ConfigVoyageMgr.GetCaptains();
    local len = #captains;
    if (len > 0) then
        this.showDices = true;
        local skill;
        local listData;
        local listDatas = {};
        local captain = PlayerVoyageMgr.GetCaptain();
        for i = 1, len do
            skill = captains[i];
            listData = UIListData.GetData(this.diceItem, "VoyageSelectCharacterDiceItem", skill);
            if (skill.CaptainID == captain) then
                table.insert(listDatas, 1, listData);
            else
                table.insert(listDatas, listData);
            end
        end
        this.dicesList:SetData(listDatas);
        SetActive(this.dice, false);
        SetActive(this.dices, true);
    end
end


this.SetCharacters = function(count)
    this.characterList:Clear();
    if (HeroParameter.battleMembers ~= nil) then
        PlayerVoyageMgr.SetSelectMembers(HeroParameter.battleMembers);
        HeroParameter.EmptyDungeon66Param();
    end
    local listData;
    local listDatas = {};
    local memberList = PlayerVoyageMgr.GetSelectMembers();
    for i = 1, count do
        listData = UIListData.GetData(this.characterItem, "VoyageSelectCharacterItem", memberList[i]);
        table.insert(listDatas, listData);
    end
    this.characterList:SetData(listDatas);
end





this.SetCaptain = function()
    local captain = PlayerVoyageMgr.GetCaptain();
    local captainConfig = ConfigVoyageMgr.GetCaptainConfig(captain);
    if (captainConfig ~= nil) then
        this.diceType.sprite = LuaMgr.GetSprite("VoyageRichMan", captainConfig.SkillPic);
        this.diceName.text = LuaMgr.GetLangText(captainConfig.SkillNameLan);
        this.diceDesc.text = LuaMgr.GetLangText(captainConfig.CaptainDesLan);
        if (PlayerVoyageMgr.IsLockCaptain(captainConfig)) then
            local portConfig = ConfigVoyageMgr.GetPortConfig(captainConfig.UnlockHarbor);
            if (portConfig ~= nil) then
                this.diceLockMsg.text = string.format(ConfigMgr.LangGlobal("10455"), LuaMgr.GetLangText(portConfig.HarborNameLan));
            end
            SetActive(this.diceLock, true);
        else
            SetActive(this.diceLock, false);
        end
    end
    this.showDices = false;
    this.dicesList:Clear();
    SetActive(this.dice, true);
    SetActive(this.dices, false);
    local characterCount = ConfigVoyageMgr.GetCaptainCharacterCount(captain);
    local memberList = PlayerVoyageMgr.GetSelectMembers();
    local count = #memberList;
    if (count > characterCount) then
        characterCount = characterCount + 1;
        for i = count, characterCount, -1 do
            table.remove(memberList, i);
        end
    end
    this.SetCharacters(characterCount);
end


this.OnClickBg = function()
    if (this.showDices) then
        this.SetCaptain();
    end
end


this.OnClickSailOn = function()
    local memberList = PlayerVoyageMgr.GetSelectMembers();
    if (#memberList <= 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10459"));
        return;
    end
    local member;
    local isActor;
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
        isActor = ConfigMgr.Config.actor[member] ~= nil;
        if (isActor) then
            attrStr = LuaMgr.GetActorPropertyCopy(member, attrKeys);
            attrMap = json.decode(attrStr);
            hp = tonumber(attrMap["Hp"]);
        else
            character = DataMgr.Player.characters[member];
            if (character.wear ~= "") then
                equipStr = json.encode(DataMgr.Player.equipments[character.wear]);
                attrStr = LuaMgr.GetCharacterPropertyCopy(member, equipStr, attrKeys);
            else
                attrStr = LuaMgr.GetCharacterPropertyCopy(member, "", attrKeys);
            end
            attrMap = json.decode(attrStr);
            hp = tonumber(attrMap["Hp"]);
        end
        members[member] = {IsActor=isActor, ID=member, HP=hp, MaxHP=hp};
    end
    local captain = PlayerVoyageMgr.GetCaptain();
    local captainConfig = ConfigVoyageMgr.GetCaptainConfig(captain);
    if (captainConfig ~= nil and PlayerVoyageMgr.IsLockCaptain(captainConfig)) then
        captain = "";
    end
    PlayerVoyageMgr.OpenHarbor(this.portConfig.HarborID, captain, members);
end


this.GetAttrKeys = function(attrs)
    local attrKeys = {};
    local len = #attrs;
    for i = 1, len do
        attrKeys[i] = attrs[i].id;
    end
    return attrKeys;
end


this.OnClickFastFormation = function()
    HeroParameter.EmptyVoyageParam();
    local captain = PlayerVoyageMgr.GetCaptain();
    local characterCount = ConfigVoyageMgr.GetCaptainCharacterCount(captain);
    local memberList = PlayerVoyageMgr.GetSelectMembers();
    HeroParameter.SaveVoyageParam(memberList, this.portConfig.TryActor, true, characterCount);
    FeatureManager.GotoPanel("1004");
end


this.OnSelectCharacterClick = function(args)
    local heroId = args[0];
    HeroParameter.EmptyVoyageParam();
    local captain = PlayerVoyageMgr.GetCaptain();
    local characterCount = ConfigVoyageMgr.GetCaptainCharacterCount(captain);
    local memberList = PlayerVoyageMgr.GetSelectMembers();
    HeroParameter.SaveVoyageParam(memberList, this.portConfig.TryActor, false, characterCount, heroId);
    FeatureManager.GotoPanel("1004");
end


this.OnClickSelectSkill = function()
    this.SetDices();
end


this.OnSelectCharacterSkill = function()
    this.SetCaptain();
end


this.OnClickEnemyDetails = function()
    LuaMgr.ShowLuaPanel(UIName.VoyageRichManEnemyViewModel, this.portConfig);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.bgBtn, this.OnClickBg);
        LuaMgr.AddClick(this.sailOnBtn, this.OnClickSailOn);
        LuaMgr.AddClick(this.fastFormationBtn, this.OnClickFastFormation);
        LuaMgr.AddClick(this.diceSelectBtn, this.OnClickSelectSkill);
        LuaMgr.AddClick(this.enemyDetailsBtn, this.OnClickEnemyDetails);
        this.characterList = UIListView.New(this.characterListTF);
        this.enemyDetailsList = UIListView.New(this.enemyDetailsListTF);
        this.jobsList = UIListView.New(this.jobsListTF);
        this.dicesList = UIListView.New(this.dicesListTF);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        vm.behaviour:UpdateTopBar("", this.OnBack);
        LuaMgr.AddUIEventListener(UIEventConst.VoyageSelectCharacterSkill, this.OnSelectCharacterSkill);
        LuaMgr.AddUIEventListener(UIEventConst.VoyageSelectCharacterClick, this.OnSelectCharacterClick);
        this.portConfig = vm.behaviour.Params[0];
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageSelectCharacterSkill, this.OnSelectCharacterSkill);
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageSelectCharacterClick, this.OnSelectCharacterClick);
        this.characterList:Clear();
        this.enemyDetailsList:Clear();
        this.jobsList:Clear();
        this.dicesList:Clear();
        this.showDices = false;
        this.portConfig = nil;
        this.mapImg.texture = nil;
        this.portName.sprite = nil;
        this.diceType.sprite = nil;
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.bgBtn, this.OnClickBg);
        LuaMgr.RemoveClick(this.sailOnBtn, this.OnClickSailOn);
        LuaMgr.RemoveClick(this.fastFormationBtn, this.OnClickFastFormation);
        LuaMgr.RemoveClick(this.diceSelectBtn, this.OnClickSelectSkill);
        LuaMgr.RemoveClick(this.enemyDetailsBtn, this.OnClickEnemyDetails);
        UIListView.ClearItem("VoyageSelectCharacterItem");
        UIListView.ClearItem("VoyageSelectCharacterEnemyItem");
        UIListView.ClearItem("VoyageSelectCharacterJobItem");
        UIListView.ClearItem("VoyageSelectCharacterDiceItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})