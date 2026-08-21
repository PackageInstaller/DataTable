local var_0_0 = class("EducateTargetLayer", import(".base.EducateBaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "EducateTargetUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.initData(arg_3_0)
	arg_3_0.taskProxy = getProxy(EducateProxy):GetTaskProxy()
	arg_3_0.targetId = arg_3_0.taskProxy:GetTargetId()
	arg_3_0.mainTaskVOs = arg_3_0.taskProxy:FilterByGroup(arg_3_0.taskProxy:GetMainTasksForShow())
	arg_3_0.otherTaskVOs = arg_3_0.taskProxy:FilterByGroup(arg_3_0.taskProxy:GetTargetTasksForShow())
	arg_3_0.canGetTargetAward = arg_3_0.taskProxy:CanGetTargetAward()

	return
end

function var_0_0.findUI(arg_4_0)
	arg_4_0.anim = arg_4_0._tf:Find("anim_root"):GetComponent(typeof(Animation))
	arg_4_0.animEvent = arg_4_0._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	arg_4_0.animEvent:SetEndEvent(function()
		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end)

	arg_4_0.windowTF = arg_4_0._tf:Find("anim_root/window")
	arg_4_0.leftTF = arg_4_0.windowTF:Find("left/content")
	arg_4_0.leftEmptyTF = arg_4_0.windowTF:Find("left/empty")

	setText(arg_4_0.leftEmptyTF:Find("target_info/Text"), i18n("child_target_set_empty"))

	arg_4_0.targetSetBtn = arg_4_0.leftEmptyTF:Find("target_info/target_set_btn")

	setText(arg_4_0.targetSetBtn:Find("skip_title"), i18n("child_target_set_skip"))

	arg_4_0.targetInfoTF = arg_4_0.leftTF:Find("target_info")
	arg_4_0.iconTF = arg_4_0.targetInfoTF:Find("icon")
	arg_4_0.nameTF = arg_4_0.targetInfoTF:Find("name_bg/name")
	arg_4_0.unfinishTF = arg_4_0.targetInfoTF:Find("unfinish")
	arg_4_0.sliderTF = arg_4_0.unfinishTF:Find("progress")
	arg_4_0.progressWhiteTF = arg_4_0.sliderTF:Find("white")

	setActive(arg_4_0.progressWhiteTF, true)
	setText(arg_4_0.unfinishTF:Find("progress/title"), i18n("child_target_progress"))

	arg_4_0.progressTextTF = arg_4_0.unfinishTF:Find("progress/title/Text")
	arg_4_0.targetAwardTF = arg_4_0.unfinishTF:Find("award")
	arg_4_0.finishTF = arg_4_0.targetInfoTF:Find("finish")

	setText(arg_4_0.finishTF:Find("Text"), i18n("child_target_finish_tip"))
	setText(arg_4_0.leftTF:Find("time/title"), i18n("child_target_time_title"))

	arg_4_0.timeTF = arg_4_0.leftTF:Find("time/Text")
	arg_4_0.taskContentTF = arg_4_0.windowTF:Find("task_scrollview/content")
	arg_4_0.mainTaskTF = arg_4_0.taskContentTF:Find("main_list")

	setText(arg_4_0.mainTaskTF:Find("list/tpl/status/get/btn/Text"), i18n("word_take"))

	arg_4_0.mainTaskUIList = UIItemList.New(arg_4_0.mainTaskTF:Find("list"), arg_4_0.mainTaskTF:Find("list/tpl"))
	arg_4_0.mainTitleTF = arg_4_0.mainTaskTF:Find("title/Text")

	setText(arg_4_0.mainTitleTF, i18n("child_target_title1"))

	arg_4_0.mainProgressTF = arg_4_0.mainTaskTF:Find("title/progress")

	setActive(arg_4_0.mainProgressTF, false)

	arg_4_0.otherTaskTF = arg_4_0.taskContentTF:Find("other_list")

	setText(arg_4_0.otherTaskTF:Find("list/tpl/status/get/btn/Text"), i18n("word_take"))

	arg_4_0.otherTaskUIList = UIItemList.New(arg_4_0.otherTaskTF:Find("list"), arg_4_0.otherTaskTF:Find("list/tpl"))
	arg_4_0.otherTitleTF = arg_4_0.otherTaskTF:Find("title/Text")

	setText(arg_4_0.otherTitleTF, i18n("child_target_title2"))

	return
end

function var_0_0.addListener(arg_6_0)
	onButton(arg_6_0, arg_6_0._tf:Find("anim_root/close"), function()
		arg_6_0:_close()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.targetSetBtn, function()
		function arg_6_0.onExit()
			getProxy(EducateProxy):MainAddLayer(Context.New({
				viewComponent = EducateTargetSetLayer,
				mediator = EducateTargetSetMediator
			}))

			return
		end

		arg_6_0:_close()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_10_0)
	arg_10_0:OverlayPanel(arg_10_0._tf, {
		groupDelta = 1
	})
	arg_10_0:initLeft()
	arg_10_0.mainTaskUIList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			arg_10_0:updateItem(arg_11_1, arg_11_2, "main")
		end

		return
	end)
	arg_10_0.otherTaskUIList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			arg_10_0:updateItem(arg_12_1, arg_12_2, "other")
		end

		return
	end)
	arg_10_0:updateItems()
	EducateGuideSequence.CheckGuide(arg_10_0.__cname, function()
		return
	end)

	return
end

function var_0_0.sumbitTask(arg_14_0, arg_14_1)
	arg_14_0:emit(EducateTargetMediator.ON_TASK_SUBMIT, arg_14_1)

	return
end

function var_0_0.initLeft(arg_15_0)
	setActive(arg_15_0.leftTF, arg_15_0.targetId ~= 0)
	setActive(arg_15_0.leftEmptyTF, arg_15_0.targetId == 0)

	if arg_15_0.targetId ~= 0 then
		LoadImageSpriteAsync("educatetarget/" .. pg.child_target_set[arg_15_0.targetId].icon, arg_15_0.iconTF, true)
		setText(arg_15_0.nameTF, pg.child_target_set[arg_15_0.targetId].name)
		EducateHelper.UpdateDropShow(arg_15_0.targetAwardTF, {
			type = pg.child_target_set[arg_15_0.targetId].drop_display[1],
			id = pg.child_target_set[arg_15_0.targetId].drop_display[2],
			number = pg.child_target_set[arg_15_0.targetId].drop_display[3]
		})
		onButton(arg_15_0, arg_15_0.targetAwardTF, function()
			if arg_15_0.canGetFinishAward then
				arg_15_0:emit(EducateTargetMediator.ON_GET_TARGET_AWARD)
			else
				arg_15_0:emit(var_0_0.EDUCATE_ON_ITEM, {
					drop = var_0
				})
			end

			return
		end, SFX_PANEL)

		local var_15_0 = getProxy(EducateProxy):GetCharData():GetStageReaminWeek(pg.child_target_set[arg_15_0.targetId].stage)
		local var_15_1 = var_15_0 <= 1 and i18n("word_in_one_week") or var_15_0 .. i18n("word_week")

		setText(arg_15_0.timeTF, var_15_1)
	end

	arg_15_0:updataTarget()

	return
end

function var_0_0.updataTarget(arg_17_0)
	local var_17_0, var_17_1 = getProxy(EducateProxy):GetTaskProxy():GetOtherTargetTaskProgress()
	local var_17_2 = var_17_0 / var_17_1

	if var_17_0 / var_17_1 > 1 then
		var_17_2 = 1
	end

	if var_17_1 == 0 then
		var_17_2 = 1
	end

	setText(arg_17_0.progressTextTF, var_17_0 .. "/" .. var_17_1)

	if not arg_17_0.lastProgress or var_17_2 <= arg_17_0.lastProgress then
		setSlider(arg_17_0.sliderTF, 0, 1, var_17_2)

		arg_17_0.lastProgress = var_17_2
	else
		arg_17_0:playProgressAnim(var_17_2)

		arg_17_0.lastProgress = var_17_2
	end

	local var_17_3 = var_17_2 >= 1

	arg_17_0.canGetFinishAward = var_17_2 >= 1 and arg_17_0.canGetTargetAward

	setActive(arg_17_0.unfinishTF, not var_17_3 or arg_17_0.canGetFinishAward)
	setActive(arg_17_0.targetAwardTF:Find("receiveVX"), arg_17_0.canGetFinishAward)
	setActive(arg_17_0.unfinishTF:Find("tip"), arg_17_0.canGetFinishAward)
	setActive(arg_17_0.finishTF, var_17_3 and not arg_17_0.canGetTargetAward)

	return
end

function var_0_0.playProgressAnim(arg_18_0, arg_18_1)
	arg_18_0:cleanManagedTween()

	local var_18_0 = arg_18_0.sliderTF:GetComponent(typeof(Slider)).value

	arg_18_0.progressWhiteTF.sizeDelta = Vector2(arg_18_0.sliderTF.rect.width * arg_18_1, arg_18_0.sliderTF.rect.height)

	arg_18_0.sliderTF:GetComponent(typeof(Animation)):Play("anim_educate_target_progress_add")
	arg_18_0:managedTween(LeanTween.delayedCall, function()
		arg_18_0:managedTween(LeanTween.value, nil, go(arg_18_0.sliderTF), var_18_0, arg_18_1, 0.264):setOnUpdate(System.Action_float(function(arg_20_0)
			setSlider(arg_18_0.sliderTF, 0, 1, arg_20_0)

			return
		end)):setEase(LeanTweenType.easeInCubic)

		return
	end, 0.132, nil)

	return
end

function var_0_0.updateItems(arg_21_0)
	setActive(arg_21_0.mainTaskTF, #arg_21_0.mainTaskVOs > 0)
	arg_21_0.mainTaskUIList:align(#arg_21_0.mainTaskVOs)
	setActive(arg_21_0.otherTaskTF, #arg_21_0.otherTaskVOs > 0)
	arg_21_0.otherTaskUIList:align(#arg_21_0.otherTaskVOs)

	return
end

function var_0_0.updateItem(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_3 == "main" then
		local var_22_0 = arg_22_0.mainTaskVOs[arg_22_1 + 1] or arg_22_0.otherTaskVOs[arg_22_1 + 1]

		setText(arg_22_2:Find("desc"), var_22_0:getConfig("name"))
		setText(arg_22_2:Find("status/go/btn/Text"), var_22_0:GetProgress() .. "/" .. var_22_0:GetFinishNum())

		local var_22_1 = var_22_0:GetTaskStatus()

		setActive(arg_22_2:Find("status/go"), var_22_1 == EducateTask.STATUS_UNFINISH)
		setActive(arg_22_2:Find("status/get"), var_22_1 == EducateTask.STATUS_FINISH)
		setActive(arg_22_2:Find("status/got"), var_22_1 == EducateTask.STATUS_RECEIVE)
		EducateHelper.UpdateDropShow(arg_22_2:Find("award"), (var_22_0:GetAwardShow()))
		onButton(arg_22_0, arg_22_2:Find("award"), function()
			arg_22_0:emit(var_0_0.EDUCATE_ON_ITEM, {
				drop = var_0
			})

			return
		end)
		onButton(arg_22_0, arg_22_2:Find("status/get"), function()
			if arg_22_0.isClick then
				return
			end

			arg_22_0.isClick = true

			arg_22_2:GetComponent(typeof(Animation)):Play(var_22_0:IsMain() and "anim_educate_target_tpl_maingot" or "anim_educate_target_tpl_othergot")
			onDelayTick(function()
				arg_22_0.isClick = nil

				arg_22_0:sumbitTask(var_22_0)
				var_22_0:SetRecieve()

				return
			end, 0.5)

			return
		end, SFX_PANEL)

		return
	end
end

function var_0_0.updateView(arg_26_0)
	arg_26_0:initData()
	arg_26_0:updateItems()
	arg_26_0:updataTarget()

	return
end

function var_0_0._close(arg_27_0)
	if arg_27_0.isClick then
		return
	end

	arg_27_0.anim:Play("anim_educate_target_out")

	return
end

function var_0_0.onBackPressed(arg_28_0)
	arg_28_0:_close()

	return
end

function var_0_0.willExit(arg_29_0)
	arg_29_0.animEvent:SetEndEvent(nil)
	arg_29_0:UnOverlayPanel(arg_29_0._tf)

	if arg_29_0.onExit then
		arg_29_0.onExit()
	else
		local var_29_0 = getProxy(EducateProxy)

		if var_29_0:GetCurTime().month == 2 then
			getProxy(EducateProxy):CheckGuide("EducateScene")
		end
	end

	return
end

return var_0_0
