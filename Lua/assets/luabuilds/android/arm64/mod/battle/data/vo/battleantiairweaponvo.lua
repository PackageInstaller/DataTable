ys = ys or {}

local var_0_1 = ys.Battle.BattleConfig.AntiAirConfig

ys.Battle.BattleAntiAirWeaponVO = class("BattleAntiAirWeaponVO", ys.Battle.BattlePlayerWeaponVO)
ys.Battle.BattleAntiAirWeaponVO.__name = "BattleAntiAirWeaponVO"

local var_0_2 = ys.Battle.BattleAntiAirWeaponVO

function ys.Battle.BattleAntiAirWeaponVO.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._restoreDenominator = var_0_1.const_A

	arg_1_0:ResetCost()

	arg_1_0._restoreInterval = var_0_1.Restore_Interval

	return
end

function ys.Battle.BattleAntiAirWeaponVO.SetBattleFleetVO(arg_2_0, arg_2_1)
	arg_2_0._battleFleetVO = arg_2_1

	return
end

function ys.Battle.BattleAntiAirWeaponVO.AppendWeapon(arg_3_0, arg_3_1)
	var_0_2.super.AppendWeapon(arg_3_0, arg_3_1)
	arg_3_1:SetTotalDurabilityInfo(arg_3_0)

	return
end

function ys.Battle.BattleAntiAirWeaponVO.RemoveWeapon(arg_4_0, arg_4_1)
	arg_4_0._total = arg_4_0._total - 1
	arg_4_0._count = arg_4_0._count - 1

	return (arg_4_0.deleteElementFromArray(arg_4_1, arg_4_0._weaponList))
end

function ys.Battle.BattleAntiAirWeaponVO.SetMax(arg_5_0, arg_5_1)
	if arg_5_1 > arg_5_0._max then
		arg_5_0._current = arg_5_0._current + (arg_5_1 - arg_5_0._max)
	end

	var_0_2.super.SetMax(arg_5_0, arg_5_1)

	if arg_5_0._current > arg_5_0._max then
		arg_5_0._current = arg_5_0._max
	end

	return
end

function ys.Battle.BattleAntiAirWeaponVO.SetAverageReload(arg_6_0, arg_6_1)
	arg_6_0._fleetReload = arg_6_1

	return
end

function ys.Battle.BattleAntiAirWeaponVO.GetMaxRange(arg_7_0)
	local var_7_0 = arg_7_0._battleFleetVO:GetScoutList()
	local var_7_1 = 0

	if #var_7_0 > 0 then
		local var_7_2

		for iter_7_0 = 1, #var_7_0 do
			if #var_7_0[iter_7_0]:GetAntiAirWeapon() > 0 then
				var_7_2 = var_7_0[iter_7_0]

				break
			end
		end

		if var_7_2 then
			for iter_7_1, iter_7_2 in ipairs((var_7_2:GetAntiAirWeapon())) do
				var_7_1 = math.max(var_7_1, iter_7_2:GetTemplateData().range)
			end
		end
	end

	return var_7_1
end

function ys.Battle.BattleAntiAirWeaponVO.SetActive(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._weaponList) do
		iter_8_1:SetActive(arg_8_1)
	end

	return
end

function ys.Battle.BattleAntiAirWeaponVO.Restore(arg_9_0)
	arg_9_0._current = arg_9_0._current + arg_9_0._fleetReload / arg_9_0._restoreDenominator

	arg_9_0:checkRestorState()

	return
end

function ys.Battle.BattleAntiAirWeaponVO.RestoreRate(arg_10_0, arg_10_1)
	arg_10_0._current = arg_10_0._current + arg_10_0._max * arg_10_1

	arg_10_0:checkRestorState()

	return
end

function ys.Battle.BattleAntiAirWeaponVO.checkRestorState(arg_11_0)
	if arg_11_0._current >= arg_11_0._max then
		arg_11_0._current = arg_11_0._max
		arg_11_0._restoreDenominator = var_0_1.const_A
		arg_11_0._isOverLoad = false

		arg_11_0:RemoveRestoreTimer()
		arg_11_0:DispatchOverLoadChange()
	end

	return
end

function ys.Battle.BattleAntiAirWeaponVO.Consume(arg_12_0)
	arg_12_0:RemoveRestoreTimer()

	arg_12_0._current = arg_12_0._current - arg_12_0._consumeNormal

	if arg_12_0._current <= 0 then
		arg_12_0._current = 0
		arg_12_0._restoreDenominator = var_0_1.const_B
		arg_12_0._isOverLoad = true

		arg_12_0:DispatchOverLoadChange()
	end

	return
end

function ys.Battle.BattleAntiAirWeaponVO.ResetCost(arg_13_0, arg_13_1)
	arg_13_0._consumeNormal = arg_13_1 or var_0_1.const_N

	return
end

function ys.Battle.BattleAntiAirWeaponVO.AddRestoreTimer(arg_14_0)
	if arg_14_0._restoreTimer or arg_14_0._current >= arg_14_0._max then
		return
	end

	arg_14_0._restoreTimer = pg.TimeMgr.GetInstance():AddBattleTimer("AARestoreTimer", -1, arg_14_0._restoreInterval, function()
		arg_14_0:Restore()

		return
	end, true)

	return
end

function ys.Battle.BattleAntiAirWeaponVO.RemoveRestoreTimer(arg_16_0)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_16_0._restoreTimer)

	arg_16_0._restoreTimer = nil

	return
end

function ys.Battle.BattleAntiAirWeaponVO.Dispose(arg_17_0)
	arg_17_0._battleFleetVO = nil

	var_0_2.super.Dispose(arg_17_0)

	return
end

return
