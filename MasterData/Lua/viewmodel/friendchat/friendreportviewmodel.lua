






local this = {vm = nil}
local callBack=nil;
local maxReported=nil;
local curReported=nil;

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local btnClose = nil;
local btnConfirm = nil;
local btnCance = nil;
local txtReportName = nil;
local txtDayRepotCount = nil;
local toggleAdver = nil;
local toggleOutRule = nil;
local toggleAbuseAndYellow = nil;
local toggleCheat = nil;
local toggleSensitive = nil;
local toggleSwindle = nil;
local toggleOther = nil;
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
    txtReportName = uiLink:Get("txtReportName"):GetComponent("Text");
    txtDayRepotCount = uiLink:Get("txtDayRepotCount"):GetComponent("Text");
    toggleAdver = uiLink:Get("toggleAdver"):GetComponent("Toggle");
    toggleOutRule = uiLink:Get("toggleOutRule"):GetComponent("Toggle");
    toggleAbuseAndYellow = uiLink:Get("toggleAbuseAndYellow"):GetComponent("Toggle");
    toggleCheat = uiLink:Get("toggleCheat"):GetComponent("Toggle");
    toggleSensitive = uiLink:Get("toggleSensitive"):GetComponent("Toggle");
    toggleSwindle = uiLink:Get("toggleSwindle"):GetComponent("Toggle");
    toggleOther = uiLink:Get("toggleOther"):GetComponent("Toggle");
    inputContent = uiLink:Get("inputContent"):GetComponent("InputField");
    uiLink:AddClickEvent("btnCance",function()
        LuaMgr.HidePanel(UIName.FriendReportViewModel)
    end)
    uiLink:AddClickEvent("btnClose",function()
        LuaMgr.HidePanel(UIName.FriendReportViewModel)
    end)
    uiLink:AddClickEvent("btnConfirm",function()
        this.ReportCommit();
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
    txtReportName = nil;
    txtDayRepotCount = nil;
    toggleAdver = nil;
    toggleOutRule = nil;
    toggleAbuseAndYellow = nil;
    toggleCheat = nil;
    toggleSensitive = nil;
    toggleSwindle = nil;
    toggleOther = nil;
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
        local name=vm.behaviour.Params[0];
         maxReported=ConfigMgr.Config.FriendConstants.MaxReported
         curReported=DataMgr.Player.Friends.DailyReport;
        txtDayRepotCount.text=string.format("%s/%s",curReported,maxReported);
        txtReportName.text=name;
        callBack=vm.behaviour.Params[1];
        this.ResetToggles()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
}

this.ResetToggles=function()
    toggleAdver.isOn=false;
    toggleOutRule.isOn=false;
    toggleAbuseAndYellow.isOn=false;
    toggleCheat.isOn=false;
    toggleSensitive.isOn=false;
    toggleSwindle.isOn=false;
    toggleOther.isOn=false;
    inputContent.text="";
end


this.ReportCommit=function()
    if curReported>=maxReported then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("17004"))
        return
    end
    local askData={}
    if toggleAdver.isOn then
        table.insert(askData,"1");
    end
    if toggleOutRule.isOn then
        table.insert(askData,"2");
    end
    if toggleAbuseAndYellow.isOn then
        table.insert(askData,"3");
    end
    if toggleCheat.isOn then
        table.insert(askData,"4");
    end
    if toggleSensitive.isOn then
        table.insert(askData,"5");
    end
    if toggleSwindle.isOn then
        table.insert(askData,"6");
    end
    if toggleOther.isOn then
        table.insert(askData,"7");
    end
    if #askData==0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("17001"))
        return;
    end
    callBack(askData,inputContent.text)
    LuaMgr.HidePanel(UIName.FriendReportViewModel)
end

return vm({
    data = data,
    command = command,
    hook = hook
})