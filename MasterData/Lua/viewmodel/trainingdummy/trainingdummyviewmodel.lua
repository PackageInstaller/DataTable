local this = {
    vm = nil,
    curType = 1,
    attackIsOn = false,
    curSandBagCfg = nil,
}

local data = {
    isType_1 = false,
    isType_2 = false,
    showAttackToggle = false,
    attackToggleOn = false,
    damageNum = "",
}

local command = {
    typeBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.curType = tonumber(param) + 1
            this.RefreshData()
        end
    },
    attackBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.attackIsOn = not this.attackIsOn
            this.vm.data.attackToggleOn = this.attackIsOn
        end
    },
    damageBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.TrainingDummyDamagePopup);
        end
    },
    startBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
            enterDungeonParams.eventId = this.curSandBagCfg.Id
            enterDungeonParams.dungeonId = this.curSandBagCfg.DungeonId
            if this.attackIsOn and not IsNullOrEmpty(this.curSandBagCfg.DungeonId2) then
                enterDungeonParams.dungeonId = this.curSandBagCfg.DungeonId2
            end
            enterDungeonParams.extraParams = {}
            table.insert(enterDungeonParams.extraParams, "wood_training")
            table.insert(enterDungeonParams.extraParams, this.curSandBagCfg.Id)
            BattlePrepareMgr.BattlePrepare(enterDungeonParams)
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
        this.curType = TrainingDummyMgr.CurChooseType
        this.attackIsOn = TrainingDummyMgr.AttackIsOn
        this.RefreshData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        TrainingDummyMgr.CurChooseType = this.curType
        TrainingDummyMgr.AttackIsOn = this.attackIsOn
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.RefreshData = function()
    this.curSandBagCfg = this.GetCurSandBagCfg()
    this.vm.data.isType_1 = this.curType == 1
    this.vm.data.isType_2 = this.curType == 2
    this.vm.data.showAttackToggle = not IsNullOrEmpty(this.curSandBagCfg.DungeonId2)
    this.vm.data.attackToggleOn = this.attackIsOn
    this.vm.data.damageNum = DataMgr.Player.WoodTraining.DamageTotal
end

this.GetCurSandBagCfg = function()
    local sandBagMap = ConfigMgr.Config.SandBagMap
    local cfg = nil
    for k, v in pairs(sandBagMap) do
        if v.Type == this.curType then
            cfg = v
            break
        end
    end
    return cfg
end

return vm({
    data = data,
    command = command,
    hook = hook
})