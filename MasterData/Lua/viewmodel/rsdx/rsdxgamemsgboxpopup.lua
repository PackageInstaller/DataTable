local this = {}

local objs = {
    content = {path = "root/Middle/ContentText", type = UITool.Text},
    leftBtn = {path = "root/Middle/LeftBtn", type = UITool.Button},
    rightBtn = {path = "root/Middle/RightBtn", type = UITool.Button}
}

this.before_awake = function()
end

this.before_active = function()
end

this.ParseParam = function(data)
    if not data then
        return
    end
    this.data = data
    this.content.text = tostring(this.data.Content)
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.RSDXGameMsgBoxPopup)
end

this.OnClickLeft = function()
    this.OnClickBack()
    if this.data.OnCancel then
        this.data.OnCancel()
    end
end

this.OnClickRight = function()
    this.OnClickBack()
    if this.data.OnConfirm then
        this.data.OnConfirm()
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.leftBtn, this.OnClickLeft)
        LuaMgr.AddClick(this.rightBtn, this.OnClickRight)
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
        LuaMgr.RemoveClick(this.leftBtn, this.OnClickLeft)
        LuaMgr.RemoveClick(this.rightBtn, this.OnClickRight)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)