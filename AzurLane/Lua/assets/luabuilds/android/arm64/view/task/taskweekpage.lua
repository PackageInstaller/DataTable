local var_0_0 = class("TaskWeekPage", import(".TaskCommonPage"))

var_0_0.WEEK_TASK_TYPE_COMMON = 1
var_0_0.WEEK_TASK_TYPE_PT = 2

function var_0_0.getUIName(arg_1_0)
	return "TaskListForWeekPage"
end

function var_0_0.RefreshWeekProgress(arg_2_0)
	arg_2_0:UpdateWeekProgress(arg_2_0.contextData.weekTaskProgressInfo)

	return
end

function var_0_0.OnLoaded(arg_3_0)
	var_0_0.super.OnLoaded(arg_3_0)

	local var_3_0 = arg_3_0._tf:Find("task_progress")

	setActive(var_3_0, true)
	setText(var_3_0:Find("title"), i18n("week_task_title_label"))

	arg_3_0.awardPreviewBtn = var_3_0:Find("award_preview")

	setText(arg_3_0.awardPreviewBtn:Find("Text"), i18n("week_task_award_preview_label"))

	arg_3_0.phaseTxt = var_3_0:Find("phase/Text"):GetComponent(typeof(Text))
	arg_3_0.progressSlider = var_3_0:Find("slider"):GetComponent(typeof(Slider))
	arg_3_0.progressTxt = var_3_0:Find("slider/Text"):GetComponent(typeof(Text))
	arg_3_0.awardList = UIItemList.New(var_3_0:Find("awards"), var_3_0:Find("awards/itemtpl"))
	arg_3_0.getBtn = var_3_0:Find("get_btn")
	arg_3_0.getBtnEnableTF = arg_3_0.getBtn:Find("enable")
	arg_3_0.getBtnDisableTF = arg_3_0.getBtn:Find("disable")
	arg_3_0.tip = var_3_0:Find("tip")

	onButton(arg_3_0, arg_3_0.awardPreviewBtn, function()
		arg_3_0.contextData.ptAwardWindow:ExecuteAction("Display", arg_3_0.contextData.weekTaskProgressInfo:GetAllPhaseDrops())

		return
	end, SFX_PANEL)

	return
end

function var_0_0.onUpdateTask(arg_5_0, arg_5_1, arg_5_2)
	var_0_0.super.onUpdateTask(arg_5_0, arg_5_1, arg_5_2)

	arg_5_2.name = arg_5_0.taskCards[arg_5_2].taskVO.id

	return
end

function var_0_0.Update(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_0.contextData.weekTaskProgressInfo:ReachMaxPt() and arg_6_0:isShowing() then
		pg.UIMgr.GetInstance():LoadingOn(false)
		arg_6_0:DoDisablePtTaskAnim(function()
			pg.UIMgr.GetInstance():LoadingOff()
			arg_6_0:Flush(arg_6_2)

			if arg_6_3 then
				local var_7_0 = arg_6_0.taskVOs or {}

				arg_6_3(var_7_0)
			end

			return
		end)
	elseif TaskScene.IsPassScenario() then
		arg_6_0:Flush(arg_6_2)

		if arg_6_3 then
			local var_6_0 = arg_6_0.taskVOs or {}

			arg_6_3(var_6_0)
		end
	else
		setActive(arg_6_0._tf, false)

		if arg_6_3 then
			arg_6_3({})
		end
	end

	return
end

function var_0_0.DoDisablePtTaskAnim(arg_8_0, arg_8_1)
	local function var_8_0(arg_9_0, arg_9_1)
		arg_9_0:DoSubmitAnim(function()
			setActive(arg_9_0._go, false)
			arg_9_1()

			return
		end)

		return
	end

	arg_8_0._scrollView.enabled = false

	local var_8_1 = arg_8_0.taskVOs or {}

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		if iter_8_1.isWeekTask then
			if arg_8_0:GetCard(iter_8_1.id) then
				table.insert({}, function(arg_11_0)
					var_8_0(var_0, arg_11_0)

					return
				end)
			end
		end
	end

	seriesAsync({}, function()
		arg_8_0._scrollView.enabled = true

		arg_8_1()

		return
	end)

	return
end

function var_0_0.GetCard(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.taskCards) do
		if iter_13_1.taskVO.id == arg_13_1 then
			return iter_13_1
		end
	end

	return nil
end

function var_0_0.Flush(arg_14_0, arg_14_1)
	arg_14_0.taskVOs = {}

	arg_14_0:UpdateWeekProgress(arg_14_0.contextData.weekTaskProgressInfo)

	if not arg_14_0.contextData.weekTaskProgressInfo:ReachMaxPt() then
		for iter_14_0, iter_14_1 in pairs((arg_14_0.contextData.weekTaskProgressInfo:GetSubTasks())) do
			table.insert(arg_14_0.taskVOs, iter_14_1)
		end
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_0.contextData.taskVOsById) do
		if iter_14_3:ShowOnTaskScene() and arg_14_1[iter_14_3:GetRealType()] then
			table.insert(arg_14_0.taskVOs, iter_14_3)
		end
	end

	table.sort(arg_14_0.taskVOs, CompareFuncs({
		function(arg_15_0)
			return -arg_15_0.getTaskStatus(arg_15_0, arg_15_0)
		end,
		function(arg_16_0)
			local var_16_0 = pg.NewGuideMgr.GetInstance()

			return var_16_0:IsBusy() and arg_16_0.id == getDorm3dGameset("drom3d_weekly_task")[1] and 0 or 1
		end,
		function(arg_17_0)
			return arg_17_0.isWeekTask and 1 or 0
		end,
		function(arg_18_0)
			return arg_18_0.id
		end
	}))
	arg_14_0:Show()

	arg_14_0._scrollView.enabled = true

	arg_14_0._scrollView:SetTotalCount(#arg_14_0.taskVOs, -1)

	return
end

function var_0_0.UpdateWeekProgress(arg_19_0, arg_19_1)
	arg_19_0:UpdateWeekProgressGetBtn(arg_19_1)

	arg_19_0.phaseTxt.text = arg_19_1:GetPhase() .. "/" .. arg_19_1:GetTotalPhase()

	local var_19_0 = arg_19_1:GetProgress()
	local var_19_1 = arg_19_1:GetTarget()

	arg_19_0.progressSlider.value = var_19_0 / var_19_1
	arg_19_0.progressTxt.text = var_19_0 .. "/" .. var_19_1

	local var_19_2 = arg_19_1:GetDropList()

	arg_19_0.awardList:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			updateDrop(arg_20_2, {
				type = var_19_2[arg_20_1 + 1][1],
				id = var_19_2[arg_20_1 + 1][2],
				count = var_19_2[arg_20_1 + 1][3]
			})
			onButton(arg_19_0, arg_20_2, function()
				arg_19_0:emit(TaskMediator.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_19_0.awardList:align(#arg_19_1:GetDropList())

	return
end

function var_0_0.UpdateWeekProgressGetBtn(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1:CanUpgrade()

	setGray(arg_22_0.getBtn, not var_22_0, false)
	setActive(arg_22_0.getBtnEnableTF, var_22_0)
	setActive(arg_22_0.getBtnDisableTF, not var_22_0)
	setActive(arg_22_0.tip, var_22_0)
	onButton(arg_22_0, arg_22_0.getBtn, function()
		if var_22_0 then
			arg_22_0:JudgeOverflow(arg_22_1, function()
				arg_22_0:emit(TaskMediator.ON_SUBMIT_WEEK_PROGREE)

				return
			end)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.JudgeOverflow(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = getProxy(PlayerProxy):getRawData()
	local var_25_1 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
	local var_25_2, var_25_3 = Task.StaticJudgeOverflow(var_25_0.gold, var_25_0.oil, var_25_1, true, true, (arg_25_1:GetDropList()))

	if var_25_2 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_ITEM_BOX,
			content = i18n("award_max_warning"),
			items = var_25_3,
			onYes = arg_25_2
		})
	else
		arg_25_2()
	end

	return
end

function var_0_0.OnDestroy(arg_26_0)
	arg_26_0._scrollView.onValueChanged:RemoveAllListeners()

	return
end

function var_0_0.RefreshWeekTaskPageBefore(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:GetCard(arg_27_1)

	if var_27_0 then
		setActive(var_27_0._go, false)
	end

	return
end

return var_0_0
