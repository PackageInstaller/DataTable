ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent

class = var_0_10003

local var_0_3 = var_0_10003("BattleAirFightCommand", var_0.Battle.BattleSingleDungeonCommand)

var_0.Battle.BattleAirFightCommand = var_0_3
var_0_3.__name = "BattleAirFightCommand"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.AddEvent(arg_2_0, ...)
	var_0_3.super.AddEvent(arg_2_0, ...)

	local var_2_0 = arg_2_0._dataProxy

	var_1.RegisterEventListener(var_2_0, arg_2_0, var_0_2.COMMON_DATA_INIT_FINISH, arg_2_0.onBattleDataInitFinished)

	return
end

function var_0_3.RemoveEvent(arg_3_0, ...)
	local var_3_0 = arg_3_0._dataProxy

	var_1.UnregisterEventListener(var_3_0, arg_3_0, var_0_2.COMMON_DATA_INIT_FINISH)
	var_0_3.super.RemoveEvent(arg_3_0, ...)

	return
end

function var_0_3.DoPrologue(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.Marching(var_4_0)

	local function var_4_1()
		local var_5_0 = arg_4_0._uiMediator
		local var_5_1 = var_0.OpeningEffect

		local function var_5_2()
			local var_6_0 = var_0.Battle.BattleFormulas.CreateContextCalculateDamage()

			local function var_6_1(arg_7_0, arg_7_1, ...)
				if arg_7_1:GetIFF() == var_0.Battle.BattleConfig.FRIENDLY_CODE then
					return 1, {
						isMiss = false,
						isCri = false,
						isDamagePrevent = false
					}
				elseif var_2 == var_0.Battle.BattleConfig.FOE_CODE then
					return var_6_0(arg_7_0, arg_7_1, ...)
				end

				return
			end

			local function var_6_2(arg_8_0, arg_8_1)
				local var_8_0, var_8_1 = var_0.CalculateCrashDamage(arg_8_0, arg_8_1)
				local var_8_2 = 1

				var_8_1 = arg_8_1:GetIFF() == var_0.Battle.BattleConfig.FRIENDLY_CODE and 1 or var_8_1

				return var_8_2, var_8_1
			end

			local var_6_3 = arg_4_0._dataProxy

			var_4.SetupCalculateDamage(var_6_3, var_6_1)

			local var_6_4 = arg_4_0._dataProxy

			var_4.SetupDamageKamikazeShip(var_6_4, var_0.Battle.BattleFormulas.CalcDamageLockS2M)

			local var_6_5 = arg_4_0._dataProxy

			var_4.SetupDamageCrush(var_6_5, var_6_2)

			local var_6_6 = arg_4_0._uiMediator

			var_4.ShowTimer(var_6_6)

			local var_6_7 = arg_4_0._state

			var_4.ChangeState(var_6_7, var_0.Battle.BattleState.BATTLE_STATE_FIGHT)

			local var_6_8 = arg_4_0._waveUpdater

			var_4.Start(var_6_8)

			return
		end

		SYSTEM_AIRFIGHT = var_2_10004

		var_5_1(var_5_0, var_5_2, var_2_10004)

		local var_5_3 = arg_4_0._dataProxy

		var_0.InitAllFleetUnitsWeaponCD(var_5_3)

		return
	end

	local var_4_2 = arg_4_0._uiMediator

	var_2.SeaSurfaceShift(var_4_2, 1, 15, nil, var_4_1)

	local var_4_3 = arg_4_0._dataProxy

	var_2.AutoStatistics(var_4_3, 0)

	local var_4_4 = arg_4_0._state
	local var_4_5 = var_2.GetSceneMediator(var_4_4)
	local var_4_6 = arg_4_0._uiMediator

	var_3.ShowAirFightScoreBar(var_4_6)

	return
end

function var_0_3.initWaveModule(arg_9_0)
	local function var_9_0(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_9_0._dataProxy

		var_3.SpawnMonster(var_10_0, arg_10_0, arg_10_1, arg_10_2, var_0.Battle.BattleConfig.FOE_CODE)

		return
	end

	local function var_9_1()
		if arg_9_0._vertifyFail then
			pg = var_0

			local var_11_0 = var_0.m02
			local var_11_1 = var_0.sendNotification

			GAME = var_2_10003

			var_11_1(var_11_0, var_2_10003.CHEATER_MARK, {
				reason = arg_9_0._vertifyFail
			})

			return
		end

		local var_11_2 = arg_9_0._dataProxy

		var_0.TriggerFinishBattle(var_11_2)

		local var_11_3 = arg_9_0._dataProxy

		var_0.CalcAirFightScore(var_11_3)

		local var_11_4 = arg_9_0._state

		var_0.BattleEnd(var_11_4)

		return
	end

	arg_9_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(var_9_0, nil, var_9_1, nil)

	return
end

function var_0_3.onBattleDataInitFinished(arg_12_0)
	local var_12_0 = arg_12_0._dataProxy

	var_1.AirFightInit(var_12_0)

	local var_12_1 = arg_12_0._userFleet
	local var_12_2 = var_1.GetScoutList(var_12_1)

	ipairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(var_12_2) do
		iter_12_1:HideWaveFx()
	end

	return
end

function var_0_3.RegisterUnitEvent(arg_13_0, arg_13_1, ...)
	var_0_3.super.RegisterUnitEvent(arg_13_0, arg_13_1, ...)

	if arg_13_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_13_1:RegisterEventListener(arg_13_0, var_0_1.UPDATE_HP, arg_13_0.onPlayerHPUpdate)
	end

	return
end

function var_0_3.UnregisterUnitEvent(arg_14_0, arg_14_1, ...)
	if arg_14_1:GetUnitType() == var_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_14_1:UnregisterEventListener(arg_14_0, var_0_1.UPDATE_HP)
	end

	var_0_3.super.UnregisterUnitEvent(arg_14_0, arg_14_1, ...)

	return
end

local var_0_4 = {}

ShipType = var_5
var_0_4[var_5.YuLeiTing] = 200
ShipType = var_5
var_0_4[var_5.JinBi] = 300
ShipType = var_5
var_0_4[var_5.ZiBao] = 3000
var_0_3.ShipType2Point = var_0_4
var_0_3.BeenHitDecreasePoint = 10

function var_0_3.onWillDie(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.Dispatcher
	local var_15_1 = var_2.GetDeathReason(var_15_0)
	local var_15_2 = var_2:GetTemplate().type

	if (var_15_1 == var_0.Battle.BattleConst.UnitDeathReason.CRUSH or var_15_1 == var_0.Battle.BattleConst.UnitDeathReason.KILLED) and var_0_3.ShipType2Point[var_15_2] and var_5 > 0 then
		local var_15_3 = arg_15_0._dataProxy

		var_6.AddAirFightScore(var_15_3, var_5)
	end

	return
end

function var_0_3.onPlayerHPUpdate(arg_16_0, arg_16_1)
	if arg_16_1.Data.dHP <= 0 then
		local var_16_0 = arg_16_0._dataProxy

		var_2.DecreaseAirFightScore(var_16_0, var_0_3.BeenHitDecreasePoint * -arg_16_1.Data.dHP)
	end

	return
end

return
