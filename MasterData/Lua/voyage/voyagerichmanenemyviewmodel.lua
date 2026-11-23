require("Voyage/VoyageRichManEnemyItem")
require("Voyage/VoyageRichManEnemyTag")
require("Voyage/VoyageRichManEnemyAttribute")
require("Voyage/VoyageRichManEnemySkill")

local this = {
    vm = nil,
    portConfig = nil,
    enemysSV = nil,
    selectEnemy = nil,
    tagList = nil,
    attributeList = nil,
    skillsSV = nil,
    monsterIds = nil,
}

local objs = {
    backBtn = { path = "root/Left/Back", type = "Button" },
    group = { path = "root/Middle/Group", type = "RectTransform" },
    enemyIcon = { path = "root/Middle/Group/Info/Enemy/Icon", type = "RawImage" },
    enemyBorder = { path = "root/Middle/Group/Info/Enemy/Border", type = "Image" },
    enemyTypeGO = { path = "root/Middle/Group/Info/Enemy/Type", type = "GameObject" },
    enemyTypeImg = { path = "root/Middle/Group/Info/Enemy/Type", type = "Image" },
    enemyName = { path = "root/Middle/Group/Info/Enemy/Name", type = "Text" },
    tags = { path = "root/Middle/Group/Info/Tags", type = "Transform" },
    attributes = { path = "root/Middle/Group/Info/Attributes", type = "Transform" },
    detailsText = { path = "root/Middle/Group/Details/Text", type = "Text" },
    enemyItem = { path = "template/EnemyItem", type = "GameObject" },
    enemysScrollView = { path = "root/Middle/Enemys/ScrollView", type = "GameObject" },
    tagItem = { path = "template/TagItem", type = "GameObject" },
    tagsTF = { path = "root/Middle/Group/Info/Tags", type = "Transform" },
    attributeItem = { path = "template/AttributeItem", type = "GameObject" },
    attributesTF = { path = "root/Middle/Group/Info/Attributes", type = "Transform" },
    skillItem = { path = "template/SkillItem", type = "GameObject" },
    skillsScrollView = { path = "root/Middle/Group/Skills/ScrollView", type = "GameObject" },
}

local data = {
    skillDatas = {{skillData={id="", icon=DefaultTexture, iconColor=normalColor, level="", sname="", isLevel=false,
                             isLock=false, isName=false, scale=Vector3.one, typeSp=DefaultSprite, isType=false,
                             isEx=false, isShow=false, isClick=false}}}
}


this.SetData = function()


    this.SetEnemys();
    this.SetInfo();
    this.SetTags();

    this.SetSkills();
end


this.SetInfo = function()
    local monster = this.selectEnemy.data;
    this.enemyIcon.texture = GetCharacterTexture(monster.monsterModel, monster.monsterSkin);
    this.enemyBorder.sprite = LuaMgr.GetSprite("CommonRes", monster.type == 2 and "ui_ty_txk_guaiwu_hong" or "ui_ty_txk_guaiwu_bai");
    SetActive(this.enemyTypeGO, monster.type ~= 0);
    if (monster.type == 1) then
        this.enemyTypeImg.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_zj");
    elseif (monster.type == 2) then
        this.enemyTypeImg.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_boss");
    elseif (monster.type == 3) then
        this.enemyTypeImg.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_jy");
    end
    this.enemyName.text = LuaMgr.GetLangText(monster.NameLan);
    this.detailsText.text = LuaMgr.GetLangText(monster.monsterDesLan);
end


this.SetTags = function()
    this.tagList:Clear();
    local monster = this.selectEnemy.data;
    if (IsNullOrEmpty(monster.monsterTagLan)) then return end
    
    local listData;
    local listDatas = {};
    local tag = LuaMgr.GetLangText(monster.monsterTagLan);
    local tags = NumTool.split(tag, ';');
    local len = #tags;
    for i = 1, len do
        listData = UIListData.GetData(this.tagItem, "VoyageRichManEnemyTag", {id=tags[i], status=i==1});
        table.insert(listDatas, listData);
    end
    this.tagList:SetData(listDatas);
end


this.SetAttributes = function()
    this.attributeList:Clear();
    local listData;
    local listDatas = {};
    local monster = this.selectEnemy.data;
    local rankLen = #monster.attrRank;
    local mainAttr = HeroMgr.GetMainAttrList();
    local len = #mainAttr;
    for i = 1, len do
        local evaluate = rankLen >= i and monster.attrRank[i] or "";
        listData = UIListData.GetData(this.attributeItem, "VoyageRichManEnemyAttribute", {name=LuaMgr.GetLangText(attr.NameLan), evaluate=evaluate});
        table.insert(listDatas, listData);
    end
    this.attributeList:SetData(listDatas);
end


this.SetSkills = function()
    this.skillsSV:Clear(false);
    local skill;
    local scrollData;
    local scrollDatas = {};
    local monster = this.selectEnemy.data;
    local len = #monster.skills;
    for i = 1, len do
        skill = monster.skills[i];
        if (not ConfigSkillMgr.SkillShouldHide(skill[1] .. skill[2], 1)) then
            scrollData = UIScrollData.GetData(this.skillItem, "VoyageRichManEnemySkill", 116, 176, {monster=monster.id, type=1, skill=skill});
            table.insert(scrollDatas, scrollData);
        end
    end
    len = #monster.passiveskills;
    for i = 1, len do
        skill = monster.passiveskills[i];
        if (not ConfigSkillMgr.SkillShouldHide(skill[1] .. skill[2], 2)) then
            scrollData = UIScrollData.GetData(this.skillItem, "VoyageRichManEnemySkill", 116, 176, {monster=monster.id, type=2, skill=skill});
            table.insert(scrollDatas, scrollData);
        end
    end
    local addWidth = LuaMgr.GetScreenAddWidth();
    this.skillsSV:SetParams(770 + (addWidth > 200 and 200 or addWidth), 176);
    this.skillsSV:SetData(scrollDatas, true);
end


this.SetEnemys = function()
    this.enemysSV:Clear(false);
    local monster;
    local scrollData;
    local scrollDatas = {};
    local monsterMap = ConfigMgr.Config.monsterMap;
    local isSelect = true;
    local monsters;
    if (this.monsterIds ~= nil) then
        monsters = this.monsterIds;
    else
        monsters = this.portConfig.MonsterID;
    end
    local len = #monsters;
    for i = 1, len do
        monster = monsterMap[monsters[i]];
        if (monster ~= nil and not monster.hideShowinfo) then
            scrollData = UIScrollData.GetData(this.enemyItem, "VoyageRichManEnemyItem", 285, 103, {data=monster, select=isSelect});
            table.insert(scrollDatas, scrollData);
            isSelect = false;
        end
    end
    this.selectEnemy = scrollDatas[1].data;
    this.enemysSV:SetParams(285, 595);
    this.enemysSV:SetPadding(0, 0, 0, 0);
    this.enemysSV:SetData(scrollDatas, true);
end


this.OnEnemy = function(args)
    if (this.selectEnemy ~= nil) then
        this.selectEnemy.select = false;
        this.selectEnemy = nil;
    end
    this.selectEnemy = args[0];
    this.selectEnemy.select = true;
    this.SetInfo();
    this.SetTags();

    this.SetSkills();
    this.enemysSV:Refresh();
end


this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.VoyageRichManEnemyViewModel);
end

local command = {}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.enemysSV = UIScrollView.New(this.enemysScrollView);
        this.tagList = UIListView.New(this.tagsTF);
        this.attributeList = UIListView.New(this.attributesTF);
        this.skillsSV = UIScrollView.New(this.skillsScrollView);
        LuaMgr.AddClick(this.backBtn, this.OnClickBack);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.VoyageRichManEnemy, this.OnEnemy);
        this.portConfig = vm.behaviour.Params[0];
        if (vm.behaviour.Params.Length == 2) then
            this.monsterIds = vm.behaviour.Params[1];
        end
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageRichManEnemy, this.OnEnemy);
        this.portConfig = nil;
        this.enemyIcon.texture = nil;
        this.enemyBorder.sprite = nil;
        this.enemyTypeImg.sprite = nil;
        this.enemysSV:Clear(true);
        this.tagList:Clear();
        this.attributeList:Clear();
        this.skillsSV:Clear(true);
        this.monsterIds = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.backBtn, this.OnClickBack);
        UIScrollView.ClearItem("VoyageRichManEnemyItem");
        UIListView.ClearItem("VoyageRichManEnemyTag");
        UIListView.ClearItem("VoyageRichManEnemyAttribute");
        UIScrollView.ClearItem("VoyageRichManEnemySkill");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})