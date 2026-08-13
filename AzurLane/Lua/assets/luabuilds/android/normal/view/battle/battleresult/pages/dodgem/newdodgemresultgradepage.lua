class = var_0_10000

local var_0_0 = "NewDodgemResultGradePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..NewBattleResultGradePage"))

function var_0_1.LoadBG(arg_1_0, arg_1_1)
	local var_1_0 = "CommonBg"

	LoadAnyAsync = var_1_10003

	var_1_10003("BattleResultItems/" .. var_1_0, "", nil, function(arg_2_0)
		if not arg_1_0.exited then
			IsNil = var_1

			if var_1(arg_2_0) then
				if arg_1_1 then
					arg_1_1()
				end

				return
			end

			Object = var_1

			local var_2_0 = var_1.Instantiate(arg_2_0, arg_1_0.bgTr).transform

			var_2.SetAsFirstSibling(var_2_0)

			if arg_1_1 then
				arg_1_1()
			end

			return
		end
	end)

	return
end

function var_0_1.RegisterEvent(arg_3_0, arg_3_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_4_0)
			var_0_1.super.RegisterEvent(arg_3_0, arg_4_0)

			return
		end,
		function(arg_5_0)
			removeOnButton = var_2_10001

			var_2_10001(arg_3_0._tf)

			local var_5_0 = arg_3_0

			var_1.LoadPainitingContainer(var_5_0, arg_5_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_3_0

			var_1.MovePainting(var_6_0, arg_6_0)

			return
		end
	}, function()
		onButton = var_2_10000

		local var_7_0 = arg_3_0
		local var_7_1 = arg_3_0._tf

		local function var_7_2()
			arg_3_1()

			return
		end

		SFX_PANEL = var_2_10004

		var_2_10000(var_7_0, var_7_1, var_7_2, var_2_10004)

		return
	end)

	return
end

function var_0_1.MovePainting(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.paintingTr.parent

	LeanTween = var_1_10003

	local var_9_1 = var_1_10003.value(var_9_0.gameObject, 2500, 587, 0.3)
	local var_9_2 = var_3.setOnUpdate

	System = var_5

	local var_9_3 = var_9_2(var_9_1, var_5.Action_float(function(arg_10_0)
		local var_10_0 = var_9_0

		Vector3 = var_2_10002
		var_10_0.localPosition = var_2_10002(arg_10_0, 0, 0)

		return
	end))
	local var_9_4 = var_3.setOnComplete

	System = var_5

	var_9_4(var_9_3, var_5.Action(arg_9_1))

	Vector2 = var_9_4

	local var_9_5 = var_9_4(-247, 213)
	local var_9_6 = arg_9_0.gradePanel.anchoredPosition

	LeanTween = var_5

	local var_9_7 = var_5.value(arg_9_0.gradePanel.gameObject, var_9_6, var_9_6 + var_9_5, 0.29)
	local var_9_8 = var_5.setOnUpdate

	System = var_7

	var_9_8(var_9_7, var_7.Action_UnityEngine_Vector2(function(arg_11_0)
		local var_11_0 = arg_9_0.gradePanel

		Vector3 = var_2_10002
		var_11_0.anchoredPosition3D = var_2_10002(arg_11_0.x, arg_11_0.y, 0)

		return
	end))

	return
end

function var_0_1.GetGetObjectives(arg_12_0)
	local var_12_0 = arg_12_0.contextData
	local var_12_1 = {}
	local var_12_2 = var_12_0.statistics.dodgemResult

	i18n = var_1_10004

	local var_12_3 = var_1_10004("battle_result_total_score")

	table = var_5

	local var_12_4 = var_5.insert
	local var_12_5 = var_12_1
	local var_12_6 = {}

	setColorStr = var_1_10008
	var_12_6.text = var_1_10008(var_12_3, "#FFFFFFFF")
	setColorStr = var_8

	local var_12_7 = var_12_2.score

	COLOR_BLUE = var_10
	var_12_6.value = var_8(var_12_7, var_10)

	var_12_4(var_12_5, var_12_6)

	i18n = var_12_4

	local var_12_8 = var_12_4("battle_result_max_combo")

	table = var_6

	local var_12_9 = var_6.insert
	local var_12_10 = var_12_1
	local var_12_11 = {}

	setColorStr = var_12_7
	var_12_11.text = var_12_7(var_12_8, "#FFFFFFFF")
	setColorStr = var_9

	local var_12_12 = var_12_2.maxCombo

	COLOR_YELLOW = var_11
	var_12_11.value = var_9(var_12_12, var_11)

	var_12_9(var_12_10, var_12_11)

	return var_12_1
end

function var_0_1.LoadPainitingContainer(arg_13_0, arg_13_1)
	LoadAny = var_1_10002

	var_1_10002("BattleResultItems/Painting", "", nil, function(arg_14_0)
		if arg_13_0.exited then
			return
		end

		Object = var_1

		local var_14_0 = var_1.Instantiate(arg_14_0, arg_13_0.bgTr)
		local var_14_1 = arg_13_0

		var_2.UpdatePainting(var_14_1, var_14_0, arg_13_1)

		return
	end)

	return
end

function var_0_1.UpdatePainting(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1.transform
	local var_15_1 = var_3.Find(var_15_0, "painting")
	local var_15_2 = arg_15_0:GetFlagShip()
	local var_15_3 = var_4.getPainting(var_15_2)

	setPaintingPrefabAsync = var_15_2

	var_15_2(var_15_1, var_15_3, "biandui", function()
		ShipExpressionHelper = var_2_10000

		local var_16_0 = var_2_10000.SetExpression

		findTF = var_2_10001

		local var_16_1 = var_2_10001(var_15_1, "fitter")
		local var_16_2 = var_1.GetChild(var_16_1, 0)
		local var_16_3 = var_15_3

		ShipWordHelper = var_3

		var_16_0(var_16_2, var_16_3, var_3.WORD_TYPE_MVP)
		arg_15_2()

		return
	end)

	local var_15_4 = arg_15_0
	local var_15_5 = arg_15_0.DisplayShipDialogue
	local var_15_6 = arg_15_1.transform

	var_15_5(var_15_4, var_8.Find(var_15_6, "chat"), var_4)

	arg_15_0.paintingTr = var_15_1

	local var_15_7 = arg_15_1.transform

	Vector3 = var_15_4
	var_15_7.localPosition = var_15_4(2500, 0, 0)

	local var_15_8 = arg_15_1.transform

	var_6.SetSiblingIndex(var_15_8, 2)

	setActive = var_6

	var_6(arg_15_0.objectiveContainer.parent, false)

	return
end

function var_0_1.DisplayShipDialogue(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0
	local var_17_1
	local var_17_2
	local var_17_3

	if arg_17_0.contextData.score > 1 then
		ShipWordHelper = var_17_3
		var_17_3 = var_17_3.GetWordAndCV

		local var_17_4 = arg_17_2.skinId

		ShipWordHelper = var_1_10008

		local var_17_5

		var_17_3, var_17_5, var_1_10008 = var_17_3(var_17_4, var_1_10008.WORD_TYPE_MVP)
		var_17_1 = var_1_10008

		local var_17_6 = var_17_5
		local var_17_7 = var_17_3
	else
		ShipWordHelper = var_17_3

		local var_17_8 = var_17_3.GetWordAndCV
		local var_17_9 = arg_17_2.skinId

		ShipWordHelper = var_1_10008

		local var_17_10, var_17_11

		var_17_10, var_17_11, var_17_1 = var_17_8(var_17_9, var_1_10008.WORD_TYPE_LOSE)
	end

	local var_17_12 = arg_17_1:Find("Text")
	local var_17_13 = var_6.GetComponent

	typeof = var_8
	Text = var_1_10009

	local var_17_14 = var_17_13(var_17_12, var_8(var_1_10009))

	var_17_14.text = var_17_1

	local var_17_15 = #var_17_1

	CHAT_POP_STR_LEN = var_8

	if var_8 < var_17_15 then
		TextAnchor = var_17_15

		if not var_17_15.MiddleLeft then
			TextAnchor = var_17_15
			var_17_15 = var_17_15.MiddleCenter
		end

		var_17_14.alignment = var_17_15

		return
	end
end

function var_0_1.GetFlagShip(arg_18_0)
	Ship = var_1_10001

	return var_1_10001.New({
		id = 9999,
		configId = 205021,
		skin_id = 205020
	})
end

function var_0_1.OnDestroy(arg_19_0)
	if arg_19_0.paintingTr then
		local var_19_0 = arg_19_0
		local var_19_1 = arg_19_0.GetFlagShip(var_19_0)

		retPaintingPrefab = var_19_0

		var_19_0(arg_19_0.paintingTr, var_19_1:getPainting())
	end

	var_0_1.super.OnDestroy(arg_19_0)

	return
end

return var_0_1
