require("Foundation/ViewModel/FoundationQuickSetItem")
require("Foundation/ViewModel/FoundationQuickSetItemGroup")

local this = {
    quickSetSV = nil,
}

local objs = {
    maskBtn = { path = "root/Mask", type = "Button" },
    theme = { path = "root/Middle/QuickSet/Theme/Text", type = "Text" },
    themeCount = { path = "root/Middle/QuickSet/Theme/Count/Text", type = "Text" },
    comfort = { path = "root/Middle/QuickSet/Comfort/Text", type = "Text" },
    furnitureItemGroup = { path = "template/FurnitureItemGroup", type = "GameObject" },
    furnitureItem = { path = "template/FurnitureItem", type = "GameObject" },
    scrollView = { path = "root/Middle/QuickSet/ScrollView", type = "GameObject" },
    setBtn = { path = "root/Middle/QuickSet/Set", type = "Button" },
}


this.SetData = function()
    local roomId = FoundationMgr.GetRoomId();
    local themeId = FoundationMgr.GetThemeId(roomId);
    local styleConfig = ConfigMgr.Config.RoomStyleMap[themeId];
    if (styleConfig == nil) then return end
    
    this.theme.text = LuaMgr.GetLangText(styleConfig.NameLan);
    local putCount, maxCount = FoundationMgr.GetThemePutCount(styleConfig.Roomputid);
    this.themeCount.text = string.format("%d/%d", putCount, maxCount);
    local comfort = ConfigFoundationMgr.GetThemeFurnitureComfort(styleConfig.Roomputid);
    this.comfort.text = tostring(comfort);
    this.SetQuickSetList(styleConfig.Roomputid);
end


this.SetQuickSetList = function(roomPutId)
    local quickSet;
    local groupData;
    local scrollData;
    this.quickSetSV:Clear(false);
    local scrollDatas = {};
    local putList = ConfigFoundationMgr.GetStylePutList(roomPutId);
    local len = #putList;
    local index = 1;
    while (index <= len) do
        groupData = {};
        groupData.item = this.furnitureItem;
        quickSet = putList[index];
        if (quickSet ~= nil) then
            groupData.quickSet1 = quickSet;
        end
        quickSet = putList[index + 1];
        if (quickSet ~= nil) then
            groupData.quickSet2 = quickSet;
        end
        scrollData = UIScrollData.GetData(this.furnitureItemGroup, "FoundationQuickSetItemGroup", 256, 280, groupData);
        table.insert(scrollDatas, scrollData);
        index = index + 2;
    end
    this.quickSetSV:SetParams(930, 280);
    this.quickSetSV:SetData(scrollDatas, true);
end


this.OnClickMask = function()
    LuaMgr.HidePanel(UIName.FoundationQuickSetViewModel);
end


this.OnClickSet = function()
    FoundationRoom.ClearAll();
    FoundationRoom.PutFurniture();
    LuaMgr.HidePanel(UIName.FoundationQuickSetViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.quickSetSV = UIScrollView.New(this.scrollView);
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask);
        LuaMgr.AddClick(this.setBtn, this.OnClickSet);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.SetData();
    end,
    before_deactive = function(vm)
        this.quickSetSV:Clear(true);
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
        LuaMgr.RemoveClick(this.setBtn, this.OnClickSet);
        UIScrollView.ClearItem("FoundationQuickSetItemGroup");
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})