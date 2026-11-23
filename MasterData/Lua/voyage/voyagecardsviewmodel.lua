require("Voyage/VoyageCardItem")
require("Voyage/VoyageCardsTabItem")

local this = {
    tabList = nil,
    tabIndex = 1,
    cardList = nil,
    cardDatas = nil,
    msgs = {"10550", "10551", "10552", "10553", "10554", "10555", "10556", "10557"},
    animations = {"happy", "sadness", "shyness", "sadness", "anger", "normal", "normal", "anger"},
};

local objs = {
    closeBtn = { path = "root/Middle/Cards/Close", type = "Button" },
    countText = { path = "root/Middle/Cards/Count/Text", type = "Text" },
    tab1 = { path = "root/Middle/Cards/Tabs/Tab1", type = "GameObject" },
    tab2 = { path = "root/Middle/Cards/Tabs/Tab2", type = "GameObject" },
    tab3 = { path = "root/Middle/Cards/Tabs/Tab3", type = "GameObject" },
    cardItem = { path = "template/CardItem", type = "GameObject" },
    cardListTF = { path = "root/Middle/Cards/CardList", type = "Transform" },
    confrimBtn = { path = "root/Middle/Cards/Confrim", type = "Button" },
    itemIcon = { path = "root/Middle/Cards/Item/Icon", type = "RawImage" },
    itemText = { path = "root/Middle/Cards/Item/Text", type = "Text" },
    spineCharacter = { path = "root/Middle/Cards/Character/Spine", type = "UISpineCharacter" },
    characterMsg = { path = "root/Middle/Cards/Character/Msg/Text", type = "UIText" },
    characterBtn = { path = "root/Middle/Cards/Character/Click", type = "Button" },
    tipsText = { path = "root/Middle/Cards/Tips/Text", type = "Text" },
};


this.SetData = function()
    this.tabIndex = 1;
    this.cardDatas = ConfigVoyageMgr.GetCards();
    this.SetTabs();
    this.SetCards();
    this.SetCount();
    this.SetCost();
    this.SetSpine();
    this.PlaySpine();
    this.tipsText.text = ConfigMgr.LangGlobal("10496");
end


this.SetCount = function()
    local count = PlayerVoyageMgr.GetUnlockCardCount();
    this.countText.text = string.format("%d/%d", count, #this.cardDatas);
end


this.SetCost = function()
    local cost = ConfigVoyageMgr.GetCardCost();
    if (cost == nil) then return end
    
    this.itemIcon.texture = GetItemTexture(cost.id);
    local itemCount = PlayerItemMgr.GetItemCountById(cost.id);
    this.itemText.text = tostring(itemCount);
end


this.SetSpine = function()
    this.spineCharacter:SetDrawingFace("JQ004", "JQ004A01", 15, 12.3, -0.5);
end


this.PlaySpine = function()
    local index = math.random(1, #this.msgs);
    this.characterMsg.text = ConfigMgr.LangGlobal(this.msgs[index]);
    this.spineCharacter:Play(this.animations[index], "idle_1");
    local path = string.format("%sSailingVoice/SailingVoice_%s.mp3", Path.audio_PATH, this.msgs[index]);
    AudioMgr.Singleton:PlayVoice(path);
end


this.SetTabs = function()
    if (this.tabList == nil) then
        this.tabList = {};
    end
    local tabItem;
    for i = 1, 3 do
        tabItem = this.tabList[i];
        if (tabItem == nil) then
            tabItem = VoyageCardsTabItem.New(this["tab" .. i]);
            this.tabList[i] = tabItem;
        end
        tabItem:SetData(i, this.tabIndex == i);
    end
end


this.DestroyTabs = function()
    if (this.tabList ~= nil) then
        local len = #this.tabList;
        for i = 1, len do
            this.tabList[i]:Destroy();
        end
        this.tabList = nil;
    end
end


this.SetCards = function()
    this.cardList:Clear();
    local listData;
    local listDatas = {};
    local pos = (this.tabIndex - 1) * 6;
    local index = pos + 1;
    local len = pos + 6;
    for i = index, len do
        listData = UIListData.GetData(this.cardItem, "VoyageCardItem", this.cardDatas[i]);
        table.insert(listDatas, listData);
    end
    this.cardList:SetData(listDatas);
end


this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.VoyageCardsViewModel);
end


this.OnClickConfirm = function()
    local unlockCardCount = PlayerVoyageMgr.GetUnlockCardCount();
    if (unlockCardCount >= #this.cardDatas) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("VoyageCardsViewModel_0"));
        return;
    end
    local cost = ConfigVoyageMgr.GetCardCost();
    if (cost ~= nil) then
        local itemCount = PlayerItemMgr.GetItemCountById(cost.id);
        if (itemCount < cost.count) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("VoyageCardsViewModel_1"));
            return;
        end
    end
    LuaMgr.ShowLuaPanel(UIName.VoyageOpenCardViewModel);
end


this.OnClickCharacter = function()
    this.PlaySpine();
end


this.OnSelectTab = function(args)
    local tab = args[0];
    if (tab == this.tabIndex) then return end
    
    this.tabIndex = tab;
    this.SetTabs();
    this.SetCards();
end


this.OnUnlock = function(args)
    this.SetCount();
    this.SetCost();
    this.SetCards();
    this.PlaySpine();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
        LuaMgr.AddClick(this.confrimBtn, this.OnClickConfirm);
        LuaMgr.AddClick(this.characterBtn, this.OnClickCharacter);
        this.cardList = UIListView.New(this.cardListTF);
        RedMgr.Singleton:RegisterViewModel(UIName.VoyageCardsViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.VoyageCardsSelectTab, this.OnSelectTab);
        LuaMgr.AddUIEventListener(UIEventConst.VoyageCardsUnlock, this.OnUnlock);
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageCardsSelectTab, this.OnSelectTab);
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageCardsUnlock, this.OnUnlock);
        this.cardList:Clear();
        this.spineCharacter:Clear();
        this.itemIcon.texture = nil;
        this.cardDatas = nil;
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        LuaMgr.RemoveClick(this.confrimBtn, this.OnClickConfirm);
        LuaMgr.RemoveClick(this.characterBtn, this.OnClickCharacter);
        this.spineCharacter = nil;
        this.DestroyTabs();
        UIListView.ClearItem("VoyageCardItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})