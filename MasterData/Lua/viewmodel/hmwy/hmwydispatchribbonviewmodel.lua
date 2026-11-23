local this = {
};


local ui = {}

this.InitUI = function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.imgIcon = uiLink:Get("imgIcon"):GetComponent("Image");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtDes = uiLink:Get("txtDes"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.ScrollbarVertical = uiLink:Get("ScrollbarVertical"):GetComponent("ScrollRect");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister = function(uiLink)
    uiLink:AddClickEvent("btnMask", function()
        LuaMgr.HidePanel(UIName.HMWYDispatchRibbonViewModel);
        if (this.resultData.showEggOnly) then
            return
        end
        LuaMgr.ShowLuaPanel(UIName.HMWYDispatchResultViewModel, this.resultData);
    end)
end




local data = {}
local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length > 0 then
            this.resultData = vm.behaviour.Params[0];
            this.ParseData();
        end
    end,
    before_deactive = function(vm)

    end,
    before_destroy = function()
        this.ClearUI()
    end
}

this.ParseData = function()
    local cfgEvent = ConfigMgr.Config.HmwyDispatchEventCheckMap[this.resultData.eggId]
    if cfgEvent ~= nil then
        ui.imgIcon.sprite = LuaMgr.GetSprite("HMWY", cfgEvent.EggImage)
        ui.txtTitle.text = LuaMgr.GetLangText(cfgEvent.EggTitleLan)
        ui.txtDes.text = LuaMgr.GetLangText(cfgEvent.EggCopytLan)
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})