
local this = {

};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnComfrim = uiLink:Get("btnComfrim"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtInfo = uiLink:Get("txtInfo"):GetComponent("Text");
    ui.txtRank = uiLink:Get("txtRank"):GetComponent("Text");
    ui.text = uiLink:Get("text"):GetComponent("Text");
    ui.sliderProgress = uiLink:Get("sliderProgress"):GetComponent("Slider");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end



this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventBoss2PopupViewModel);
    end)

    uiLink:AddClickEvent("btnComfrim",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventBoss2PopupViewModel);
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBoss2PopupInfoViewModel,this.eventType,this.gridBossId);
    end)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)

    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>1 then
            this.eventType=vm.behaviour.Params[0]
            this.gridBossId=vm.behaviour.Params[1]
            this.cfgGridBoss=ConfigMgr.Config.SeasonalGridBOSSMap[this.gridBossId]
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end

    end,
    before_destroy = function()
        this.ClearUI();
    end
}

this.ParseData=function()
    ui.txtTitle.text=string.format(LuaMgr.GetLangText("SeasonSlGEventBoss2PopupViewModel_0"),LuaMgr.GetLangText(this.cfgGridBoss.NameLan));
    local info1=string.format(LuaMgr.GetLangText("SeasonSlGEventBoss2PopupViewModel_1"),LuaMgr.GetLangText(this.cfgGridBoss.NameLan))
    local info2=string.format(LuaMgr.GetLangText("SeasonSlGEventBoss2PopupViewModel_2"),LuaMgr.GetLangText(this.cfgGridBoss.NameLan))

    local challengeProgress=SeasonSLGMapMgr.GetBoss2ChallengeProgress();
    local seasonalBossHeatTipProgress=SeasonSLGMapMgr.Constants().SeasonalBossHeatTipProgress
    if seasonalBossHeatTipProgress==nil then
        seasonalBossHeatTipProgress=50000;
    end
    ui.txtInfo.text=challengeProgress>=seasonalBossHeatTipProgress and info1 or info2 ;
    local limit=SeasonSLGMapMgr.Constants().SeasonalBossHeatMax
    local progress=challengeProgress/(limit[1]*limit[2]);
    ui.sliderProgress.value= progress;
    ui.txtRank.text=SeasonSLGEventMgr.GetProgressName(challengeProgress)
end

return vm({
    data = data,
    command = command,
    hook = hook
})