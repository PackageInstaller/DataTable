local this = {
    formulaId = nil,
    isMake = false,
    callBack = nil,
    isAutoSelect = false,
}

local objs = {
    maskBtn = { path = "root/Mask", type = "Button" },
    content = { path = "root/Middle/Group/Content", type = "Text" },
    autoGO = { path = "root/Middle/Group/Auto", type = "GameObject" },
    autoBtn = { path = "root/Middle/Group/Auto", type = "Button" },
    autoSelect = { path = "root/Middle/Group/Auto/Select", type = "GameObject" },
    autoText = { path = "root/Middle/Group/Auto/Text", type = "Text" },
    confirmBtn = { path = "root/Middle/Group/ConfirmBtn", type = "Button" },
    cancelBtn = { path = "root/Middle/Group/CancelBtn", type = "Button" },
}


this.SetData = function()
    local formula = ConfigMgr.Config.FormulaMap[this.formulaId];
    if (formula == nil) then return end
    
    this.content.text = ConfigMgr.LangGlobal(this.isMake and "6964" or "6963");
    SetActive(this.autoGO, formula.AutoAppend);
    this.isAutoSelect = false;
    SetActive(this.autoSelect, this.isAutoSelect);
    this.autoText.text = ConfigMgr.LangGlobal("6965");
end


this.OnClickMask = function()
    LuaMgr.HidePanel(UIName.FoundationMakeConfirmViewModel);
end


this.OnClickAuto = function()
    this.isAutoSelect = not this.isAutoSelect;
    SetActive(this.autoSelect, this.isAutoSelect);
end


this.OnClickConfirm = function()
    this.callBack(this.isAutoSelect);
    LuaMgr.HidePanel(UIName.FoundationMakeConfirmViewModel);
end


this.OnClickCancel = function()
    LuaMgr.HidePanel(UIName.FoundationMakeConfirmViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask);
        LuaMgr.AddClick(this.autoBtn, this.OnClickAuto);
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirm);
        LuaMgr.AddClick(this.cancelBtn, this.OnClickCancel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.formulaId = vm.behaviour.Params[0];
        this.isMake = vm.behaviour.Params[1];
        this.callBack = vm.behaviour.Params[2];
        this.SetData();
    end,
    before_deactive = function(vm)
        this.callBack = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
        LuaMgr.RemoveClick(this.autoBtn, this.OnClickAuto);
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirm);
        LuaMgr.RemoveClick(this.cancelBtn, this.OnClickCancel);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})