local data = {};

local this = {
    uiContainer = nil,
};

local command = {

}

local hook = {
    before_awake = function(vm)
        this.uiContainer = vm.behaviour.transform:Find("root/Middle/Container");
        FoundationBuildingMgr.SetUIContainer(this.uiContainer);
        FoundationCharacterMgr.SetUIContainer(this.uiContainer);
        FoundationOutside.SetUIContainer(this.uiContainer);
        FoundationRoomCtrl.SetUIContainer(this.uiContainer);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
    end,
    before_deactive = function(vm)

    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})