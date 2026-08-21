local var_0_0 = class("MallSettleBox", import("view.base.BaseSubView"))

var_0_0.SILDER_TIME = 2
var_0_0.DIALOGUE_PROGRESS = 0.5
var_0_0.DIALOGUE_INTERVAL_TIME = 0.5
var_0_0.STAFF_CHANGE_INTERVAL = 0.2
var_0_0.STAFF_BODY_CNT = 4
var_0_0.STAFF_CLOTHES_CNT = 6
var_0_0.STAFF_FACE_CNT = 5

function var_0_0.getUIName(arg_1_0)
	return "MallSettleBox"
end

function var_0_0.OnLoaded(arg_2_0)
	setText(arg_2_0.uiSummaryText, i18n("mall_summary_btn"))
	setText(arg_2_0._tf:Find("window/tip"), i18n("word_click_to_close"))
	setActive(arg_2_0.uiDialogueTpl, false)

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.uiSummaryBtn, function()
		arg_3_0:emit(MallMediator.OPEN_SUMMARY_BOX)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_6_0, arg_6_1, arg_6_2)
	var_0_0.super.Show(arg_6_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)

	arg_6_0.onHide = arg_6_2
	arg_6_0.level = arg_6_1

	arg_6_0:ShowAnim()
	setSlider(arg_6_0.uiSliderTF, 0, 1, 0)

	arg_6_0.isShowEvaluate = false

	arg_6_0:managedTween(LeanTween.value, nil, go(arg_6_0.uiSliderTF), 0, 1, var_0_0.SILDER_TIME):setOnUpdate(System.Action_float(function(arg_7_0)
		if not arg_6_0.isShowEvaluate and arg_7_0 > var_0_0.DIALOGUE_PROGRESS then
			arg_6_0.isShowEvaluate = true

			arg_6_0:ChangeToEvaluate()
		end

		setSlider(arg_6_0.uiSliderTF, 0, 1, arg_7_0)

		return
	end))

	return
end

function var_0_0.ShowAnim(arg_8_0)
	setText(arg_8_0.uiTitleText, i18n("mall_open_title"))
	setActive(arg_8_0.uiAnimTF, true)
	setActive(arg_8_0.uiDialogueTF, false)
	setActive(arg_8_0.uiSummaryBtn, false)
	arg_8_0:StartTimer()

	return
end

function var_0_0.ShowRandomShowStaff(arg_9_0)
	GetImageSpriteFromAtlasAsync("ui/mallstafftpl_atlas", "body" .. math.random(1, var_0_0.STAFF_BODY_CNT), arg_9_0.uiStaffTF:Find("body"))
	GetImageSpriteFromAtlasAsync("ui/mallstafftpl_atlas", "clothes" .. math.random(1, var_0_0.STAFF_CLOTHES_CNT), arg_9_0.uiStaffTF:Find("clothes"))
	GetImageSpriteFromAtlasAsync("ui/mallstafftpl_atlas", "face" .. math.random(1, var_0_0.STAFF_FACE_CNT), arg_9_0.uiStaffTF:Find("face"))

	return
end

function var_0_0.StartTimer(arg_10_0)
	arg_10_0:StopTimer()

	arg_10_0.timer = Timer.New(function()
		arg_10_0:ShowRandomShowStaff()

		return
	end, var_0_0.STAFF_CHANGE_INTERVAL, -1)

	arg_10_0.timer:Start()
	arg_10_0.timer.func()

	return
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer then
		arg_12_0.timer:Stop()

		arg_12_0.timer = nil
	end

	return
end

function var_0_0.ChangeToEvaluate(arg_13_0)
	if arg_13_0.isInDialogue then
		return
	end

	arg_13_0:StopTimer()
	setText(arg_13_0.uiTitleText, i18n("mall_evaluate_title"))
	setActive(arg_13_0.uiAnimTF, false)
	removeAllChildren(arg_13_0.uiDialogueContentTF)
	setActive(arg_13_0.uiDialogueTF, true)

	local var_13_0 = MallLevel.GetShowInfos(arg_13_0.level)
	local var_13_1 = pg.ship_skin_template[var_13_0.skinId].name
	local var_13_2 = "squareicon/" .. pg.ship_skin_template[var_13_0.skinId].prefab

	for iter_13_0, iter_13_1 in ipairs(var_13_0.wordList) do
		table.insert({}, function(arg_14_0)
			local var_14_0 = cloneTplTo(arg_13_0.uiDialogueTpl, arg_13_0.uiDialogueContentTF)

			setText(var_14_0:Find("name/Text"), var_13_1)
			setText(var_14_0:Find("word/Text"), iter_13_1)
			GetImageSpriteFromAtlasAsync(var_13_2, "", var_14_0:Find("icon"), true)
			scrollToBottom(arg_13_0.uiDialogueTF)
			arg_13_0:managedTween(LeanTween.delayedCall, function()
				arg_14_0()

				return
			end, var_0_0.DIALOGUE_INTERVAL_TIME, nil)

			return
		end)
	end

	arg_13_0.isInDialogue = true

	seriesAsync({}, function()
		arg_13_0.isInDialogue = false

		setActive(arg_13_0.uiSummaryBtn, true)

		return
	end)

	return
end

function var_0_0.Hide(arg_17_0)
	if arg_17_0.timer then
		arg_17_0:ChangeToEvaluate()

		return
	end

	if arg_17_0.isInDialogue then
		return
	end

	var_0_0.super.Hide(arg_17_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_17_0._tf)
	arg_17_0:StopTimer()
	arg_17_0:cleanManagedTween()
	existCall(arg_17_0.onHide)

	arg_17_0.onHide = nil

	return
end

function var_0_0.OnDestroy(arg_18_0)
	return
end

return var_0_0
