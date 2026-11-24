local objs = {
    gotoBtn = {path = "root/Middle/Goto", type = UITool.Button},
    timeText = {path = "root/Middle/Time/DownTime", type = UITool.Text}
}

local this = {}

this.before_awake = function()
end

this.before_active = function()
end

this.OnRefreshTime = function()
    if this.timeText ~= nil then
        this.timeText.text = WJWYData.GetRemainTimeStr()
    end
end

this.OnClickGoto = function()
    if WJWYData.CheckActivityRunning() == false then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.WJWYHomePanel)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.gotoBtn, this.OnClickGoto)
        this.timerKey = TimerConst.JYCSGameTipTimer * 10 + 1
        LuaMgr.AddTimer(this.timerKey, this.OnRefreshTime, 60, -1, true)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.before_active()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(this.timerKey)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.gotoBtn, this.OnClickGoto)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)