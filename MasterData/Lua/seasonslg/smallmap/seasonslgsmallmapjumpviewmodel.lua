
local this = {vm = nil}


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnJump = uiLink:Get("btnJump"):GetComponent("Button");
    ui.txtName = uiLink:Get("txtName"):GetComponent("Text");
    ui.txtDes = uiLink:Get("txtDes"):GetComponent("Text");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask", function()
      LuaMgr.HidePanel(UIName.SeasonSLGSmallMapJumpViewModel);
    end)
    uiLink:AddClickEvent("btnJump", function()
        if this.callBack~=nil then
            this.callBack();
        end
        LuaMgr.HidePanel(UIName.SeasonSLGSmallMapJumpViewModel);
    end)
end

local data = {

}

local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitUI(vm.behaviour)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>=3 then
            ui.txtName.text=vm.behaviour.Params[0];
            ui.txtDes.text=vm.behaviour.Params[1];
            this.callBack=vm.behaviour.Params[2];
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end

    end,
    before_destroy = function()
        this.ClearUI();
    end
}


return vm({
    data = data,
    command = command,
    hook = hook
})