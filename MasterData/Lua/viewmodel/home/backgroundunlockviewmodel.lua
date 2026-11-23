local this = { 
    vm = nil,
    bgId = nil,
    selecIndex = 1,
}

local data = {
    title = "",
    selectDatas = {{id = "",isLight = false,itemName = "",itemCount = 0,rare = DefaultSprite,icon = DefaultTexture}},
}


this.SetItems = function()
    local list = {};
    local bgConfig = ConfigMgr.Config.BGSwitchMap[this.bgId];
    if (bgConfig ~= nil) then
        local itemData = this.GetItemData(bgConfig.UnlockItem1);
        if (itemData ~= nil) then
            table.insert(list, itemData);
        end
        itemData = this.GetItemData(bgConfig.UnlockItem2);
        if (itemData ~= nil) then
            table.insert(list, itemData);
        end
    end
    this.vm.data.selectDatas = list;
    this.SelectItem(1);
end


this.GetItemData = function(unlockItem)
    if (#unlockItem <= 0) then return nil end
    
    local itemConfig = ConfigMgr.Config.itemMap[unlockItem[1]];
    if (itemConfig == nil) then return nil end

    local itemCount = PlayerItemMgr.GetItemCountById(itemConfig.id);
    local needCount = tonumber(unlockItem[2]);
    local countStr = "";
    if (itemCount >= needCount) then
        countStr = string.format("<color=#32d9ce>%s</color>/<color=#c1c0c0>%s</color>", itemCount, needCount);
    else
        countStr = string.format("<color=#c31f36>%s</color>/<color=#c1c0c0>%s</color>", itemCount, needCount);
    end
    local itemData = {id = itemConfig.id,
                      isLight = false,
                      itemName = LuaMgr.GetLangText(itemConfig.nameLan),
                      itemCount = countStr,
                      needCount = needCount,
                      rare = LuaMgr.GetSprite("ItemRare", "itemRare" .. itemConfig.rare),
                      icon = LuaMgr.GetTexture("Images/ItemIcons/itemicon_" .. itemConfig.id .. ".png")};
    return itemData;
end


this.UnlockBgImage = function(bgImageId, itemId, count)
    ApiMgr.Request("unlock_bg_image", {bgImageId=bgImageId,itemId=itemId,count=count}, true, this.UnlockBgImageResponse, nil, true, true);
end


this.UnlockBgImageResponse = function(result)
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15964"));
    LuaMgr.HidePanel(UIName.BackgroundUnlockViewModel);
    LuaMgr.InvokeUIEventListeners(UIEventConst.SelectCharacterRefreshBg, this.bgId);
end


this.SelectItem = function(index)
    local len = #this.vm.data.selectDatas;
    if (this.selecIndex <= len) then
        this.vm.data.selectDatas[this.selecIndex].isLight = false;
    end
    this.selecIndex = index;
    this.vm.data.selectDatas[this.selecIndex].isLight = true;
end

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.BackgroundUnlockViewModel);
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local itemData = this.vm.data.selectDatas[this.selecIndex];
            this.UnlockBgImage(this.bgId, itemData.id, itemData.needCount);
        end
    },
    itemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SelectItem(1 + param);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.bgId = vm.behaviour.Params[0];
        this.vm.data.title = ConfigMgr.LangGlobal("15962");
        this.SetItems();
    end,
    before_deactive = function(vm)
        
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})