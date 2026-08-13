class = var_0_10000

local var_0_0 = "EducateTargetLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".base.EducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EducateTargetUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.initData(arg_3_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)

	arg_3_0.taskProxy = var_1.GetTaskProxy(var_3_0)

	local var_3_1 = arg_3_0.taskProxy

	arg_3_0.targetId = var_1.GetTargetId(var_3_1)

	local var_3_2 = arg_3_0.taskProxy
	local var_3_3 = var_1.FilterByGroup
	local var_3_4 = arg_3_0.taskProxy

	arg_3_0.mainTaskVOs = var_3_3(var_3_2, var_3.GetMainTasksForShow(var_3_4))

	local var_3_5 = arg_3_0.taskProxy
	local var_3_6 = var_1.FilterByGroup
	local var_3_7 = arg_3_0.taskProxy

	arg_3_0.otherTaskVOs = var_3_6(var_3_5, var_3.GetTargetTasksForShow(var_3_7))

	local var_3_8 = arg_3_0.taskProxy

	arg_3_0.canGetTargetAward = var_1.CanGetTargetAward(var_3_8)

	return
end

function var_0_1.findUI(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "anim_root")
	local var_4_2 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_4_0.anim = var_4_2(var_4_1, var_3(var_1_10004))

	local var_4_3 = arg_4_0._tf
	local var_4_4 = var_1.Find(var_4_3, "anim_root")
	local var_4_5 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_4_0.animEvent = var_4_5(var_4_4, var_3(var_1_10004))

	local var_4_6 = arg_4_0.animEvent

	var_1.SetEndEvent(var_4_6, function()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_4_7 = arg_4_0._tf

	arg_4_0.windowTF = var_1.Find(var_4_7, "anim_root/window")

	local var_4_8 = arg_4_0.windowTF

	arg_4_0.leftTF = var_1.Find(var_4_8, "left/content")

	local var_4_9 = arg_4_0.windowTF

	arg_4_0.leftEmptyTF = var_1.Find(var_4_9, "left/empty")
	setText = var_1

	local var_4_10 = arg_4_0.leftEmptyTF
	local var_4_11 = var_2.Find(var_4_10, "target_info/Text")

	i18n = var_4_10

	var_1(var_4_11, var_4_10("child_target_set_empty"))

	local var_4_12 = arg_4_0.leftEmptyTF

	arg_4_0.targetSetBtn = var_1.Find(var_4_12, "target_info/target_set_btn")
	setText = var_1

	local var_4_13 = arg_4_0.targetSetBtn
	local var_4_14 = var_2.Find(var_4_13, "skip_title")

	i18n = var_4_13

	var_1(var_4_14, var_4_13("child_target_set_skip"))

	local var_4_15 = arg_4_0.leftTF

	arg_4_0.targetInfoTF = var_1.Find(var_4_15, "target_info")

	local var_4_16 = arg_4_0.targetInfoTF

	arg_4_0.iconTF = var_1.Find(var_4_16, "icon")

	local var_4_17 = arg_4_0.targetInfoTF

	arg_4_0.nameTF = var_1.Find(var_4_17, "name_bg/name")

	local var_4_18 = arg_4_0.targetInfoTF

	arg_4_0.unfinishTF = var_1.Find(var_4_18, "unfinish")

	local var_4_19 = arg_4_0.unfinishTF

	arg_4_0.sliderTF = var_1.Find(var_4_19, "progress")

	local var_4_20 = arg_4_0.sliderTF

	arg_4_0.progressWhiteTF = var_1.Find(var_4_20, "white")
	setActive = var_1

	var_1(arg_4_0.progressWhiteTF, true)

	setText = var_1

	local var_4_21 = arg_4_0.unfinishTF
	local var_4_22 = var_2.Find(var_4_21, "progress/title")

	i18n = var_4_21

	var_1(var_4_22, var_4_21("child_target_progress"))

	local var_4_23 = arg_4_0.unfinishTF

	arg_4_0.progressTextTF = var_1.Find(var_4_23, "progress/title/Text")

	local var_4_24 = arg_4_0.unfinishTF

	arg_4_0.targetAwardTF = var_1.Find(var_4_24, "award")

	local var_4_25 = arg_4_0.targetInfoTF

	arg_4_0.finishTF = var_1.Find(var_4_25, "finish")
	setText = var_1

	local var_4_26 = arg_4_0.finishTF
	local var_4_27 = var_2.Find(var_4_26, "Text")

	i18n = var_4_26

	var_1(var_4_27, var_4_26("child_target_finish_tip"))

	setText = var_1

	local var_4_28 = arg_4_0.leftTF
	local var_4_29 = var_2.Find(var_4_28, "time/title")

	i18n = var_4_28

	var_1(var_4_29, var_4_28("child_target_time_title"))

	local var_4_30 = arg_4_0.leftTF

	arg_4_0.timeTF = var_1.Find(var_4_30, "time/Text")

	local var_4_31 = arg_4_0.windowTF

	arg_4_0.taskContentTF = var_1.Find(var_4_31, "task_scrollview/content")

	local var_4_32 = arg_4_0.taskContentTF

	arg_4_0.mainTaskTF = var_1.Find(var_4_32, "main_list")
	setText = var_1

	local var_4_33 = arg_4_0.mainTaskTF
	local var_4_34 = var_2.Find(var_4_33, "list/tpl/status/get/btn/Text")

	i18n = var_4_33

	var_1(var_4_34, var_4_33("word_take"))

	UIItemList = var_1

	local var_4_35 = var_1.New
	local var_4_36 = arg_4_0.mainTaskTF
	local var_4_37 = var_2.Find(var_4_36, "list")
	local var_4_38 = arg_4_0.mainTaskTF

	arg_4_0.mainTaskUIList = var_4_35(var_4_37, var_3.Find(var_4_38, "list/tpl"))

	local var_4_39 = arg_4_0.mainTaskTF

	arg_4_0.mainTitleTF = var_1.Find(var_4_39, "title/Text")
	setText = var_1

	local var_4_40 = arg_4_0.mainTitleTF

	i18n = var_3

	var_1(var_4_40, var_3("child_target_title1"))

	local var_4_41 = arg_4_0.mainTaskTF

	arg_4_0.mainProgressTF = var_1.Find(var_4_41, "title/progress")
	setActive = var_1

	var_1(arg_4_0.mainProgressTF, false)

	local var_4_42 = arg_4_0.taskContentTF

	arg_4_0.otherTaskTF = var_1.Find(var_4_42, "other_list")
	setText = var_1

	local var_4_43 = arg_4_0.otherTaskTF
	local var_4_44 = var_2.Find(var_4_43, "list/tpl/status/get/btn/Text")

	i18n = var_4_43

	var_1(var_4_44, var_4_43("word_take"))

	UIItemList = var_1

	local var_4_45 = var_1.New
	local var_4_46 = arg_4_0.otherTaskTF
	local var_4_47 = var_2.Find(var_4_46, "list")
	local var_4_48 = arg_4_0.otherTaskTF

	arg_4_0.otherTaskUIList = var_4_45(var_4_47, var_3.Find(var_4_48, "list/tpl"))

	local var_4_49 = arg_4_0.otherTaskTF

	arg_4_0.otherTitleTF = var_1.Find(var_4_49, "title/Text")
	setText = var_1

	local var_4_50 = arg_4_0.otherTitleTF

	i18n = var_3

	var_1(var_4_50, var_3("child_target_title2"))

	return
end

function var_0_1.addListener(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_3.Find(var_6_1, "anim_root/close")

	local function var_6_3()
		local var_7_0 = arg_6_0

		var_0._close(var_7_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_6_0, var_6_2, var_6_3, var_5)

	onButton = var_1_10001

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.targetSetBtn

	local function var_6_6()
		function arg_6_0.onExit()
			getProxy = var_3_10000
			EducateProxy = var_3_10001

			local var_9_0 = var_3_10000(var_3_10001)
			local var_9_1 = var_0.MainAddLayer

			Context = var_3_10002

			local var_9_2 = var_3_10002.New
			local var_9_3 = {}

			EducateTargetSetLayer = var_3_10004
			var_9_3.viewComponent = var_3_10004
			EducateTargetSetMediator = var_3_10004
			var_9_3.mediator = var_3_10004

			var_9_1(var_9_0, var_9_2(var_9_3))

			return
		end

		local var_8_0 = arg_6_0

		var_0._close(var_8_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_6_4, var_6_5, var_6_6, var_5)

	return
end

function var_0_1.didEnter(arg_10_0)
	arg_10_0:OverlayPanel(arg_10_0._tf, {
		groupDelta = 1
	})
	arg_10_0:initLeft()

	local var_10_0 = arg_10_0.mainTaskUIList

	var_1.make(var_10_0, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_10_0

			var_3.updateItem(var_11_0, arg_11_1, arg_11_2, "main")
		end

		return
	end)

	local var_10_1 = arg_10_0.otherTaskUIList

	var_1.make(var_10_1, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = arg_10_0

			var_3.updateItem(var_12_0, arg_12_1, arg_12_2, "other")
		end

		return
	end)
	arg_10_0:updateItems()

	EducateGuideSequence = var_1

	var_1.CheckGuide(arg_10_0.__cname, function()
		return
	end)

	return
end

function var_0_1.sumbitTask(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.emit

	EducateTargetMediator = var_1_10004

	var_14_1(var_14_0, var_1_10004.ON_TASK_SUBMIT, arg_14_1)

	return
end

function var_0_1.initLeft(arg_15_0)
	setActive = var_1_10001

	var_1_10001(arg_15_0.leftTF, arg_15_0.targetId ~= 0)

	setActive = var_1_10001

	var_1_10001(arg_15_0.leftEmptyTF, arg_15_0.targetId == 0)

	if arg_15_0.targetId ~= 0 then
		pg = var_1

		local var_15_0 = var_1.child_target_set[arg_15_0.targetId]

		LoadImageSpriteAsync = var_2

		var_2("educatetarget/" .. var_15_0.icon, arg_15_0.iconTF, true)

		setText = var_2

		var_2(arg_15_0.nameTF, var_15_0.name)

		local var_15_1 = var_15_0.drop_display
		local var_15_2 = {
			type = var_15_1[1],
			id = var_15_1[2],
			number = var_15_1[3]
		}

		EducateHelper = var_4

		var_4.UpdateDropShow(arg_15_0.targetAwardTF, var_15_2)

		onButton = var_4

		local var_15_3 = arg_15_0
		local var_15_4 = arg_15_0.targetAwardTF

		local function var_15_5()
			if arg_15_0.canGetFinishAward then
				local var_16_0 = arg_15_0
				local var_16_1 = var_0.emit

				EducateTargetMediator = var_2_10002

				var_16_1(var_16_0, var_2_10002.ON_GET_TARGET_AWARD)
			else
				local var_16_2 = arg_15_0

				var_0.emit(var_16_2, var_0_1.EDUCATE_ON_ITEM, {
					drop = var_15_2
				})
			end

			return
		end

		SFX_PANEL = var_1_10008

		var_4(var_15_3, var_15_4, var_15_5, var_1_10008)

		getProxy = var_4
		EducateProxy = var_15_3

		local var_15_6 = var_4(var_15_3)
		local var_15_7 = var_4.GetCharData(var_15_6)

		if var_4.GetStageReaminWeek(var_15_7, var_15_0.stage) <= 1 then
			i18n = var_15_8

			local var_15_8

			if not var_15_8("word_in_one_week") then
				var_15_8 = var_4
				i18n = var_6
				var_15_8 = var_15_8 .. var_6("word_week")
			end

			setText = var_6

			var_6(arg_15_0.timeTF, var_15_8)
			arg_15_0:updataTarget()

			return
		end
	end
end

function var_0_1.updataTarget(arg_17_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10002

	local var_17_0 = var_1_10001(var_1_10002)
	local var_17_1 = var_1.GetTaskProxy(var_17_0)
	local var_17_2, var_17_3 = var_1.GetOtherTargetTaskProgress(var_17_1)
	local var_17_4 = var_17_2 / var_17_3

	if 1 < var_17_4 then
		var_17_4 = 1
	end

	if var_17_3 == 0 then
		var_17_4 = 1
	end

	setText = var_4

	var_4(arg_17_0.progressTextTF, var_17_2 .. "/" .. var_17_3)

	if not arg_17_0.lastProgress or var_17_4 <= arg_17_0.lastProgress then
		setSlider = var_4

		var_4(arg_17_0.sliderTF, 0, 1, var_17_4)

		arg_17_0.lastProgress = var_17_4
	else
		arg_17_0:playProgressAnim(var_17_4)

		arg_17_0.lastProgress = var_17_4
	end

	arg_17_0.canGetFinishAward = var_17_4 >= 1 and arg_17_0.canGetTargetAward
	setActive = var_5

	var_5(arg_17_0.unfinishTF, not var_4 or arg_17_0.canGetFinishAward)

	setActive = var_5

	local var_17_5 = arg_17_0.targetAwardTF

	var_5(var_6.Find(var_17_5, "receiveVX"), arg_17_0.canGetFinishAward)

	setActive = var_5

	local var_17_6 = arg_17_0.unfinishTF

	var_5(var_6.Find(var_17_6, "tip"), arg_17_0.canGetFinishAward)

	setActive = var_5

	var_5(arg_17_0.finishTF, var_4 and not arg_17_0.canGetTargetAward)

	return
end

function var_0_1.playProgressAnim(arg_18_0, arg_18_1)
	arg_18_0:cleanManagedTween()

	local var_18_0 = arg_18_0.sliderTF
	local var_18_1 = var_2.GetComponent

	typeof = var_1_10004
	Slider = var_1_10005

	local var_18_2 = var_18_1(var_18_0, var_1_10004(var_1_10005)).value
	local var_18_3 = arg_18_0.sliderTF.rect
	local var_18_4 = arg_18_0.progressWhiteTF

	Vector2 = var_1_10005
	var_18_4.sizeDelta = var_1_10005(var_18_3.width * arg_18_1, var_18_3.height)

	local var_18_5 = arg_18_0.sliderTF
	local var_18_6 = var_4.GetComponent

	typeof = var_6
	Animation = var_7

	local var_18_7 = var_18_6(var_18_5, var_6(var_7))

	var_4.Play(var_18_7, "anim_educate_target_progress_add")

	local var_18_8 = arg_18_0
	local var_18_9 = arg_18_0.managedTween

	LeanTween = var_6

	var_18_9(var_18_8, var_6.delayedCall, function()
		local var_19_0 = arg_18_0
		local var_19_1 = var_0.managedTween

		LeanTween = var_2_10002

		local var_19_2 = var_2_10002.value
		local var_19_3

		go = var_2_10004

		local var_19_4 = var_19_1(var_19_0, var_19_2, var_19_3, var_2_10004(arg_18_0.sliderTF), var_18_2, arg_18_1, 0.264)
		local var_19_5 = var_0.setOnUpdate

		System = var_19_2

		local var_19_6 = var_19_5(var_19_4, var_19_2.Action_float(function(arg_20_0)
			setSlider = var_3_10001

			var_3_10001(arg_18_0.sliderTF, 0, 1, arg_20_0)

			return
		end))
		local var_19_7 = var_0.setEase

		LeanTweenType = var_2

		var_19_7(var_19_6, var_2.easeInCubic)

		return
	end, 0.132, nil)

	return
end

function var_0_1.updateItems(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0.mainTaskTF, #arg_21_0.mainTaskVOs > 0)

	local var_21_0 = arg_21_0.mainTaskUIList

	var_1.align(var_21_0, #arg_21_0.mainTaskVOs)

	setActive = var_1

	var_1(arg_21_0.otherTaskTF, #arg_21_0.otherTaskVOs > 0)

	local var_21_1 = arg_21_0.otherTaskUIList

	var_1.align(var_21_1, #arg_21_0.otherTaskVOs)

	return
end

function var_0_1.updateItem(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0

	if arg_22_3 ~= "main" or not arg_22_0.mainTaskVOs[arg_22_1 + 1] then
		var_22_0 = arg_22_0.otherTaskVOs[arg_22_1 + 1]
	end

	setText = var_1_10005

	var_1_10005(arg_22_2:Find("desc"), var_22_0:getConfig("name"))

	setText = var_1_10005

	var_1_10005(arg_22_2:Find("status/go/btn/Text"), var_22_0:GetProgress() .. "/" .. var_22_0:GetFinishNum())

	local var_22_1 = var_22_0
	local var_22_2 = var_22_0.GetTaskStatus(var_22_1)

	setActive = var_22_1

	local var_22_3 = arg_22_2
	local var_22_4 = arg_22_2.Find(var_22_3, "status/go")

	EducateTask = var_22_3

	var_22_1(var_22_4, var_22_2 == var_22_3.STATUS_UNFINISH)

	setActive = var_22_1

	local var_22_5 = arg_22_2
	local var_22_6 = arg_22_2.Find(var_22_5, "status/get")

	EducateTask = var_22_5

	var_22_1(var_22_6, var_22_2 == var_22_5.STATUS_FINISH)

	setActive = var_22_1

	local var_22_7 = arg_22_2
	local var_22_8 = arg_22_2.Find(var_22_7, "status/got")

	EducateTask = var_22_7

	var_22_1(var_22_8, var_22_2 == var_22_7.STATUS_RECEIVE)

	local var_22_9 = var_22_0
	local var_22_10 = var_22_0.GetAwardShow(var_22_9)

	EducateHelper = var_22_9

	var_22_9.UpdateDropShow(arg_22_2:Find("award"), var_22_10)

	onButton = var_7

	var_7(arg_22_0, arg_22_2:Find("award"), function()
		local var_23_0 = arg_22_0

		var_0.emit(var_23_0, var_0_1.EDUCATE_ON_ITEM, {
			drop = var_22_10
		})

		return
	end)

	onButton = var_7

	local var_22_11 = arg_22_0
	local var_22_12 = arg_22_2:Find("status/get")

	local function var_22_13()
		if arg_22_0.isClick then
			return
		end

		arg_22_0.isClick = true

		local var_24_0 = var_22_0
		local var_24_1 = var_0.IsMain(var_24_0) and "anim_educate_target_tpl_maingot" or "anim_educate_target_tpl_othergot"
		local var_24_2 = arg_22_2
		local var_24_3 = var_1.GetComponent

		typeof = var_2_10003
		Animation = var_2_10004

		local var_24_4 = var_24_3(var_24_2, var_2_10003(var_2_10004))

		var_1.Play(var_24_4, var_24_1)

		onDelayTick = var_1

		var_1(function()
			arg_22_0.isClick = nil

			local var_25_0 = arg_22_0

			var_0.sumbitTask(var_25_0, var_22_0)

			local var_25_1 = var_22_0

			var_0.SetRecieve(var_25_1)

			return
		end, 0.5)

		return
	end

	SFX_PANEL = var_11

	var_7(var_22_11, var_22_12, var_22_13, var_11)

	return
end

function var_0_1.updateView(arg_26_0)
	arg_26_0:initData()
	arg_26_0:updateItems()
	arg_26_0:updataTarget()

	return
end

function var_0_1._close(arg_27_0)
	if arg_27_0.isClick then
		return
	end

	local var_27_0 = arg_27_0.anim

	var_1.Play(var_27_0, "anim_educate_target_out")

	return
end

function var_0_1.onBackPressed(arg_28_0)
	arg_28_0:_close()

	return
end

function var_0_1.willExit(arg_29_0)
	local var_29_0 = arg_29_0.animEvent

	var_1.SetEndEvent(var_29_0, nil)

	local var_29_1 = arg_29_0

	arg_29_0.UnOverlayPanel(var_29_1, arg_29_0._tf)

	if arg_29_0.onExit then
		arg_29_0.onExit()
	else
		getProxy = var_1
		EducateProxy = var_29_1

		local var_29_2 = var_1(var_29_1)

		if var_1.GetCurTime(var_29_2).month == 2 then
			getProxy = var_1
			EducateProxy = var_29_2

			local var_29_3 = var_1(var_29_2)

			var_1.CheckGuide(var_29_3, "EducateScene")
		end
	end

	return
end

return var_0_1
