local objs = {
    leftBtn = {path = "root/Middle/LeftBtn", type = UITool.Button},
    rightBtn = {path = "root/Middle/RightBtn", type = UITool.Button},
    contentText = {path = "root/Middle/ContentText", type = UITool.Text},
    noAgainToggle = {path = "root/Middle/NoAgainToggle", type = UITool.Toggle}
}

local this = {}

this.before_awake = function()
    local callback = function(value)
        if value == true then
            SCNJData.SetArchiveByKey(this.params.noAgainTipsKey)
        else
            SCNJData.SetArchiveByKey(this.params.noAgainTipsKey, 0)
        end
    end
    this.noAgainToggle.onValueChanged:AddListener(callback)
end

this.before_active = function()
    SetActive(this.noAgainToggle.gameObject, this.params.showNoAgainToggle == true)
    if this.params.showNoAgainToggle == true then
        local nowstamp = LuaMgr.Timestamp()
        local nowDate = DateTool.UnixToDateTime(nowstamp, 1)
        this.noAgainToggle.isOn = SCNJData.GetArchiveByKey(this.params.noAgainTipsKey) == nowDate.Day
    else
        this.noAgainToggle.isOn = false
    end
    this.contentText.text = this.params.content or ""
end

this.OnClickLeftBtn = function()
    if this.params.OnClickLeftBtn ~= nil then
        this.params.OnClickLeftBtn()
    end
    LuaMgr.HidePanel(UIName.SCNJMsgBoxPopup)
end
this.OnClickRightBtn = function()
    if this.params.OnClickRightBtn ~= nil then
        this.params.OnClickRightBtn()
    end
    LuaMgr.HidePanel(UIName.SCNJMsgBoxPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.leftBtn, this.OnClickLeftBtn)
        LuaMgr.AddClick(this.rightBtn, this.OnClickRightBtn)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.params = vm.behaviour.Params[0]
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.leftBtn, this.OnClickLeftBtn)
        LuaMgr.RemoveClick(this.rightBtn, this.OnClickRightBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)