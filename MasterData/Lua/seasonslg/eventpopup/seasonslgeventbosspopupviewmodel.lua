
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
    ui.btnRank = uiLink:Get("btnRank"):GetComponent("Button");
    ui.btnComfrim = uiLink:Get("btnComfrim"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtScore = uiLink:Get("txtScore"):GetComponent("Text");
    ui.txtRank = uiLink:Get("txtRank"):GetComponent("Text");
    ui.text = uiLink:Get("text"):GetComponent("Text");

    this.AddRegister(uiLink)
end

this.ClearUI = function()
    ui = nil
end




this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventBossPopupViewModel);
    end)
    uiLink:AddClickEvent("btnRank",function()

        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventBossPopupViewModel_0"));
    end)

    uiLink:AddClickEvent("btnComfrim",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventBossPopupViewModel);
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBossPopupInfoViewModel,this.eventType,this.gridBossId);
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
    ui.txtTitle.text=string.format(LuaMgr.GetLangText("SeasonSlGEventBossPopupViewModel_1"),LuaMgr.GetLangText(this.cfgGridBoss.NameLan))
    local rankData=SeasonSLGEventMgr.bossRankMap[tostring(SeasonSLGEventMgr.curGridIndex)]
    if rankData~=nil then
        ui.txtScore.text=rankData.Score;
        ui.txtRank.text=rankData.Rank;
    else
        ui.txtScore.text="0";
        ui.txtRank.text=LuaMgr.GetLangText("SeasonSlGEventBossPopupViewModel_2");
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})