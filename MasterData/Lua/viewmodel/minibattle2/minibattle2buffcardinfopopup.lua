local this = {
    vm=nil,
    canAchieveIds = {},
};

local data = {
    cardTexture = DefaultTexture,
    kuang_1 = false,
    kuang_2 = false,
    name = "",
    desc = "",
}

local command = {
    closeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.HidePanel(UIName.MiniBattle2BuffCardInfoPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        local cardId = vm.behaviour.Params[0]
        local cardInfo = MiniBattle2Mgr.GetBuffCardInfo(cardId)
        this.vm.data.name = cardInfo.name
        this.vm.data.desc = cardInfo.desc
        this.vm.data.cardTexture = cardInfo.icon
        this.vm.data.kuang_1 = cardInfo.quality == 0
        this.vm.data.kuang_2 = cardInfo.quality == 1
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    before_destroy=function(vm)
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