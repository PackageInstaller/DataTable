local var_0_0 = class("NewBattleResultDisplayPaintingsPage", import("view.base.BaseSubView"))
local var_0_1 = 6
local var_0_2 = 295

function var_0_0.getUIName(arg_1_0)
	return "NewBattleResultDisplayPaintingsPages"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.slots = {
		arg_2_0._tf:Find("tpl")
	}
	arg_2_0.defaultPaintingPosition = arg_2_0._tf:Find("tpl/mask/painting").anchoredPosition

	return
end

function var_0_0.StaticGetFinalExpandPosition(arg_3_0)
	if arg_3_0 <= var_0_1 then
		return var_0_0.StaticGetExpandPosition(arg_3_0, var_0_1 - 1)
	else
		return var_0_0.StaticGetExpandPosition(arg_3_0, arg_3_0 - 1) - (arg_3_0 - var_0_1) * Vector2(var_0_2, 0)
	end

	return
end

function var_0_0.StaticGetExpandPosition(arg_4_0, arg_4_1)
	local var_4_0 = math.ceil(arg_4_1 / 2)
	local var_4_1 = arg_4_1 % 2 ~= 0
	local var_4_2 = (arg_4_0 > 6 and arg_4_0 % 2 == 0 or arg_4_0 <= 6) and (var_4_1 and Vector2(-730, 72) or Vector2(-457, -72)) or var_4_1 and Vector2(-751, -72) or Vector2(-437, 72)

	return var_4_2 + Vector2(590, 0) * (var_4_0 - 1)
end

function var_0_0.GetExpandPosition(arg_5_0, arg_5_1, arg_5_2)
	return var_0_0.StaticGetExpandPosition(arg_5_1, arg_5_2)
end

function var_0_0.GetShrinkPosition(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:GetExpandPosition(arg_6_1, arg_6_2)
	local var_6_1 = arg_6_2 % 2 ~= 0
	local var_6_2 = Vector2(-125, -936)

	if arg_6_1 > 6 and arg_6_1 % 2 == 0 or arg_6_1 <= 6 then
		if var_6_1 then
			do return var_6_0 - var_6_2 or var_6_0 + var_6_2 end

			goto label_6_0

			::label_6_0::

			if var_6_1 then
				do
					return var_6_0 + var_6_2 or var_6_0 - var_6_2
				end

				return
			end
		end
	end
end

function var_0_0.SetUp(arg_7_0, arg_7_1)
	arg_7_0:Show()

	arg_7_0.displayShips = arg_7_0:ReSortFleetShips()

	seriesAsync({
		function(arg_8_0)
			arg_7_0:InitMainFleetShips(arg_8_0)

			return
		end,
		function(arg_9_0)
			arg_7_0:DisplayMainFleet(arg_9_0)

			return
		end,
		function(arg_10_0)
			arg_7_0:MoveMainFleetShips(arg_10_0)

			return
		end,
		function(arg_11_0)
			arg_7_0:InitSubFleetShips(arg_11_0)

			return
		end,
		function(arg_12_0)
			arg_7_0:DisplaySubFleet(arg_12_0)

			return
		end,
		function(arg_13_0)
			onDelayTick(arg_13_0, 0.5)

			return
		end
	}, function()
		arg_7_1()

		return
	end)

	return
end

function var_0_0.ReSortFleetShips(arg_15_0)
	local var_15_0, var_15_1, var_15_2, var_15_3 = NewBattleResultUtil.SeparateMvpShip(arg_15_0.contextData.oldMainShips, arg_15_0.contextData.statistics.mvpShipID, arg_15_0.contextData.statistics._flagShipID)
	local var_15_4 = {}

	if var_15_3 ~= nil then
		local var_15_5 = ShipType.GetTeamFromShipType(ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(var_15_3.configId).type)

		if var_15_5 == TeamType.Vanguard then
			NewBattleResultUtil.SpecialInsertItem(var_15_4, var_15_2, var_15_1, var_15_0, var_15_3)
		elseif var_15_5 == TeamType.Main then
			NewBattleResultUtil.SpecialInsertItem(var_15_4, var_15_2, var_15_0, var_15_1, var_15_3)
		elseif var_15_5 == TeamType.Submarine then
			NewBattleResultUtil.SpecialInsertItem(var_15_4, var_15_0, var_15_1, var_15_2, var_15_3)
		end
	else
		var_15_4 = arg_15_0.contextData.oldMainShips
	end

	return var_15_4
end

function var_0_0.InitSubFleetShips(arg_16_0, arg_16_1)
	if arg_16_0.exited then
		return
	end

	local var_16_0 = arg_16_0.displayShips

	if #arg_16_0.displayShips <= var_0_1 then
		arg_16_1()

		return
	end

	for iter_16_0 = 1, #var_16_0 - var_0_1 do
		if arg_16_0.slots[iter_16_0] then
			arg_16_0:RevertPainting(arg_16_0.slots[iter_16_0])
			retPaintingPrefab(arg_16_0.slots[iter_16_0]:Find("mask/painting"), var_16_0[iter_16_0]:getPainting())
		end
	end

	for iter_16_1 = var_0_1 + 1, math.max(var_0_1, #var_16_0) do
		local var_16_1 = Object.Instantiate(arg_16_0.slots[1], arg_16_0.slots[1].parent)

		table.insert(arg_16_0.slots, var_16_1)

		local var_16_2 = var_16_0[iter_16_1]

		var_16_1.localPosition = arg_16_0:GetExpandPosition(#var_16_0, iter_16_1)

		table.insert({}, function(arg_17_0)
			setPaintingPrefabAsync(var_16_1:Find("mask/painting"), var_16_2:getPainting(), "biandui", arg_17_0)
			arg_16_0:AdjustPainting(var_16_1, var_16_2)

			return
		end)
	end

	parallelAsync({}, function()
		onDelayTick(arg_16_1, 0.05)

		return
	end)

	return
end

function var_0_0.DisplaySubFleet(arg_19_0, arg_19_1)
	if arg_19_0.exited then
		return
	end

	arg_19_0:EffectSlots(false)

	if #arg_19_0.displayShips <= var_0_1 then
		arg_19_1()

		return
	end

	local var_19_0 = {}

	for iter_19_0 = var_0_1 + 1, math.max(var_0_1, #arg_19_0.displayShips) do
		local var_19_1 = arg_19_0.slots[iter_19_0]
		local var_19_2 = arg_19_0:GetExpandPosition(#arg_19_0.displayShips, iter_19_0).x - (#arg_19_0.displayShips - var_0_1) * var_0_2

		table.insert(var_19_0, function(arg_20_0)
			if arg_19_0.exited then
				return
			end

			LeanTween.value(var_19_1.gameObject, var_0, var_19_2, 0.3):setOnUpdate(System.Action_float(function(arg_21_0)
				var_19_1.localPosition = Vector3(arg_21_0, var_19_1.localPosition.y, 0)

				return
			end)):setEase(LeanTweenType.easeOutQuad)
			onDelayTick(function()
				if arg_19_0.exited then
					return
				end

				setActive(var_19_1:Find("mask/blink"), true)

				return
			end, 0.15)
			onDelayTick(function()
				if arg_19_0.exited then
					return
				end

				setActive(var_19_1:Find("mask/blink"), false)

				return
			end, 0.2)
			onDelayTick(arg_20_0, 0.1)

			return
		end)
	end

	seriesAsync(var_19_0, function()
		arg_19_0:EffectSlots(true)
		arg_19_1()

		return
	end)

	return
end

function var_0_0.EffectSlots(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0.slots) do
		if not IsNil(iter_25_1) then
			setActive(iter_25_1:Find("effect"), arg_25_1)
		end
	end

	return
end

function var_0_0.MoveMainFleetShips(arg_26_0, arg_26_1)
	if arg_26_0.exited then
		return
	end

	local var_26_0 = #arg_26_0.displayShips

	if #arg_26_0.displayShips <= var_0_1 then
		arg_26_1()

		return
	end

	local var_26_1 = {}
	local var_26_2 = var_26_0 - var_0_1

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.slots) do
		table.insert(var_26_1, function(arg_27_0)
			local var_27_0 = arg_26_0:GetExpandPosition(var_26_0, iter_26_0).x

			LeanTween.value(iter_26_1.gameObject, var_27_0, var_27_0 - var_26_2 * var_0_2, 0.3):setOnUpdate(System.Action_float(function(arg_28_0)
				iter_26_1.localPosition = Vector3(arg_28_0, iter_26_1.localPosition.y, 0)

				return
			end)):setEase(LeanTweenType.easeOutQuad):setOnComplete(System.Action(arg_27_0))

			return
		end)
	end

	parallelAsync(var_26_1, function()
		return
	end)
	onDelayTick(function()
		if arg_26_0.exited then
			return
		end

		arg_26_1()

		for iter_30_0 = 1, var_26_2 do
			if arg_26_0.slots[iter_30_0] then
				setActive(arg_26_0.slots[iter_30_0], false)
			end
		end

		return
	end, 0.05)

	return
end

function var_0_0.DisplayMainFleet(arg_31_0, arg_31_1)
	if arg_31_0.exited then
		return
	end

	local var_31_0 = {}
	local var_31_1 = var_0_1 - #arg_31_0.slots
	local var_31_2 = #arg_31_0.displayShips

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.slots) do
		table.insert(var_31_0, function(arg_32_0)
			if arg_31_0.exited then
				return
			end

			LeanTween.value(iter_31_1.gameObject, arg_31_0:GetShrinkPosition(var_31_2, var_31_1 + iter_31_0), arg_31_0:GetExpandPosition(var_31_2, var_31_1 + iter_31_0), 0.29):setOnUpdate(System.Action_UnityEngine_Vector2(function(arg_33_0)
				iter_31_1.localPosition = arg_33_0

				return
			end))
			onNextTick(arg_32_0)

			return
		end)
	end

	local var_31_3 = 0

	Timer.New(function()
		if arg_31_0.exited then
			return
		end

		for iter_34_0, iter_34_1 in ipairs(arg_31_0.slots) do
			setActive(iter_34_1:Find("mask/blink"), var_31_3 % 2 ~= 0 == (iter_34_0 % 2 ~= 0))
		end

		var_31_3 = var_31_3 + 1

		return
	end, 0.059, 5):Start()
	Timer.New(function()
		if arg_31_0.exited then
			return
		end

		for iter_35_0, iter_35_1 in ipairs(arg_31_0.slots) do
			setActive(iter_35_1:Find("mask/blink"), false)
		end

		return
	end, 0.3, 1):Start()
	seriesAsync(var_31_0, function()
		arg_31_0:EffectSlots(true)
		onDelayTick(arg_31_1, 0.5)

		return
	end)

	return
end

function var_0_0.InitMainFleetShips(arg_37_0, arg_37_1)
	local var_37_0 = math.min(var_0_1, #arg_37_0.displayShips)

	for iter_37_0 = 2, var_37_0 do
		table.insert(arg_37_0.slots, (Object.Instantiate(arg_37_0.slots[1], arg_37_0.slots[1].parent)))
	end

	for iter_37_1 = 1, var_37_0 do
		local var_37_1 = arg_37_0.displayShips[iter_37_1]
		local var_37_2 = arg_37_0.slots[iter_37_1]

		arg_37_0.slots[iter_37_1].localPosition = arg_37_0:GetShrinkPosition(#arg_37_0.displayShips, var_0_1 - var_37_0 + iter_37_1)

		table.insert({}, function(arg_38_0)
			if arg_37_0.exited then
				return
			end

			setPaintingPrefabAsync(var_37_2:Find("mask/painting"), var_37_1:getPainting(), "biandui", arg_38_0)
			arg_37_0:AdjustPainting(var_37_2, var_37_1)

			return
		end)
	end

	parallelAsync({}, arg_37_1)

	return
end

function var_0_0.AdjustPainting(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = pg.ship_skin_newmainui_shift[arg_39_2:getSkinId()]

	if var_39_0 then
		local var_39_1 = arg_39_1:Find("mask/painting"):GetComponent(typeof(RectTransform))

		var_39_1.anchoredPosition = Vector2(var_39_0.battle_result_display_shift[1] + arg_39_0.defaultPaintingPosition.x, var_39_0.battle_result_display_shift[2] + arg_39_0.defaultPaintingPosition.y)
		var_39_1.localScale = Vector3(var_39_0.battle_result_display_shift[4], var_39_0.battle_result_display_shift[4], 1)

		local var_39_3 = var_39_1.localEulerAngles.x
		local var_39_4 = var_39_1.localEulerAngles.y

		if var_39_0.battle_result_display_shift[5] then
			local var_39_5 = var_39_0.battle_result_display_shift[5] or 0

			var_39_1.localEulerAngles = var_39_2(var_39_3, var_39_4, var_39_5)

			return
		end
	end
end

function var_0_0.RevertPainting(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1:Find("mask/painting"):GetComponent(typeof(RectTransform))

	var_40_0.anchoredPosition = arg_40_0.defaultPaintingPosition
	var_40_0.localScale = Vector3(1, 1, 1)
	var_40_0.localEulerAngles = Vector3(0, 0, 0)

	return
end

function var_0_0.OnDestroy(arg_41_0)
	arg_41_0.exited = true

	if arg_41_0:isShowing() then
		arg_41_0:Hide()
	end

	local var_41_0 = arg_41_0.displayShips or {}
	local var_41_2 = arg_41_0.slots or {}

	for iter_41_0, iter_41_1 in var_41_1(var_41_2) do
		if iter_41_1 then
			local var_41_3 = iter_41_1:Find("mask/painting")

			if var_41_3 and var_41_0[iter_41_0] and var_41_3:Find("fitter").childCount > 0 then
				arg_41_0:RevertPainting(iter_41_1)
				retPaintingPrefab(var_41_3, var_41_0[iter_41_0]:getPainting())
			end
		end

		if iter_41_1 and LeanTween.isTweening(iter_41_1.gameObject) then
			LeanTween.cancel(iter_41_1.gameObject)
		end
	end

	return
end

return var_0_0
