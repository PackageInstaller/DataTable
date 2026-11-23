local this = {
    vm = nil,
    
}
local objs = {
    limitToggle = { path = "root/Middle/Condition/limit", type = "Toggle" },
    noLimitToggle = { path = "root/Middle/Condition/Nolimit", type = "Toggle" },
    
}
local data = {
    levelLimit = "0",
    guildName = "",
}

local command = {
    ConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            PlayerGuildMgr.ChangeJoinCondition(tonumber(this.vm.data.levelLimit),this.limitToggle.isOn,function()
                LuaMgr.HidePanel(UIName.GuildSettingViewModel);
            end)
        end
    },
    
    ChangeLevelLimitCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local num = tonumber(param);
            local level = tonumber(this.vm.data.levelLimit) + num;
            local cfgMaxLevel = ConfigMgr.Config.constants.maxPlayerLevel
            if level <= 0 then
                level = 0;
            end
            if level > cfgMaxLevel then
                level = cfgMaxLevel
            end
            this.vm.data.levelLimit = tostring(level)
        end
    },
    
    ClosePanelCommand =
    {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.GuildSettingViewModel);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour, this, objs);

    end,
    before_active = function(vm)
        this.vm.behaviour:UpdateTopBar("")
        local guildInfo = PlayerGuildMgr.GuildInfo()
        this.vm.data.guildName = guildInfo.guildName;
        this.limitToggle.isOn = guildInfo.needApprove;
        this.noLimitToggle.isOn = not guildInfo.needApprove;
        this.vm.data.levelLimit = tostring(guildInfo.levelLimit);
    end,
    before_deactive = function(vm)

    end,
    before_destroy = function(vm)
        this = nil
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})