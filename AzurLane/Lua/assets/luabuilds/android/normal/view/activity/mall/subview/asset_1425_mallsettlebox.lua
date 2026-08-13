class = var_0_10000

local var_0_0 = "MallSettleBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.SILDER_TIME = 2
var_0_1.DIALOGUE_PROGRESS = 0.5
var_0_1.DIALOGUE_INTERVAL_TIME = 0.5
var_0_1.STAFF_CHANGE_INTERVAL = 0.2
var_0_1.STAFF_BODY_CNT = 4
var_0_1.STAFF_CLOTHES_CNT = 6
var_0_1.STAFF_FACE_CNT = 5

function var_0_1.getUIName(arg_1_0)
	return "MallSettleBox"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.uiSummaryText

	i18n = var_1_10003

	var_1_10001(var_2_0, var_1_10003("mall_summary_btn"))

	setText = var_1_10001

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_2.Find(var_2_1, "window/tip")

	i18n = var_2_1

	var_1_10001(var_2_2, var_2_1("word_click_to_close"))

	setActive = var_1_10001

	var_1_10001(arg_2_0.uiDialogueTpl, false)

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.uiSummaryBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		MallMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.OPEN_SUMMARY_BOX)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1, arg_6_2)
	var_0_1.super.Show(arg_6_0)

	pg = var_3

	local var_6_0 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_6_0, arg_6_0._tf)

	arg_6_0.onHide = arg_6_2
	arg_6_0.level = arg_6_1

	arg_6_0:ShowAnim()

	setSlider = var_3

	var_3(arg_6_0.uiSliderTF, 0, 1, 0)

	arg_6_0.isShowEvaluate = false

	local var_6_1 = arg_6_0
	local var_6_2 = arg_6_0.managedTween

	LeanTween = var_5

	local var_6_3 = var_5.value
	local var_6_4

	go = var_7

	local var_6_5 = var_6_2(var_6_1, var_6_3, var_6_4, var_7(arg_6_0.uiSliderTF), 0, 1, var_0_1.SILDER_TIME)
	local var_6_6 = var_3.setOnUpdate

	System = var_6_3

	var_6_6(var_6_5, var_6_3.Action_float(function(arg_7_0)
		local var_7_0

		if not arg_6_0.isShowEvaluate and var_0_1.DIALOGUE_PROGRESS < arg_7_0 then
			var_7_0 = arg_6_0
			var_7_0.isShowEvaluate = true

			local var_7_1 = arg_6_0

			var_7_0.ChangeToEvaluate(var_7_1)
		end

		setSlider = var_7_0

		var_7_0(arg_6_0.uiSliderTF, 0, 1, arg_7_0)

		return
	end))

	return
end

function var_0_1.ShowAnim(arg_8_0)
	setText = var_1_10001

	local var_8_0 = arg_8_0.uiTitleText

	i18n = var_1_10003

	var_1_10001(var_8_0, var_1_10003("mall_open_title"))

	setActive = var_1_10001

	var_1_10001(arg_8_0.uiAnimTF, true)

	setActive = var_1_10001

	var_1_10001(arg_8_0.uiDialogueTF, false)

	setActive = var_1_10001

	var_1_10001(arg_8_0.uiSummaryBtn, false)
	arg_8_0:StartTimer()

	return
end

function var_0_1.ShowRandomShowStaff(arg_9_0)
	math = var_1_10001

	local var_9_0 = var_1_10001.random(1, var_0_1.STAFF_BODY_CNT)

	math = var_2

	local var_9_1 = var_2.random(1, var_0_1.STAFF_CLOTHES_CNT)

	math = var_3

	local var_9_2 = var_3.random(1, var_0_1.STAFF_FACE_CNT)

	GetImageSpriteFromAtlasAsync = var_4

	local var_9_3 = "ui/mallstafftpl_atlas"
	local var_9_4 = "body" .. var_9_0
	local var_9_5 = arg_9_0.uiStaffTF

	var_4(var_9_3, var_9_4, var_7.Find(var_9_5, "body"))

	GetImageSpriteFromAtlasAsync = var_4

	local var_9_6 = "ui/mallstafftpl_atlas"
	local var_9_7 = "clothes" .. var_9_1
	local var_9_8 = arg_9_0.uiStaffTF

	var_4(var_9_6, var_9_7, var_7.Find(var_9_8, "clothes"))

	GetImageSpriteFromAtlasAsync = var_4

	local var_9_9 = "ui/mallstafftpl_atlas"
	local var_9_10 = "face" .. var_9_2
	local var_9_11 = arg_9_0.uiStaffTF

	var_4(var_9_9, var_9_10, var_7.Find(var_9_11, "face"))

	return
end

function var_0_1.StartTimer(arg_10_0)
	arg_10_0:StopTimer()

	Timer = var_1
	arg_10_0.timer = var_1.New(function()
		local var_11_0 = arg_10_0

		var_0.ShowRandomShowStaff(var_11_0)

		return
	end, var_0_1.STAFF_CHANGE_INTERVAL, -1)

	local var_10_0 = arg_10_0.timer

	var_1.Start(var_10_0)
	arg_10_0.timer.func()

	return
end

function var_0_1.StopTimer(arg_12_0)
	if arg_12_0.timer then
		local var_12_0 = arg_12_0.timer

		var_1.Stop(var_12_0)

		arg_12_0.timer = nil
	end

	return
end

function var_0_1.ChangeToEvaluate(arg_13_0)
	if arg_13_0.isInDialogue then
		return
	end

	arg_13_0:StopTimer()

	setText = var_1

	local var_13_0 = arg_13_0.uiTitleText

	i18n = var_1_10003

	var_1(var_13_0, var_1_10003("mall_evaluate_title"))

	setActive = var_1

	var_1(arg_13_0.uiAnimTF, false)

	removeAllChildren = var_1

	var_1(arg_13_0.uiDialogueContentTF)

	setActive = var_1

	var_1(arg_13_0.uiDialogueTF, true)

	local var_13_1 = {}

	MallLevel = var_2

	local var_13_2 = var_2.GetShowInfos(arg_13_0.level)

	pg = var_3

	local var_13_3 = var_3.ship_skin_template[var_13_2.skinId].name
	local var_13_4 = "squareicon/" .. var_3.prefab

	ipairs = var_6

	for iter_13_0, iter_13_1 in var_6(var_13_2.wordList) do
		table = var_1_10011

		var_1_10011.insert(var_13_1, function(arg_14_0)
			cloneTplTo = var_2_10001

			local var_14_0 = var_2_10001(arg_13_0.uiDialogueTpl, arg_13_0.uiDialogueContentTF)

			setText = var_2

			var_2(var_14_0:Find("name/Text"), var_13_3)

			setText = var_2

			var_2(var_14_0:Find("word/Text"), iter_13_1)

			GetImageSpriteFromAtlasAsync = var_2

			var_2(var_13_4, "", var_14_0:Find("icon"), true)

			scrollToBottom = var_2

			var_2(arg_13_0.uiDialogueTF)

			local var_14_1 = arg_13_0
			local var_14_2 = var_2.managedTween

			LeanTween = var_4

			var_14_2(var_14_1, var_4.delayedCall, function()
				arg_14_0()

				return
			end, var_0_1.DIALOGUE_INTERVAL_TIME, nil)

			return
		end)
	end

	arg_13_0.isInDialogue = true
	seriesAsync = var_6

	var_6(var_13_1, function()
		local var_16_0 = arg_13_0

		var_16_0.isInDialogue = false
		setActive = var_16_0

		var_16_0(arg_13_0.uiSummaryBtn, true)

		return
	end)

	return
end

function var_0_1.Hide(arg_17_0)
	if arg_17_0.timer then
		arg_17_0:ChangeToEvaluate()

		return
	end

	if arg_17_0.isInDialogue then
		return
	end

	var_0_1.super.Hide(arg_17_0)

	pg = var_1

	local var_17_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_17_0, arg_17_0._tf)
	arg_17_0:StopTimer()
	arg_17_0:cleanManagedTween()

	existCall = var_1

	var_1(arg_17_0.onHide)

	arg_17_0.onHide = nil

	return
end

function var_0_1.OnDestroy(arg_18_0)
	return
end

return var_0_1
