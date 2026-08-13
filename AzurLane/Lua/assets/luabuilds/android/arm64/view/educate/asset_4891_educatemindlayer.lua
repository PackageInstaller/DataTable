class = var_0_10000

local var_0_0 = "EducateMindLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".base.EducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EducateMindUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.initData(arg_3_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)

	arg_3_0.taskProxy = var_1.GetTaskProxy(var_3_0)

	local var_3_1 = arg_3_0.taskProxy
	local var_3_2 = var_1.GetTasksBySystem

	EducateTask = var_1_10004
	arg_3_0.taskVOs = var_3_2(var_3_1, var_1_10004.SYSTEM_TYPE_MIND)

	return
end

function var_0_1.findUI(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "anim_root")
	local var_4_2 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_4_0.anim = var_4_2(var_4_1, var_4(var_1_10006))

	local var_4_3 = arg_4_0._tf
	local var_4_4 = var_1.Find(var_4_3, "anim_root")
	local var_4_5 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_4_0.animEvent = var_4_5(var_4_4, var_4(var_1_10006))

	local var_4_6 = arg_4_0.animEvent

	var_1.SetEndEvent(var_4_6, function()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_4_7 = arg_4_0._tf

	arg_4_0.windowTF = var_1.Find(var_4_7, "anim_root/window")

	local var_4_8 = arg_4_0.windowTF

	arg_4_0.scrollview = var_1.Find(var_4_8, "scrollview")

	local var_4_9 = arg_4_0.scrollview

	arg_4_0.emptyTF = var_1.Find(var_4_9, "empty")
	setText = var_1

	local var_4_10 = arg_4_0.emptyTF
	local var_4_11 = var_3.Find(var_4_10, "Text")

	i18n = var_4

	var_1(var_4_11, var_4("child_mind_empty_tip"))

	local var_4_12 = arg_4_0.scrollview

	arg_4_0.contentTF = var_1.Find(var_4_12, "view/content")

	local var_4_13 = arg_4_0.contentTF

	arg_4_0.finishListTF = var_1.Find(var_4_13, "finish_list")
	UIItemList = var_1

	local var_4_14 = var_1.New
	local var_4_15 = arg_4_0.finishListTF
	local var_4_16 = var_3.Find(var_4_15, "list")
	local var_4_17 = arg_4_0.finishListTF

	arg_4_0.finishUIList = var_4_14(var_4_16, var_4.Find(var_4_17, "list/tpl"))
	setText = var_1

	local var_4_18 = arg_4_0.finishListTF
	local var_4_19 = var_3.Find(var_4_18, "title/Text")

	i18n = var_4

	var_1(var_4_19, var_4("child_mind_finish_title"))

	setText = var_1

	local var_4_20 = arg_4_0.finishListTF
	local var_4_21 = var_3.Find(var_4_20, "list/tpl/get_btn/Text")

	i18n = var_4

	var_1(var_4_21, var_4("word_take"))

	local var_4_22 = arg_4_0.contentTF

	arg_4_0.unFinishListTF = var_1.Find(var_4_22, "unfinish_list")
	UIItemList = var_1

	local var_4_23 = var_1.New
	local var_4_24 = arg_4_0.unFinishListTF
	local var_4_25 = var_3.Find(var_4_24, "list")
	local var_4_26 = arg_4_0.unFinishListTF

	arg_4_0.unFinishUIList = var_4_23(var_4_25, var_4.Find(var_4_26, "list/tpl"))
	setText = var_1

	local var_4_27 = arg_4_0.unFinishListTF
	local var_4_28 = var_3.Find(var_4_27, "title/Text")

	i18n = var_4

	var_1(var_4_28, var_4("child_mind_processing_title"))

	setText = var_1

	local var_4_29 = arg_4_0.unFinishListTF
	local var_4_30 = var_3.Find(var_4_29, "list/tpl/time_desc")

	i18n = var_4

	var_1(var_4_30, var_4("child_mind_time_title"))

	return
end

function var_0_1.addListener(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_4.Find(var_6_1, "anim_root/bg")

	local function var_6_3()
		local var_7_0 = arg_6_0

		var_0._close(var_7_0)

		return
	end

	SFX_PANEL = var_6_1

	var_1_10001(var_6_0, var_6_2, var_6_3, var_6_1)

	return
end

function var_0_1.didEnter(arg_8_0)
	arg_8_0:OverlayPanel(arg_8_0._tf, {
		groupDelta = 1
	})

	local var_8_0 = arg_8_0.finishUIList

	var_1.make(var_8_0, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			GetOrAddComponent = var_3
			var_3(arg_9_2, "CanvasGroup").alpha = 1

			local var_9_0 = arg_8_0

			var_3.updateFinishItem(var_9_0, arg_9_1, arg_9_2)
		end

		return
	end)

	local var_8_1 = arg_8_0.unFinishUIList

	var_1.make(var_8_1, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_8_0

			var_3.updateUnfinishItem(var_10_0, arg_10_1, arg_10_2)
		end

		return
	end)

	local var_8_2 = arg_8_0

	arg_8_0.updateItems(var_8_2)

	EducateTipHelper = var_1

	local var_8_3 = var_1.ClearNewTip

	EducateTipHelper = var_8_2

	var_8_3(var_8_2.NEW_MIND_TASK)

	return
end

function var_0_1.sumbitTask(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.emit

	EducateMindMediator = var_1_10005

	var_11_1(var_11_0, var_1_10005.ON_TASK_SUBMIT, arg_11_1)

	return
end

function var_0_1.updateItems(arg_12_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_12_0 = var_1_10001(var_1_10003)
	local var_12_1 = var_1.GetCurTime(var_12_0)

	underscore = var_1_10002
	arg_12_0.taskVOs = var_1_10002.select(arg_12_0.taskVOs, function(arg_13_0)
		return arg_13_0:InTime(var_12_1)
	end)
	arg_12_0.finishTaskVOs = {}
	arg_12_0.unFinishTaskVOs = {}
	underscore = var_2

	var_2.each(arg_12_0.taskVOs, function(arg_14_0)
		if arg_14_0:IsFinish() then
			table = var_1

			var_1.insert(arg_12_0.finishTaskVOs, arg_14_0)
		else
			table = var_1

			var_1.insert(arg_12_0.unFinishTaskVOs, arg_14_0)
		end

		return
	end)

	CompareFuncs = var_2

	local var_12_2 = var_2({
		function(arg_15_0)
			return arg_15_0:GetRemainTime(var_12_1)
		end,
		function(arg_16_0)
			return arg_16_0.id
		end
	})

	table = var_12_0

	var_12_0.sort(arg_12_0.finishTaskVOs, var_12_2)

	table = var_3

	var_3.sort(arg_12_0.unFinishTaskVOs, var_12_2)

	setActive = var_3

	var_3(arg_12_0.finishListTF, #arg_12_0.finishTaskVOs > 0)

	local var_12_3 = arg_12_0.finishUIList

	var_3.align(var_12_3, #arg_12_0.finishTaskVOs)

	setActive = var_3

	var_3(arg_12_0.unFinishListTF, #arg_12_0.unFinishTaskVOs > 0)

	local var_12_4 = arg_12_0.unFinishUIList

	var_3.align(var_12_4, #arg_12_0.unFinishTaskVOs)

	setActive = var_3

	var_3(arg_12_0.emptyTF, #arg_12_0.finishTaskVOs <= 0 and #arg_12_0.unFinishTaskVOs <= 0)

	return
end

function var_0_1.updateFinishItem(arg_17_0, arg_17_1, arg_17_2)
	LeanTween = var_1_10003

	if var_1_10003.isTweening(arg_17_2.gameObject) then
		LeanTween = var_3

		var_3.cancel(arg_17_2.gameObject)
	end

	GetOrAddComponent = var_3

	local var_17_0 = var_3(arg_17_2, "CanvasGroup")

	var_17_0.alpha = 1
	setActive = var_17_0

	var_17_0(arg_17_2, true)

	local var_17_1 = arg_17_0.finishTaskVOs[arg_17_1 + 1]

	setText = var_4

	var_4(arg_17_2:Find("desc"), var_17_1:getConfig("name"))

	onButton = var_4

	local var_17_2 = arg_17_0
	local var_17_3 = arg_17_2
	local var_17_4 = arg_17_2.Find(var_17_3, "get_btn")

	local function var_17_5()
		if not arg_17_0.isClick then
			arg_17_0.isClick = true

			local var_18_0 = arg_17_0

			var_0.doAnim(var_18_0, arg_17_2, function()
				return
			end)

			onDelayTick = var_0

			var_0(function()
				arg_17_0.isClick = nil

				local var_20_0 = arg_17_0

				var_0.sumbitTask(var_20_0, var_17_1)

				return
			end, 0.165)
		end

		return
	end

	SFX_PANEL = var_17_3

	var_4(var_17_2, var_17_4, var_17_5, var_17_3)

	return
end

function var_0_1.updateUnfinishItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.unFinishTaskVOs[arg_21_1 + 1]

	setText = var_4

	var_4(arg_21_2:Find("desc"), var_21_0:getConfig("name"))

	local var_21_1 = var_21_0
	local var_21_2

	if var_21_0.GetRemainTime(var_21_1) < 7 then
		var_21_2 = 0
	else
		math = var_21_2
		var_21_2 = var_21_2.floor(var_4 / 7)
	end

	setText = var_21_1

	local var_21_3 = arg_21_2
	local var_21_4 = arg_21_2.Find(var_21_3, "time_desc/time")
	local var_21_5 = var_21_2

	i18n = var_21_3

	var_21_1(var_21_4, var_21_5 .. var_21_3("word_week"))

	return
end

function var_0_1.doAnim(arg_22_0, arg_22_1, arg_22_2)
	GetOrAddComponent = var_1_10003

	local var_22_0 = var_1_10003(arg_22_1, "CanvasGroup")
	local var_22_1 = arg_22_1.transform.localPosition

	LeanTween = var_5

	local var_22_2 = var_5.alphaCanvas(var_22_0, 0, 0.198)

	var_5.setFrom(var_22_2, 1)

	LeanTween = var_5

	local var_22_3 = var_5.value

	go = var_22_2

	local var_22_4 = var_22_3(var_22_2(arg_22_1), var_22_1.x, var_22_1.x + 200, 0.264)
	local var_22_5 = var_5.setOnUpdate

	System = var_8

	local var_22_6 = var_22_5(var_22_4, var_8.Action_float(function(arg_23_0)
		local var_23_0 = arg_22_1.transform

		Vector3 = var_2_10002
		var_23_0.localPosition = var_2_10002(arg_23_0, var_22_1.y, var_22_1.z)

		return
	end))
	local var_22_7 = var_5.setEase

	LeanTweenType = var_8

	local var_22_8 = var_22_7(var_22_6, var_8.easeInCubic)
	local var_22_9 = var_5.setOnComplete

	System = var_8

	var_22_9(var_22_8, var_8.Action(function()
		local var_24_0 = arg_22_1.transform

		var_24_0.localPosition = var_22_1
		setActive = var_24_0

		var_24_0(arg_22_1, false)
		arg_22_2()

		return
	end))

	return
end

function var_0_1.updateView(arg_25_0)
	arg_25_0:initData()
	arg_25_0:updateItems()

	return
end

function var_0_1._close(arg_26_0)
	if arg_26_0.isClick then
		return
	end

	local var_26_0 = arg_26_0.anim

	var_1.Play(var_26_0, "anim_educate_mind_out")

	return
end

function var_0_1.onBackPressed(arg_27_0)
	arg_27_0:_close()

	return
end

function var_0_1.willExit(arg_28_0)
	local var_28_0 = arg_28_0.animEvent

	var_1.SetEndEvent(var_28_0, nil)
	arg_28_0:UnOverlayPanel(arg_28_0._tf)

	if arg_28_0.contextData.onExit then
		arg_28_0.contextData.onExit()
	end

	return
end

return var_0_1
