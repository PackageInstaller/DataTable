require("GuoBao/GuoBaoShopItem")
require("GuoBao/GuoBaoShopItemGroup")

local this = {
    groupId = 3020,
    scrollView = nil,
    questEvents = nil,
};

local objs = {

    shopItem = { path = "template/ShopItem", type = "GameObject" },
    shopItemGroup = { path = "template/ShopItemGroup", type = "GameObject" },
    shopsGO = { path = "root/Left/Shops", type = "GameObject" },
    characterTF = { path = "root/Middle/Character", type = "RectTransform" },
    characterDrawing = { path = "root/Middle/Character/Body", type = "DrawingAdjustTool" },
    spineCharacter = { path = "root/Middle/Character/Body", type = "UISpineCharacter" },
    scoreGO = { path = "root/Right/Score", type = "GameObject" },
    scoreText = { path = "root/Right/Score/Text", type = "Text" },
    characterBtn = { path = "root/Right/Character", type = "Button" },
    receiveBtn = { path = "root/Right/Receive", type = "Button" },
    receiveGO = { path = "root/Right/Receive", type = "GameObject" },
    receiveBtn = { path = "root/Right/Receive", type = "Button" },
    receiveRedDot = { path = "root/Right/Receive/RedDot", type = "GameObject" },
    receivedGO = { path = "root/Right/Received", type = "GameObject" },
};


this.SetData = function()
    this.questEvents = DataExHelper.Check_ConfigQuestEventByGroupId(this.groupId);
    this.SetScore();
    this.SetReceiveStatus();
end


this.SetScore = function()
    local countryExchangeChar = ConfigMgr.Config.constants.CountryExchangeChar;
    if (countryExchangeChar ~= nil) then
        local itemsAccumulate = DataMgr.Player.itemsAccumulate[countryExchangeChar[1]];
        itemsAccumulate = itemsAccumulate == nil and 0 or itemsAccumulate;
        this.scoreText.text = string.format("%d<color=#8e8d8d>/%s</color>", itemsAccumulate, countryExchangeChar[2]);
        SetActive(this.receiveRedDot, itemsAccumulate >= tonumber(countryExchangeChar[2]));
    else
        SetActive(this.receiveRedDot, false);
    end
end


this.SetReceiveStatus = function()
    local hadExchanged = DataMgr.Player.simulatedShop.hadExchanged;
    SetActive(this.receiveGO, not hadExchanged);
    SetActive(this.receivedGO, hadExchanged);
end


this.SetCharacter = function()
    local countryExchangeChar = ConfigMgr.Config.constants.CountryExchangeChar;
    if (countryExchangeChar ~= nil) then
        local characterId = countryExchangeChar[3];
        local path = HeroManager.SetCharacterDrawing(this.spineCharacter, characterId, characterId .. "001");
        if (path ~= "") then
            this.characterDrawing.Sprite = path;
        end
    end
end


this.SetShopList = function()
    this.scrollView:Clear(false);
    local groupData;
    local itemLen;
    local scrollData;
    local scrollDatas = {};
    local events = this.GetQuestEvents();
    local len = #events;
    local index = 0;
    while (index < len) do
        itemLen = index + 4 > len and len - index or 4;
        groupData = {};
        groupData.item = this.shopItem;
        groupData.list = {};
        for i = 1, itemLen do
            table.insert(groupData.list, events[i + index]);
        end
        index = index + itemLen;
        scrollData = UIScrollData.GetData(this.shopItemGroup, "GuoBaoShopItemGroup", 806, 290, groupData);
        table.insert(scrollDatas, scrollData);
    end
    this.scrollView:SetParams(830, 596);
    this.scrollView:SetData(scrollDatas, true);
end


this.GetQuestEvents = function()
    local questConfig;
    local questData;
    local startTime;
    local endTime;
    local events = {};
    local sellouts = {};
    local guoBao = DataExHelper.GetDataExByTag(ActivityKey.GuoBao);
    local sysTime = LuaMgr.Timestamp();
    local quests = DataMgr.Player.quests;
    local len = #this.questEvents;
    for i = 1, len do
        questConfig = this.questEvents[i];
        if (questConfig.text == "GuoBaoshop") then
            startTime = questConfig.startTime * 60 + guoBao.startTime;
            endTime = questConfig.endTime * 60 + guoBao.startTime;
            if (sysTime >= startTime and sysTime <= endTime) then
                questData = quests[questConfig.id];
                if (questData ~= nil and questData.progress >= questConfig.progress) then
                    table.insert(sellouts, questConfig);
                else
                    table.insert(events, questConfig);
                end
            end
        end
    end
    len = #sellouts;
    for i = 1, len do
        table.insert(events, sellouts[i]);
    end
    return events;
end


this.OnShopRefresh = function(args)
    local questConfig = args[0];
    local questData = DataMgr.Player.quests[questConfig.id];
    if (questData ~= nil and questData.progress >= questConfig.progress) then
        this.SetShopList();
    else
        this.scrollView:Refresh();
    end
    this.SetScore();
end


this.OnClickReceive = function()
    PlayerGuoBaoMgr.SimulatedShopExchangeChar(this.ExchangeCharResponse);
end


this.OnClickCharacter = function()
    local countryExchangeChar = ConfigMgr.Config.constants.CountryExchangeChar;
    if (countryExchangeChar ~= nil) then
        LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel", countryExchangeChar[3]);
    end
end


this.ExchangeCharResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local reward = json.encode(data.result.Rewards);
        LuaMgr.ShowItemRewared(reward);
    end
    this.SetReceiveStatus();
end

local data = {bodyPath = ""}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.scrollView = UIScrollView.New(this.shopsGO);
        LuaMgr.AddClick(this.receiveBtn, this.OnClickReceive);
        LuaMgr.AddClick(this.characterBtn, this.OnClickCharacter);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        

        LuaMgr.AddUIEventListener(UIEventConst.GuoBaoShopRefresh, this.OnShopRefresh);
        this.SetData();
        this.SetCharacter();
        this.SetShopList();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.GuoBaoShopRefresh, this.OnShopRefresh);
        this.scrollView:Clear(true);
        if (this.spineCharacter ~= nil) then
            this.spineCharacter:Clear();
        end
        this.questEvents = nil;
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.receiveBtn, this.OnClickReceive);
        LuaMgr.RemoveClick(this.characterBtn, this.OnClickCharacter);
        this.spineCharacter = nil;
        UIScrollView.ClearItem("GuoBaoShopItemGroup");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})