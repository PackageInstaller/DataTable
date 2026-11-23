







local this = {}

local objs = {
    leftBtnText = {path = "root/Middle/LeftBtn/Text", type = BalatroUtil.Text},
    rightBtnText = {path = "root/Middle/RightBtn/Text", type = BalatroUtil.Text},
    content = {path = "root/Middle/ContentText", type = BalatroUtil.Text},
    leftBtn = {path = "root/Middle/LeftBtn", type = BalatroUtil.Button},
    rightBtn = {path = "root/Middle/RightBtn", type = BalatroUtil.Button}
}

this.before_awake = function()
    LuaMgr.AddClick(this.leftBtn, this.OnClickLeft)
    LuaMgr.AddClick(this.rightBtn, this.OnClickRight)
end

this.before_active = function()
end

this.ParseParam = function(data)
    if not data then
        LuaDebug.error("BalatroMsgboxPopUp ParseParam : 参数错误")
        return
    end
    this.data = data
    if type(this.data) ~= BalatroUtil.LuaDataType.Table then
        return
    end
    this.leftBtnText.text = tostring(this.data.leftStr)
    this.rightBtnText.text = tostring(this.data.rightStr)
    this.content.text = tostring(this.data.content)
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.BalatroMsgboxPopUp)
end

this.OnClickLeft = function()
    this.OnClickBack()
    if type(this.data) ~= BalatroUtil.LuaDataType.Table then
        LuaDebug.error("OnClickLeft 外部参数不是Table" .. tostring(this.data))
        return
    end
    if type(this.data.callBackCancel) ~= BalatroUtil.LuaDataType.Function then
        LuaDebug.info("OnClickLeft callBackCancel 为空")
        return
    end
    this.data.callBackCancel()
end

this.OnClickRight = function()
    this.OnClickBack()
    if type(this.data) ~= BalatroUtil.LuaDataType.Table then
        LuaDebug.error("OnClickRight 外部参数不是Table" .. tostring(this.data))
        return
    end
    if type(this.data.callBackConfirm) ~= BalatroUtil.LuaDataType.Function then
        LuaDebug.info("OnClickRight callBackConfirm 为空")
        return
    end
    this.data.callBackConfirm(this.data)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        LuaMgr.AddUIEventListener(UIEventConst.BalatroIntoCalView, this.OnClickBack)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.ParseParam(vm.behaviour.Params[0])
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        if this.OnClickLeft then
            LuaMgr.RemoveClick(this.leftBtn, this.OnClickLeft)
        end
        if this.OnClickRight then
            LuaMgr.RemoveClick(this.rightBtn, this.OnClickRight)
        end
        LuaMgr.RemoveUIEventListener(UIEventConst.BalatroIntoCalView, this.OnClickBack)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)