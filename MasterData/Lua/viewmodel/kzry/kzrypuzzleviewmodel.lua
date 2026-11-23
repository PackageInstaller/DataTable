require("ViewModel/KZRY/KZRYPuzzleItem")

local this = {
    vm = nil,
    dataList = {},
    moveIndex = 0,
    canGetReward = {},
};

local objs = {

    novelItem = { path = "template/Item", type = "GameObject" },
    scrollViewGO = { path = "root/Middle/ScrollView", type = "GameObject" },
    closeBtn = { path = "root/Middle/Close", type = "Button" },
    oneKeyGet = { path = "root/Middle/OneKeyGet", type = "Button" },
    introducePanel = { path = "root/Middle/IntroducePanel", type = "GameObject" },
    maskBtn = { path = "root/Middle/IntroducePanel/Mask", type = "Button" },
    textTitle = { path = "root/Middle/IntroducePanel/TextTitle", type = "Text" },
    textContent = { path = "root/Middle/IntroducePanel/ScrollView/Viewport/Content/TextContent", type = "Text" },
};

local data = {

}
local command = {

}

this.ParseData = function()
    this.dataList = {}    
    local groupList = KZRYMgr.GetGroupsByKZRY();
    local questDataList = KZRYMgr.GetPuzzleRewardCfgData()
    for i, v in ipairs(groupList) do
        local cache = {}
        cache.group = v
        cache.questList = questDataList[v.id]
        table.insert(this.dataList, cache)
    end
    this.RefreshData()
end

this.RefreshData = function()
    this.canGetReward = {}
    HeroRedDataHelper.SetKZRYRed()
    RedMgr.Singleton:Refresh()
    local canGet = false
    for i, v in ipairs(this.dataList) do
        if (v.questList ~= nil) then
            for key, value in pairs(v.questList) do
                local state = DataExHelper.Check_RewardState(value.id);
                if (state ~= nil and state == 2) then
                    if (not canGet) then
                        canGet = true
                        this.moveIndex = i
                    end
                    table.insert(this.canGetReward, value.id)
                end
            end
        end
    end
    SetActive(this.oneKeyGet.gameObject, canGet)
    this.SetPuzzleList()
end


this.SetPuzzleList = function()
    this.scrollView:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local len = #this.dataList;
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.novelItem, "KZRYPuzzleItem", 290, 340,
            { config = this.dataList[i], callback = this.ShowIntroducePanel });
        table.insert(scrollDatas, scrollData);
    end
    this.scrollView:SetParams(1180, 340);
    this.scrollView:SetData(scrollDatas, true);
    this.scrollView:MoveToIndex(this.moveIndex);
    this.showIndex = 1;
    this.showList = this.scrollView.screenList;
    for _, v in pairs(this.showList) do
        SetActive(v.gameObject, false);
    end
    LuaMgr.AddTimer(TimerConst.SGYNovelListDelay, this.OnPuzzleList, 0.05, -1, true);
end


this.OnPuzzleList = function()
    if (this.showIndex > #this.showList) then
        LuaMgr.RemoveTimer(TimerConst.SGYNovelListDelay);
        this.showList = nil;
        return;
    end
    local item = this.showList[this.showIndex];
    SetActive(item.gameObject, true);
    this.showIndex = this.showIndex + 1;
end

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.vm = vm;

        this.scrollView = UIScrollView.New(this.scrollViewGO);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
        LuaMgr.AddClick(this.oneKeyGet, this.OnClickOneKeyGet);
        LuaMgr.AddClick(this.maskBtn, this.OnClickClosePanel);
    end,
    before_active = function(vm)
        LuaMgr.AddUIEventListener(UIEventConst.RhythmGameQuestReceive, this.RefreshData);
        this.OnClickClosePanel()
        if (vm.behaviour.Params ~= nil) then
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        this.scrollView:Clear(true);
        LuaMgr.RemoveTimer(TimerConst.SGYNovelListDelay);
        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGameQuestReceive, this.RefreshData);
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        LuaMgr.RemoveClick(this.oneKeyGet, this.OnClickOneKeyGet);
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickClosePanel);
        UIScrollView.ClearItem("KZRYPuzzleItem");
    end
}


this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.KZRYPuzzleViewModel);
end


this.OnClickOneKeyGet = function()

    DataExHelper.EX_GetAwards(this.canGetReward, function(_result)
        this.RefreshData()      
    end)
end

this.OnClickClosePanel = function()
    SetActive(this.introducePanel.gameObject, false)
end

this.ShowIntroducePanel = function(_config)
    this.textTitle.text = ConfigMgr.LangGlobal("".._config.parameter);
    this.textContent.text = LuaMgr.GetLangText(_config.DescriptionLan);
    SetActive(this.introducePanel.gameObject, true)
end


return vm({
    data = data,
    command = command,
    hook = hook
})