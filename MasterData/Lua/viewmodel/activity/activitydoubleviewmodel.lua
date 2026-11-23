






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
local txtRemain = nil;
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
    txtRemain = uiLink:Get("txtRemain"):GetComponent("Text");
    btnGoto = uiLink:Get("btnGoto"):GetComponent("Button");
    uiLink:AddClickEvent("btnGoto",this.BtnGotoExecute)
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
    txtRemain = nil;
    btnGoto = nil;

end



this.BtnGotoExecute=function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.double) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"))
        return
    end
    local panelName=nil;
    for i,v in ipairs(ActivityMgr.activityKeyList) do
        if v.key==ActivityKey.double then
            panelName=v.iconPanel[1];
            break
        end
    end
    if not IsNullOrEmpty(panelName) then
        LuaMgr.ShowLuaPanel(panelName);
    end
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
    local variables=DataExHelper.GetDataExByTag(ActivityKey.double)
    local remainTime=variables.expireTime-LuaMgr.Timestamp();
    if remainTime<0 then remainTime=0 end;
    local d, h, m = GetTimeDHM(remainTime);
    if IsNullOrEmpty(d) then
        d="0";
    end
    textTimer.text=string.format(ConfigMgr.LangGlobal("15506"),d,h,m);
    txtTip.text=ConfigMgr.LangGlobal("10215");
    local doubleID=ActivityMgr.DoubleRewards_ActiveID();
    if doubleID~=nil then
        local  dataDouble=DataMgr.Player.activityDouble[doubleID]
        local strTip=ConfigMgr.LangGlobal("10216")
         txtRemain.text= string.format(strTip,dataDouble.totalTimes-dataDouble.todayUsedTimes)
    end

end


return vm({
    data = data,
    command = command,
    hook = hook
})