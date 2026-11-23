
local this = {
    vm = nil,
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.txtCancelTip = uiLink:Get("txtCancelTip"):GetComponent("Text");
    ui.btnCancel2 = uiLink:Get("btnCancel2"):GetComponent("Button");
    ui.btnConfrim2 = uiLink:Get("btnConfrim2"):GetComponent("Button");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnCancel2",function()
        if this.cancelCallBack~=nil then
            this.cancelCallBack();
        end
        LuaMgr.HidePanel(UIName.SimulateConfirmTipViewModel)
    end)
    uiLink:AddClickEvent("btnConfrim2",function()
        if this.confirmCallBack~=nil then
            this.confirmCallBack();
        end
        LuaMgr.HidePanel(UIName.SimulateConfirmTipViewModel)
    end)
    
end

local data = {
  
}
local command = {

}
local hook = {
    before_awake = function(vm)
        this.vm = vm;
        print("before_awake");
        this.InitUI(vm.behaviour);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>2 then
                ui.txtCancelTip.text=vm.behaviour.Params[0];
                this.confirmCallBack=vm.behaviour.Params[1];
                this.cancelCallBack=vm.behaviour.Params[2];
            end
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
      
    end,
    before_destroy = function()
        this.ClearUI()
      
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})