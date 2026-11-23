local this = {
    vm = nil,
}


local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local btnMask = nil;
local btnConfrim = nil;
local txtDes = nil;
local text = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnConfrim = uiLink:Get("btnConfrim"):GetComponent("Button");
    txtDes = uiLink:Get("txtDes"):GetComponent("Text");
    text = uiLink:Get("text"):GetComponent("Text");
    uiLink:AddClickEvent("btnConfrim", function()
        LuaMgr.HidePanel(UIName.AreaMapNovelModelTipViewModel);
    end)
    uiLink:AddClickEvent("btnMask", function()
        LuaMgr.HidePanel(UIName.AreaMapNovelModelTipViewModel);
    end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    btnMask = nil;
    btnConfrim = nil;
    txtDes = nil;
    text = nil;

end


local command = {
}
local data={
    
}
local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.Init(vm.behaviour);
    end,
    before_active = function(vm)
        if (this.vm.behaviour.Params == nil) then
            txtDes.text=ConfigMgr.LangGlobal("23680");
            return
        end
      
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
    end,
}


return vm({
    data = data,
    command = command,
    hook = hook
})