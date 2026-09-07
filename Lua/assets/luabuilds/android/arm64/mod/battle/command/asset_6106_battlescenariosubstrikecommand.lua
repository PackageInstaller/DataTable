ys = ys or {}

local var_0_0 = ys
local BattleScenarioSubStrikeCommand = class("BattleScenarioSubStrikeCommand", ys.Battle.BattleSingleDungeonCommand)

ys.Battle.BattleScenarioSubStrikeCommand = BattleScenarioSubStrikeCommand
BattleScenarioSubStrikeCommand.__name = "BattleScenarioSubStrikeCommand"

function BattleScenarioSubStrikeCommand:Ctor()
	BattleScenarioSubStrikeCommand.super.Ctor(self)

	return
end

function BattleScenarioSubStrikeCommand:DoPrologue()
	pg.UIMgr.GetInstance():Marching()
	self._uiMediator:SeaSurfaceShift(45, 0, nil, function()
		self._uiMediator:OpeningEffect(function()
			self._uiMediator:ShowTimer()
			self._state:ChangeState(var_0_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			self._waveUpdater:Start()

			if self._dataProxy:GetInitData().hideAllButtons then
				self._dataProxy:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleEvent.HIDE_INTERACTABLE_BUTTONS, {
					isActive = false
				}))
			end

			self._uiMediator:InitCameraGestureSlider()
			self._uiMediator:EnableJoystick(false)
			self._uiMediator:EnableWeaponButton(false)

			return
		end)
		self._dataProxy:SubmarineStrike(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)

		return
	end)

	return
end

function BattleScenarioSubStrikeCommand:initWaveModule()
	self._waveUpdater = var_0_0.Battle.BattleWaveUpdater.New(function(arg_6_0, arg_6_1, arg_6_2)
		self._dataProxy:SpawnMonster(arg_6_0, arg_6_1, arg_6_2, var_0_0.Battle.BattleConfig.FOE_CODE)

		return
	end, function(arg_7_0)
		self._dataProxy:SpawnAirFighter(arg_7_0)

		return
	end, function()
		if self._vertifyFail then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = self._vertifyFail
			})

			return
		end

		self._dataProxy:TriggerFinishBattle()
		self:CalcStatistic()
		self._state:BattleEnd()

		return
	end, function(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
		self._dataProxy:SpawnCubeArea(var_0_0.Battle.BattleConst.AOEField.SURFACE, -1, arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)

		return
	end)

	return
end

function BattleScenarioSubStrikeCommand:onAddUnit(arg_10_1)
	BattleScenarioSubStrikeCommand.super.onAddUnit(self, arg_10_1)

	if arg_10_1.Data.type == var_0_0.Battle.BattleConst.UnitType.BOSS_UNIT then
		self._dataProxy:AddScenarioSubStrikeBoss(arg_10_1.Data.unit)
	end

	return
end

function BattleScenarioSubStrikeCommand:onPlayerShutDown(arg_11_1)
	if self._state:GetState() ~= self._state.BATTLE_STATE_FIGHT then
		return
	end

	if #self._userFleet:GetSubList() == 0 then
		self._dataProxy:TriggerFinishBattle()
		self:CalcStatistic()
		self._state:BattleEnd()
	end

	return
end

function BattleScenarioSubStrikeCommand:onUpdateCountDown(arg_12_1)
	if self._dataProxy:GetCountDown() <= 0 then
		self._dataProxy:EnemyEscape()
		self:CalcStatistic()
		self._state:BattleTimeUp()
	end

	return
end

function BattleScenarioSubStrikeCommand:onWillDie(arg_13_1)
	if arg_13_1.Dispatcher:GetDeathReason() == var_0_0.Battle.BattleConst.UnitDeathReason.LEAVE then
		if arg_13_1.Dispatcher:GetIFF() == var_0_0.Battle.BattleConfig.FRIENDLY_CODE then
			self._dataProxy:CalcBPWhenPlayerLeave(arg_13_1.Dispatcher)
		end
	else
		self._dataProxy:CalcBattleScoreWhenDead(arg_13_1.Dispatcher)
	end

	if arg_13_1.Dispatcher:IsBoss() and not self._dataProxy:IsThereBoss() then
		self._dataProxy:KillAllEnemy()
	end

	return
end

function BattleScenarioSubStrikeCommand:CalcBattleEnd()
	self._dataProxy:TriggerFinishBattle()
	self:CalcStatistic()
	self._state:BattleEnd()

	return
end

function BattleScenarioSubStrikeCommand:CalcStatistic()
	self._dataProxy:CalcScenarioSubStrikeScoreAtEnd()

	return
end

return
