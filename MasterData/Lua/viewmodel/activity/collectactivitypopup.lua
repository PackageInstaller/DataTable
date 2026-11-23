




local this = {vm = nil}

local activityKey = "302"
local activityData = nil
local data = {
    timeTipText = "",timeText = "",tipText = "",
}

local command = {
    gotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.CollectActivityPopup)
            LuaMgr.ShowLuaPanel(UIName.CollectActivityViewModel,"collect")
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
}


this.InitParameter = function()
    local groupId = ActivityMgr.groupKeyList["collect"]
    activityData = DataMgr.Player.variables[groupId]
    if activityData == nil then
        local tempData = {}
        tempData["Keys"] = nil
        ApiMgr.Request("collection/normal",tempData,true,function()
            activityData = DataMgr.Player.variables[groupId]
            this.SetActivityTime()
        end,nil,true)
    else
        this.SetActivityTime()
    end
end


this.SetActivityTime = function()
    if activityData == nil then return end

    local time = activityData.delTime - LuaMgr.Timestamp()
    local day = math.floor(time/86400)
    local hour = math.fmod(math.floor(time/3600),24)
    local minute = math.fmod(math.floor(time/60), 60)
    local timeStr = string.format(LuaMgr.GetLangText("CollectActivityViewModel_3"),day,hour,minute)
this.vm.data.timeText = timeStr
    this.vm.data.timeTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7032"].NameLan)
    this.vm.data.tipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7026"].NameLan)
end

return vm({
    data = data,
    command = command,
    hook = hook
})