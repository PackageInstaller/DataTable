local objs = {
    maskBtn = {path = "root/Mask", type = UITool.Button},
    loseGroup = {path = "root/Middle/LoseGroup", type = UITool.GameObject},
    loseName = {path = "root/Middle/LoseGroup/Name", type = UITool.Text},
    loseDesc = {path = "root/Middle/LoseGroup/Desc", type = UITool.Text},
    successGroup = {path = "root/Middle/SuccessGroup", type = UITool.GameObject},
    successName = {path = "root/Middle/SuccessGroup/Name", type = UITool.Text},
    curScore = {path = "root/Middle/SuccessGroup/CurScore", type = UITool.Text}
}

local this = {
    downTime = 0
}

this.before_awake = function()
end

this.before_active = function()
    this.downTime = 0
    SetActive(this.loseGroup, this.data.Type == JYCSConst.GameEventPopupType.Lose)
    SetActive(this.successGroup, this.data.Type == JYCSConst.GameEventPopupType.Success)
    if this.data.Type == JYCSConst.GameEventPopupType.Lose then
        this.loseName.text = this.data.Name
        this.loseDesc.text = this.data.Desc
    else
        this.successName.text = this.data.Name
        local curScore = this.data.Score or 0
        this.curScore.text = tostring(curScore)
    end
end

this.OnGameEventCloseTimer = function()
    local closeTime = 0
    if this.data.Type == JYCSConst.GameEventPopupType.Lose then
        closeTime = JYCSConst.LoseCloseTime
    elseif this.data.Type == JYCSConst.GameEventPopupType.Success then
        closeTime = JYCSConst.SuccessCloseTime
    end
    if this.downTime >= closeTime then
        LuaMgr.InvokeUIEventListeners(UIEventConst.JYCSCloseEventPopup, this.data)
        LuaMgr.HidePanel(UIName.JYCSGameEventPopup)
    end
    this.downTime = this.downTime + 1
end

this.OnClickMask = function()
    LuaMgr.InvokeUIEventListeners(UIEventConst.JYCSCloseEventPopup, this.data)
    LuaMgr.HidePanel(UIName.JYCSGameEventPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length == 0 then
            return
        end
        this.data = vm.behaviour.Params[0]
        this.before_active()
        LuaMgr.AddTimer(TimerConst.JyCSGameEventCloseTimer, this.OnGameEventCloseTimer, 1, -1, false)
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.JyCSGameEventCloseTimer)
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)