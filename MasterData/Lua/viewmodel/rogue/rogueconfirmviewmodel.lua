local this = {
    vm = nil,
    confirmCallBack = nil;
    exitCallBack = nil;
}

local ui = {}

this.InitUI = function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goType1 = uiLink:Get("goType1");
    ui.goType2 = uiLink:Get("goType2");
    ui.goType3 = uiLink:Get("goType3");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    ui.btnConfrim = uiLink:Get("btnConfrim"):GetComponent("Button");
    ui.btnExit = uiLink:Get("btnExit"):GetComponent("Button");
    ui.txtType1Des = uiLink:Get("txtType1Des"):GetComponent("Text");
    ui.txtType2Des = uiLink:Get("txtType2Des"):GetComponent("Text");
    ui.txtType3Des = uiLink:Get("txtType3Des"):GetComponent("Text");
    ui.imgIcon = uiLink:Get("imgIcon"):GetComponent("RawImage");
    ui.txtNum = uiLink:Get("txtNum"):GetComponent("Text");
    ui.txtConfirm = uiLink:Get("txtConfirm"):GetComponent("Text");
    ui.txtExit = uiLink:Get("txtExit"):GetComponent("Text");

    this.AddRegister(uiLink)
end

this.ClearUI = function()
    ui = nil
end

this.AddRegister = function(uiLink)
    uiLink:AddClickEvent("btnConfrim", function()
        LuaMgr.HidePanel(UIName.RogueConfirmViewModel)
        if this.confirmCallBack ~= nil then
            this.confirmCallBack();
        end
    end)
    uiLink:AddClickEvent("btnExit", function()
        LuaMgr.HidePanel(UIName.RogueConfirmViewModel)
        if this.exitCallBack ~= nil then
            this.exitCallBack();
        end
    end)
    uiLink:AddClickEvent("btnClose", function()
        LuaMgr.HidePanel(UIName.RogueConfirmViewModel)
    end)
end

local data = {

}

local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitUI(vm.behaviour)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.confirmCallBack = nil;
        this.exitCallBack = nil;
        if vm.behaviour.Params.Length == 3 then

            this.SetTypeTextInfo1(vm);
        elseif vm.behaviour.Params.Length == 4 then

            this.SetTypeTextInfo3(vm);
        elseif vm.behaviour.Params.Length == 5 then

            this.SetTypeTextInfo2(vm);
        end

    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        this.ClearUI()
        this.vm=nil;
        this = nil
    end,
}

this.SetTypeTextInfo1 = function(vm)
    SetActive(ui.goType1, true);
    SetActive(ui.goType2, false);
    SetActive(ui.goType3, false);
    ui.txtType1Des.text = vm.behaviour.Params[0];
    this.confirmCallBack = vm.behaviour.Params[1];
    this.exitCallBack = vm.behaviour.Params[2];
    ui.txtConfirm.text = LuaMgr.GetLangText("RogueConfirmViewModel_0");
    ui.txtExit.text = LuaMgr.GetLangText("RogueConfirmViewModel_1");
end

this.SetTypeTextInfo2 = function(vm)
    SetActive(ui.goType1, true);
    SetActive(ui.goType2, false);
    SetActive(ui.goType3, false);
    ui.txtType1Des.text = vm.behaviour.Params[0];
    ui.txtConfirm.text = vm.behaviour.Params[1];
    ui.txtExit.text = vm.behaviour.Params[2];
    this.confirmCallBack = vm.behaviour.Params[3];
    this.exitCallBack = vm.behaviour.Params[4];
end

this.SetTypeTextInfo3 = function(vm)
    SetActive(ui.goType1, false);
    SetActive(ui.goType2, false);
    SetActive(ui.goType3, true);
    ui.txtType3Des.text = vm.behaviour.Params[0];
    local item = vm.behaviour.Params[1];
    ui.imgIcon.texture =  GetItemHomeIcon(item[1]);
    ui.txtNum.text = item[2]
    this.confirmCallBack = vm.behaviour.Params[2];
    this.exitCallBack = vm.behaviour.Params[3];
    ui.txtConfirm.text = LuaMgr.GetLangText("RogueConfirmViewModel_0");
    ui.txtExit.text = LuaMgr.GetLangText("RogueConfirmViewModel_1");
end

return vm({
    data = data,
    command = command,
    hook = hook
})