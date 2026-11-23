require("ViewModel/WMFC/WMFCNovelItem")

local this = {
    scrollView = nil,
    showIndex = 0,
    showList = nil,
};

local objs = {

    novelItem = { path = "template/NovelItem", type = "GameObject" },
    scrollViewGO = { path = "root/Middle/ScrollView", type = "GameObject" },
    closeBtn = { path = "root/Middle/Close", type = "Button" },
};


this.SetData = function()
    this.SetNovelList()   
end


this.SetNovelList = function()
    this.scrollView:Clear(false);
    local scrollData;
    local scrollDatas = {};    
    local cacheList = WMFCMgr.GetActiveEventsByArea("WMFC1")
    local novelList = {};
    for k, v in pairs(cacheList) do
        if v.type == 1 then
            table.insert(novelList, v);
        end
    end
    local len = #novelList;
    for i = 1, len do
        local pPass = WMFCMgr.CheckEventIsComplete(novelList[i]);   
        if(pPass)then
             WMFCMgr.SetNovelIndex(i);  
        end        
        scrollData = UIScrollData.GetData(this.novelItem, "WMFCNovelItem",300, 320, {config=novelList[i], num=i});
        table.insert(scrollDatas, scrollData);
    end
    this.scrollView:SetParams(1052, 341);
    this.scrollView:SetData(scrollDatas, true);
    local originIndex = WMFCMgr.GetNovelIndex();
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


this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.WMFCNovelViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.scrollView = UIScrollView.New(this.scrollViewGO);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.SetData();
    end,
    before_deactive = function(vm)       
        LuaMgr.RemoveTimer(TimerConst.SGYNovelListDelay);
        this.showList = nil;
        this.scrollView:Clear(true);
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        UIScrollView.ClearItem("WMFCNovelItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})