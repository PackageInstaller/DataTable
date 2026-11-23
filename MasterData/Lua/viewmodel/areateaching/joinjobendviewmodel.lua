






local this = {
   
};
local data={}
local command={}

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local btnMask = nil;
local textTip = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    textTip = uiLink:Get("textTip"):GetComponent("Text");
    uiLink:AddClickEvent("btnMask",this.BtnMaskCommand);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    btnMask = nil;
    textTip = nil;

end


this.BtnMaskCommand=function()
    LuaMgr.HidePanel(UIName.JoinJobEndViewModel)
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            textTip.text=ConfigMgr.LangGlobal("12004")
        end
    end,
    before_deactive = function(vm)
      
    end,
    before_destroy=function()
        this.Clear()
    end
}



return vm({
    data = data,
    command = command,
    hook = hook
})