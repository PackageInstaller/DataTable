local this = {
    vm = nil,
};

local data = {
    cardTexture = DefaultSprite,
    name = "",
    desc = "",
}

local command = {
    closeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.MiniBattle3BuffCardInfoPopup)
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
        local cardId = vm.behaviour.Params[0]
        local cardInfo = MiniBattle3Mgr.GetBuffCardInfo(cardId)
        this.vm.data.name = cardInfo.name
        this.vm.data.desc = cardInfo.desc
        this.vm.data.cardTexture = cardInfo.icon
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

this.Refresh = function()

end

return vm({
    data = data,
    command = command,
    hook = hook
})