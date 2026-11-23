
local this = {
};



local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.txtTime = uiLink:Get("txtTime"):GetComponent("Text");
    ui.btnGoto = uiLink:Get("btnGoto"):GetComponent("Button");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
   uiLink:AddClickEvent("btnGoto",function()
       if this.CheckTRJActiveTime() then
           LuaMgr.ShowLuaPanel(UIName.TRJMainViewModel)
       end
   end)
end

this.CheckTRJActiveTime=function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.ZNHD) then

        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"))
        return false;
    end
    return true;
end


local data = {}
local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour);
      
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.ParseData();
    end,
    before_deactive = function(vm)
        
    end,
    before_destroy = function()
        this.ClearUI()
     
    end
}
this.ParseData=function()
    local var=DataExHelper.GetDataExByTag(ActivityKey.ZNHD)
    local time = var.expireTime - LuaMgr.Timestamp()
    if time<0 then
        time=0;
    end
    local d, h, m = GetTimeDHM(time)
    local timeStr = ""
    if not IsNullOrEmpty(d) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"))
    end
    if not IsNullOrEmpty(h) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"))
    end
    if not IsNullOrEmpty(m) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"))
    end
    ui.txtTime.text=timeStr;
end


return vm({
    data = data,
    command = command,
    hook = hook
})