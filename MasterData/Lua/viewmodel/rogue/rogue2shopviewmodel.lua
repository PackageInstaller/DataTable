require("ViewModel/Rogue/RogueShopItem")
require("ViewModel/Rogue/RogueShopItemGroup2")

local this = {
    msgList = { "26701", "26702", "26703", "26704", "26705" },
    msgIndex = 0,
    scrollView = nil,
    questEvents = nil,
    shopItem = nil,
};

local objs = {

    shopItem = { path = "template/ShopItem", type = "GameObject" },
    shopItemGroup = { path = "template/ShopItemGroup", type = "GameObject" },
    shopsGO = { path = "root/Left/Shops", type = "GameObject" },
    characterTF = { path = "root/Middle/Character", type = "RectTransform" },
    characterDrawing = { path = "root/Middle/Character/Body", type = "DrawingAdjustTool" },
    spineCharacter = { path = "root/Middle/Character/Body", type = "UISpineCharacter" },
    characterBtn = { path = "root/Middle/Character/Click", type = "Button" },
    msgContent = { path = "root/Middle/Msg/Content", type = "Text" },
};


this.SetData = function()
    this.questEvents = DataExHelper.Check_ConfigQuestEventByGroupId(RogueMgr.GroupId_1);
    LuaMgr.AddTimer(TimerConst.SGYShopMsgTime, this.SetMsg, 10, -1, true);
end


this.SetCharacter = function()
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, "V0169", "V0169001");
    if (path ~= "" and this.characterDrawing ~= nil) then
        this.characterDrawing.Sprite = path;
    end
end


this.SetMsg = function()
    local len = #this.msgList;
    local index = math.random(1, len);
    if (this.msgIndex ~= index) then
        this.msgIndex = index;
    else
        if (index >= len) then
            this.msgIndex = index - 1;
        else
            this.msgIndex = index + 1;
        end
    end
    this.msgContent.text = ConfigMgr.LangGlobal(this.msgList[this.msgIndex]);
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
            if (i + index <= len) then
                table.insert(groupData.list, events[i + index]);
                groupData.numIndex = i + index
            end
        end
        index = index + itemLen;
        scrollData = UIScrollData.GetData(this.shopItemGroup, "RogueShopItemGroup2", 806, 270, groupData);
        table.insert(scrollDatas, scrollData);
    end
    this.scrollView:SetParams(830, 592);
    this.scrollView:SetData(scrollDatas, true);
end


this.GetQuestEvents = function()
    local questConfig;
    local questData;
    local startTime;
    local endTime;
    local events = {};
    local sellouts = {};
    local sgy = DataExHelper.GetDataExByTag(ActivityKey.RogueLike);
    local sysTime = LuaMgr.Timestamp();
    local quests = DataMgr.Player.quests;

    if (this.questEvents == nil) then
        return events;
    end

    local len = #this.questEvents;
    for i = 1, len do
        questConfig = this.questEvents[i];
        if (questConfig and questConfig.text == "RogueShop2" and sgy) then
            startTime = questConfig.startTime * 60 + sgy.startTime;
            endTime = questConfig.endTime * 60 + sgy.startTime;
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
end


this.OnClickCharacter = function()
    this.SetMsg();
    LuaMgr.RemoveTimer(TimerConst.SGYShopMsgTime);
    LuaMgr.AddTimer(TimerConst.SGYShopMsgTime, this.SetMsg, 10, -1, true);
end


this.OnBack = function()
    if DataExHelper.CommonActivityCheck(ActivityKey.checkIn7Days) then
        LuaMgr.Back(ActivityKey.checkIn7Days);
    else
        LuaMgr.Back();
    end
end

local data = { bodyPath = "" }

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.scrollView = UIScrollView.New(this.shopsGO);
        LuaMgr.AddClick(this.characterBtn, this.OnClickCharacter);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if vm.behaviour.Params.Length > 0 then
            vm.behaviour:UpdateTopBar("", this.OnBack);
        end
        LuaMgr.AddUIEventListener(UIEventConst.SGYShopRefresh, this.OnShopRefresh);
        this.SetData();
        this.SetCharacter();
        this.SetShopList();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.SGYShopMsgTime);
        LuaMgr.RemoveUIEventListener(UIEventConst.SGYShopRefresh, this.OnShopRefresh);
        this.scrollView:Clear(true);
        if (this.spineCharacter ~= nil) then
            this.spineCharacter:Clear();
        end
        this.questEvents = nil;
    end,
    before_destroy = function()
        this.spineCharacter = nil;
        LuaMgr.RemoveClick(this.characterBtn, this.OnClickCharacter);
        UIScrollView.ClearItem("RogueShopItemGroup2");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})