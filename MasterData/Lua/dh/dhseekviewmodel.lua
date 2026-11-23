require("DH/DHSeekItem")

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
    btnAllusion = { path = "root/Right/AllusionBtn", type = "Button" },
};


this.SetLevelList = function()
    local addWidth = LuaMgr.GetScreenAddWidth();
    this.scrollWidth = 1280 + addWidth;
    this.levelSV:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local selectIndex = 0
    for i, v in ipairs(this.eventList) do
        scrollData = UIScrollData.GetData(this.levelItem, "DHSeekItem", 320, 439,
            { config = v, num = i, playAni = true });
        table.insert(scrollDatas, scrollData);
        if (DataMgr.Player.DunHuang.StageId == v.Id) then
            selectIndex = i
        end
    end
    this.levelSV:SetParams(this.scrollWidth, 439);
    this.levelSV:SetPadding(20, 0, 0, 0);
    this.levelSV:SetData(scrollDatas, true);
    this.contentWidth = this.scrollViewContent.sizeDelta.x;
    this.levelSV:MoveToIndex(selectIndex);
end

this.RefreshLevelList = function()
    this.levelSV:Clear(false);
    local scrollData;
    local scrollDatas = {};
    for i, v in ipairs(this.eventList) do
        scrollData = UIScrollData.GetData(this.levelItem, "DHSeekItem", 320, 439,
            { config = v, num = i, playAni = false });
        table.insert(scrollDatas, scrollData);
    end
    this.levelSV:SetParams(this.scrollWidth, 439);
    this.levelSV:SetPadding(20, 0, 0, 0);
    this.levelSV:SetData(scrollDatas, false);
end

this.CheckShowAllusion = function()
    local gridType = ConfigDHMgr.GetGridType(DHSurveyGrid.Box);
    local lvConfig = ConfigMgr.Config.DHLevelMap;
    for k, v in pairs(lvConfig) do
        if (v.ImgInfo ~= nil) then
            local curGet = PlayerDHMgr.GetBoxToolsCount(v.Id, gridType.ItemsID);
            if (curGet > 0) then
                return true
            end
        end
    end
    return false
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

this.BtnAllusionOnClick = function()
    LuaMgr.ShowLuaPanel(UIName.DHAllusionViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.eventList = {};
        for k, v in pairs(ConfigMgr.Config.DHLevelMap) do
            table.insert(this.eventList, v);
        end
        table.sort(this.eventList, function(a, b)
            return a.SortId < b.SortId;
        end)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.levelSV = UIScrollView.New(this.scrollView);
        RedMgr.Singleton:RegisterViewModel(UIName.DHSeekViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.AddUIEventListener(UIEventConst.QinSurveyMapRefresh, this.RefreshLevelList);
        vm.behaviour:UpdateTopBar("", this.OnBack);
        LuaMgr.AddClick(this.btnAllusion, this.BtnAllusionOnClick);

        if (RedMgr.Singleton:CheckRedCondition("16057")) then
            RedMgr.Singleton:FrushRedCondition("16057")
        end
        this.SetLevelList();
        SetActive(this.btnAllusion.gameObject, this.CheckShowAllusion())

    end,
    before_deactive = function(vm)
        LuaMgr.RemoveClick(this.btnAllusion, this.BtnAllusionOnClick);
        LuaMgr.RemoveUIEventListener(UIEventConst.QinSurveyMapRefresh, this.RefreshLevelList);

        this.levelSV:Clear(true);
    end,
    before_destroy = function()
        UIScrollView.ClearItem("DHSeekItem");
        RedMgr.Singleton:RemoveViewModel(UIName.DHSeekViewModel);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})