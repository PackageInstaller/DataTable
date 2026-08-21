ys = ys or {}

local var_0_0 = ys.Battle.BattleUnitEvent
local var_0_1 = ys.Battle.BattleEvent
local var_0_2 = class("BattleAirFightCommand", ys.Battle.BattleSingleDungeonCommand)

ys.Battle.BattleAirFightCommand = var_0_2
var_0_2.__name = "BattleAirFightCommand"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.AddEvent(arg_2_0, ...)
	var_0_2.super.AddEvent(arg_2_0, ...)
	arg_2_0._dataProxy:RegisterEventListener(arg_2_0, var_0_1.COMMON_DATA_INIT_FINISH, arg_2_0.onBattleDataInitFinished)

	return
end

function var_0_2.RemoveEvent(arg_3_0, ...)
	arg_3_0._dataProxy:UnregisterEventListener(arg_3_0, var_0_1.COMMON_DATA_INIT_FINISH)
	var_0_2.super.RemoveEvent(arg_3_0, ...)

	return
end

function var_0_2.DoPrologue(arg_4_0)
	pg.UIMgr.GetInstance():Marching()
	arg_4_0._uiMediator:SeaSurfaceShift(1, 15, nil, function()
		arg_4_0._uiMediator:OpeningEffect(function()
			local var_6_0 = var_0.Battle.BattleFormulas.CreateContextCalculateDamage()

			arg_4_0._dataProxy:SetupCalculateDamage(function(arg_7_0, arg_7_1, ...)
				local var_7_0 = arg_7_1:GetIFF()

				if var_7_0 == var_0.Battle.BattleConfig.FRIENDLY_CODE then
					return 1, {
						isMiss = false,
						isCri = false,
						isDamagePrevent = false
					}
				elseif var_7_0 == var_0.Battle.BattleConfig.FOE_CODE then
					return var_6_0(arg_7_0, arg_7_1, ...)
				end

				return
			end)
			arg_4_0._dataProxy:SetupDamageKamikazeShip(var_0.Battle.BattleFormulas.CalcDamageLockS2M)
			arg_4_0._dataProxy:SetupDamageCrush(function(arg_8_0, arg_8_1)
				local var_8_0, var_8_1 = var_0.CalculateCrashDamage(arg_8_0, arg_8_1)

				var_8_1 = arg_8_1:GetIFF() == var_0.Battle.BattleConfig.FRIENDLY_CODE and 1 or var_8_1

				return 1, var_8_1
			end)
			arg_4_0._uiMediator:ShowTimer()
			arg_4_0._state:ChangeState(var_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			arg_4_0._waveUpdater:Start()

			return
		end, SYSTEM_AIRFIGHT)
		arg_4_0._dataProxy:InitAllFleetUnitsWeaponCD()

		return
	end)
	arg_4_0._dataProxy:AutoStatistics(0)

	local var_4_0 = arg_4_0._state:GetSceneMediator()

	arg_4_0._uiMediator:ShowAirFightScoreBar()

	return
end

function var_0_2.initWaveModule(arg_9_0)
	arg_9_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(function(arg_10_0, arg_10_1, arg_10_2)
		arg_9_0._dataProxy:SpawnMonster(arg_10_0, arg_10_1, arg_10_2, var_0.Battle.BattleConfig.FOE_CODE)

		return
	end, nil, function()
		if arg_9_0._vertifyFail then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = arg_9_0._vertifyFail
			})

			return
		end

		arg_9_0._dataProxy:TriggerFinishBattle()
		arg_9_0._dataProxy:CalcAirFightScore()
		arg_9_0._state:BattleEnd()

		return
	end, nil)

	return
end

function var_0_2.onBattleDataInitFinished(arg_12_0)
	arg_12_0._dataProxy:AirFightInit()

	for iter_12_0, iter_12_1 in ipairs((arg_12_0._userFleet:GetScoutList())) do
		iter_12_1:HideWaveFx()
	end

	return
end

function var_0_2.RegisterUnitEvent(arg_13_0, arg_13_1, ...)
	var_0_2.super.RegisterUnitEvent(arg_13_0, arg_13_1, ...)

	if arg_13_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_13_1:RegisterEventListener(arg_13_0, var_0_0.UPDATE_HP, arg_13_0.onPlayerHPUpdate)
	end

	return
end

function var_0_2.UnregisterUnitEvent(arg_14_0, arg_14_1, ...)
	if arg_14_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_14_1:UnregisterEventListener(arg_14_0, var_0_0.UPDATE_HP)
	end

	var_0_2.super.UnregisterUnitEvent(arg_14_0, arg_14_1, ...)

	return
end

var_0_2.ShipType2Point = {
	[ShipType.YuLeiTing] = 200,
	[ShipType.JinBi] = 300,
	[ShipType.ZiBao] = 3000
}
var_0_2.BeenHitDecreasePoint = 10

function var_0_2.onWillDie(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.Dispatcher:GetDeathReason()
	local var_15_1 = arg_15_1.Dispatcher:GetTemplate().type

	if var_15_0 == var_0.Battle.BattleConst.UnitDeathReason.CRUSH or var_15_0 == var_0.Battle.BattleConst.UnitDeathReason.KILLED then
		local var_15_2 = var_0_2.ShipType2Point[var_15_1]

		if var_0_2.ShipType2Point[var_15_1] and var_15_2 > 0 then
			arg_15_0._dataProxy:AddAirFightScore(var_15_2)
		end
	end

	return
end

function var_0_2.onPlayerHPUpdate(arg_16_0, arg_16_1)
	if arg_16_1.Data.dHP <= 0 then
		arg_16_0._dataProxy:DecreaseAirFightScore(var_0_2.BeenHitDecreasePoint * -arg_16_1.Data.dHP)
	end

	return
end

return
