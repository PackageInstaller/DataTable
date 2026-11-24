
local this = {

};




this.AddRegister=function(uiLink)




end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.animator= vm.behaviour.transform:Find("root/Middle/anim"):GetComponent("Animator")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.animator:Play("Cutin_SeasonSLGMap_ani_born")
        LuaMgr.AddUIEventListener(UIEventConst.SeasonCutIn, this.ClosePanel);
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUIEventListener(UIEventConst.SeasonCutIn, this.ClosePanel);
    end,
    before_destroy = function()
    end
}



this.ClosePanel=function()
    coroutine_runner.start(function()
        this.animator:Play("Cutin_SeasonSLGMap_ani_ending")
        coroutine_runner.wait(1)
        LuaMgr.HidePanel(UIName.SeasonSLGCutInViewModel);
    end)
end



return vm({
    data = data,
    command = command,
    hook = hook
})