
local this = {
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.Middle = uiLink:Get("Middle");
    ui.Right = uiLink:Get("Right");
    ui.txtTime = uiLink:Get("txtTime"):GetComponent("Text");
    ui.btnRotate = uiLink:Get("btnRotate"):GetComponent("Button");
    ui.btnGift = uiLink:Get("btnGift"):GetComponent("Button");
    ui.btnPay = uiLink:Get("btnPay"):GetComponent("Button");
    ui.btnPuzzle = uiLink:Get("btnPuzzle"):GetComponent("Button");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end



this.AddRegister=function(uiLink)
   uiLink:AddClickEvent("btnPuzzle",function()
       if this.CheckTRJActiveTime() then
           LuaMgr.ShowLuaPanel(UIName.TRJMainPuzzleViewModel)
       end
   end)
    uiLink:AddClickEvent("btnGift",function()
        if this.CheckTRJActiveTime() then
            LuaMgr.ShowLuaPanel(UIName.TRJCheckInViewModel);
        end
    end)
    uiLink:AddClickEvent("btnPay",function()
        if this.CheckTRJActiveTime() then
            LuaMgr.ShowLuaPanel(UIName.TRJMarketPayViewModel)
        end
    end)
    uiLink:AddClickEvent("btnRotate",function()
        if this.CheckTRJActiveTime() then
            LuaMgr.ShowLuaPanel(UIName.TRJRouletteViewModel)
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
        RedMgr.Singleton:RegisterViewModel(UIName.TRJMainViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        HeroRedDataHelper.CheckTRJRed();
        this.ParseData();
    end,
    before_deactive = function(vm)
        
    end,
    before_destroy = function()
        this.ClearUI()
     
    end
}
this.OnBack=function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.ZNHD) then
        LuaMgr.Back();
    else
        LuaMgr.Back(ActivityKey.ZNHD);
    end
end
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