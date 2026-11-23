







ConfirmCommonPanel = {}
ConfirmCommonPanel.MsgBoxType = {
TextButton = 1,
ImageButton = 2
}

ConfirmCommonPanel.BtnType = {
    Confirm = 1,
    Cancel = 2,
    Center = 3
}

local objs = {
    okBtn1 = {path = "root/Middle/Group/ConfirmBtn1", type = UITool.Button},
    okBtn2 = {path = "root/Middle/Group/ConfirmBtn2", type = UITool.Button},
    cancelBtn = {path = "root/Middle/Group/CancelBtn", type = UITool.Button},
    sytleImgObjOk1 = {path = "root/Middle/Group/ConfirmBtn1/StyleImage", type = UITool.GameObject},
    sytleImgObjOk2 = {path = "root/Middle/Group/ConfirmBtn2/StyleImage", type = UITool.GameObject},
    sytleImgObjCancel = {path = "root/Middle/Group/CancelBtn/StyleImage", type = UITool.GameObject},
    sytleTextOk1 = {path = "root/Middle/Group/ConfirmBtn1/StyleText", type = UITool.Text},
    sytleTextOk2 = {path = "root/Middle/Group/ConfirmBtn2/StyleText", type = UITool.Text},
    sytleTextCancel = {path = "root/Middle/Group/CancelBtn/StyleText", type = UITool.Text},
    contentText = {path = "root/Middle/Group/Content", type = UITool.Text}
}

local this = {}

this.before_active = function()
    this.buttons = {
        [ConfirmCommonPanel.BtnType.Confirm] = this.okBtn1,
        [ConfirmCommonPanel.BtnType.Cancel] = this.cancelBtn,
        [ConfirmCommonPanel.BtnType.Center] = this.okBtn2
    }
    this.styleImgs = {
        [ConfirmCommonPanel.BtnType.Confirm] = this.sytleImgObjOk1,
        [ConfirmCommonPanel.BtnType.Cancel] = this.sytleImgObjCancel,
        [ConfirmCommonPanel.BtnType.Center] = this.sytleImgObjOk2
    }
    this.styleTxts = {
        [ConfirmCommonPanel.BtnType.Confirm] = this.sytleTextOk1,
        [ConfirmCommonPanel.BtnType.Cancel] = this.sytleTextCancel,
        [ConfirmCommonPanel.BtnType.Center] = this.sytleTextOk2
    }
    if this.MsgBoxType == ConfirmCommonPanel.MsgBoxType.TextButton and this.btnTextStrs == nil then
        LuaDebug.error("MsgBoxType with Params not match")
        return
    end
    if this.btnCallbacks == nil then
        return
    end
    for key, value in pairs(this.buttons) do
        if this.showCenter == true and key == ConfirmCommonPanel.BtnType.Center then
            SetActive(value.gameObject, true)
        elseif key == ConfirmCommonPanel.BtnType.Center then
            SetActive(value.gameObject, false)
        else
            SetActive(value.gameObject, true)
        end
    end

    for key, value in pairs(this.styleImgs) do
        SetActive(value.gameObject, this.MsgBoxType == ConfirmCommonPanel.MsgBoxType.ImageButton)
    end
    for key, value in pairs(this.styleTxts) do
        SetActive(value.gameObject, this.MsgBoxType == ConfirmCommonPanel.MsgBoxType.TextButton)
        local btnTextStr = this.btnTextStrs[key]
        if this.MsgBoxType == ConfirmCommonPanel.MsgBoxType.TextButton then
            SetActive(this.buttons[key].gameObject, btnTextStr ~= nil)
        end
        if btnTextStr ~= nil then
            value.text = this.btnTextStrs[key]
        end
    end
    this.contentText.text = string.gsub(this.contentStr, "\\n", "\n")
end

this.OnClickOkBtn1 = function()
    LuaMgr.HidePanel(UIName.ConfirmCommonPanel)
    local callback = this.btnCallbacks[ConfirmCommonPanel.BtnType.Confirm]
    if callback == nil then
        return
    end
    callback()
end

this.OnClickCancel = function()
    LuaMgr.HidePanel(UIName.ConfirmCommonPanel)
    local callback = this.btnCallbacks[ConfirmCommonPanel.BtnType.Cancel]
    if callback == nil then
        return
    end
    callback()
end

this.OnClickOkBtn2 = function()
    LuaMgr.HidePanel(UIName.ConfirmCommonPanel)
    local callback = this.btnCallbacks[ConfirmCommonPanel.BtnType.Center]
    if callback == nil then
        return
    end
    callback()
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.okBtn1, this.OnClickOkBtn1)
        LuaMgr.AddClick(this.cancelBtn, this.OnClickCancel)
        LuaMgr.AddClick(this.okBtn2, this.OnClickOkBtn2)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length < 2 then
            return
        end
        this.MsgBoxType = vm.behaviour.Params[0]

        this.btnCallbacks = vm.behaviour.Params[1].clickCallbacks
        this.btnTextStrs = vm.behaviour.Params[1].btnTextStrs
        this.contentStr = vm.behaviour.Params[1].contentStr
        this.showCenter = vm.behaviour.Params[1].showCenter == true
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.okBtn1, this.OnClickOkBtn1)
        LuaMgr.RemoveClick(this.cancelBtn, this.OnClickCancel)
        LuaMgr.RemoveClick(this.okBtn2, this.OnClickOkBtn2)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)