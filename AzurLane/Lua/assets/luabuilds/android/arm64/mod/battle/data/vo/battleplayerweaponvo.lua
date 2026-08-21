ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig

ys.Battle.BattlePlayerWeaponVO = class("BattlePlayerWeaponVO")
ys.Battle.BattlePlayerWeaponVO.__name = "BattlePlayerWeaponVO"

function ys.Battle.BattlePlayerWeaponVO.Ctor(arg_1_0, arg_1_1)
	var_0_0.EventDispatcher.AttachEventDispatcher(arg_1_0)

	arg_1_0._GCD = arg_1_1

	arg_1_0:Reset()

	return
end

function ys.Battle.BattlePlayerWeaponVO.Reset(arg_2_0)
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

function ys.Battle.BattlePlayerWeaponVO.Update(arg_3_0, arg_3_1)
	if arg_3_0._current < arg_3_0._max then
		if arg_3_1 - arg_3_0._reloadStartTime >= arg_3_0._max then
			arg_3_0._current = arg_3_0._max
			arg_3_0._reloadStartTime = nil

			for iter_3_0, iter_3_1 in ipairs(arg_3_0._chargingList) do
				iter_3_1:UpdateReload()
			end

			arg_3_0:DispatchOverLoadChange()
		else
			arg_3_0._current = arg_3_1 - arg_3_0._reloadStartTime
		end
	end

	return
end

function ys.Battle.BattlePlayerWeaponVO.PlayFocus(arg_4_0, arg_4_1, arg_4_2)
	var_0_0.Battle.BattleCameraUtil.GetInstance():FocusCharacter(arg_4_1, var_0_1.CAST_CAM_ZOOM_IN_DURATION)
	var_0_0.Battle.BattleCameraUtil.GetInstance():ZoomCamara(nil, var_0_1.CAST_CAM_ZOOM_SIZE, var_0_1.CAST_CAM_ZOOM_IN_DURATION, true)
	var_0_0.Battle.BattleCameraUtil.GetInstance():BulletTime(var_0_1.SPEED_FACTOR_FOCUS_CHARACTER, var_0_1.FOCUS_MAP_RATE, arg_4_1)

	arg_4_0._focus = true

	if arg_4_0._focusTimer then
		pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_4_0._focusTimer)
	end

	arg_4_0._focusTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", -1, var_0_1.CAST_CAM_ZOOM_IN_DURATION, function()
		pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_4_0._focusTimer)

		arg_4_0._focusTimer = nil

		arg_4_2()

		return
	end, true)

	return
end

function ys.Battle.BattlePlayerWeaponVO.PlayCutIn(arg_6_0, arg_6_1, arg_6_2)
	var_0_0.Battle.BattleCameraUtil.GetInstance():CutInPainting(arg_6_1, arg_6_2)

	return
end

function ys.Battle.BattlePlayerWeaponVO.ResetFocus(arg_7_0)
	return
end

function ys.Battle.BattlePlayerWeaponVO.CancelFocus(arg_8_0)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_8_0._focusTimer)

	arg_8_0._focusTimer = nil

	return
end

function ys.Battle.BattlePlayerWeaponVO.GetWeaponList(arg_9_0)
	return arg_9_0._weaponList
end

function ys.Battle.BattlePlayerWeaponVO.AppendWeapon(arg_10_0, arg_10_1)
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

function ys.Battle.BattlePlayerWeaponVO.AppendFreezeWeapon(arg_11_0, arg_11_1)
	arg_11_0._weaponList[#arg_11_0._weaponList + 1] = arg_11_1
	arg_11_0._total = arg_11_0._total + 1

	arg_11_0:DispatchTotalChange()

	if arg_11_1:GetCurrentState() == arg_11_1.STATE_READY then
		arg_11_0._count = arg_11_0._count + 1

		table.insert(arg_11_0._readyList, arg_11_1)
	elseif arg_11_1:GetCDStartTimeStamp() then
		table.insert(arg_11_0._chargingList, arg_11_1)
	else
		table.insert(arg_11_0._overHeatList, arg_11_1)
	end

	arg_11_0:resetCurrent()
	arg_11_0:refreshCD()
	arg_11_0:RefreshReloadingBar()
	arg_11_0:DispatchOverLoadChange()

	return
end

function ys.Battle.BattlePlayerWeaponVO.RemoveWeapon(arg_12_0, arg_12_1)
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

function ys.Battle.BattlePlayerWeaponVO.refreshCD(arg_13_0)
	if #arg_13_0._readyList ~= 0 then
		arg_13_0._current = 1
		arg_13_0._max = 1
	elseif #arg_13_0._readyList + #arg_13_0._chargingList == 0 then
		arg_13_0._current = 1
		arg_13_0._max = 1
	else
		local var_13_0 = arg_13_0:GetNextTimeStamp() - pg.TimeMgr.GetInstance():GetCombatTime()

		arg_13_0._max = arg_13_0._current >= arg_13_0._GCD and var_13_0 or math.max(math.max(arg_13_0._max, arg_13_0._GCD) - arg_13_0._current, var_13_0)

		arg_13_0:resetCurrent()
	end

	return
end

function ys.Battle.BattlePlayerWeaponVO.RefreshReloadingBar(arg_14_0)
	if not arg_14_0._reloadStartTime or #arg_14_0._readyList ~= 0 or arg_14_0._max == arg_14_0._GCD then
		return
	end

	arg_14_0._max = arg_14_0:GetNextTimeStamp() - arg_14_0._reloadStartTime
	arg_14_0._current = arg_14_0._current / arg_14_0._max * arg_14_0._max

	return
end

function ys.Battle.BattlePlayerWeaponVO.resetCurrent(arg_15_0)
	arg_15_0._current = 0
	arg_15_0._reloadStartTime = arg_15_0._jammingStarTime or pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function ys.Battle.BattlePlayerWeaponVO.SetMax(arg_16_0, arg_16_1)
	arg_16_0._max = arg_16_1

	return
end

function ys.Battle.BattlePlayerWeaponVO.GetMax(arg_17_0)
	return arg_17_0._max
end

function ys.Battle.BattlePlayerWeaponVO.GetCurrent(arg_18_0)
	return arg_18_0._current
end

function ys.Battle.BattlePlayerWeaponVO.IsOverLoad(arg_19_0)
	return arg_19_0._current < arg_19_0._max or arg_19_0._count < 1
end

function ys.Battle.BattlePlayerWeaponVO.SetTotal(arg_20_0, arg_20_1)
	arg_20_0._total = arg_20_1

	return
end

function ys.Battle.BattlePlayerWeaponVO.GetTotal(arg_21_0)
	return arg_21_0._total
end

function ys.Battle.BattlePlayerWeaponVO.SetCount(arg_22_0, arg_22_1)
	arg_22_0._count = arg_22_1

	return
end

function ys.Battle.BattlePlayerWeaponVO.GetCount(arg_23_0)
	return arg_23_0._count
end

function ys.Battle.BattlePlayerWeaponVO.GetNextTimeStamp(arg_24_0)
	local var_24_0

	if #arg_24_0._chargingList > 0 then
		var_24_0 = arg_24_0._chargingList[1]
		tiemStampB = arg_24_0._chargingList[1]:GetReloadFinishTimeStamp()

		for iter_24_0, iter_24_1 in ipairs(arg_24_0._chargingList) do
			local var_24_1 = iter_24_1:GetReloadFinishTimeStamp()

			tiemStampB = var_24_0:GetReloadFinishTimeStamp()

			if var_24_1 < tiemStampB then
				var_24_0 = iter_24_1
				tiemStampB = var_24_1
			end
		end
	end

	return tiemStampB, var_24_0
end

function ys.Battle.BattlePlayerWeaponVO.GetCurrentWeapon(arg_25_0)
	return arg_25_0._readyList[1]
end

function ys.Battle.BattlePlayerWeaponVO.GetHeadWeapon(arg_26_0)
	return arg_26_0:GetCurrentWeapon() or arg_26_0._chargingList[1] or arg_26_0._overHeatList[1]
end

function ys.Battle.BattlePlayerWeaponVO.GetCurrentWeaponIconIndex(arg_27_0)
	return 0
end

function ys.Battle.BattlePlayerWeaponVO.Plus(arg_28_0, arg_28_1)
	arg_28_0._count = arg_28_0._count + 1

	arg_28_0:DispatchCountChange()
	arg_28_0.deleteElementFromArray(arg_28_1, arg_28_0._chargingList)

	arg_28_0._readyList[#arg_28_0._readyList + 1] = arg_28_1

	arg_28_0:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.WEAPON_COUNT_PLUS)))
	arg_28_0:DispatchOverLoadChange(arg_28_0._count)

	return
end

function ys.Battle.BattlePlayerWeaponVO.Deduct(arg_29_0, arg_29_1)
	arg_29_0:readyToOverheat(arg_29_1)

	if #arg_29_0._readyList ~= 0 then
		arg_29_0._max = arg_29_0._GCD

		arg_29_0:resetCurrent()
	elseif #arg_29_0._chargingList ~= 0 then
		arg_29_0._max = math.max(arg_29_0._GCD, arg_29_0:GetNextTimeStamp() - pg.TimeMgr.GetInstance():GetCombatTime())

		arg_29_0:resetCurrent()
	elseif arg_29_1:GetType() == var_0_0.Battle.BattleConst.EquipmentType.DISPOSABLE_TORPEDO then
		-- block empty
	else
		arg_29_0._current = 0
	end

	arg_29_0:DispatchOverLoadChange(nil, true)

	return
end

function ys.Battle.BattlePlayerWeaponVO.InitialDeduct(arg_30_0, arg_30_1)
	arg_30_0:readyToOverheat(arg_30_1)
	arg_30_0:DispatchOverLoadChange()

	return
end

function ys.Battle.BattlePlayerWeaponVO.Charge(arg_31_0, arg_31_1)
	arg_31_0.deleteElementFromArray(arg_31_1, arg_31_0._overHeatList)

	arg_31_0._chargingList[#arg_31_0._chargingList + 1] = arg_31_1

	table.sort(arg_31_0._chargingList, function(arg_32_0, arg_32_1)
		return arg_32_0:GetReloadFinishTimeStamp() < arg_32_1:GetReloadFinishTimeStamp()
	end)

	if #arg_31_0._readyList == 0 then
		arg_31_0._max = math.max(arg_31_0._GCD, arg_31_0:GetNextTimeStamp() - pg.TimeMgr.GetInstance():GetCombatTime())

		arg_31_0:resetCurrent()
	end

	arg_31_0:DispatchCountChange()

	return
end

function ys.Battle.BattlePlayerWeaponVO.ReloadBoost(arg_33_0, arg_33_1, arg_33_2)
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

function ys.Battle.BattlePlayerWeaponVO.InstantCoolDown(arg_34_0, arg_34_1)
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

function ys.Battle.BattlePlayerWeaponVO.DispatchBlink(arg_35_0, arg_35_1)
	arg_35_0:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.WEAPON_BUTTON_BLINK, {
		value = arg_35_1
	})))

	return
end

function ys.Battle.BattlePlayerWeaponVO.DispatchTotalChange(arg_36_0, arg_36_1)
	arg_36_0:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.WEAPON_TOTAL_CHANGE, {
		index = arg_36_1
	})))

	return
end

function ys.Battle.BattlePlayerWeaponVO.DispatchOverLoadChange(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.OVER_LOAD_CHANGE, {
		preCast = arg_37_1,
		postCast = arg_37_2
	})))

	return
end

function ys.Battle.BattlePlayerWeaponVO.DispatchCountChange(arg_38_0)
	arg_38_0:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.COUNT_CHANGE)))

	return
end

function ys.Battle.BattlePlayerWeaponVO.DispatchInitSubIcon(arg_39_0)
	arg_39_0:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.INIT_SUB_ICON)))

	return
end

function ys.Battle.BattlePlayerWeaponVO.StartJamming(arg_40_0)
	arg_40_0._jammingStarTime = pg.TimeMgr.GetInstance():GetCombatTime()

	for iter_40_0, iter_40_1 in ipairs(arg_40_0._chargingList) do
		iter_40_1:StartJamming()
	end

	return
end

function ys.Battle.BattlePlayerWeaponVO.JammingEliminate(arg_41_0)
	for iter_41_0, iter_41_1 in ipairs(arg_41_0._chargingList) do
		iter_41_1:JammingEliminate()
	end

	if arg_41_0._reloadStartTime then
		local var_41_0 = pg.TimeMgr.GetInstance():GetCombatTime()

		arg_41_0._max = #arg_41_0._readyList ~= 0 and arg_41_0._GCD or arg_41_0:GetNextTimeStamp() - var_41_0 + arg_41_0._current
		arg_41_0._reloadStartTime = arg_41_0._reloadStartTime + (var_41_0 - arg_41_0._jammingStarTime)
	end

	arg_41_0._jammingStarTime = nil

	return
end

function ys.Battle.BattlePlayerWeaponVO.Dispose(arg_42_0)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_42_0._focusTimer)

	arg_42_0._focusTimer = nil

	var_0_0.EventDispatcher.DetachEventDispatcher(arg_42_0)

	return
end

function ys.Battle.BattlePlayerWeaponVO.readyToOverheat(arg_43_0, arg_43_1)
	arg_43_0.deleteElementFromArray(arg_43_1, arg_43_0._readyList)

	arg_43_0._overHeatList[#arg_43_0._overHeatList + 1] = arg_43_1
	arg_43_0._count = arg_43_0._count - 1

	if arg_43_0._count < 0 then
		arg_43_0._count = 0
	end

	arg_43_0:DispatchCountChange()

	return
end

function ys.Battle.BattlePlayerWeaponVO.deleteElementFromArray(arg_44_0, arg_44_1)
	local var_44_0

	for iter_44_0, iter_44_1 in ipairs(arg_44_1) do
		if arg_44_0 == iter_44_1 then
			var_44_0 = iter_44_0

			break
		end
	end

	if var_44_0 == nil then
		return -1
	end

	for iter_44_2 = var_44_0, #arg_44_1 do
		arg_44_1[iter_44_2] = arg_44_1[iter_44_2 + 1] ~= nil and arg_44_1[iter_44_2 + 1] or nil
	end

	return var_44_0
end

return
