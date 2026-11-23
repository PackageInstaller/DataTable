require("ViewModel/JSYZ/JSYZGameMgr")
require("ViewModel/JSYZ/JSYZGameMissionItem")

local this = {
    scrollView = nil,
    scrollWidth = 0,
    questEvents = nil,
    serveCount = 0,
};

local objs = {
    missionItem = { path = "template/MissionItem", type = "GameObject" },
    scrollViewGO = { path = "root/Middle/ScrollView", type = "GameObject" },
    openGO = { path = "root/Middle/Bottom/Open", type = "GameObject" },
    openCount = { path = "root/Middle/Bottom/Open/Count/Text", type = "Text" },
    closeGO = { path = "root/Middle/Bottom/Close", type = "GameObject" },
};


this.SetData = function()
    local isComplete = this.IsCompleteAll();
    if (not isComplete) then
        local count = DataMgr.Player.BoomGame.Count;
        this.openCount.text = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29809"), count);
    end
    SetActive(this.openGO, not isComplete);
    SetActive(this.closeGO, isComplete);
    this.SetMissionList(isComplete);
end


this.MissionSort = function(a, b)
    return string.lower(a.id) < string.lower(b.id);
end


this.GetServeCount = function()
    local len = #this.questEvents;
    local questEvent = this.questEvents[len];
    return questEvent.progress;
end


this.IsCompleteAll = function()
    local questData;
    local quests = DataMgr.Player.quests;
    local len = #this.questEvents;
    for i = 1, len do
        questData = quests[this.questEvents[i].id];
        if (questData == nil or questData.state ~= 3) then
            return false;
        end
    end
    return true;
end


this.SetMissionList = function(isComplete)
    local addWidth = LuaMgr.GetScreenAddWidth();
    this.scrollWidth = 1280 + addWidth;
    this.scrollView:Clear(false);
    local missionConfig;
    local missionData;
    local scrollData;
    local scrollDatas = {};
    local quests = DataMgr.Player.quests;
    local len = #this.questEvents;
    local index = 0;
    for i = 1, len do
        missionConfig = this.questEvents[i];
        missionData = quests[missionConfig.id];
        if (index == 0 and (missionData == nil or missionData.state ~= 3)) then
            index = i;
        end
        scrollData = UIScrollData.GetData(this.missionItem, "JSYZGameMissionItem", 400, 520,
            { config = missionConfig, complete = isComplete, num = i });
        table.insert(scrollDatas, scrollData);
    end
    this.scrollView:SetParams(this.scrollWidth, 520);
    this.scrollView:SetPadding(15, 0, 0, 0);
    this.scrollView:SetData(scrollDatas, true);
    this.scrollView:MoveToIndex(index);
end


this.OnGetReward = function(args)
    DataExHelper.EX_GetAward(args[0], this.SetData);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.scrollView = UIScrollView.New(this.scrollViewGO);
        this.questEvents = DataExHelper.Check_ConfigQuestEventByText("JSYZGame");
        table.sort(this.questEvents, this.MissionSort);
        this.serveCount = this.GetServeCount();
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.YPSGameMissionGetReward, this.OnGetReward);
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.YPSGameMissionGetReward, this.OnGetReward);
        this.scrollView:Clear(true);
    end,
    before_destroy = function()
        UIScrollView.ClearItem("JSYZGameMissionItem");
        this.questEvents = nil;
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})