local this = 
{
    vm = nil,
}
local data =
{
    from = "",
    to = "",
}

local command = 
{
    CloseCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TeamTowerSuccessPopup)
            local callback = this.vm.behaviour.Params[0]
            if callback ~= nil then
                callback();
            end
        end
    },
}

local hook = 
{
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        local from = PlayerPrefs.GetInt(DataMgr.Player.uid .. "TeamTowerFloor",0)
        local to = TeamTowerMgr.GetCurChallengeFloor()
        this.vm.data.from = tostring(from)
        this.vm.data.to = to
        PlayerPrefs.SetInt(DataMgr.Player.uid .. "TeamTowerFloor",tonumber(to))
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})