require("GuoBao/GuoBaoNovelItem")

local this = {
    scrollView = nil,
    scrollWidth = 0,
    screenWidth = 0,
    eventList = nil,
};

local objs = {

    novelItem = { path = "template/NovelItem", type = "GameObject" },
    scrollViewGO = { path = "root/Middle/ScrollView", type = "GameObject" },
};


this.SetData = function()
    this.eventList = DataExHelper.EX_GetEventListByArea(GuoBaoActivity.Novel);
    ConfigGuoBaoMgr.InitActivityMapEvent(this.eventList);
    this.SetNovelList();
end


this.SetNovelList = function()
    local addWidth = LuaMgr.GetScreenAddWidth();
    this.scrollWidth = 1280 + addWidth;
    this.scrollView:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local len = #this.eventList;
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.novelItem, "GuoBaoNovelItem", 333, 270, {config=this.eventList[i], num=i});
        table.insert(scrollDatas, scrollData);
    end
    this.scrollView:SetParams(this.scrollWidth, 520);
    this.scrollView:SetPadding(73, 0, 0, 0);
    local novelIndex = PlayerGuoBaoMgr.GetNovelIndex();
    this.scrollView:SetData(scrollDatas, true, novelIndex);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.scrollView = UIScrollView.New(this.scrollViewGO);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.SetData();
    end,
    before_deactive = function(vm)
        this.scrollView:Clear(true);
    end,
    before_destroy = function()
        UIScrollView.ClearItem("GuoBaoNovelItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})