require("ViewModel/YPS/YPSNovelItem")

local this = {
    scrollView = nil,
    showIndex = 0,
    showList = nil,
    novelList = nil,
    battleList = nil,
    rcType1SoftPos = nil,
    rcType2SoftPos = nil,
};

local objs = {
    novelItem = { path = "template/NovelItem", type = "GameObject" },
    scrollViewGO = { path = "root/Middle/ScrollView", type = "GameObject" },
    btnType1 = { path = "root/Middle/btnType1", type = "Button" },
    btnType2 = { path = "root/Middle/btnType2", type = "Button" },
    rcType1 = { path = "root/Middle/btnType1", type = "RectTransform" },
    rcType2 = { path = "root/Middle/btnType2", type = "RectTransform" },
    mask1 = { path = "root/Middle/btnType1/Mask1", type = "GameObject" },
    mask2 = { path = "root/Middle/btnType2/Mask2", type = "GameObject" },
    closeBtn = { path = "root/Middle/Close", type = "Button" },
};


this.SetData = function()
    this.novelList = {};
    this.battleList = {}
    local cacheList = YPSMgr.GetActiveEventsByArea("YPS01")
    for k, v in pairs(cacheList) do
        if v.type == 1 then
            table.insert(this.novelList, v);
        elseif v.type == 2 then
            table.insert(this.battleList, v);
        end
    end
    this.SwitchType(1)
end


this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.YPSNovelViewModel);
end

this.OnClickType1 = function()
    this.SwitchType(1)
end

this.OnClickType2 = function()
    this.SwitchType(2)
end

this.SwitchType = function(type)
    SetActive(this.mask1, type ~= 1);
    SetActive(this.mask2, type == 1);
    local list = nil
    if (type == 1) then
        list = this.novelList
        this.rcType1.anchoredPosition = this.rcType1SoftPos
        this.rcType2.anchoredPosition = Vector2(this.rcType2SoftPos.x, this.rcType2SoftPos.y - 5)
    else
        list = this.battleList
        this.rcType2.anchoredPosition = this.rcType2SoftPos
        this.rcType1.anchoredPosition = Vector2(this.rcType1SoftPos.x, this.rcType1SoftPos.y - 5)
    end
    this.SetScollList(list)
end


this.SetScollList = function(list)
    this.scrollView:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local len = #list;
    for i = 1, len do
        local pPass = YPSMgr.CheckEventIsComplete(list[i]);
        if (pPass) then
            YPSMgr.SetNovelIndex(i);
        end
        scrollData = UIScrollData.GetData(this.novelItem, "YPSNovelItem", 265, 292, { config = list[i], num = i });
        table.insert(scrollDatas, scrollData);
    end
    this.scrollView:SetParams(1080, 292);
    this.scrollView:SetData(scrollDatas, true);
    local originIndex = YPSMgr.GetNovelIndex();
    if (originIndex > 0) then
        this.scrollView:MoveToIndex(originIndex);
    end
    this.showIndex = 1;
    this.showList = this.scrollView.screenList;
    for _, v in pairs(this.showList) do
        SetActive(v.gameObject, false);
    end
    LuaMgr.AddTimer(TimerConst.SGYNovelListDelay, this.OnNovelList, 0.05, -1, true);
end


this.OnNovelList = function()
    if (this.showIndex > #this.showList) then
        LuaMgr.RemoveTimer(TimerConst.SGYNovelListDelay);
        this.showList = nil;
        return;
    end
    local item = this.showList[this.showIndex];
    SetActive(item.gameObject, true);
    this.showIndex = this.showIndex + 1;
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.scrollView = UIScrollView.New(this.scrollViewGO);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
        LuaMgr.AddClick(this.btnType1, this.OnClickType1);
        LuaMgr.AddClick(this.btnType2, this.OnClickType2);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.rcType1SoftPos = this.rcType1.anchoredPosition
        this.rcType2SoftPos = this.rcType2.anchoredPosition
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.SGYNovelListDelay);
        this.showList = nil;
        this.scrollView:Clear(true);
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        LuaMgr.RemoveClick(this.btnType1, this.OnClickType1);
        LuaMgr.RemoveClick(this.btnType2, this.OnClickType2);
        UIScrollView.ClearItem("YPSNovelItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})