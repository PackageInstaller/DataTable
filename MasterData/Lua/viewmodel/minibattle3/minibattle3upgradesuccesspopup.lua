local this = {
    dungeonNameText = nil,
};

local data = {
    levelStr = "",
    leftName = "",
    leftDesc = "",
    rightName = "",
    rightDesc = "",
}

local command = {
    maskBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.MiniBattle3UpGradeSuccessPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        local buffGroupId = vm.behaviour.Params[0]
        local upGradeLevel = vm.behaviour.Params[1]
        local newLevel = MiniBattle3Mgr.GetBuffLevel(buffGroupId)
        local oldLevel = newLevel - upGradeLevel
        local buffGroupCfg = ConfigMgr.Config.DualBattleBuffLevelMap[buffGroupId]
        local newBuffDescCfg = ConfigMgr.Config.DualBattleBuffDescMap[buffGroupCfg.GroupId[newLevel]]
        local oldBuffDescCfg = ConfigMgr.Config.DualBattleBuffDescMap[buffGroupCfg.GroupId[oldLevel]]
        this.vm.data.leftName = LuaMgr.GetLangText("MiniBattle3UpGradeSuccessPopup_0") .. oldLevel
        this.vm.data.rightName = LuaMgr.GetLangText("MiniBattle3UpGradeSuccessPopup_1") .. newLevel
        this.vm.data.leftDesc = LuaMgr.GetLangText(oldBuffDescCfg.BuffDeslan)
        this.vm.data.rightDesc =  LuaMgr.GetLangText(newBuffDescCfg.BuffDeslan)
        this.vm.data.levelStr = tostring(newLevel)
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