






local this = {vm = nil}


local callBack=nil;


local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local btnClose = nil;
local btnConfirm = nil;
local btnCance = nil;
local txtTitle = nil;
local inputContent = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    btnConfirm = uiLink:Get("btnConfirm"):GetComponent("Button");
    btnCance = uiLink:Get("btnCance"):GetComponent("Button");
    txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    inputContent = uiLink:Get("inputContent"):GetComponent("InputField");
    uiLink:AddClickEvent("btnCance",function()
        LuaMgr.HidePanel(UIName.CommonInputViewModel)
    end)
    uiLink:AddClickEvent("btnClose",function()
        LuaMgr.HidePanel(UIName.CommonInputViewModel)
    end)
    uiLink:AddClickEvent("btnConfirm",function()
         local value=inputContent.text
        if callBack~=nil then
            callBack(value);
        end
    end)
    
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    btnClose = nil;
    btnConfirm = nil;
    btnCance = nil;
    txtTitle = nil;
    inputContent = nil;

end



local data = {
}

local command = {
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.Init(vm.behaviour);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        local title=vm.behaviour.Params[0];
        callBack=vm.behaviour.Params[1]
        inputContent.text="";
        txtTitle.text=title;
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
}



return vm({
    data = data,
    command = command,
    hook = hook
})