
local this = {
    vm = nil,

};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.Middle = uiLink:Get("Middle");
    ui.btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    ui.imgRare = uiLink:Get("imgRare"):GetComponent("Image");
    ui.imgIcon = uiLink:Get("imgIcon"):GetComponent("Image");
    ui.txtName = uiLink:Get("txtName"):GetComponent("Text");
    ui.txtDes = uiLink:Get("txtDes"):GetComponent("Text");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end



this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnClose",function()
        LuaMgr.HidePanel(UIName.RogueExploreBuffInfoViewModel)
    end)
end


local data = {

}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        RedMgr.Singleton:RegisterViewModel(UIName.KZRYExploreViewModel);
        print("before_awake");
        this.InitUI(vm.behaviour)
      
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>1 then
                this.buffId=vm.behaviour.Params[0];
                this.callBack=vm.behaviour.Params[1];
                this.ParseData();
            end
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if this.callBack~=nil then
            this.callBack();
        end
    end,
    before_destroy = function()
        this.ClearUI()
    end
}

this.ParseData=function()
    local cfgBuffDes=ConfigMgr.Config.RogueBuffDescMap[this.buffId]
    if cfgBuffDes==nil then 
        LuaDebug.error("cfgBuffDes is nil");
        return
    end;
    ui.imgRare.sprite=LuaMgr.GetSprite("Rogue","ui_xhyt_csqzxbfd_0"..cfgBuffDes.BuffQuality);
    ui.imgIcon.sprite=LuaMgr.GetSprite("BuffIcon",cfgBuffDes.BuffIcon);
    ui.txtName.text=LuaMgr.GetLangText(cfgBuffDes.BuffNameLan);
    ui.txtDes.text=LuaMgr.GetLangText(cfgBuffDes.BuffDesLan);
end

return vm({
    data = data,
    command = command,
    hook = hook
})