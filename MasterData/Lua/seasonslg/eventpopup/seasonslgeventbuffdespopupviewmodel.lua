
local this = {

};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.txtBuffName = uiLink:Get("txtBuffName"):GetComponent("Text");
    ui.txtBuffDes = uiLink:Get("txtBuffDes"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.imgBuffIcon = uiLink:Get("imgBuffIcon"):GetComponent("Image");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventBuffDesPopUpViewModel);
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
        if vm.behaviour.Params.Length>0 then
            this.buffId=vm.behaviour.Params[0];
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
    local seasonalBuff=ConfigMgr.Config.SeasonalBuffMap[this.buffId];
    if seasonalBuff~=nil then
        ui.txtBuffName.text=LuaMgr.GetLangText(seasonalBuff.BuffNameLan)
        ui.txtBuffDes.text=LuaMgr.GetLangText(seasonalBuff.BuffDesLan)
        ui.imgBuffIcon.sprite=LuaMgr.GetSprite("BuffIcon", seasonalBuff.BuffIcon);
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})