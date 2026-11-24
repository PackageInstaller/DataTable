
local this = {

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
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnComfrim = uiLink:Get("btnComfrim"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtDes = uiLink:Get("txtDes"):GetComponent("Text");
    ui.txtButtonName = uiLink:Get("txtButtonName"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end



this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnComfrim",function()
        if this.callBack~=nil then
            this.callBack();
        end
        LuaMgr.HidePanel(UIName.SeasonSlGEventCommonPopupViewModel)
    end)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventCommonPopupViewModel)
    end)

end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>3 then
            ui.txtTitle.text=vm.behaviour.Params[0];
            ui.txtDes.text=vm.behaviour.Params[1];
            ui.txtButtonName.text=vm.behaviour.Params[2];
            this.callBack=vm.behaviour.Params[3]
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