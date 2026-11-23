require("DH/DHStoryItem")

local this = {
    levelSV = nil,
    scrollWidth = 0,
    mapPath = "",
    mapItemGO = nil,
    mapItemTF = nil,
    bgWidth = 0,
    bgPos = Vector2.zero,
    contentWidth = 0,
    contentPosX = 0,
    screenWidth = 0,
    eventList = nil,
};

local objs = {

    levelItem = { path = "template/LevelItem", type = "GameObject" },
    scrollView = { path = "root/Middle/ScrollView", type = "GameObject" },
    scrollViewContent = { path = "root/Middle/ScrollView/Viewport/Content", type = "RectTransform" },
};


this.SetData = function()
    this.eventList = DataExHelper.EX_GetEventListByArea(DHLevelType.Story);
    this.SetLevelList();
end


this.SetLevelList = function()
    local addWidth = LuaMgr.GetScreenAddWidth();
    this.scrollWidth = 1100 + addWidth;
    this.levelSV:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local len = #this.eventList;
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.levelItem, "DHStoryItem", 130, 608,
            { type = 1, config = this.eventList[i], num = i });
        table.insert(scrollDatas, scrollData);
    end
    this.levelSV:SetParams(this.scrollWidth, 608);
    this.levelSV:SetPadding(10, 0, 0, 0);
    this.levelSV:SetData(scrollDatas, true);
    this.contentWidth = this.scrollViewContent.sizeDelta.x;
end


this.OnUpdate = function()
    local px = math.floor(this.scrollViewContent.anchoredPosition.x);
    if (px == this.contentPosX) then return end

    this.contentPosX = px;
    if (px >= 0) then
        this.bgPos.x = 0;
    else
        local rate = px / (this.contentWidth - this.scrollWidth);
        local width = this.bgWidth - this.screenWidth;
        local bx = math.floor(width * rate);
        if (bx <= -width) then
            bx = -width;
        end
        this.bgPos.x = bx;
    end
end

this.OnBack = function()
    LuaMgr.Back();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.levelSV = UIScrollView.New(this.scrollView);
        RedMgr.Singleton:RegisterViewModel(UIName.DHStoryViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end       
        vm.behaviour:UpdateTopBar("1", this.OnBack);

        this.SetData();

    end,
    before_deactive = function(vm)

        this.levelSV:Clear(true);
    end,
    before_destroy = function()
        UIScrollView.ClearItem("DHStoryItem");
        RedMgr.Singleton:RemoveViewModel(UIName.DHStoryViewModel);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})