require("DH/DHAllusionItem")

local this = {
    levelSV = nil,
    eventList = nil,
    dataCacheList = nil,
selectIndex = 1,
};

local objs = {
    TapItem = { path = "template/TapItem", type = "GameObject" },
    maskBtn = { path = "root/Mask", type = "Button" },
    scrollView = { path = "root/Middle/ScrollView", type = "GameObject" },
    textTitle = { path = "root/Middle/title/TextTitle", type = "Text" },
    textContent = { path = "root/Middle/ScrollViewContent/goViewport/rectContent/TextContent", type = "Text" },
};


this.SetData = function(bReset)
    this.textTitle.text = ""
    this.textContent.text = ""
    local gridType = ConfigDHMgr.GetGridType(DHSurveyGrid.Box);
    this.levelSV:Clear(false);
    this.dataCacheList = {}
    local scrollDatas = {};
    local indexNum = 0
    
    for i, v in ipairs(this.eventList) do
        if v and v.Id and v.ImgInfo then
            local curGet = PlayerDHMgr.GetBoxToolsCount(v.Id, gridType.ItemsID);
            for k = curGet, 1, -1 do
                local textInfo = v.ImgInfo[k];
                if textInfo then
                    indexNum = indexNum + 1
                    local data = {
                        curIndex = indexNum,
                        Info = textInfo,
                        bSelected = this.selectIndex == indexNum,
                        ClickCallback = this.OnTapItem
                    }
                    table.insert(this.dataCacheList, data)
                    local scrollData = UIScrollData.GetData(this.TapItem, "DHAllusionItem", 271, 96, data);
                    table.insert(scrollDatas, scrollData);
                end
            end
        end
    end
    

    if #this.dataCacheList > 0 then

        if this.selectIndex > #this.dataCacheList then
            this.selectIndex = 1
        end
        this.UpdateTextContent()
    end
    
    this.levelSV:SetParams(271, 460);
    this.levelSV:SetData(scrollDatas, bReset);
    if(bReset and this.selectIndex and this.selectIndex <= #this.dataCacheList)then
        this.levelSV:MoveToIndex(this.selectIndex);
    end
end


this.UpdateTextContent = function()

    if not this.dataCacheList or #this.dataCacheList == 0 then
        LuaDebug.error("DHAllusionViewModel.UpdateTextContent: 没有可用数据")
        return
    end
    
    if not this.selectIndex or this.selectIndex > #this.dataCacheList then
        LuaDebug.error("DHAllusionViewModel.UpdateTextContent: 无效的索引 selectIndex=" .. (this.selectIndex or "nil") .. ", 列表大小=" .. #this.dataCacheList)
        this.selectIndex = 1
    end
    
    local data = this.dataCacheList[this.selectIndex]
    if not data or not data.Info then
        LuaDebug.error("DHAllusionViewModel.UpdateTextContent: 数据不完整")
        return
    end
    
    local config = data.Info
    local id1 = config[1]
    local id2 = config[2]
    
    if not id1 or not id2 then
        LuaDebug.error("DHAllusionViewModel.UpdateTextContent: 配置ID缺失")
        return
    end
    
    local config1 = ConfigMgr.Config.DHTextMaps[id1]
    local config2 = ConfigMgr.Config.DHTextMaps[id2]
    
    if config1 and config1.TextLan then
        this.textTitle.text = LuaMgr.GetLangText(config1.TextLan)
    end
    
    if config2 and config2.TextLan then
        this.textContent.text = LuaMgr.GetLangText(config2.TextLan)
    end
end


this.OnTapItem = function(data)
    if data and data > 0 and data <= #this.dataCacheList then
        this.selectIndex = data
        this.SetData(false)
    end
end


this.OnBack = function()
    LuaMgr.HidePanel(UIName.DHAllusionViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.levelSV = UIScrollView.New(this.scrollView);
    end,
    
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.AddClick(this.maskBtn, this.OnBack);
        this.eventList = {};
        
        local len = vm.behaviour.Params.Length;
        if (len > 0) then
            local stageId = vm.behaviour.Params[0];
            if ConfigMgr.Config.DHLevelMap[stageId] then
                this.eventList = { ConfigMgr.Config.DHLevelMap[stageId] };
            end
        else

            local lvConfig = ConfigMgr.Config.DHLevelMap;
            local sortedEvents = {}
            for k, v in pairs(lvConfig) do
                if (v.ImgInfo ~= nil) then
                    sortedEvents[v.SortId] = v;
                end
            end
            this.eventList = sortedEvents           
        end
        
        this.selectIndex = 1
        this.SetData(true);
    end,
    
    before_deactive = function(vm)
        LuaMgr.RemoveClick(this.maskBtn, this.OnBack);
        this.levelSV:Clear(true);
    end,
    
    before_destroy = function()
        UIScrollView.ClearItem("DHAllusionItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})