ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleVariable
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattlePlayerWeaponVO = var_0_10004("BattlePlayerWeaponVO")
var_0.Battle.BattlePlayerWeaponVO.__name = "BattlePlayerWeaponVO"

local var_0_4 = var_0.Battle.BattlePlayerWeaponVO

function var_0_4.Ctor(arg_1_0, arg_1_1)
	var_0.EventDispatcher.AttachEventDispatcher(arg_1_0)

	arg_1_0._GCD = arg_1_1

	arg_1_0:Reset()

	return
end

function var_0_4.Reset(arg_2_0)
	arg_2_0._isOverLoad = false
	arg_2_0._current = arg_2_0._GCD
	arg_2_0._max = arg_2_0._GCD
	arg_2_0._count = 0
	arg_2_0._total = 0
	arg_2_0._weaponList = {}
	arg_2_0._overHeatList = {}
	arg_2_0._readyList = {}
	arg_2_0._chargingList = {}

	return
end

function var_0_4.Update(arg_3_0, arg_3_1)
	if arg_3_0._current < arg_3_0._max then
		if arg_3_1 - arg_3_0._reloadStartTime >= arg_3_0._max then
			arg_3_0._current = arg_3_0._max
			arg_3_0._reloadStartTime = nil
			ipairs = var_3

			for iter_3_0, iter_3_1 in var_3(arg_3_0._chargingList) do
				iter_3_1:UpdateReload()
			end

			arg_3_0:DispatchOverLoadChange()
		else
			arg_3_0._current = var_2
		end
	end

	return
end

function var_0_4.PlayFocus(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0.Battle.BattleCameraUtil.GetInstance()

	var_3.FocusCharacter(var_4_0, arg_4_1, var_0_1.CAST_CAM_ZOOM_IN_DURATION)

	local var_4_1 = var_0.Battle.BattleCameraUtil.GetInstance()

	var_3.ZoomCamara(var_4_1, nil, var_0_1.CAST_CAM_ZOOM_SIZE, var_0_1.CAST_CAM_ZOOM_IN_DURATION, true)

	local var_4_2 = var_0.Battle.BattleCameraUtil.GetInstance()

	var_3.BulletTime(var_4_2, var_0_1.SPEED_FACTOR_FOCUS_CHARACTER, var_0_1.FOCUS_MAP_RATE, arg_4_1)

	arg_4_0._focus = true

	if arg_4_0._focusTimer then
		pg = var_3
		var_4_2 = var_3.TimeMgr.GetInstance()

		var_3.RemoveBattleTimer(var_4_2, arg_4_0._focusTimer)
	end

	local function var_4_3()
		pg = var_2_10000

		local var_5_0 = var_2_10000.TimeMgr.GetInstance()

		var_0.RemoveBattleTimer(var_5_0, arg_4_0._focusTimer)

		arg_4_0._focusTimer = nil

		arg_4_2()

		return
	end

	pg = var_4_2

	local var_4_4 = var_4_2.TimeMgr.GetInstance()

	arg_4_0._focusTimer = var_4.AddBattleTimer(var_4_4, "", -1, var_0_1.CAST_CAM_ZOOM_IN_DURATION, var_4_3, true)

	return
end

function var_0_4.PlayCutIn(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = var_0.Battle.BattleCameraUtil.GetInstance()

	var_3.CutInPainting(var_6_0, arg_6_1, arg_6_2)

	return
end

function var_0_4.ResetFocus(arg_7_0)
	return
end

function var_0_4.CancelFocus(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.TimeMgr.GetInstance()

	var_1.RemoveBattleTimer(var_8_0, arg_8_0._focusTimer)

	arg_8_0._focusTimer = nil

	return
end

function var_0_4.GetWeaponList(arg_9_0)
	return arg_9_0._weaponList
end

function var_0_4.AppendWeapon(arg_10_0, arg_10_1)
	arg_10_0._weaponList[#arg_10_0._weaponList + 1] = arg_10_1

	if arg_10_1:GetCurrentState() == arg_10_1.STATE_READY then
		arg_10_0._count = arg_10_0._count + 1
	end

	arg_10_0._total = arg_10_0._total + 1

	arg_10_0:DispatchTotalChange()

	arg_10_0._current = arg_10_0._max

	arg_10_0:DispatchOverLoadChange()

	arg_10_0._readyList[#arg_10_0._readyList + 1] = arg_10_1

	return
end

function var_0_4.AppendFreezeWeapon(arg_11_0, arg_11_1)
	arg_11_0._weaponList[#arg_11_0._weaponList + 1] = arg_11_1
	arg_11_0._total = arg_11_0._total + 1

	arg_11_0:DispatchTotalChange()

	if arg_11_1:GetCurrentState() == arg_11_1.STATE_READY then
		arg_11_0._count = arg_11_0._count + 1
		table = var_3

		var_3.insert(arg_11_0._readyList, arg_11_1)
	elseif arg_11_1:GetCDStartTimeStamp() then
		table = var_3

		var_3.insert(arg_11_0._chargingList, arg_11_1)
	else
		table = var_3

		var_3.insert(arg_11_0._overHeatList, arg_11_1)
	end

	arg_11_0:resetCurrent()
	arg_11_0:refreshCD()
	arg_11_0:RefreshReloadingBar()
	arg_11_0:DispatchOverLoadChange()

	return
end

function var_0_4.RemoveWeapon(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.deleteElementFromArray(arg_12_1, arg_12_0._weaponList)

	arg_12_0._total = arg_12_0._total - 1

	if arg_12_1:GetCurrentState() ~= arg_12_1.STATE_OVER_HEAT then
		arg_12_0._count = arg_12_0._count - 1

		if arg_12_0._count < 0 then
			arg_12_0._count = 0
		end

		local var_12_1 = arg_12_0.deleteElementFromArray(arg_12_1, arg_12_0._readyList)

		arg_12_0:DispatchOverLoadChange()
		arg_12_0:DispatchTotalChange(var_12_1)
	else
		if arg_12_0.deleteElementFromArray(arg_12_1, arg_12_0._chargingList) == -1 then
			arg_12_0.deleteElementFromArray(arg_12_1, arg_12_0._overHeatList)
		end

		arg_12_0:DispatchOverLoadChange()
		arg_12_0:DispatchTotalChange()
	end

	arg_12_0:refreshCD()

	return var_12_0
end

function var_0_4.refreshCD(arg_13_0)
	local var_13_0 = #arg_13_0._readyList
	local var_13_1 = #arg_13_0._chargingList

	if var_13_0 ~= 0 then
		arg_13_0._current = 1
		arg_13_0._max = 1
	elseif var_13_0 + var_13_1 == 0 then
		arg_13_0._current = 1
		arg_13_0._max = 1
	else
		local var_13_2 = arg_13_0
		local var_13_3 = arg_13_0.GetNextTimeStamp(var_13_2)

		pg = var_13_2

		local var_13_4 = var_13_2.TimeMgr.GetInstance()
		local var_13_5 = var_13_3 - var_4.GetCombatTime(var_13_4)

		if arg_13_0._current >= arg_13_0._GCD then
			arg_13_0._max = var_13_5
		else
			math = var_5

			local var_13_6 = var_5.max(arg_13_0._max, arg_13_0._GCD)

			math = var_6
			arg_13_0._max = var_6.max(var_13_6 - arg_13_0._current, var_13_5)
		end

		arg_13_0:resetCurrent()
	end

	return
end

function var_0_4.RefreshReloadingBar(arg_14_0)
	if not arg_14_0._reloadStartTime or #arg_14_0._readyList ~= 0 or arg_14_0._max == arg_14_0._GCD then
		return
	end

	local var_14_0 = arg_14_0:GetNextTimeStamp()
	local var_14_1 = arg_14_0._current / arg_14_0._max

	arg_14_0._max = var_14_0 - arg_14_0._reloadStartTime
	arg_14_0._current = var_14_1 * arg_14_0._max

	return
end

function var_0_4.resetCurrent(arg_15_0)
	arg_15_0._current = 0

	local var_15_1

	if not arg_15_0._jammingStarTime then
		pg = var_15_1

		local var_15_0 = var_15_1.TimeMgr.GetInstance()

		var_15_1 = var_15_1.GetCombatTime(var_15_0)
	end

	arg_15_0._reloadStartTime = var_15_1

	return
end

function var_0_4.SetMax(arg_16_0, arg_16_1)
	arg_16_0._max = arg_16_1

	return
end

function var_0_4.GetMax(arg_17_0)
	return arg_17_0._max
end

function var_0_4.GetCurrent(arg_18_0)
	return arg_18_0._current
end

function var_0_4.IsOverLoad(arg_19_0)
	return arg_19_0._current < arg_19_0._max or arg_19_0._count < 1
end

function var_0_4.SetTotal(arg_20_0, arg_20_1)
	arg_20_0._total = arg_20_1

	return
end

function var_0_4.GetTotal(arg_21_0)
	return arg_21_0._total
end

function var_0_4.SetCount(arg_22_0, arg_22_1)
	arg_22_0._count = arg_22_1

	return
end

function var_0_4.GetCount(arg_23_0)
	return arg_23_0._count
end

function var_0_4.GetNextTimeStamp(arg_24_0)
	local var_24_0
	local var_24_2

	if #arg_24_0._chargingList > 0 then
		local var_24_1 = arg_24_0._chargingList[1]

		var_24_2 = var_24_0.GetReloadFinishTimeStamp(var_24_1)
		ipairs = tiemStampB

		for iter_24_0, iter_24_1 in var_24_2(arg_24_0._chargingList) do
			local var_24_3 = iter_24_1:GetReloadFinishTimeStamp()
			local var_24_4 = var_24_0:GetReloadFinishTimeStamp()

			tiemStampB = tiemStampB

			if var_24_3 < var_8 then
				var_24_0 = iter_24_1

				local var_24_5 = tiemStampB
			end
		end
	end

	tiemStampB = var_24_2

	return var_24_2, var_24_0
end

function var_0_4.GetCurrentWeapon(arg_25_0)
	return arg_25_0._readyList[1]
end

function var_0_4.GetHeadWeapon(arg_26_0)
	local var_26_0

	if not arg_26_0:GetCurrentWeapon() and not arg_26_0._chargingList[1] then
		var_26_0 = arg_26_0._overHeatList[1]
	end

	return var_26_0
end

function var_0_4.GetCurrentWeaponIconIndex(arg_27_0)
	return 0
end

function var_0_4.Plus(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0._count

	arg_28_0._count = arg_28_0._count + 1

	arg_28_0:DispatchCountChange()
	arg_28_0.deleteElementFromArray(arg_28_1, arg_28_0._chargingList)

	arg_28_0._readyList[#arg_28_0._readyList + 1] = arg_28_1

	local var_28_1 = var_0.Event.New(var_0.Battle.BattleEvent.WEAPON_COUNT_PLUS)

	arg_28_0:DispatchEvent(var_28_1)
	arg_28_0:DispatchOverLoadChange(var_28_0)

	return
end

function var_0_4.Deduct(arg_29_0, arg_29_1)
	arg_29_0:readyToOverheat(arg_29_1)

	if #arg_29_0._readyList ~= 0 then
		arg_29_0._max = arg_29_0._GCD

		arg_29_0:resetCurrent()
	elseif #arg_29_0._chargingList ~= 0 then
		local var_29_0 = arg_29_0
		local var_29_1 = arg_29_0.GetNextTimeStamp(var_29_0)

		math = var_29_0

		local var_29_2 = var_29_0.max
		local var_29_3 = arg_29_0._GCD

		pg = var_1_10005

		local var_29_4 = var_1_10005.TimeMgr.GetInstance()

		arg_29_0._max = var_29_2(var_29_3, var_29_1 - var_5.GetCombatTime(var_29_4))

		arg_29_0:resetCurrent()
	elseif arg_29_1:GetType() == var_0.Battle.BattleConst.EquipmentType.DISPOSABLE_TORPEDO then
		-- block empty
	else
		arg_29_0._current = 0
	end

	arg_29_0:DispatchOverLoadChange(nil, true)

	return
end

function var_0_4.InitialDeduct(arg_30_0, arg_30_1)
	arg_30_0:readyToOverheat(arg_30_1)
	arg_30_0:DispatchOverLoadChange()

	return
end

function var_0_4.Charge(arg_31_0, arg_31_1)
	arg_31_0.deleteElementFromArray(arg_31_1, arg_31_0._overHeatList)

	local var_31_0 = arg_31_0._chargingList

	var_31_0[#arg_31_0._chargingList + 1] = arg_31_1
	table = var_31_0

	var_31_0.sort(arg_31_0._chargingList, function(arg_32_0, arg_32_1)
		return arg_32_0:GetReloadFinishTimeStamp() < arg_32_1:GetReloadFinishTimeStamp()
	end)

	if #arg_31_0._readyList == 0 then
		local var_31_1 = arg_31_0
		local var_31_2 = arg_31_0.GetNextTimeStamp(var_31_1)

		math = var_31_1

		local var_31_3 = var_31_1.max
		local var_31_4 = arg_31_0._GCD

		pg = var_1_10005

		local var_31_5 = var_1_10005.TimeMgr.GetInstance()

		arg_31_0._max = var_31_3(var_31_4, var_31_2 - var_5.GetCombatTime(var_31_5))

		arg_31_0:resetCurrent()
	end

	arg_31_0:DispatchCountChange()

	return
end

function var_0_4.ReloadBoost(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0, var_33_1 = arg_33_0:GetNextTimeStamp()

	arg_33_1:ReloadBoost(arg_33_2)

	local var_33_2, var_33_3 = arg_33_0:GetNextTimeStamp()

	if var_33_1 ~= arg_33_1 and var_33_3 ~= arg_33_1 then
		-- block empty
	elseif var_33_1 == arg_33_1 and var_33_3 == arg_33_1 then
		arg_33_0:RefreshReloadingBar()
	elseif var_33_1 ~= var_33_3 then
		arg_33_0:RefreshReloadingBar()
	end

	return
end

function var_0_4.InstantCoolDown(arg_34_0, arg_34_1)
	arg_34_0.deleteElementFromArray(arg_34_1, arg_34_0._overHeatList)

	if arg_34_0._current >= arg_34_0._GCD then
		arg_34_0._current = arg_34_0._max
		arg_34_0._reloadStartTime = nil
	else
		arg_34_0._max = arg_34_0._GCD - arg_34_0._current

		arg_34_0:resetCurrent()
	end

	arg_34_0:Plus(arg_34_1)

	return
end

function var_0_4.DispatchBlink(arg_35_0, arg_35_1)
	local var_35_0 = {
		value = arg_35_1
	}
	local var_35_1 = var_0.Event.New(var_0.Battle.BattleEvent.WEAPON_BUTTON_BLINK, var_35_0)

	arg_35_0:DispatchEvent(var_35_1)

	return
end

function var_0_4.DispatchTotalChange(arg_36_0, arg_36_1)
	local var_36_0 = var_0.Event.New(var_0.Battle.BattleEvent.WEAPON_TOTAL_CHANGE, {
		index = arg_36_1
	})

	arg_36_0:DispatchEvent(var_36_0)

	return
end

function var_0_4.DispatchOverLoadChange(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = var_0.Event.New(var_0.Battle.BattleEvent.OVER_LOAD_CHANGE, {
		preCast = arg_37_1,
		postCast = arg_37_2
	})

	arg_37_0:DispatchEvent(var_37_0)

	return
end

function var_0_4.DispatchCountChange(arg_38_0)
	local var_38_0 = var_0.Event.New(var_0.Battle.BattleEvent.COUNT_CHANGE)

	arg_38_0:DispatchEvent(var_38_0)

	return
end

function var_0_4.DispatchInitSubIcon(arg_39_0)
	local var_39_0 = var_0.Event.New(var_0.Battle.BattleEvent.INIT_SUB_ICON)

	arg_39_0:DispatchEvent(var_39_0)

	return
end

function var_0_4.StartJamming(arg_40_0)
	pg = var_1_10001

	local var_40_0 = var_1_10001.TimeMgr.GetInstance()

	arg_40_0._jammingStarTime = var_1.GetCombatTime(var_40_0)
	ipairs = var_1

	for iter_40_0, iter_40_1 in var_1(arg_40_0._chargingList) do
		iter_40_1:StartJamming()
	end

	return
end

function var_0_4.JammingEliminate(arg_41_0)
	ipairs = var_1_10001

	for iter_41_0, iter_41_1 in var_1_10001(arg_41_0._chargingList) do
		iter_41_1:JammingEliminate()
	end

	if arg_41_0._reloadStartTime then
		pg = var_1

		local var_41_0 = var_1.TimeMgr.GetInstance()
		local var_41_1 = var_1.GetCombatTime(var_41_0)

		if #arg_41_0._readyList ~= 0 then
			arg_41_0._max = arg_41_0._GCD
		else
			arg_41_0._max = arg_41_0:GetNextTimeStamp() - var_41_1 + arg_41_0._current
		end

		arg_41_0._reloadStartTime = arg_41_0._reloadStartTime + (var_41_1 - arg_41_0._jammingStarTime)
	end

	arg_41_0._jammingStarTime = nil

	return
end

function var_0_4.Dispose(arg_42_0)
	pg = var_1_10001

	local var_42_0 = var_1_10001.TimeMgr.GetInstance()

	var_1.RemoveBattleTimer(var_42_0, arg_42_0._focusTimer)

	arg_42_0._focusTimer = nil

	var_0.EventDispatcher.DetachEventDispatcher(arg_42_0)

	return
end

function var_0_4.readyToOverheat(arg_43_0, arg_43_1)
	arg_43_0.deleteElementFromArray(arg_43_1, arg_43_0._readyList)

	arg_43_0._overHeatList[#arg_43_0._overHeatList + 1] = arg_43_1
	arg_43_0._count = arg_43_0._count - 1

	if arg_43_0._count < 0 then
		arg_43_0._count = 0
	end

	arg_43_0:DispatchCountChange()

	return
end

function var_0_4.deleteElementFromArray(arg_44_0, arg_44_1)
	local var_44_0

	ipairs = var_1_10003

	for iter_44_0, iter_44_1 in var_1_10003(arg_44_1) do
		if arg_44_0 == iter_44_1 then
			var_44_0 = iter_44_0

			break
		end
	end

	if var_44_0 == nil then
		return -1
	end

	for iter_44_2 = var_44_0, #arg_44_1 do
		if arg_44_1[iter_44_2 + 1] ~= nil then
			arg_44_1[iter_44_2] = arg_44_1[iter_44_2 + 1]
		else
			arg_44_1[iter_44_2] = nil
		end
	end

	return var_44_0
end

return
