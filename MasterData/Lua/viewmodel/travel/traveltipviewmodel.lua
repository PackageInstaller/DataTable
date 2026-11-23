






local this = {
    vm=nil,
   
};

local cokey=nil;

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goTip3 = nil;
local goTip2 = nil;
local goTip1 = nil;
local Right = nil;
local textTip = nil;


 this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goTip3 = uiLink:Get("goTip3");
    goTip2 = uiLink:Get("goTip2");
    goTip1 = uiLink:Get("goTip1");
    Right = uiLink:Get("Right");
    textTip = uiLink:Get("textTip"):GetComponent("Text");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    goTip3 = nil;
    goTip2 = nil;
    goTip1 = nil;
    Right = nil;
    textTip = nil;

end



local data = {
}


local command = {
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
      
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>0 then
                local type=vm.behaviour.Params[0]
                if not LuaMgr.IsPanelOpen("MainPageViewModel") then
                    LuaMgr.HidePanel(UIName.TravelTipViewModel);
                end
                this.ParseData(type);
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end;
        if cokey~=nil then
            coroutine_runner.stop(cokey);
        end
    end,
    before_destroy=function()
       this.Clear();
    end
        
    
}

this.ParseData=function(type)
    local cfgTip=ConfigMgr.Config.TravelTipsMap[type];
    if cfgTip~=nil then
        textTip.text=LuaMgr.GetLangText(cfgTip.TravelMessageLan);
    end
    LuaMgr.NextFrame(function()
        RectTransformTool.RebuildLayoutImmediate(textTip.transform.parent);
    end)
    local closeTime=ConfigMgr.Config.TravelConstants.CloseTips;
    cokey=coroutine_runner.start(function()
        coroutine_runner.wait(closeTime)
        LuaMgr.HidePanel(UIName.TravelTipViewModel);
    end)
end


return vm({
    data = data,
    command = command,
    hook = hook
})