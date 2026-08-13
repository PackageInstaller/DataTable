class = var_0_10000

local var_0_0 = "NewBattleResultDisplayPaintingsPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))
local var_0_2 = 6
local var_0_3 = 295

function var_0_1.getUIName(arg_1_0)
	return "NewBattleResultDisplayPaintingsPages"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = arg_2_0._tf

	var_2_0[1] = var_2.Find(var_2_1, "tpl")
	arg_2_0.slots = var_2_0

	local var_2_2 = arg_2_0._tf

	arg_2_0.defaultPaintingPosition = var_1.Find(var_2_2, "tpl/mask/painting").anchoredPosition

	return
end

function var_0_1.StaticGetFinalExpandPosition(arg_3_0)
	if arg_3_0 <= var_0_2 then
		return var_0_1.StaticGetExpandPosition(arg_3_0, var_0_2 - 1)
	else
		local var_3_0 = arg_3_0 - var_0_2
		local var_3_1 = var_0_1.StaticGetExpandPosition(arg_3_0, arg_3_0 - 1)

		Vector2 = var_3

		return var_3_1 - var_3_0 * var_3(var_0_3, 0)
	end

	return
end

function var_0_1.StaticGetExpandPosition(arg_4_0, arg_4_1)
	math = var_1_10002

	local var_4_0 = var_1_10002.ceil(arg_4_1 / 2)
	local var_4_1 = arg_4_1 % 2 ~= 0
	local var_4_2

	if 6 < arg_4_0 and arg_4_0 % 2 == 0 or arg_4_0 <= 6 then
		if var_4_1 then
			Vector2 = var_5

			if not var_5(-730, 72) then
				::label_4_0::

				Vector2 = var_5
				var_4_2 = var_5(-457, -72)
			end

			goto label_4_2

			if var_4_1 then
				Vector2 = var_5

				if not var_5(-751, -72) then
					::label_4_1::

					Vector2 = var_5
					var_4_2 = var_5(-437, 72)
				end

				::label_4_2::

				Vector2 = var_5

				return var_4_2 + var_5(590, 0) * (var_4_0 - 1)
			end
		end
	end
end

function var_0_1.GetExpandPosition(arg_5_0, arg_5_1, arg_5_2)
	return var_0_1.StaticGetExpandPosition(arg_5_1, arg_5_2)
end

function var_0_1.GetShrinkPosition(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:GetExpandPosition(arg_6_1, arg_6_2)
	local var_6_1 = arg_6_2 % 2 ~= 0

	Vector2 = var_5

	local var_6_2 = var_5(-125, -936)

	if arg_6_1 > 6 and arg_6_1 % 2 == 0 or arg_6_1 <= 6 then
		local var_6_3

		if not var_6_1 or not (var_6_0 - var_6_2) then
			var_6_3 = var_6_0 + var_6_2
		end

		return var_6_3
	else
		local var_6_4

		if not var_6_1 or not (var_6_0 + var_6_2) then
			var_6_4 = var_6_0 - var_6_2
		end

		return var_6_4
	end

	return
end

function var_0_1.SetUp(arg_7_0, arg_7_1)
	arg_7_0:Show()

	arg_7_0.displayShips = arg_7_0:ReSortFleetShips()
	seriesAsync = var_2

	var_2({
		function(arg_8_0)
			local var_8_0 = arg_7_0

			var_1.InitMainFleetShips(var_8_0, arg_8_0)

			return
		end,
		function(arg_9_0)
			local var_9_0 = arg_7_0

			var_1.DisplayMainFleet(var_9_0, arg_9_0)

			return
		end,
		function(arg_10_0)
			local var_10_0 = arg_7_0

			var_1.MoveMainFleetShips(var_10_0, arg_10_0)

			return
		end,
		function(arg_11_0)
			local var_11_0 = arg_7_0

			var_1.InitSubFleetShips(var_11_0, arg_11_0)

			return
		end,
		function(arg_12_0)
			local var_12_0 = arg_7_0

			var_1.DisplaySubFleet(var_12_0, arg_12_0)

			return
		end,
		function(arg_13_0)
			onDelayTick = var_2_10001

			var_2_10001(arg_13_0, 0.5)

			return
		end
	}, function()
		arg_7_1()

		return
	end)

	return
end

function var_0_1.ReSortFleetShips(arg_15_0)
	local var_15_0 = arg_15_0.contextData.oldMainShips
	local var_15_1 = arg_15_0.contextData.statistics.mvpShipID
	local var_15_2 = arg_15_0.contextData.statistics._flagShipID

	NewBattleResultUtil = var_1_10004

	local var_15_3, var_15_4, var_15_5, var_15_6 = var_1_10004.SeparateMvpShip(var_15_0, var_15_1, var_15_2)
	local var_15_7 = {}

	if var_15_6 ~= nil then
		ys = var_1_10009

		local var_15_8 = var_1_10009.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(var_15_6.configId).type

		ShipType = var_10

		local var_15_9 = var_10.GetTeamFromShipType(var_15_8)

		TeamType = var_11

		if var_15_9 == var_11.Vanguard then
			NewBattleResultUtil = var_11

			var_11.SpecialInsertItem(var_15_7, var_15_5, var_15_4, var_15_3, var_15_6)
		else
			TeamType = var_11

			if var_15_9 == var_11.Main then
				NewBattleResultUtil = var_11

				var_11.SpecialInsertItem(var_15_7, var_15_5, var_15_3, var_15_4, var_15_6)
			else
				TeamType = var_11

				if var_15_9 == var_11.Submarine then
					NewBattleResultUtil = var_11

					var_11.SpecialInsertItem(var_15_7, var_15_3, var_15_4, var_15_5, var_15_6)
				end
			end
		end
	else
		var_15_7 = var_15_0
	end

	return var_15_7
end

function var_0_1.InitSubFleetShips(arg_16_0, arg_16_1)
	if arg_16_0.exited then
		return
	end

	if #arg_16_0.displayShips <= var_0_2 then
		arg_16_1()

		return
	end

	local var_16_0 = #var_2 - var_0_2

	for iter_16_0 = 1, var_16_0 do
		if arg_16_0.slots[iter_16_0] then
			var_1_10009 = arg_16_0

			arg_16_0.RevertPainting(var_1_10009, arg_16_0.slots[iter_16_0])

			retPaintingPrefab = var_8

			local var_16_1 = arg_16_0.slots[iter_16_0]

			var_1_10009 = var_1_10009.Find(var_16_1, "mask/painting")

			local var_16_2 = var_2[iter_16_0]

			var_8(var_1_10009, var_10.getPainting(var_16_2))
		end
	end

	local var_16_3 = {}
	local var_16_4 = var_0_2 + 1

	math = var_6

	for iter_16_1 = var_16_4, var_6.max(var_0_2, #var_2) do
		Object = var_1_10009
		var_1_10009 = var_1_10009.Instantiate(arg_16_0.slots[1], arg_16_0.slots[1].parent)
		table = var_10

		var_10.insert(arg_16_0.slots, var_1_10009)

		local var_16_5 = var_2[iter_16_1]
		local var_16_6 = arg_16_0

		var_1_10009.localPosition = arg_16_0.GetExpandPosition(var_16_6, #var_2, iter_16_1)
		table = var_16_6

		var_16_6.insert(var_16_3, function(arg_17_0)
			setPaintingPrefabAsync = var_2_10001

			local var_17_0 = var_1_10009
			local var_17_1 = var_2.Find(var_17_0, "mask/painting")
			local var_17_2 = var_16_5

			var_2_10001(var_17_1, var_3.getPainting(var_17_2), "biandui", arg_17_0)

			local var_17_3 = arg_16_0

			var_1.AdjustPainting(var_17_3, var_1_10009, var_16_5)

			return
		end)
	end

	parallelAsync = var_16_4

	var_16_4(var_16_3, function()
		onDelayTick = var_2_10000

		var_2_10000(arg_16_1, 0.05)

		return
	end)

	return
end

function var_0_1.DisplaySubFleet(arg_19_0, arg_19_1)
	if arg_19_0.exited then
		return
	end

	arg_19_0:EffectSlots(false)

	if #arg_19_0.displayShips <= var_0_2 then
		arg_19_1()

		return
	end

	local var_19_0 = {}
	local var_19_1 = #var_2 - var_0_2
	local var_19_2 = var_0_2 + 1

	math = var_1_10006

	for iter_19_0 = var_19_2, var_1_10006.max(var_0_2, #var_2) do
		local var_19_3 = arg_19_0.slots[iter_19_0]
		local var_19_4 = arg_19_0:GetExpandPosition(#var_2, iter_19_0).x - var_19_1 * var_0_3

		table = var_12

		var_12.insert(var_19_0, function(arg_20_0)
			if arg_19_0.exited then
				return
			end

			LeanTween = var_1

			local var_20_0 = var_1.value(var_19_3.gameObject, var_0, var_19_4, 0.3)
			local var_20_1 = var_1.setOnUpdate

			System = var_3

			local var_20_2 = var_20_1(var_20_0, var_3.Action_float(function(arg_21_0)
				local var_21_0 = var_19_3

				Vector3 = var_3_10002
				var_21_0.localPosition = var_3_10002(arg_21_0, var_19_3.localPosition.y, 0)

				return
			end))
			local var_20_3 = var_1.setEase

			LeanTweenType = var_3

			var_20_3(var_20_2, var_3.easeOutQuad)

			onDelayTick = var_20_3

			var_20_3(function()
				if arg_19_0.exited then
					return
				end

				setActive = var_0

				local var_22_0 = var_19_3

				var_0(var_1.Find(var_22_0, "mask/blink"), true)

				return
			end, 0.15)

			onDelayTick = var_20_3

			var_20_3(function()
				if arg_19_0.exited then
					return
				end

				setActive = var_0

				local var_23_0 = var_19_3

				var_0(var_1.Find(var_23_0, "mask/blink"), false)

				return
			end, 0.2)

			onDelayTick = var_20_3

			var_20_3(arg_20_0, 0.1)

			return
		end)
	end

	seriesAsync = var_19_2

	var_19_2(var_19_0, function()
		local var_24_0 = arg_19_0

		var_0.EffectSlots(var_24_0, true)
		arg_19_1()

		return
	end)

	return
end

function var_0_1.EffectSlots(arg_25_0, arg_25_1)
	ipairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_0.slots) do
		IsNil = var_1_10007

		if not var_1_10007(iter_25_1) then
			setActive = var_1_10007

			var_1_10007(iter_25_1:Find("effect"), arg_25_1)
		end
	end

	return
end

function var_0_1.MoveMainFleetShips(arg_26_0, arg_26_1)
	if arg_26_0.exited then
		return
	end

	if #arg_26_0.displayShips <= var_0_2 then
		arg_26_1()

		return
	end

	local var_26_0 = {}
	local var_26_1 = var_2 - var_0_2

	ipairs = var_1_10005

	for iter_26_0, iter_26_1 in var_1_10005(arg_26_0.slots) do
		table = var_1_10010

		var_1_10010.insert(var_26_0, function(arg_27_0)
			local var_27_0 = arg_26_0
			local var_27_1 = var_1.GetExpandPosition(var_27_0, var_0, iter_26_0).x - var_26_1 * var_0_3

			LeanTween = var_3

			local var_27_2 = var_3.value(iter_26_1.gameObject, var_1, var_27_1, 0.3)
			local var_27_3 = var_3.setOnUpdate

			System = var_5

			local var_27_4 = var_27_3(var_27_2, var_5.Action_float(function(arg_28_0)
				local var_28_0 = iter_26_1

				Vector3 = var_3_10002
				var_28_0.localPosition = var_3_10002(arg_28_0, iter_26_1.localPosition.y, 0)

				return
			end))
			local var_27_5 = var_3.setEase

			LeanTweenType = var_5

			local var_27_6 = var_27_5(var_27_4, var_5.easeOutQuad)
			local var_27_7 = var_3.setOnComplete

			System = var_5

			var_27_7(var_27_6, var_5.Action(arg_27_0))

			return
		end)
	end

	parallelAsync = var_5

	var_5(var_26_0, function()
		return
	end)

	onDelayTick = var_5

	var_5(function()
		if arg_26_0.exited then
			return
		end

		arg_26_1()

		for iter_30_0 = 1, var_26_1 do
			if arg_26_0.slots[iter_30_0] then
				setActive = var_4

				var_4(arg_26_0.slots[iter_30_0], false)
			end
		end

		return
	end, 0.05)

	return
end

function var_0_1.DisplayMainFleet(arg_31_0, arg_31_1)
	if arg_31_0.exited then
		return
	end

	local var_31_0 = {}
	local var_31_1 = var_0_2 - #arg_31_0.slots
	local var_31_2 = #arg_31_0.displayShips

	ipairs = var_1_10005

	for iter_31_0, iter_31_1 in var_1_10005(arg_31_0.slots) do
		table = var_1_10010

		var_1_10010.insert(var_31_0, function(arg_32_0)
			if arg_31_0.exited then
				return
			end

			local var_32_0 = var_31_1 + iter_31_0
			local var_32_1 = arg_31_0
			local var_32_2 = var_2.GetExpandPosition(var_32_1, var_31_2, var_32_0)
			local var_32_3 = arg_31_0
			local var_32_4 = var_3.GetShrinkPosition(var_32_3, var_31_2, var_32_0)

			LeanTween = var_32_3

			local var_32_5 = var_32_3.value(iter_31_1.gameObject, var_32_4, var_32_2, 0.29)
			local var_32_6 = var_4.setOnUpdate

			System = var_6

			var_32_6(var_32_5, var_6.Action_UnityEngine_Vector2(function(arg_33_0)
				iter_31_1.localPosition = arg_33_0

				return
			end))

			onNextTick = var_32_6

			var_32_6(arg_32_0)

			return
		end)
	end

	local var_31_3 = 0

	Timer = var_6

	local var_31_4 = var_6.New(function()
		if arg_31_0.exited then
			return
		end

		ipairs = var_0

		for iter_34_0, iter_34_1 in var_0(arg_31_0.slots) do
			setActive = var_2_10005

			var_2_10005(iter_34_1:Find("mask/blink"), var_31_3 % 2 ~= 0 == (iter_34_0 % 2 ~= 0))
		end

		var_31_3 = var_31_3 + 1

		return
	end, 0.059, 5)

	var_6.Start(var_31_4)

	Timer = var_6

	local var_31_5 = var_6.New(function()
		if arg_31_0.exited then
			return
		end

		ipairs = var_0

		for iter_35_0, iter_35_1 in var_0(arg_31_0.slots) do
			setActive = var_2_10005

			var_2_10005(iter_35_1:Find("mask/blink"), false)
		end

		return
	end, 0.3, 1)

	var_6.Start(var_31_5)

	seriesAsync = var_6

	var_6(var_31_0, function()
		local var_36_0 = arg_31_0

		var_0.EffectSlots(var_36_0, true)

		onDelayTick = var_0

		var_0(arg_31_1, 0.5)

		return
	end)

	return
end

function var_0_1.InitMainFleetShips(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.displayShips

	math = var_1_10003

	local var_37_1 = var_1_10003.min(var_0_2, #var_37_0)

	for iter_37_0 = 2, var_37_1 do
		Object = var_1_10008
		var_1_10008 = var_1_10008.Instantiate(arg_37_0.slots[1], arg_37_0.slots[1].parent)
		table = var_9

		var_9.insert(arg_37_0.slots, var_1_10008)
	end

	local var_37_2 = {}
	local var_37_3 = var_0_2 - var_37_1

	for iter_37_1 = 1, var_37_1 do
		local var_37_4 = var_37_0[iter_37_1]
		local var_37_5 = arg_37_0.slots[iter_37_1]

		var_37_5.localPosition = arg_37_0:GetShrinkPosition(#var_37_0, var_37_3 + iter_37_1)
		table = var_12

		var_12.insert(var_37_2, function(arg_38_0)
			if arg_37_0.exited then
				return
			end

			setPaintingPrefabAsync = var_1

			local var_38_0 = var_37_5
			local var_38_1 = var_2.Find(var_38_0, "mask/painting")
			local var_38_2 = var_37_4

			var_1(var_38_1, var_3.getPainting(var_38_2), "biandui", arg_38_0)

			local var_38_3 = arg_37_0

			var_1.AdjustPainting(var_38_3, var_37_5, var_37_4)

			return
		end)
	end

	parallelAsync = var_6

	var_6(var_37_2, arg_37_1)

	return
end

function var_0_1.AdjustPainting(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_1
	local var_39_1 = arg_39_1.Find(var_39_0, "mask/painting")

	pg = var_39_0

	if var_39_0.ship_skin_newmainui_shift[arg_39_2:getSkinId()] then
		local var_39_2 = var_4.battle_result_display_shift
		local var_39_3 = var_39_1
		local var_39_4 = var_39_1.GetComponent

		typeof = var_1_10008
		RectTransform = var_1_10009

		local var_39_5 = var_39_4(var_39_3, var_1_10008(var_1_10009))

		Vector2 = var_39_3
		var_39_5.anchoredPosition = var_39_3(var_39_2[1] + arg_39_0.defaultPaintingPosition.x, var_39_2[2] + arg_39_0.defaultPaintingPosition.y)

		local var_39_6 = var_39_2[4]

		Vector3 = var_8
		var_39_5.localScale = var_8(var_39_6, var_39_6, 1)

		local var_39_7 = var_39_5.localEulerAngles

		Vector3 = var_9

		local var_39_8 = var_39_7.x
		local var_39_9 = var_39_7.y
		local var_39_10

		if not var_39_2[5] or not var_39_2[5] then
			var_39_10 = 0
		end

		var_39_5.localEulerAngles = var_9(var_39_8, var_39_9, var_39_10)
	end

	return
end

function var_0_1.RevertPainting(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1:Find("mask/painting")
	local var_40_1 = var_2.GetComponent

	typeof = var_1_10005
	RectTransform = var_1_10006

	local var_40_2 = var_40_1(var_40_0, var_1_10005(var_1_10006))

	var_40_2.anchoredPosition = arg_40_0.defaultPaintingPosition
	Vector3 = var_4
	var_40_2.localScale = var_4(1, 1, 1)
	Vector3 = var_4
	var_40_2.localEulerAngles = var_4(0, 0, 0)

	return
end

function var_0_1.OnDestroy(arg_41_0)
	arg_41_0.exited = true

	local var_41_0 = arg_41_0

	if arg_41_0.isShowing(var_41_0) then
		var_41_0 = arg_41_0

		arg_41_0.Hide(var_41_0)
	end

	local var_41_1

	if not arg_41_0.displayShips then
		var_41_1 = {}
	end

	ipairs = var_41_0

	local var_41_2

	if not arg_41_0.slots then
		var_41_2 = {}
	end

	for iter_41_0, iter_41_1 in var_41_0(var_41_2) do
		if iter_41_1 and iter_41_1:Find("mask/painting") and var_41_1[iter_41_0] and var_1_10007:Find("fitter").childCount > 0 then
			arg_41_0:RevertPainting(iter_41_1)

			retPaintingPrefab = var_8

			local var_41_3 = var_1_10007
			local var_41_4 = var_41_1[iter_41_0]

			var_8(var_41_3, var_10.getPainting(var_41_4))
		end

		if iter_41_1 then
			LeanTween = var_1_10007

			if var_1_10007.isTweening(iter_41_1.gameObject) then
				LeanTween = var_1_10007

				var_1_10007.cancel(iter_41_1.gameObject)
			end
		end
	end

	return
end

return var_0_1
