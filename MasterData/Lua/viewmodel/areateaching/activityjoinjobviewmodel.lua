






local this = {
   
};
local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local btnEnter = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    btnEnter = uiLink:Get("btnEnter"):GetComponent("Button");
    uiLink:AddClickEvent("btnEnter",this.BtnEnterCommand)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    btnEnter = nil;

end

this.BtnEnterCommand=function()
    LuaMgr.ShowLuaPanel(UIName.JoinJobTaskViewModel)
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
          
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