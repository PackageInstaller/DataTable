local this = {
    vm = nil,
};

local data = {
    rareSprite = DefaultSprite,
    iconSprite = DefaultSprite,
    name = "",
    desc = "",
}

local command = {
    closeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.RogueBuffInfoPopup);
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
        this.buffId = vm.behaviour.Params[0]
        local cfgBuffDes = ConfigMgr.Config.RogueBuffDescMap[this.buffId]
        this.vm.data.rareSprite = LuaMgr.GetSprite("Rogue", "ui_xhyt_csqzxbfd_0" .. cfgBuffDes.BuffQuality)
        this.vm.data.iconSprite = LuaMgr.GetSprite("BuffIcon", cfgBuffDes.BuffIcon)
        this.vm.data.name = LuaMgr.GetLangText(cfgBuffDes.BuffNameLan)
        this.vm.data.desc = LuaMgr.GetLangText(cfgBuffDes.BuffDesLan)
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