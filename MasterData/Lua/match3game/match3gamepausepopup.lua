local objs = {
    existBtn = {path = "root/Middle/ExitBtn", type = UITool.Button},
    replayBtn = {path = "root/Middle/ReplayBtn", type = UITool.Button},
    continueBtn = {path = "root/Middle/ContinueBtn", type = UITool.Button}
}

local this = {}

this.InitParseObj = function()
end

this.InitObjItems = function()
end

this.before_awake = function()
end

this.before_active = function()
end

this.OnClickExistBtn = function()
    if this.onExistCallback ~= nil then
        this.onExistCallback()
    end
    this.OnClose()
end

this.OnClickReplayBtn = function()
    if this.onReplayCallback then
        this.onReplayCallback()
    end
    this.OnClose()
end

this.OnClickContinueBtn = function()
    this.OnClose()
end

this.OnClose = function()
    LuaMgr.HidePanel(UIName.Match3GamePausePopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.existBtn, this.OnClickExistBtn)
        LuaMgr.AddClick(this.replayBtn, this.OnClickReplayBtn)
        LuaMgr.AddClick(this.continueBtn, this.OnClickContinueBtn)
    end,
    before_active = function(vm)
        if vm.behaviour.Params and vm.behaviour.Params.Length > 0 then
            local data = vm.behaviour.Params[0]
            this.onExistCallback = data.onExistCallback
            this.onReplayCallback = data.onReplayCallback
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.existBtn, this.OnClickExistBtn)
        LuaMgr.RemoveClick(this.replayBtn, this.OnClickReplayBtn)
        LuaMgr.RemoveClick(this.continueBtn, this.OnClickContinueBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)