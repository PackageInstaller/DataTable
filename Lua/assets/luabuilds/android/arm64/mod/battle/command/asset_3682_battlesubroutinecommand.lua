ys = ys or {}

local var_0_0 = ys
local BattleSubRoutineCommand = class("BattleSubRoutineCommand", ys.Battle.BattleSubmarineRunCommand)

ys.Battle.BattleSubRoutineCommand = BattleSubRoutineCommand
BattleSubRoutineCommand.__name = "BattleSubRoutineCommand"

function BattleSubRoutineCommand:Ctor()
	BattleSubRoutineCommand.super.Ctor(self)

	return
end

function BattleSubRoutineCommand:Initialize()
	BattleSubRoutineCommand.super.Initialize(self)
	self._dataProxy:SubmarineRunInit()

	return
end

function BattleSubRoutineCommand:DoPrologue()
	pg.UIMgr.GetInstance():Marching()
	self._dataProxy:AutoStatistics(0)

	for iter_3_0, iter_3_1 in ipairs((self._userFleet:GetUnitList())) do
		iter_3_1:AddBuff((var_0_0.Battle.BattleBuffUnit.New(9040)))
		iter_3_1:RemoveBuff(8520)
	end

	self._uiMediator:SeaSurfaceShift(45, 0, nil, function()
		self._uiMediator:OpeningEffect(function()
			self._uiMediator:ShowTimer()
			self._state:ChangeState(var_0_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			self._waveUpdater:Start()

			return
		end, SYSTEM_SUB_ROUTINE)

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

function BattleSubRoutineCommand:initWaveModule()
	self._waveUpdater = var_0_0.Battle.BattleWaveUpdater.New(function(arg_7_0, arg_7_1, arg_7_2)
		self._dataProxy:SpawnMonster(arg_7_0, arg_7_1, arg_7_2, var_0_0.Battle.BattleConfig.FOE_CODE)

		return
	end, nil, function()
		if self._vertifyFail then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = self._vertifyFail
			})

			return
		end

		self._dataProxy:TriggerFinishBattle()
		self._dataProxy:CalcSubRoutineScore()
		self._state:BattleEnd()

		return
	end, nil)

	return
end

function BattleSubRoutineCommand:onUpdateCountDown(arg_9_1)
	if self._dataProxy:GetCountDown() <= 0 then
		self._dataProxy:EnemyEscape()
		self._dataProxy:CalcSubRountineTimeUp()
		self._state:BattleTimeUp()
	end

	return
end

function BattleSubRoutineCommand:onShutDownPlayer(arg_10_1)
	self._dataProxy:ShutdownPlayerUnit((arg_10_1.Dispatcher:GetUniqueID()))

	return
end

function BattleSubRoutineCommand:onPlayerShutDown(arg_11_1)
	if self._state:GetState() ~= self._state.BATTLE_STATE_FIGHT then
		return
	end

	if #self._userFleet:GetSubBench() > 0 then
		self._userFleet:ShiftManualSub()
	else
		self._dataProxy:TriggerFinishBattle()
		self._dataProxy:CalcSubRountineElimate()
		self._state:BattleEnd()
	end

	return
end

return
