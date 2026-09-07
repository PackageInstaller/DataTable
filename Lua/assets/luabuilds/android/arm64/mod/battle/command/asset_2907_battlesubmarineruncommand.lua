ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_2 = ys.Battle.BattleEvent
local BattleSubmarineRunCommand = class("BattleSubmarineRunCommand", ys.Battle.BattleSingleDungeonCommand)

ys.Battle.BattleSubmarineRunCommand = BattleSubmarineRunCommand
BattleSubmarineRunCommand.__name = "BattleSubmarineRunCommand"

function BattleSubmarineRunCommand:Ctor()
	BattleSubmarineRunCommand.super.Ctor(self)

	return
end

function BattleSubmarineRunCommand:Initialize()
	BattleSubmarineRunCommand.super.Initialize(self)
	self._dataProxy:SubmarineRunInit()

	return
end

function BattleSubmarineRunCommand:DoPrologue()
	pg.UIMgr.GetInstance():Marching()
	self._dataProxy:AutoStatistics(0)

	for iter_3_0, iter_3_1 in ipairs((self._userFleet:GetUnitList())) do
		iter_3_1:RemoveBuff(8520)
	end

	self._uiMediator:SeaSurfaceShift(45, 0, nil, function()
		self._uiMediator:OpeningEffect(function()
			self._uiMediator:ShowTimer()
			self._state:ChangeState(var_0_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			self._waveUpdater:Start()

			return
		end, SYSTEM_SUBMARINE_RUN)

		local var_4_0 = self._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)

		var_4_0:FleetWarcry()
		var_4_0:ChangeSubmarineState(var_0_0.Battle.OxyState.STATE_FREE_DIVE)
		var_4_0:GetSubBoostVO():ResetCurrent()
		self._dataProxy:InitAllFleetUnitsWeaponCD()
		self._dataProxy:TirggerBattleStartBuffs()

		return
	end)

	return
end

function BattleSubmarineRunCommand:onInitBattle()
	BattleSubmarineRunCommand.super.onInitBattle(self)
	self._userFleet:RegisterEventListener(self, var_0_2.MANUAL_SUBMARINE_SHIFT, self.onSubmarineShift)

	return
end

function BattleSubmarineRunCommand:initWaveModule()
	self._waveUpdater = var_0_0.Battle.BattleWaveUpdater.New(function(arg_8_0, arg_8_1, arg_8_2)
		self._dataProxy:SpawnMonster(arg_8_0, arg_8_1, arg_8_2, var_0_0.Battle.BattleConfig.FOE_CODE)

		return
	end, nil, function()
		if self._vertifyFail then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = self._vertifyFail
			})

			return
		end

		self._dataProxy:TriggerFinishBattle()
		self._dataProxy:CalcSubRunScore()
		self._state:BattleEnd()

		return
	end, nil)

	return
end

function BattleSubmarineRunCommand:onUpdateCountDown(arg_10_1)
	if self._dataProxy:GetCountDown() <= 0 then
		self._dataProxy:EnemyEscape()
		self._dataProxy:CalcSubRunTimeUp()
		self._state:BattleTimeUp()
	end

	return
end

function BattleSubmarineRunCommand:RemoveEvent()
	self._userFleet:UnregisterEventListener(self, var_0_2.MANUAL_SUBMARINE_SHIFT)
	BattleSubmarineRunCommand.super.RemoveEvent(self)

	return
end

function BattleSubmarineRunCommand:UnregisterUnitEvent(arg_12_1)
	BattleSubmarineRunCommand.super.UnregisterUnitEvent(self, arg_12_1)
	arg_12_1:UnregisterEventListener(self, var_0_1.ANTI_SUB_VIGILANCE_HATE_CHAIN)

	return
end

function BattleSubmarineRunCommand:onAddUnit(arg_13_1)
	BattleSubmarineRunCommand.super.onAddUnit(self, arg_13_1)

	if arg_13_1.Data.type ~= var_0_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_13_1.Data.unit:RegisterEventListener(self, var_0_1.ANTI_SUB_VIGILANCE_HATE_CHAIN, self.onHateChain)
	end

	return
end

function BattleSubmarineRunCommand:onHateChain(arg_14_1)
	for iter_14_0, iter_14_1 in pairs(self._unitDataList) do
		iter_14_1:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_ANTI_SUB_HATE_CHAIN)
	end

	return
end

function BattleSubmarineRunCommand:onWillDie(arg_15_1)
	local var_15_0 = arg_15_1.Dispatcher:GetDeathReason()

	if arg_15_1.Dispatcher:GetIFF() == var_0_0.Battle.BattleConfig.FRIENDLY_CODE then
		self._dataProxy:DelScoreWhenPlayerDead(arg_15_1.Dispatcher)
	end

	if var_15_0 == var_0_0.Battle.BattleConst.UnitDeathReason.KILLED or var_15_0 == var_0_0.Battle.BattleConst.UnitDeathReason.DESTRUCT then
		for iter_15_0, iter_15_1 in pairs(self._unitDataList) do
			iter_15_1:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_TEAMMATE_SHIP_DYING, {
				unit = iter_15_1
			})
		end
	end

	if arg_15_1.Dispatcher:GetTemplate().type == ShipType.JinBi and var_15_0 == var_0_0.Battle.BattleConst.UnitDeathReason.KILLED then
		self._dataProxy:CalcKillingSupplyShip()
	end

	if arg_15_1.Dispatcher:IsBoss() and not self._dataProxy:IsThereBoss() then
		if var_15_0 == var_0_0.Battle.BattleConst.UnitDeathReason.DESTRUCT then
			self._dataProxy:AddScoreWhenBossDestruct()
		end

		self._dataProxy:KillAllEnemy()
	end

	return
end

function BattleSubmarineRunCommand:onSubmarineShift(arg_16_1)
	local var_16_0

	if arg_16_1.Data.state == var_0_0.Battle.OxyState.STATE_FREE_DIVE then
		var_16_0 = var_0_0.Battle.BattleConst.BuffEffectType.ON_SUBMARINE_FREE_DIVE
	elseif arg_16_1.Data.state == var_0_0.Battle.OxyState.STATE_FREE_FLOAT then
		var_16_0 = var_0_0.Battle.BattleConst.BuffEffectType.ON_SUBMARINE_FREE_FLOAT
	end

	for iter_16_0, iter_16_1 in pairs(self._unitDataList) do
		iter_16_1:TriggerBuff(var_16_0)
	end

	return
end

function BattleSubmarineRunCommand:onShutDownPlayer()
	self._dataProxy:TriggerFinishBattle()
	self._dataProxy:CalcSubRunDead()
	self._state:BattleEnd()

	return
end

return
