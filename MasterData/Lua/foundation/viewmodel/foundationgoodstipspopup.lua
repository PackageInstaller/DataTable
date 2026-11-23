local this = {
    IconPath = "Assets/_BundleResources/Images/ItemIcons/%s",
};

local data = {
    name = "",
    desc = "",
    count = "",
    icon = DefaultTexture,
}

local command = {
    maskBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.FoundationGoodsTipsPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end

        local interactionId  = vm.behaviour.Params[0]
        local config = ConfigFoundationMgr.GetInteractionById(interactionId);
        this.vm.data.name = LuaMgr.GetLangText(config.NameLan)
        this.vm.data.count = string.format(LuaMgr.GetLangText("FoundationGoodsTipsPopup_0"), tostring(PlayerFoundationMgr.GetFurnitureItemCount(config.Furniture)))
        this.vm.data.icon = LuaMgr.GetTexture(string.format(this.IconPath, config.Icon))
        local itemCfg = ConfigHelper.GetItemById(config.Furniture)
        this.vm.data.desc = LuaMgr.GetLangText(itemCfg.DescriptionLan)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})