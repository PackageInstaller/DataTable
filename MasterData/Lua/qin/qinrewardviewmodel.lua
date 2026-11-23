require("Qin/QinRewardItem")
require("Qin/QinRewardItemGroup")

local this = {
    groupId = 220,
    scrollView = nil,
    questEvents = nil,
};

local objs = {

    rewardItem = { path = "template/RewardItem", type = "GameObject" },
    rewardItemGroup = { path = "template/RewardItemGroup", type = "GameObject" },
    characterTF = { path = "root/Middle/Character", type = "RectTransform" },
    characterDrawing = { path = "root/Middle/Character/Body", type = "DrawingAdjustTool" },
    rewardsGO = { path = "root/Left/Rewards", type = "GameObject" },
    dayText = { path = "root/Left/Time/Day", type = "Text" },
    characterDesc = { path = "root/Right/Character/Desc", type = "Text" },
    characterBtn = { path = "root/Right/Character", type = "Button" },
    spineCharacter = { path = "root/Middle/Character/Body", type = "UISpineCharacter" },
    scoreGO = { path = "root/Right/Score", type = "GameObject" },
    scoreLabel = { path = "root/Right/Score/Label", type = "Text" },
    scoreText = { path = "root/Right/Score/Text", type = "Text" },
    receiveGO = { path = "root/Right/Receive", type = "GameObject" },
    receiveBtn = { path = "root/Right/Receive", type = "Button" },
    receiveEffectGO = { path = "root/Right/Receive/eff_glow", type = "GameObject" },
    receivedGO = { path = "root/Right/Received", type = "GameObject" },
};


this.SetData = function()
    this.questEvents = DataExHelper.Check_ConfigQuestEventByGroupId(this.groupId);
    local daqin = DataExHelper.GetDataExByTag(ActivityKey.daqin);
    local time = daqin.expireTime - LuaMgr.Timestamp();
    local timeStr = "";
    local d, h, m = GetTimeDHM(time);
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("<color=#64e08c>%s</color>%s", d, ConfigMgr.LangGlobal("10365"));
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("<color=#64e08c>%s</color>%s", h, ConfigMgr.LangGlobal("10366"));
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("<color=#64e08c>%s</color>%s", m, ConfigMgr.LangGlobal("10367"));
    end
    this.dayText.text = timeStr;
    this.characterDesc.text = ConfigMgr.LangGlobal("10450");
    this.scoreLabel.text = ConfigMgr.LangGlobal("10451");
    this.SetScore();
    this.SetReceiveStatus();
end


this.SetScore = function()
    local qinExchangeChar = ConfigMgr.Config.constants.QinExchangeChar;
    if (qinExchangeChar ~= nil) then
        local itemsAccumulate = DataMgr.Player.itemsAccumulate[qinExchangeChar[1]];
        itemsAccumulate = itemsAccumulate == nil and 0 or itemsAccumulate;
        this.scoreText.text = string.format("%d<color=#8e8d8d>/%s</color>", itemsAccumulate, qinExchangeChar[2]);
        SetActive(this.receiveEffectGO, itemsAccumulate >= tonumber(qinExchangeChar[2]));
    else
        SetActive(this.receiveEffectGO, false);
    end
end


this.SetReceiveStatus = function()
    local hadExchanged = DataMgr.Player.Qin.HadExchanged;
    SetActive(this.receiveGO, not hadExchanged);
    SetActive(this.receivedGO, hadExchanged);
end


this.SetCharacter = function()
    local qinExchangeChar = ConfigMgr.Config.constants.QinExchangeChar;
    if (qinExchangeChar ~= nil) then
        local characterId = qinExchangeChar[3];
        local path = HeroManager.SetCharacterDrawing(this.spineCharacter, characterId, characterId .. "002");
        if (path ~= "") then
            this.characterDrawing.Sprite = path;
        end
    end
end


this.SetRewardList = function()
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
        groupData.item = this.rewardItem;
        groupData.list = {};
        for i = 1, itemLen do
            table.insert(groupData.list, events[i + index]);
        end
        index = index + itemLen;
        scrollData = UIScrollData.GetData(this.rewardItemGroup, "QinRewardItemGroup", 640, 225, groupData);
        table.insert(scrollDatas, scrollData);
    end
    this.scrollView:SetParams(640, 538);
    this.scrollView:SetData(scrollDatas, true);
end


this.GetQuestEvents = function()
    local questConfig;
    local questData;
    local startTime;
    local endTime;
    local events = {};
    local sellouts = {};
    local daqin = DataExHelper.GetDataExByTag(ActivityKey.daqin);
    local sysTime = LuaMgr.Timestamp();
    local quests = DataMgr.Player.quests;
    local len = #this.questEvents;
    for i = 1, len do
        questConfig = this.questEvents[i];
        startTime = questConfig.startTime * 60 + daqin.startTime;
        endTime = questConfig.endTime * 60 + daqin.startTime;
        if (sysTime >= startTime and sysTime <= endTime) then
            questData = quests[questConfig.id];
            if (questData ~= nil and questData.progress >= questConfig.progress) then
                table.insert(sellouts, questConfig);
            else
                table.insert(events, questConfig);
            end
        end
    end
    len = #sellouts;
    for i = 1, len do
        table.insert(events, sellouts[i]);
    end
    return events;
end


this.OnRewardRefresh = function(args)
    local questConfig = args[0];
    local questData = DataMgr.Player.quests[questConfig.id];
    if (questData ~= nil and questData.progress >= questConfig.progress) then
        this.SetRewardList();
    else
        this.scrollView:Refresh();
    end
    this.SetScore();
end


this.OnClickReceive = function()
    PlayerQinMgr.ExchangeChar(this.ExchangeCharResponse);
end


this.OnClickCharacter = function()
    local qinExchangeChar = ConfigMgr.Config.constants.QinExchangeChar;
    if (qinExchangeChar ~= nil) then
        LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel", qinExchangeChar[3]);
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
        this.scrollView = UIScrollView.New(this.rewardsGO);
        LuaMgr.AddClick(this.receiveBtn, this.OnClickReceive);
        LuaMgr.AddClick(this.characterBtn, this.OnClickCharacter);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        

        LuaMgr.AddUIEventListener(UIEventConst.QinRewardRefresh, this.OnRewardRefresh);
        this.SetData();
        this.SetCharacter();
        this.SetRewardList();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.QinRewardRefresh, this.OnRewardRefresh);
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
        UIScrollView.ClearItem("QinRewardItemGroup");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})