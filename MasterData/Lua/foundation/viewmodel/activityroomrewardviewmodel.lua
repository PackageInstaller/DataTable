require("Foundation/ViewModel/ActivityRoomRewardItem")

local this = {
    groupId = 3074,
    scrollView = nil,
    questEvents = nil,
};

local objs = {

    closeBtn = { path = "root/Middle/Rewards/Close", type = "Button" },
    rewardItem = { path = "template/RewardItem", type = "GameObject" },
    scrollViewGO = { path = "root/Middle/Rewards/ScrollView", type = "GameObject" },
    receiveAllBtn = { path = "root/Middle/Rewards/ReceiveAll", type = "Button" },
};


this.SetData = function()
    this.SetRewardList();
    this.CheckReceives();
end


this.SetRewardList = function()
    this.scrollView:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local len = #this.questEvents;
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.rewardItem, "ActivityRoomRewardItem", 830, 86, this.questEvents[i]);
        table.insert(scrollDatas, scrollData);
    end
    this.scrollView:SetParams(850, 400);
    this.scrollView:SetPadding(0, 0, 0, -40);
    this.scrollView:SetData(scrollDatas, true);
end


this.SortQuestEvent = function(a, b)
    return tonumber(a.id) < tonumber(b.id);
end


this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.ActivityRoomRewardViewModel);
end


this.CheckReceives = function()
    local questEvent;
    local questData;
    local index = 0;
    local isReceives = false;
    local isFinish = true;
    local len = #this.questEvents;
    for i = 1, len do
        questEvent = this.questEvents[i];
        questData = DataMgr.Player.quests[questEvent.id];
        if (questData ~= nil) then
            if (questData.state == 1) then
                isFinish = false;
            elseif (questData.state == 2) then
                isReceives = true;
                isFinish = false;
                index = i;
                break;
            end
        end
    end
    if (index > 0) then
        this.scrollView:MoveToIndex(index > 1 and index - 1 or 1);
    end
    if (not isReceives and isFinish) then
        this.scrollView:MoveToIndex(len);
    end
end


this.IsReceive = function()
    local questEvent;
    local questData;
    local len = #this.questEvents;
    for i = 1, len do
        questEvent = this.questEvents[i];
        questData = DataMgr.Player.quests[questEvent.id];
        if (questData ~= nil and questData.state == 2) then
            return true;
        end
    end
    return false;
end


this.OnClickReceiveAll = function()
    if (not this.IsReceive()) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10453"));
        return;
    end
    DataExHelper.EX_GetGroupAward(this.groupId, this.GetGroupAwardResponse);
end


this.GetGroupAwardResponse = function()
    this.CheckReceives();
    this.scrollView:Refresh();
    HeroRedDataHelper.SetDH2Red();
    RedMgr.Singleton:Refresh();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.scrollView = UIScrollView.New(this.scrollViewGO);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
        LuaMgr.AddClick(this.receiveAllBtn, this.OnClickReceiveAll);
        this.questEvents = DataExHelper.Check_ConfigQuestEventByText("RSReward");
        table.sort(this.questEvents, this.SortQuestEvent);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.SetData();
    end,
    before_deactive = function(vm)
        this.scrollView:Clear(true);
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        LuaMgr.RemoveClick(this.receiveAllBtn, this.OnClickReceiveAll);
        UIScrollView.ClearItem("ActivityRoomRewardItem");
        this.questEvents = nil;
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})