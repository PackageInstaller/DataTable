ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleAttr
local var_0_3 = var_0_1.AntiAirConfig
local var_0_4 = var_0.Battle

class = var_0_10005
var_0_4.BattleAntiAirWeaponVO = var_0_10005("BattleAntiAirWeaponVO", var_0.Battle.BattlePlayerWeaponVO)
var_0.Battle.BattleAntiAirWeaponVO.__name = "BattleAntiAirWeaponVO"

local var_0_5 = var_0.Battle.BattleAntiAirWeaponVO

function var_0_5.Ctor(arg_1_0, arg_1_1)
	var_0_5.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._restoreDenominator = var_0_3.const_A

	arg_1_0:ResetCost()

	arg_1_0._restoreInterval = var_0_3.Restore_Interval

	return
end

function var_0_5.SetBattleFleetVO(arg_2_0, arg_2_1)
	arg_2_0._battleFleetVO = arg_2_1

	return
end

function var_0_5.AppendWeapon(arg_3_0, arg_3_1)
	var_0_5.super.AppendWeapon(arg_3_0, arg_3_1)
	arg_3_1:SetTotalDurabilityInfo(arg_3_0)

	return
end

function var_0_5.RemoveWeapon(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.deleteElementFromArray(arg_4_1, arg_4_0._weaponList)

	arg_4_0._total = arg_4_0._total - 1
	arg_4_0._count = arg_4_0._count - 1

	return var_4_0
end

function var_0_5.SetMax(arg_5_0, arg_5_1)
	if arg_5_1 > arg_5_0._max then
		arg_5_0._current = arg_5_0._current + (arg_5_1 - arg_5_0._max)
	end

	var_0_5.super.SetMax(arg_5_0, arg_5_1)

	if arg_5_0._current > arg_5_0._max then
		arg_5_0._current = arg_5_0._max
	end

	return
end

function var_0_5.SetAverageReload(arg_6_0, arg_6_1)
	arg_6_0._fleetReload = arg_6_1

	return
end

function var_0_5.GetMaxRange(arg_7_0)
	local var_7_0 = arg_7_0._battleFleetVO
	local var_7_1 = var_1.GetScoutList(var_7_0)
	local var_7_2 = 0

	if #var_7_1 > 0 then
		local var_7_3

		for iter_7_0 = 1, var_3 do
			local var_7_4 = var_7_1[iter_7_0]

			if #var_9.GetAntiAirWeapon(var_7_4) > 0 then
				var_7_3 = var_7_1[iter_7_0]

				break
			end
		end

		if var_7_3 then
			local var_7_5 = var_7_3
			local var_7_6 = var_7_3.GetAntiAirWeapon(var_7_5)

			ipairs = var_7_5

			for iter_7_1, iter_7_2 in var_7_5(var_7_6) do
				math = var_1_10011
				var_7_2 = var_1_10011.max(var_7_2, iter_7_2:GetTemplateData().range)
			end
		end
	end

	return var_7_2
end

function var_0_5.SetActive(arg_8_0, arg_8_1)
	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0._weaponList) do
		iter_8_1:SetActive(arg_8_1)
	end

	return
end

function var_0_5.Restore(arg_9_0)
	arg_9_0._current = arg_9_0._current + arg_9_0._fleetReload / arg_9_0._restoreDenominator

	arg_9_0:checkRestorState()

	return
end

function var_0_5.RestoreRate(arg_10_0, arg_10_1)
	arg_10_0._current = arg_10_0._current + arg_10_0._max * arg_10_1

	arg_10_0:checkRestorState()

	return
end

function var_0_5.checkRestorState(arg_11_0)
	if arg_11_0._current >= arg_11_0._max then
		arg_11_0._current = arg_11_0._max
		arg_11_0._restoreDenominator = var_0_3.const_A
		arg_11_0._isOverLoad = false

		arg_11_0:RemoveRestoreTimer()
		arg_11_0:DispatchOverLoadChange()
	end

	return
end

function var_0_5.Consume(arg_12_0)
	arg_12_0:RemoveRestoreTimer()

	arg_12_0._current = arg_12_0._current - arg_12_0._consumeNormal

	if arg_12_0._current <= 0 then
		arg_12_0._current = 0
		arg_12_0._restoreDenominator = var_0_3.const_B
		arg_12_0._isOverLoad = true

		arg_12_0:DispatchOverLoadChange()
	end

	return
end

function var_0_5.ResetCost(arg_13_0, arg_13_1)
	arg_13_0._consumeNormal = arg_13_1 or var_0_3.const_N

	return
end

function var_0_5.AddRestoreTimer(arg_14_0)
	if not arg_14_0._restoreTimer then
		local var_14_0 = arg_14_0._current

		if arg_14_0._max <= var_14_0 then
			return
		end

		local function var_14_1()
			local var_15_0 = arg_14_0

			var_0.Restore(var_15_0)

			return
		end

		pg = var_1_10002

		local var_14_2 = var_1_10002.TimeMgr.GetInstance()

		arg_14_0._restoreTimer = var_2.AddBattleTimer(var_14_2, "AARestoreTimer", -1, arg_14_0._restoreInterval, var_14_1, true)

		return
	end
end

function var_0_5.RemoveRestoreTimer(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.TimeMgr.GetInstance()

	var_1.RemoveBattleTimer(var_16_0, arg_16_0._restoreTimer)

	arg_16_0._restoreTimer = nil

	return
end

function var_0_5.Dispose(arg_17_0)
	arg_17_0._battleFleetVO = nil

	var_0_5.super.Dispose(arg_17_0)

	return
end

return
