require("Foundation/ViewModel/FoundationThemeItem")
require("Foundation/ViewModel/FoundationThemeItemGroup")

local this = {
    themeSV = nil,
    themeGroupDatas = nil,
}

local objs = {
    maskBtn = { path = "root/Mask", type = "Button" },
    themeItemGroup = { path = "template/ThemeItemGroup", type = "GameObject" },
    themeItem = { path = "template/ThemeItem", type = "GameObject" },
    scrollView = { path = "root/Middle/Theme/ScrollView", type = "GameObject" },
    changeBtn = { path = "root/Middle/Theme/Change", type = "Button" },
    changeLock = { path = "root/Middle/Theme/Change/Lock", type = "GameObject" },
}


this.SetThemeList = function()
    local groupData;
    local scrollData;
    this.themeSV:Clear(false);
    local scrollDatas = {};
    local roomId = FoundationMgr.GetRoomId();
    local themeId = FoundationMgr.GetThemeId(roomId);
    FoundationMgr.SetSelectTheme(themeId);
    this.themeGroupDatas = {};
    local roomStyleList = ConfigFoundationMgr.GetRoomStyleList();
    local len = #roomStyleList;
    if (len <= 0) then return end

    local style = roomStyleList[1];
    SetActive(this.changeLock, style.Id == themeId);
    local index = 1;
    while (index <= len) do
        groupData = {};
        groupData.item = this.themeItem;
        style = roomStyleList[index];
        if (style ~= nil) then
            groupData.theme1 = style;
        end
        style = roomStyleList[index + 1];
        if (style ~= nil) then
            groupData.theme2 = style;
        end
        scrollData = UIScrollData.GetData(this.themeItemGroup, "FoundationThemeItemGroup", 350, 370, groupData);
        table.insert(scrollDatas, scrollData);
        index = index + 2;
        table.insert(this.themeGroupDatas, groupData);
    end
    this.themeSV:SetParams(930, 370);
    this.themeSV:SetData(scrollDatas, true);
    this.MoveToTheme();
end


this.MoveToTheme = function()
    local groupData;
    local themeId = FoundationMgr.GetSelectTheme();
    local len = #this.themeGroupDatas;
    for i = 1, len do
        groupData = this.themeGroupDatas[i];
        if (groupData.theme1 ~= nil and groupData.theme1.Id == themeId) then
            this.themeSV:MoveToIndex(i, false);
            return;
        end
        if (groupData.theme2 ~= nil and groupData.theme2.Id == themeId) then
            this.themeSV:MoveToIndex(i, false);
            return;
        end
    end
end


this.OnClickMask = function()
    LuaMgr.HidePanel(UIName.FoundationThemeViewModel);
end


this.OnClickChange = function()
    local roomId = FoundationMgr.GetRoomId();
    local originId = FoundationMgr.GetThemeId(roomId);
    local themeId = FoundationMgr.GetSelectTheme();
    if (originId == themeId) then return end

    local styleConfig = ConfigMgr.Config.RoomStyleMap[themeId];
    local msg = string.format(LuaMgr.GetLangText("RoomViewModel_21"), LuaMgr.GetLangText(styleConfig.NameLan));
    LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, msg, this.OnThemeConfirm, this.OnThemeCancel);
end


this.OnThemeConfirm = function()
    local theme = FoundationMgr.GetSelectTheme();
    local roomId = FoundationMgr.GetRoomId();
    PlayerFoundationMgr.SetStyle(roomId, theme, this.OnStyleResponse);
end


this.OnThemeCancel = function()
end


this.OnStyleResponse = function()
    LuaMgr.HidePanel(UIName.FoundationThemeViewModel);
    LuaMgr.ShowLuaPanel(UIName.FoundationTransitionViewModel, this.OnSwitchRoom);
end


this.OnSwitchRoom = function()
    FoundationRoomCtrl.ExitEdit();
    FoundationRoom.Clear();
    PlayerFoundationMgr.InitFurnitureItems();
    FoundationRoom.Show();
    LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationRoomFurnitureChange);
    LuaMgr.InvokeUIEventListeners(UIEventConst.FoundationRoomSkinChange);
end


this.OnClickTheme = function(args)
    local data = args[0];
    local theme = FoundationMgr.GetSelectTheme();
    if (data.Id == theme) then return end
    
    FoundationMgr.SetSelectTheme(data.Id);
    local roomId = FoundationMgr.GetRoomId();
    local themeId = FoundationMgr.GetThemeId(roomId);
    SetActive(this.changeLock, data.Id == themeId);
    this.themeSV:Refresh();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.themeSV = UIScrollView.New(this.scrollView);
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask);
        LuaMgr.AddClick(this.changeBtn, this.OnClickChange);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.FoundationThemeClick, this.OnClickTheme);
        this.SetThemeList();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationThemeClick, this.OnClickTheme);
        this.themeSV:Clear(true);
        this.themeGroupDatas = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
        LuaMgr.RemoveClick(this.changeBtn, this.OnClickChange);
        UIScrollView.ClearItem("FoundationThemeItemGroup");
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})