require("ZGCX/ZGCXRewardItem")

local this = {
    levelSV = nil,
    scrollWidth = 0,


    eventList = nil,
};

local objs = {

    levelItem = { path = "template/LevelItem", type = "GameObject" },
    scrollView = { path = "root/Middle/ScrollView", type = "GameObject" },
    btnClose = { path = "root/BtnClose", type = "Button" },
};


this.SetData = function()
    this.SetLevelList();
end


this.SetLevelList = function()
    table.sort(this.eventList, function(a, b)
        local state1 = DataExHelper.Check_RewardState(a.id) % 3;
        local state2 = DataExHelper.Check_RewardState(b.id) % 3;
        if (state1 == state2) then
            return a.id < b.id;
        elseif state1 < state2 then
            return false
        else
            return true
        end
    end)
    this.levelSV:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local len = #this.eventList;
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.levelItem, "ZGCXRewardItem", 760, 95,
            {
                config = this.eventList[i],
                callback = function()
                    this.SetLevelList()
                end
            });
        table.insert(scrollDatas, scrollData);
    end
    this.levelSV:SetParams(948, 611);
    this.levelSV:SetPadding(0, 10, 0, 0);
    this.levelSV:SetData(scrollDatas, true);
end

this.OnBack = function()
    LuaMgr.HidePanel(UIName.ZGCXRewardListViewModel)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.btnClose, this.OnBack);
        this.levelSV = UIScrollView.New(this.scrollView);
        RedMgr.Singleton:RegisterViewModel(UIName.ZGCXRewardListViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length > 0 then
            this.eventList = vm.behaviour.Params[0]
        end
        this.SetData();
    end,
    before_deactive = function(vm)
        this.levelSV:Clear(true);
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.btnClose, this.OnBack);
        UIScrollView.ClearItem("ZGCXRewardItem");
        RedMgr.Singleton:RemoveViewModel(UIName.ZGCXRewardListViewModel);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})