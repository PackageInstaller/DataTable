local this = {
    vm = nil,
}

local data = {
    medalList = {
        { bg_1 = false, bg_2 = false, icon = DefaultSprite, name = "", desc = "", progress = "", }
    }
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.Rogue2MedalPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.SetMedalList()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.SetMedalList = function()
    local tempList = {}
    local medalList = RogueMgr.GetMedalList()
    for i, v in ipairs(medalList) do
        local item = {
            bg_1 = not v.finish, 
            bg_2 = v.finish, 
            icon = v.icon, 
            name = v.name, 
            desc = v.remark, 
            progress = string.format(LuaMgr.GetLangText("Rogue2MedalPopup_0"), v.progress, v.target)
        }
        table.insert(tempList, item)
    end
    this.vm.data.medalList = tempList
end

return vm({
    data = data,
    command = command,
    hook = hook
})