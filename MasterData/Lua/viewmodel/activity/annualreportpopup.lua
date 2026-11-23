





local this = {
    vm = nil,
}

local data = {

}

local command = {
    gotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if IsNullOrEmpty(ConfigMgr.Config.constants.AnnualReport) then
                return
            end
            LuaMgr.OpenURL(ConfigMgr.Config.constants.AnnualReport)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.InitParameter = function()
    local isShow = RedMgr.Singleton:CheckRedCondition("17652")
    if not isShow then
        return
    end
    RedMgr.Singleton:FrushRedCondition("17652")
    HeroRedDataHelper.SetAnnualReportRed()
    RedMgr.Singleton:Refresh();
end

return vm({
    data = data,
    command = command,
    hook = hook
})