






local this = {
    vm=nil,
   
};

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local btnGoto = nil;
local textTime = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    btnGoto = uiLink:Get("btnGoto"):GetComponent("Button");
    textTime = uiLink:Get("textTime"):GetComponent("Text");
    
    uiLink:AddClickEvent("btnGoto",function()
        LuaMgr.ShowLuaPanel(UIName.WalkMountMainViewModel);
    end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    btnGoto = nil;
    textTime = nil;

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
           this.ParseData();
        end
    end,
    before_deactive = function(vm)
       
    end,
    before_destroy=function()
       
    end
        
    
}

this.ParseData=function()
    local variables=DataExHelper.GetDataExByTag(ActivityKey.walkmount)
    local startTimeStr = os.date(LuaMgr.GetLangText("WalkMountActivityViewModel_0"),variables.startTime)
    local delayTimeStr = os.date(LuaMgr.GetLangText("WalkMountActivityViewModel_1"),variables.expireTime)
    textTime.text = string.format("%s-%s",startTimeStr,delayTimeStr)
end


return vm({
    data = data,
    command = command,
    hook = hook
})