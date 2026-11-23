






local this = {
    vm=nil,
   
};

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local textTimer = nil;
local txtTip = nil;
local btnGoto = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    textTimer = uiLink:Get("textTimer"):GetComponent("Text");
    txtTip = uiLink:Get("txtTip"):GetComponent("Text");
    btnGoto = uiLink:Get("btnGoto"):GetComponent("Button");
    uiLink:AddClickEvent("btnGoto",function()
        if not DataExHelper.Check_LuckDrawRunning() then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"))
            return
        end
        LuaMgr.ShowLuaPanel(UIName.LuckyDrawViewModel);
    end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    textTimer = nil;
    txtTip = nil;
    btnGoto = nil;

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
    local variables=DataExHelper.GetDataExByTag(ActivityKey.draw)
    local remainTime=variables.expireTime-LuaMgr.Timestamp();
    if remainTime<0 then remainTime=0 end;
    local d, h, m = GetTimeDHM(remainTime);
    if IsNullOrEmpty(d) then
        d="0";
    end
    textTimer.text=string.format(ConfigMgr.LangGlobal("15506"),d,h,m);
    txtTip.text=ConfigMgr.LangGlobal("10213");

end


return vm({
    data = data,
    command = command,
    hook = hook
})