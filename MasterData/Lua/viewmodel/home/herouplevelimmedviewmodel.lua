require("ViewModel/Home/HeroUpLevelImmedHeadItem")

local this = {
    itemCharacterUp = nil,
    itemId = "",
    characterId = "",
    headList = nil,
    selectHead = nil,
};

local objs = {
    maskBtn = { path = "root/Mask", type = "Button" },
    headItem = { path = "template/HeadItem", type = "GameObject" },
    scrollView = { path = "root/Middle/UpLevel/ScrollView", type = "ScrollRect" },
    scrollViewContent = { path = "root/Middle/UpLevel/ScrollView/Viewport/Content", type = "RectTransform" },
    title = { path = "root/Middle/UpLevel/Title", type = "Text" },
    confirmGO = { path = "root/Middle/UpLevel/Confirm", type = "GameObject" },
    confirmBtn = { path = "root/Middle/UpLevel/Confirm", type = "Button" },
    notCharacter = { path = "root/Middle/UpLevel/NotCharacter", type = "GameObject" },
    notCharacterText = { path = "root/Middle/UpLevel/NotCharacter/Text", type = "Text" },
    confirmBtnText = {path = "root/Middle/UpLevel/Confirm/Text", type = "Text"},
};


this.SetData = function()
    this.itemCharacterUp = ConfigMgr.Config.ItemsCharacterUp[this.itemId];
    if (this.itemCharacterUp == nil) then return end
    
    this.title.text = string.format(ConfigMgr.LangGlobal("10182"), this.itemCharacterUp.Level);
    this.notCharacterText.text = ConfigMgr.LangGlobal("10184");
    this.SetHeads();
    SetActive(this.confirmGO, false);
end

this.SetLanguageText = function()
    this.confirmBtnText.text = ConfigMgr.LangGlobal("10185");
end


this.SetHeads = function()
    this.headList:Clear();
    local characterData;
    local characterConfig;
    local listData;
    local listDatas = {};
    local list = {};
    local characterTable = ConfigMgr.Config.characterTable;
    local characters = DataMgr.Player.characters;
    local type = tonumber(this.itemCharacterUp.Type);
    if (type == 1) then
        for _, v in pairs(characters) do
            if (v.level < this.itemCharacterUp.Level) then
                characterConfig = characterTable[v.id];
                if (characterConfig ~= nil) then
                    table.insert(list, {data=v, config=characterConfig});
                end
            end
        end
    elseif (type == 5) then
        local ids = this.itemCharacterUp.CharacterId;
        local len = #ids;
        for i = 1, len do
            characterData = characters[ids[i]];
            if (characterData ~= nil and characterData.level < this.itemCharacterUp.Level) then
                characterConfig = characterTable[characterData.id];
                if (characterConfig ~= nil) then
                    table.insert(list, {data=characterData, config=characterConfig});
                end
            end
        end
    else
        for _, v in pairs(characters) do
            if (v.level < this.itemCharacterUp.Level) then
                characterConfig = characterTable[v.id];
                if (characterConfig ~= nil and characterConfig.rare == type) then
                    table.insert(list, {data=v, config=characterConfig});
                end
            end
        end
    end
    local len = #list;
    if (len > 0) then
        table.sort(list, this.CharacterSort);
        for i = 1, len do
            listData = UIListData.GetData(this.headItem, "HeroUpLevelImmedHeadItem", {character=list[i].data, isSelect=false});
            table.insert(listDatas, listData);
        end
        this.headList:SetData(listDatas);
        SetActive(this.notCharacter, false);
    else
        SetActive(this.notCharacter, true);
    end
end


this.CharacterSort = function(a, b)
    if (a.config.rare == b.config.rare) then
        return a.data.level < b.data.level;
    end
    return a.config.rare > b.config.rare;
end


this.OnClickMask = function()
    LuaMgr.HidePanel(UIName.HeroUpLevelImmedViewModel);
end


this.OnClickConfirm = function()
    local obj = {characterId=this.characterId, itemId=this.itemId};
    local objStr = json.encode(obj);
    LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel", this.characterId, nil, this.itemCharacterUp.Level, this.itemCharacterUp.Talent, objStr);
end


this.CharacterUpResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        LuaMgr.HidePanel(UIName.HeroUpLevelImmedViewModel);
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("HeroUpLevelImmedViewModel_0"));
    end
end


this.OnSelectHead = function(args)
    local item = args[0];
    if (this.selectHead ~= nil) then
        this.selectHead:Select(false);
        this.selectHead = nil;
    end
    this.selectHead = item;
    this.characterId = item.data.character.id;
    this.selectHead:Select(true);
    SetActive(this.confirmGO, true);
end


this.OnNextFrame = function()
    this.scrollView.vertical = true;
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.headList = UIListView.New(this.scrollViewContent);
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask);
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.HeroUpLevelImmedSelectHead, this.OnSelectHead);
        this.itemId = vm.behaviour.Params[0];
        this.scrollView.vertical = false;
        this.scrollViewContent.anchoredPosition = Vector2.zero;
        this.SetData();
        this.SetLanguageText()
        LuaMgr.NextFrame(this.OnNextFrame);
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.HeroUpLevelImmedSelectHead, this.OnSelectHead);
        this.headList:Clear();
        this.selectHead = nil;
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm);
        UIListView.ClearItem("HeroUpLevelImmedHeadItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})