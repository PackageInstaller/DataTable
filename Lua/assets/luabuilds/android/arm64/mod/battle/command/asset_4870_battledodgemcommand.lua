ys = ys or {}

local var_0_0 = ys
local BattleDodgemCommand = class("BattleDodgemCommand", ys.Battle.BattleSingleDungeonCommand)

ys.Battle.BattleDodgemCommand = BattleDodgemCommand
BattleDodgemCommand.__name = "BattleDodgemCommand"

function BattleDodgemCommand:Ctor()
	BattleDodgemCommand.super.Ctor(self)

	return
end

function BattleDodgemCommand:Initialize()
	BattleDodgemCommand.super.Initialize(self)
	self._dataProxy:DodgemCountInit()

	return
end

function BattleDodgemCommand:DoPrologue()
	pg.UIMgr.GetInstance():Marching()
	self._uiMediator:SeaSurfaceShift(45, 0, nil, function()
		self._uiMediator:OpeningEffect(function()
			self._dataProxy:SetupDamageKamikazeShip(var_0_0.Battle.BattleFormulas.CalcDamageLockS2M)
			self._dataProxy:SetupDamageCrush(var_0_0.Battle.BattleFormulas.UnilateralCrush)
			self._uiMediator:ShowTimer()
			self._state:ChangeState(var_0_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			self._waveUpdater:Start()

			return
		end)
		self._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE):FleetWarcry()

		return
	end)
	self._uiMediator:ShowDodgemScoreBar()

	return
end

function BattleDodgemCommand:initWaveModule()
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
		self._dataProxy:CalcDodgemScore()
		self._state:BattleEnd()

		return
	end, nil)

	return
end

function BattleDodgemCommand:onWillDie(arg_9_1)
	self._dataProxy:CalcDodgemCount(arg_9_1.Dispatcher)

	if arg_9_1.Dispatcher:GetTemplate().type == ShipType.JinBi and arg_9_1.Dispatcher:GetDeathReason() == var_0_0.Battle.BattleConst.UnitDeathReason.CRUSH then
		arg_9_1.Dispatcher:DispatchScorePoint((self._dataProxy:GetScorePoint()))
	end

	return
end

return
