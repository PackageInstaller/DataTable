local var_0_0 = class("NewBattleResultGradePage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "NewBattleResultGradePage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.parentTr = arg_2_0._tf.parent
	arg_2_0.bgTr = arg_2_0._tf:Find("bg")
	arg_2_0.gradePanel = arg_2_0.bgTr:Find("grade")
	arg_2_0.gradeIcon = arg_2_0.bgTr:Find("grade/icon")
	arg_2_0.gradeTxt = arg_2_0.bgTr:Find("grade/Text")
	arg_2_0.gradeLabel = arg_2_0.bgTr:Find("grade/label")
	arg_2_0.gradeChapterName = arg_2_0.bgTr:Find("grade/chapterName")
	arg_2_0.gradeTxtCG = arg_2_0.gradeTxt:GetComponent(typeof(CanvasGroup))
	arg_2_0.gradeChapterNameCG = arg_2_0.gradeChapterName:GetComponent(typeof(CanvasGroup))
	arg_2_0.objectiveContainer = arg_2_0.bgTr:Find("conditions/list")
	arg_2_0.objectiveTpl = arg_2_0.bgTr:Find("conditions/list/tpl")
	arg_2_0.objectiveContainer.localPosition = Vector3(2000, arg_2_0.objectiveContainer.localPosition.y, 0)

	setText(arg_2_0.bgTr:Find("conditions/Text"), i18n("battle_result_targets"))

	return
end

function var_0_0.SetUp(arg_3_0, arg_3_1)
	arg_3_0:Show()
	seriesAsync({
		function(arg_4_0)
			arg_3_0:LoadBGAndGrade(arg_4_0)

			return
		end,
		function(arg_5_0)
			arg_3_0:PlayEnterAnimation(arg_5_0)
			arg_3_0:UpdateChapterName()

			return
		end,
		function(arg_6_0)
			arg_3_0:LoadEffects(arg_6_0)

			return
		end,
		function(arg_7_0)
			arg_3_0:UpdateObjectives(arg_7_0)

			return
		end,
		function(arg_8_0)
			arg_3_0:RegisterEvent(arg_8_0)

			return
		end
	}, function()
		arg_3_0:Clear()
		arg_3_0:Destroy()
		arg_3_1()

		return
	end)

	return
end

function var_0_0.RegisterEvent(arg_10_0, arg_10_1)
	if arg_10_0.exited then
		return
	end

	onButton(arg_10_0, arg_10_0._tf, arg_10_1, SFX_PANEL)

	if arg_10_0.contextData.autoSkipFlag then
		triggerButton(arg_10_0._tf)
	end

	return
end

function var_0_0.Clear(arg_11_0)
	removeOnButton(arg_11_0._tf)

	return
end

local function var_0_1(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.text or ""
	local var_12_1 = arg_12_1.icon
	local var_12_2 = arg_12_1.value or ""
	local var_12_3 = arg_12_0.transform:Find("checkBox"):GetComponent(typeof(Image))

	setActive(var_12_3.gameObject, var_12_1)

	if var_12_1 then
		var_12_3.sprite = GetSpriteFromAtlas("ui/battleresult_atlas", var_12_1)

		var_12_3:SetNativeSize()
	end

	setText(arg_12_0.transform:Find("text"), var_12_0)
	setText(arg_12_0.transform:Find("value"), var_12_2)
	setActive(arg_12_0:Find("fx"), true)

	return
end

function var_0_0.GetGetObjectives(arg_13_0)
	return NewBattleResultUtil.GetObjectives(arg_13_0.contextData)
end

function var_0_0.UpdateObjectives(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetGetObjectives()

	if #var_14_0 <= 0 then
		setActive(arg_14_0.objectiveTpl, false)
		arg_14_1()

		return
	end

	local var_14_1 = {
		arg_14_0.objectiveTpl
	}

	for iter_14_0 = 2, #var_14_0 do
		table.insert(var_14_1, (Object.Instantiate(arg_14_0.objectiveTpl, arg_14_0.objectiveContainer)))
	end

	for iter_14_1 = 1, #var_14_0 do
		table.insert({}, function(arg_15_0)
			if arg_14_0.exited then
				return
			end

			var_0_1(var_14_1[iter_14_1], var_14_0[iter_14_1])
			onDelayTick(arg_15_0, 0.3)

			return
		end)
	end

	seriesAsync({}, arg_14_1)
	LeanTween.value(arg_14_0.objectiveContainer.gameObject, 2000, 237, 0.3):setOnUpdate(System.Action_float(function(arg_16_0)
		arg_14_0.objectiveContainer.localPosition = Vector3(arg_16_0, arg_14_0.objectiveContainer.localPosition.y, 0)

		return
	end))

	return
end

function var_0_0.UpdateChapterName(arg_17_0)
	setText(arg_17_0.gradeChapterName, (NewBattleResultUtil.GetChapterName(arg_17_0.contextData)))

	return
end

function var_0_0.LoadEffects(arg_18_0, arg_18_1)
	LoadAnyAsync("BattleResultItems/ResultEffect", "", nil, function(arg_19_0)
		if arg_18_0.exited or IsNil(arg_19_0) then
			if arg_18_1 then
				arg_18_1()
			end

			return
		end

		local var_19_0 = Object.Instantiate(arg_19_0, arg_18_0.bgTr)

		setText(var_19_0.transform:Find("Tips/dianjijixu/bg20"), i18n("battle_result_continue"))

		var_19_0.name = "ResultEffect"

		var_19_0.transform:SetSiblingIndex(1)

		if arg_18_1 then
			arg_18_1()
		end

		return
	end)

	return
end

function var_0_0.PlayEnterAnimation(arg_20_0, arg_20_1)
	arg_20_0.gradeTxtCG.alpha = 0

	LeanTween.value(arg_20_0.gradeTxt.gameObject, 0.2, 1, 0.3):setOnUpdate(System.Action_float(function(arg_21_0)
		arg_20_0.gradeTxtCG.alpha = arg_21_0

		return
	end)):setDelay(0.2)
	LeanTween.value(arg_20_0.gradeTxt.gameObject, 1.3, 1, 0.15):setOnUpdate(System.Action_float(function(arg_22_0)
		arg_20_0.gradeTxt.localScale = Vector3(arg_22_0, arg_22_0, 1)

		return
	end)):setDelay(0.15)

	arg_20_0.gradeLabel.localPosition = arg_20_0.gradeLabel.localPosition + Vector3(20, 20)

	LeanTween.moveLocal(arg_20_0.gradeLabel.gameObject, arg_20_0.gradeLabel.localPosition, 0.15):setDelay(0.15)

	arg_20_0.gradeChapterNameCG.alpha = 0

	LeanTween.value(arg_20_0.gradeChapterName.gameObject, 0.1, 0.7, 0.3):setOnUpdate(System.Action_float(function(arg_23_0)
		arg_20_0.gradeChapterNameCG.alpha = arg_23_0

		return
	end)):setOnComplete(System.Action(function()
		arg_20_0.gradeChapterNameCG.alpha = 1

		return
	end)):setLoopPingPong(2):setDelay(0.15)
	LeanTween.value(arg_20_0.gradeIcon.gameObject, 15, 1, 0.3):setOnUpdate(System.Action_float(function(arg_25_0)
		arg_20_0.gradeIcon.localScale = Vector3(arg_25_0, arg_25_0, 1)

		return
	end)):setOnComplete(System.Action(arg_20_1))

	return
end

function var_0_0.LoadBGAndGrade(arg_26_0, arg_26_1)
	parallelAsync({
		function(arg_27_0)
			arg_26_0:LoadBG(arg_27_0)

			return
		end,
		function(arg_28_0)
			arg_26_0:LoadGrade(arg_28_0)

			return
		end
	}, arg_26_1)

	return
end

function var_0_0.LoadBG(arg_29_0, arg_29_1)
	LoadAnyAsync("BattleResultItems/" .. NewBattleResultUtil.Score2Bg(arg_29_0.contextData.score), "", nil, function(arg_30_0)
		if arg_29_0.exited or IsNil(arg_30_0) then
			if arg_29_1 then
				arg_29_1()
			end

			return
		end

		local var_30_0 = Object.Instantiate(arg_30_0, arg_29_0._parentTf)

		var_30_0.transform:SetAsFirstSibling()

		var_30_0.name = "Effect"

		if arg_29_1 then
			arg_29_1()
		end

		return
	end)

	return
end

function var_0_0.LoadGrade(arg_31_0, arg_31_1)
	local var_31_0, var_31_1 = NewBattleResultUtil.Score2Grade(arg_31_0.contextData.score, arg_31_0.contextData._scoreMark)

	LoadImageSpriteAsync(var_31_0, arg_31_0.gradeIcon, true)
	LoadImageSpriteAsync(var_31_1, arg_31_0.gradeTxt, true)

	if arg_31_1 then
		arg_31_1()
	end

	return
end

function var_0_0.OnDestroy(arg_32_0)
	arg_32_0.exited = true

	if arg_32_0:isShowing() then
		arg_32_0:Hide()
	end

	if LeanTween.isTweening(arg_32_0.objectiveContainer.gameObject) then
		LeanTween.cancel(arg_32_0.objectiveContainer.gameObject)
	end

	if LeanTween.isTweening(arg_32_0.gradeTxt.gameObject) then
		LeanTween.cancel(arg_32_0.gradeTxt.gameObject)
	end

	if LeanTween.isTweening(arg_32_0.gradeIcon.gameObject) then
		LeanTween.cancel(arg_32_0.gradeIcon.gameObject)
	end

	if LeanTween.isTweening(arg_32_0.gradeLabel.gameObject) then
		LeanTween.cancel(arg_32_0.gradeLabel.gameObject)
	end

	if LeanTween.isTweening(arg_32_0.gradeChapterNameCG.gameObject) then
		LeanTween.cancel(arg_32_0.gradeChapterNameCG.gameObject)
	end

	return
end

return var_0_0
