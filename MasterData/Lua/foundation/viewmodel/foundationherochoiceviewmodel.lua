require("Foundation/ViewModel/FoundationHeroChoiceItem")
require("Foundation/ViewModel/FoundationHeroChoiceItemGroup")

local this = {
    vm = nil,
    heroItem = nil,
    heroItemGroup = nil,
    interactionId = "",
    maxHero = 0,
    scrollWidth = 0,
    spineCharacter = nil,
    idleText = LuaMgr.GetLangText("FoundationHeroChoiceViewModel_3"),
    heroDatas = {},
    workingStatus = 0,
    rareStatus = 0,
    hgStatus = 0,
}

local data = {
    viewWidth = Vector2.zero,
    numPosition = Vector2.zero,
    moreCount = "",
    contentPos = Vector2.zero,
    heroName = "",
    heroJob = DefaultSprite,
    heroStatus = "",
    heroHg = "",
    isInfo = false,
    isWorkingArrow = false,
    workingScale = Vector3.one,
    selectWorking = DefaultSprite,
    isRareArrow = false,
    rareScale = Vector3.one,
    selectRare = DefaultSprite,
    isHGArrow = false,
    hgScale = Vector3.one,
    selectHG = DefaultSprite,
}


this.SetHeroInfo = function(heroId)
    local characterConfig = ConfigMgr.Config.characterTable[heroId];
    if (characterConfig ~= nil) then
        this.vm.data.heroName = LuaMgr.GetLangText(characterConfig.namelan);
        this.vm.data.heroJob = LuaMgr.GetSprite("JobIcon", "job_" .. characterConfig.job);
        local buildingId = PlayerFoundationMgr.GetCharacterBuilding(heroId);
        if (buildingId ~= nil) then
            local buildingConfig = ConfigFoundationMgr.GetInteractionById(buildingId);
            if (buildingConfig ~= nil) then
                this.vm.data.heroStatus = LuaMgr.GetLangText(buildingConfig.NameLan);
            else
                this.vm.data.heroStatus = this.idleText;
            end
        else
            this.vm.data.heroStatus = this.idleText;
        end
        local hg = DataMgr.Player.weeklyCount["prest_" .. heroId] or 0;
        local maxHG = ConfigMgr.Config.constants.MaxPrestigeByWorkPerWeek;
        this.vm.data.heroHg = string.format(LuaMgr.GetLangText("FoundationHeroChoiceViewModel_4"), hg, maxHG);
        local characterData = DataMgr.Player.characters[heroId];
        if (characterData ~= nil) then
            local wearId = "";
            if (characterData.wear ~= "") then
                local equipData = DataMgr.Player.equipments[characterData.wear];
                if (equipData ~= nil) then
                    local equipConfig = ConfigMgr.Config.equipments[equipData.equipmentId];
                    if (equipConfig ~= nil) then
                        wearId = equipConfig.Mid;
                    end
                end
            end
            this.spineCharacter:SetBattle(heroId, characterData.curSkin, wearId, characterConfig.job);
            this.vm.data.isInfo = true;
            LuaMgr.CheckRefCount();
        end
    end
end


this.InitHeros = function()
    this.interactionId = this.vm.behaviour.Params[0];
    local selectCharacters = this.vm.behaviour.Params[1];
    PlayerFoundationMgr.InitSelectCharacters(selectCharacters);
    this.maxHero = this.vm.behaviour.Params[2];
    this.SetHeroCount();
    this.heroDatas = {};
    local characterConfig;
    local heroData;
    local weeklyCount = DataMgr.Player.weeklyCount;
    local characterTable = ConfigMgr.Config.characterTable;
    local characters = DataMgr.Player.characters;
    for k, _ in pairs(characters) do
        characterConfig = characterTable[k];
        if (characterConfig ~= nil) then
            heroData = {
                id=k,
                working=PlayerFoundationMgr.GetCharacterBuilding(k),
                rare=HeroMgr.GetHeroNowRare(k),
                hg=weeklyCount["prest_" .. k] or 0};
            table.insert(this.heroDatas, heroData);
        end
    end
end


this.SetHeroCount = function()
    local selectCharacters = PlayerFoundationMgr.GetSelectCharacters();
    this.vm.data.moreCount = string.format("%d/%d", #selectCharacters, this.maxHero);
end


this.ViewAdaptive = function()
    local addWidth = LuaMgr.GetScreenAddWidth();
    this.scrollWidth = 914 + addWidth;
    this.vm.data.viewWidth = Vector2(this.scrollWidth, 630);
    this.vm.data.numPosition = Vector2(-495 - addWidth, -333);
end


this.SetType = function(working, rare, hg)
    this.workingStatus = working;
    this.rareStatus = rare;
    this.hgStatus = hg;
    local dataList = {};
    local selectCharacterMap = {};
    local selectCharacters = PlayerFoundationMgr.GetSelectCharacters();
    local len = #selectCharacters;
    for i = 1, len do
        selectCharacterMap[selectCharacters[i]] = true;
        dataList[i] = selectCharacters[i];
    end
    local heroData;
    local characterData;
    local sortList = {};
    len = #this.heroDatas;
    for i = 1, len do
        heroData = this.heroDatas[i];
        if (not selectCharacterMap[heroData.id]) then
            table.insert(sortList, heroData);
        end
    end
    this.vm.data.selectWorking = LuaMgr.GetSprite("CommonRes", this.workingStatus ~= 0 and "ui_ty_btn_top_xz" or "ui_ty_btn_top");
    this.vm.data.selectRare = LuaMgr.GetSprite("CommonRes", this.rareStatus ~= 0 and "ui_ty_btn_top_xz" or "ui_ty_btn_top");
    this.vm.data.selectHG = LuaMgr.GetSprite("CommonRes", this.hgStatus ~= 0 and "ui_ty_btn_top_xz" or "ui_ty_btn_top");
    if (this.workingStatus ~= 0) then
        this.vm.data.workingScale = Vector3(1, this.workingStatus, 1);
        this.vm.data.isWorkingArrow = true;
        if (this.workingStatus == 1) then
            table.sort(sortList, this.CompareDescWorking);
        else
            table.sort(sortList, this.CompareAscWorking);
        end
    else
        this.vm.data.isWorkingArrow = false;
    end
    if (this.rareStatus ~= 0) then
        this.vm.data.rareScale = Vector3(1, this.rareStatus, 1);
        this.vm.data.isRareArrow = true;
        if (this.rareStatus == 1) then
            table.sort(sortList, this.CompareDescRare);
        else
            table.sort(sortList, this.CompareAscRare);
        end
    else
        this.vm.data.isRareArrow = false;
    end
    if (this.hgStatus ~= 0) then
        this.vm.data.hgScale = Vector3(1, this.hgStatus, 1);
        this.vm.data.isHGArrow = true;
        if (this.hgStatus == 1) then
            table.sort(sortList, this.CompareDescHG);
        else
            table.sort(sortList, this.CompareAscHG);
        end
    else
        this.vm.data.isHGArrow = false;
    end
    len = #sortList;
    local fullList = {};
    for i = 1, len do
        heroData = sortList[i];
        characterData = DataMgr.Player.characters[heroData.id];
        if (characterData ~= nil and characterData.prestigeLevel >= 10) then
            table.insert(fullList, heroData.id);
        else
            table.insert(dataList, heroData.id);
        end
    end
    len = #fullList;
    for i = 1, len do
        table.insert(dataList, fullList[i]);
    end
    this.SetHeroList(dataList);
end


this.CompareDescWorking = function(a, b)
    if (a.working ~= nil and b.working == nil) then
        return true;
    end
    if (a.working == b.working) then
        if (a.rare == b.rare) then
            if (a.hg == b.hg) then
                return a.id > b.id;
            end
            return a.hg > b.hg;
        end
        return a.rare > b.rare;
    end
    return false;
end


this.CompareAscWorking = function(a, b)
    if (a.working == nil and b.working ~= nil) then
        return true;
    end
    if (a.working == b.working) then
        if (a.rare == b.rare) then
            if (a.hg == b.hg) then
                return a.id < b.id;
            end
            return a.hg < b.hg;
        end
        return a.rare < b.rare;
    end
    return false;
end


this.CompareDescRare = function(a, b)
    if (a.rare == b.rare) then
        if (a.working == b.working) then
            if (a.hg == b.hg) then
                return a.id > b.id;
            end
            return a.hg > b.hg;
        end
        return a.working ~= nil and b.working == nil;
    end
    return a.rare > b.rare;
end


this.CompareAscRare = function(a, b)
    if (a.rare == b.rare) then
        if (a.working == b.working) then
            if (a.hg == b.hg) then
                return a.id < b.id;
            end
            return a.hg < b.hg;
        end
        return a.working == nil and b.working ~= nil;
    end
    return a.rare < b.rare;
end


this.CompareDescHG = function(a, b)
    if (a.hg == b.hg) then
        if (a.working == b.working) then
            if (a.rare == b.rare) then
                return a.id > b.id;
            end
            return a.rare > b.rare;
        end
        return a.working ~= nil and b.working == nil;
    end
    return a.hg > b.hg;
end


this.CompareAscHG = function(a, b)
    if (a.hg == b.hg) then
        if (a.working == b.working) then
            if (a.rare == b.rare) then
                return a.id < b.id;
            end
            return a.rare < b.rare;
        end
        return a.working == nil and b.working ~= nil;
    end
    return a.hg < b.hg;
end


this.SetHeroList = function(list)
    local character;
    local groupData;
    local scrollData;
    this.scrollView:Clear(false);
    local scrollDatas = {};
    local len = #list;
    local index = 1;
    while (index <= len) do
        groupData = {};
        groupData.item = this.heroItem;
        character = list[index];
        if (character ~= nil) then
            groupData.hero1 = character;
        end
        character = list[index + 1];
        if (character ~= nil) then
            groupData.hero2 = character;
        end
        scrollData = UIScrollData.GetData(this.heroItemGroup, "FoundationHeroChoiceItemGroup", 136, 630, groupData);
        table.insert(scrollDatas, scrollData);
        index = index + 2;
    end
    this.scrollView:SetParams(this.scrollWidth, 630);
    this.scrollView:SetData(scrollDatas, true);
end


this.OnClickHero = function(args)
    local characterId = args[0];
    PlayerFoundationMgr.SelectCharacter(characterId, this.maxHero);
    this.SetHeroInfo(characterId);
    this.SetHeroCount();
    this.scrollView:Refresh();
end

local command = {
    OnClickCancel = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.Back();
        end
    },
    OnClickConfirm = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            PlayerFoundationMgr.PutCharacters(this.interactionId);
        end
    },
    OnClickWorking = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local status = this.workingStatus == 1 and -1 or 1;
            this.SetType(status, 0, 0);
        end
    },
    OnClickRare = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local status = this.rareStatus == 1 and -1 or 1;
            this.SetType(0, status, 0);
        end
    },
    OnClickHG = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local status = this.hgStatus == 1 and -1 or 1;
            this.SetType(0, 0, status);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.heroItem = vm.behaviour.transform:Find("template/HeroItem").gameObject;
        this.heroItemGroup = vm.behaviour.transform:Find("template/HeroItemGroup").gameObject;
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/HeroView").gameObject);
        this.spineCharacter = vm.behaviour.transform:Find("root/Left/Info/Character"):GetComponent("UISpineCharacter");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.FoundationHeroChoiceClick, this.OnClickHero);
        vm.data.contentPos = Vector2.zero;
        vm.data.isInfo = false;
        this.InitHeros();
        this.ViewAdaptive();
        this.SetType(1, 0, 0);
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationHeroChoiceClick, this.OnClickHero);
        this.spineCharacter:Clear();
        this.scrollView:Clear(true);
        LuaMgr.CheckRefCount();
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("FoundationHeroChoiceItemGroup");
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})