class = var_0_10000

local var_0_0 = "NewBattleResultGradePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NewBattleResultGradePage"
end

function var_0_1.OnLoaded(arg_2_0)
	arg_2_0.parentTr = arg_2_0._tf.parent

	local var_2_0 = arg_2_0._tf

	arg_2_0.bgTr = var_1.Find(var_2_0, "bg")

	local var_2_1 = arg_2_0.bgTr

	arg_2_0.gradePanel = var_1.Find(var_2_1, "grade")

	local var_2_2 = arg_2_0.bgTr

	arg_2_0.gradeIcon = var_1.Find(var_2_2, "grade/icon")

	local var_2_3 = arg_2_0.bgTr

	arg_2_0.gradeTxt = var_1.Find(var_2_3, "grade/Text")

	local var_2_4 = arg_2_0.bgTr

	arg_2_0.gradeLabel = var_1.Find(var_2_4, "grade/label")

	local var_2_5 = arg_2_0.bgTr

	arg_2_0.gradeChapterName = var_1.Find(var_2_5, "grade/chapterName")

	local var_2_6 = arg_2_0.gradeTxt
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	CanvasGroup = var_1_10006
	arg_2_0.gradeTxtCG = var_2_7(var_2_6, var_4(var_1_10006))

	local var_2_8 = arg_2_0.gradeChapterName
	local var_2_9 = var_1.GetComponent

	typeof = var_4
	CanvasGroup = var_1_10006
	arg_2_0.gradeChapterNameCG = var_2_9(var_2_8, var_4(var_1_10006))

	local var_2_10 = arg_2_0.bgTr

	arg_2_0.objectiveContainer = var_1.Find(var_2_10, "conditions/list")

	local var_2_11 = arg_2_0.bgTr

	arg_2_0.objectiveTpl = var_1.Find(var_2_11, "conditions/list/tpl")

	local var_2_12 = arg_2_0.objectiveContainer

	Vector3 = var_1_10002
	var_2_12.localPosition = var_1_10002(2000, arg_2_0.objectiveContainer.localPosition.y, 0)
	setText = var_2_12

	local var_2_13 = arg_2_0.bgTr
	local var_2_14 = var_3.Find(var_2_13, "conditions/Text")

	i18n = var_4

	var_2_12(var_2_14, var_4("battle_result_targets"))

	return
end

function var_0_1.SetUp(arg_3_0, arg_3_1)
	arg_3_0:Show()

	seriesAsync = var_2

	var_2({
		function(arg_4_0)
			local var_4_0 = arg_3_0

			var_1.LoadBGAndGrade(var_4_0, arg_4_0)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_3_0

			var_1.PlayEnterAnimation(var_5_0, arg_5_0)

			local var_5_1 = arg_3_0

			var_1.UpdateChapterName(var_5_1)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_3_0

			var_1.LoadEffects(var_6_0, arg_6_0)

			return
		end,
		function(arg_7_0)
			local var_7_0 = arg_3_0

			var_1.UpdateObjectives(var_7_0, arg_7_0)

			return
		end,
		function(arg_8_0)
			local var_8_0 = arg_3_0

			var_1.RegisterEvent(var_8_0, arg_8_0)

			return
		end
	}, function()
		local var_9_0 = arg_3_0

		var_0.Clear(var_9_0)

		local var_9_1 = arg_3_0

		var_0.Destroy(var_9_1)
		arg_3_1()

		return
	end)

	return
end

function var_0_1.RegisterEvent(arg_10_0, arg_10_1)
	if arg_10_0.exited then
		return
	end

	onButton = var_2

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0._tf
	local var_10_2 = arg_10_1

	SFX_PANEL = var_1_10007

	var_2(var_10_0, var_10_1, var_10_2, var_1_10007)

	if arg_10_0.contextData.autoSkipFlag then
		triggerButton = var_2

		var_2(arg_10_0._tf)
	end

	return
end

function var_0_1.Clear(arg_11_0)
	removeOnButton = var_1_10001

	var_1_10001(arg_11_0._tf)

	return
end

local function var_0_2(arg_12_0, arg_12_1)
	local var_12_0

	if not arg_12_1.text then
		var_12_0 = ""
	end

	local var_12_1 = arg_12_1.icon
	local var_12_2

	if not arg_12_1.value then
		var_12_2 = ""
	end

	local var_12_3 = arg_12_0.transform
	local var_12_4 = var_5.Find(var_12_3, "checkBox")
	local var_12_5 = var_5.GetComponent

	typeof = var_8
	Image = var_1_10010

	local var_12_6 = var_12_5(var_12_4, var_8(var_1_10010))

	setActive = var_1_10006

	var_1_10006(var_12_6.gameObject, var_12_1)

	if var_12_1 then
		GetSpriteFromAtlas = var_1_10006
		var_12_6.sprite = var_1_10006("ui/battleresult_atlas", var_12_1)

		var_12_6:SetNativeSize()
	end

	setText = var_1_10006

	local var_12_7 = arg_12_0.transform

	var_1_10006(var_8.Find(var_12_7, "text"), var_12_0)

	setText = var_1_10006

	local var_12_8 = arg_12_0.transform

	var_1_10006(var_8.Find(var_12_8, "value"), var_12_2)

	setActive = var_1_10006

	var_1_10006(arg_12_0:Find("fx"), true)

	return
end

function var_0_1.GetGetObjectives(arg_13_0)
	NewBattleResultUtil = var_1_10001

	return var_1_10001.GetObjectives(arg_13_0.contextData)
end

function var_0_1.UpdateObjectives(arg_14_0, arg_14_1)
	if #arg_14_0:GetGetObjectives() <= 0 then
		setActive = var_3

		var_3(arg_14_0.objectiveTpl, false)
		arg_14_1()

		return
	end

	local var_14_0 = {
		arg_14_0.objectiveTpl
	}

	for iter_14_0 = 2, #var_2 do
		Object = var_1_10008
		var_1_10008 = var_1_10008.Instantiate(arg_14_0.objectiveTpl, arg_14_0.objectiveContainer)
		table = var_1_10009

		var_1_10009.insert(var_14_0, var_1_10008)
	end

	local var_14_1 = {}

	for iter_14_1 = 1, #var_2 do
		table = var_1_10009

		var_1_10009.insert(var_14_1, function(arg_15_0)
			if arg_14_0.exited then
				return
			end

			var_0_2(var_14_0[iter_14_1], var_0[iter_14_1])

			onDelayTick = var_1

			var_1(arg_15_0, 0.3)

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_14_1, arg_14_1)

	LeanTween = var_5

	local var_14_2 = var_5.value(arg_14_0.objectiveContainer.gameObject, 2000, 237, 0.3)
	local var_14_3 = var_5.setOnUpdate

	System = var_8

	var_14_3(var_14_2, var_8.Action_float(function(arg_16_0)
		local var_16_0 = arg_14_0.objectiveContainer

		Vector3 = var_2_10002
		var_16_0.localPosition = var_2_10002(arg_16_0, arg_14_0.objectiveContainer.localPosition.y, 0)

		return
	end))

	return
end

function var_0_1.UpdateChapterName(arg_17_0)
	NewBattleResultUtil = var_1_10001

	local var_17_0 = var_1_10001.GetChapterName(arg_17_0.contextData)

	setText = var_1_10002

	var_1_10002(arg_17_0.gradeChapterName, var_17_0)

	return
end

function var_0_1.LoadEffects(arg_18_0, arg_18_1)
	LoadAnyAsync = var_1_10002

	var_1_10002("BattleResultItems/ResultEffect", "", nil, function(arg_19_0)
		if not arg_18_0.exited then
			IsNil = var_1

			if var_1(arg_19_0) then
				if arg_18_1 then
					arg_18_1()
				end

				return
			end

			Object = var_1

			local var_19_0 = var_1.Instantiate(arg_19_0, arg_18_0.bgTr)

			setText = var_2_10002

			local var_19_1 = var_19_0.transform
			local var_19_2 = var_4.Find(var_19_1, "Tips/dianjijixu/bg20")

			i18n = var_2_10005

			var_2_10002(var_19_2, var_2_10005("battle_result_continue"))

			var_19_0.name = "ResultEffect"

			local var_19_3 = var_19_0.transform

			var_2.SetSiblingIndex(var_19_3, 1)

			if arg_18_1 then
				arg_18_1()
			end

			return
		end
	end)

	return
end

function var_0_1.PlayEnterAnimation(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.gradeTxtCG

	var_20_0.alpha = 0
	LeanTween = var_20_0

	local var_20_1 = var_20_0.value(arg_20_0.gradeTxt.gameObject, 0.2, 1, 0.3)
	local var_20_2 = var_2.setOnUpdate

	System = var_5

	local var_20_3 = var_20_2(var_20_1, var_5.Action_float(function(arg_21_0)
		arg_20_0.gradeTxtCG.alpha = arg_21_0

		return
	end))

	var_2.setDelay(var_20_3, 0.2)

	LeanTween = var_2

	local var_20_4 = var_2.value(arg_20_0.gradeTxt.gameObject, 1.3, 1, 0.15)
	local var_20_5 = var_2.setOnUpdate

	System = var_5

	local var_20_6 = var_20_5(var_20_4, var_5.Action_float(function(arg_22_0)
		local var_22_0 = arg_20_0.gradeTxt

		Vector3 = var_2_10002
		var_22_0.localScale = var_2_10002(arg_22_0, arg_22_0, 1)

		return
	end))

	var_2.setDelay(var_20_6, 0.15)

	local var_20_7 = arg_20_0.gradeLabel.localPosition
	local var_20_8 = arg_20_0.gradeLabel
	local var_20_9 = arg_20_0.gradeLabel.localPosition

	Vector3 = var_5
	var_20_8.localPosition = var_20_9 + var_5(20, 20)
	LeanTween = var_20_8

	local var_20_10 = var_20_8.moveLocal(arg_20_0.gradeLabel.gameObject, var_20_7, 0.15)

	var_3.setDelay(var_20_10, 0.15)

	local var_20_11 = arg_20_0.gradeChapterNameCG

	var_20_11.alpha = 0
	LeanTween = var_20_11

	local var_20_12 = var_20_11.value(arg_20_0.gradeChapterName.gameObject, 0.1, 0.7, 0.3)
	local var_20_13 = var_3.setOnUpdate

	System = var_6

	local var_20_14 = var_20_13(var_20_12, var_6.Action_float(function(arg_23_0)
		arg_20_0.gradeChapterNameCG.alpha = arg_23_0

		return
	end))
	local var_20_15 = var_3.setOnComplete

	System = var_6

	local var_20_16 = var_20_15(var_20_14, var_6.Action(function()
		arg_20_0.gradeChapterNameCG.alpha = 1

		return
	end))
	local var_20_17 = var_3.setLoopPingPong(var_20_16, 2)

	var_3.setDelay(var_20_17, 0.15)

	LeanTween = var_3

	local var_20_18 = var_3.value(arg_20_0.gradeIcon.gameObject, 15, 1, 0.3)
	local var_20_19 = var_3.setOnUpdate

	System = var_6

	local var_20_20 = var_20_19(var_20_18, var_6.Action_float(function(arg_25_0)
		local var_25_0 = arg_20_0.gradeIcon

		Vector3 = var_2_10002
		var_25_0.localScale = var_2_10002(arg_25_0, arg_25_0, 1)

		return
	end))
	local var_20_21 = var_3.setOnComplete

	System = var_6

	var_20_21(var_20_20, var_6.Action(arg_20_1))

	return
end

function var_0_1.LoadBGAndGrade(arg_26_0, arg_26_1)
	parallelAsync = var_1_10002

	var_1_10002({
		function(arg_27_0)
			local var_27_0 = arg_26_0

			var_1.LoadBG(var_27_0, arg_27_0)

			return
		end,
		function(arg_28_0)
			local var_28_0 = arg_26_0

			var_1.LoadGrade(var_28_0, arg_28_0)

			return
		end
	}, arg_26_1)

	return
end

function var_0_1.LoadBG(arg_29_0, arg_29_1)
	NewBattleResultUtil = var_1_10002

	local var_29_0 = var_1_10002.Score2Bg(arg_29_0.contextData.score)

	LoadAnyAsync = var_1_10003

	var_1_10003("BattleResultItems/" .. var_29_0, "", nil, function(arg_30_0)
		if not arg_29_0.exited then
			IsNil = var_1

			if var_1(arg_30_0) then
				if arg_29_1 then
					arg_29_1()
				end

				return
			end

			Object = var_1

			local var_30_0 = var_1.Instantiate(arg_30_0, arg_29_0._parentTf).transform

			var_2.SetAsFirstSibling(var_30_0)

			var_1.name = "Effect"

			if arg_29_1 then
				arg_29_1()
			end

			return
		end
	end)

	return
end

function var_0_1.LoadGrade(arg_31_0, arg_31_1)
	NewBattleResultUtil = var_1_10002

	local var_31_0, var_31_1 = var_1_10002.Score2Grade(arg_31_0.contextData.score, arg_31_0.contextData._scoreMark)

	LoadImageSpriteAsync = var_4

	var_4(var_31_0, arg_31_0.gradeIcon, true)

	LoadImageSpriteAsync = var_4

	var_4(var_31_1, arg_31_0.gradeTxt, true)

	if arg_31_1 then
		arg_31_1()
	end

	return
end

function var_0_1.OnDestroy(arg_32_0)
	arg_32_0.exited = true

	if arg_32_0:isShowing() then
		arg_32_0:Hide()
	end

	LeanTween = var_1

	if var_1.isTweening(arg_32_0.objectiveContainer.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_32_0.objectiveContainer.gameObject)
	end

	LeanTween = var_1

	if var_1.isTweening(arg_32_0.gradeTxt.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_32_0.gradeTxt.gameObject)
	end

	LeanTween = var_1

	if var_1.isTweening(arg_32_0.gradeIcon.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_32_0.gradeIcon.gameObject)
	end

	LeanTween = var_1

	if var_1.isTweening(arg_32_0.gradeLabel.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_32_0.gradeLabel.gameObject)
	end

	LeanTween = var_1

	if var_1.isTweening(arg_32_0.gradeChapterNameCG.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_32_0.gradeChapterNameCG.gameObject)
	end

	return
end

return var_0_1
