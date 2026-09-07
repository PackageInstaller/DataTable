ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_2 = ys.Battle.BattleEvent
local BattleAirFightCommand = class("BattleAirFightCommand", ys.Battle.BattleSingleDungeonCommand)

ys.Battle.BattleAirFightCommand = BattleAirFightCommand
BattleAirFightCommand.__name = "BattleAirFightCommand"

function BattleAirFightCommand:Ctor()
	BattleAirFightCommand.super.Ctor(self)

	return
end

function BattleAirFightCommand:AddEvent(...)
	BattleAirFightCommand.super.AddEvent(self, ...)
	self._dataProxy:RegisterEventListener(self, var_0_2.COMMON_DATA_INIT_FINISH, self.onBattleDataInitFinished)

	return
end

function BattleAirFightCommand:RemoveEvent(...)
	self._dataProxy:UnregisterEventListener(self, var_0_2.COMMON_DATA_INIT_FINISH)
	BattleAirFightCommand.super.RemoveEvent(self, ...)

	return
end

function BattleAirFightCommand:DoPrologue()
	pg.UIMgr.GetInstance():Marching()
	self._uiMediator:SeaSurfaceShift(1, 15, nil, function()
		self._uiMediator:OpeningEffect(function()
			local var_6_0 = var_0_0.Battle.BattleFormulas
			local var_6_1 = var_0_0.Battle.BattleFormulas.CreateContextCalculateDamage()

			self._dataProxy:SetupCalculateDamage(function(arg_7_0, arg_7_1, ...)
				local var_7_0 = arg_7_1:GetIFF()

				if var_7_0 == var_0_0.Battle.BattleConfig.FRIENDLY_CODE then
					return 1, {
						isMiss = false,
						isCri = false,
						isDamagePrevent = false
					}
				elseif var_7_0 == var_0_0.Battle.BattleConfig.FOE_CODE then
					return var_6_1(arg_7_0, arg_7_1, ...)
				end

				return
			end)
			self._dataProxy:SetupDamageKamikazeShip(var_0_0.Battle.BattleFormulas.CalcDamageLockS2M)
			self._dataProxy:SetupDamageCrush(function(arg_8_0, arg_8_1)
				local var_8_0, var_8_1 = var_6_0.CalculateCrashDamage(arg_8_0, arg_8_1)

				var_8_1 = arg_8_1:GetIFF() == var_0_0.Battle.BattleConfig.FRIENDLY_CODE and 1 or var_8_1

				return 1, var_8_1
			end)
			self._uiMediator:ShowTimer()
			self._state:ChangeState(var_0_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			self._waveUpdater:Start()

			return
		end, SYSTEM_AIRFIGHT)
		self._dataProxy:InitAllFleetUnitsWeaponCD()

		return
	end)
	self._dataProxy:AutoStatistics(0)

	local var_4_0 = self._state:GetSceneMediator()

	self._uiMediator:ShowAirFightScoreBar()

	return
end

function BattleAirFightCommand:initWaveModule()
	self._waveUpdater = var_0_0.Battle.BattleWaveUpdater.New(function(arg_10_0, arg_10_1, arg_10_2)
		self._dataProxy:SpawnMonster(arg_10_0, arg_10_1, arg_10_2, var_0_0.Battle.BattleConfig.FOE_CODE)

		return
	end, nil, function()
		if self._vertifyFail then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = self._vertifyFail
			})

			return
		end

		self._dataProxy:TriggerFinishBattle()
		self._dataProxy:CalcAirFightScore()
		self._state:BattleEnd()

		return
	end, nil)

	return
end

function BattleAirFightCommand:onBattleDataInitFinished()
	self._dataProxy:AirFightInit()

	for iter_12_0, iter_12_1 in ipairs((self._userFleet:GetScoutList())) do
		iter_12_1:HideWaveFx()
	end

	return
end

function BattleAirFightCommand:RegisterUnitEvent(arg_13_1, ...)
	BattleAirFightCommand.super.RegisterUnitEvent(self, arg_13_1, ...)

	if arg_13_1:GetUnitType() == var_0_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_13_1:RegisterEventListener(self, var_0_1.UPDATE_HP, self.onPlayerHPUpdate)
	end

	return
end

function BattleAirFightCommand:UnregisterUnitEvent(arg_14_1, ...)
	if arg_14_1:GetUnitType() == var_0_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_14_1:UnregisterEventListener(self, var_0_1.UPDATE_HP)
	end

	BattleAirFightCommand.super.UnregisterUnitEvent(self, arg_14_1, ...)

	return
end

BattleAirFightCommand.ShipType2Point = {
	[ShipType.YuLeiTing] = 200,
	[ShipType.JinBi] = 300,
	[ShipType.ZiBao] = 3000
}
BattleAirFightCommand.BeenHitDecreasePoint = 10

function BattleAirFightCommand:onWillDie(arg_15_1)
	local var_15_0 = arg_15_1.Dispatcher:GetDeathReason()

	if var_15_0 == var_0_0.Battle.BattleConst.UnitDeathReason.CRUSH or var_15_0 == var_0_0.Battle.BattleConst.UnitDeathReason.KILLED then
		local var_15_1 = BattleAirFightCommand.ShipType2Point[arg_15_1.Dispatcher:GetTemplate().type]

		if BattleAirFightCommand.ShipType2Point[arg_15_1.Dispatcher:GetTemplate().type] and var_15_1 > 0 then
			self._dataProxy:AddAirFightScore(var_15_1)
		end
	end

	return
end

function BattleAirFightCommand:onPlayerHPUpdate(arg_16_1)
	if arg_16_1.Data.dHP <= 0 then
		self._dataProxy:DecreaseAirFightScore(BattleAirFightCommand.BeenHitDecreasePoint * -arg_16_1.Data.dHP)
	end

	return
end

return
