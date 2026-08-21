local var_0_0 = class("AnniversaryIslandSpringTask2023Scene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AnniversaryIslandSpringTask2023UI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.taskListRect = GetComponent(arg_2_0._tf:Find("TaskList/ScrollView"), "LScrollRect")

	function arg_2_0.taskListRect.onUpdateItem(arg_3_0, arg_3_1)
		arg_2_0:UpdateTaskListItem(arg_3_0, arg_3_1)

		return
	end

	setText(arg_2_0._tf:Find("Desc/Text"), i18n("springtask_tip"))
	setActive(arg_2_0._tf:Find("Top/Help"), false)

	return
end

function var_0_0.BuildTaskVOs(arg_4_0)
	local var_4_9000
	local var_4_0 = getProxy(ActivityProxy)
	local var_4_1 = var_4_0.getActivityByType(var_4_9000, ActivityConst.ACTIVITY_TYPE_HOTSPRING_2)
	local var_4_2 = var_4_1:GetConfigID()

	arg_4_0.activityId = var_4_0

	local var_4_3 = getProxy(ActivityTaskProxy):getTaskVOsByActId((var_4_1:GetConfigID()))

	arg_4_0.lockTasks = {}
	arg_4_0.taskVOs = _.map(var_4_1:GetUnlockTaskIds(), function(arg_5_0)
		local var_5_0 = _.detect(var_4_3, function(arg_6_0)
			return arg_6_0:GetConfigID() == arg_5_0
		end)

		if not var_5_0 then
			var_5_0 = ActivityTask.New(var_4_2, {
				id = arg_5_0
			})
			arg_4_0.lockTasks[var_5_0] = true
		end

		return var_5_0
	end)

	table.sort(arg_4_0.taskVOs, (CompareFuncs({
		function(arg_7_0)
			return arg_7_0:isOver() and 1 or 0
		end,
		function(arg_8_0)
			return arg_4_0.lockTasks[arg_8_0] and 1 or 0
		end,
		function(arg_9_0)
			return arg_9_0:GetConfigID()
		end
	})))

	return
end

function var_0_0.UpdateTaskListItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1 = arg_10_1 + 1

	local var_10_0 = tf(arg_10_2)
	local var_10_1 = pg.task_data_template[arg_10_0.taskVOs[arg_10_1]:GetConfigID()]
	local var_10_2 = arg_10_0.taskVOs[arg_10_1]:isFinish()
	local var_10_3 = arg_10_0.taskVOs[arg_10_1]:isOver()
	local var_10_4 = arg_10_0.taskVOs[arg_10_1]:isSubmit()
	local var_10_5 = var_10_1.award_display
	local var_10_6 = arg_10_0.taskVOs[arg_10_1]:getProgress()
	local var_10_7 = arg_10_0.taskVOs[arg_10_1]:getTargetNumber()

	setActive(var_10_0:Find("Lock"), arg_10_0.lockTasks[arg_10_0.taskVOs[arg_10_1]])
	setText(var_10_0:Find("BG/Progress"), var_10_6 .. "/" .. var_10_7)
	setSlider(var_10_0:Find("BG/ProgressBar"), 0, var_10_7, var_10_6)
	changeToScrollText(var_10_0:Find("BG/Name/Text"), var_10_1.name)
	setActive(var_10_0:Find("BG/Go"), not var_10_3 and not var_10_2)
	setActive(var_10_0:Find("BG/Commit"), not var_10_3 and var_10_2 and var_10_4)
	setActive(var_10_0:Find("BG/Reward"), not var_10_3 and var_10_2 and not var_10_4)
	setActive(var_10_0:Find("BG/Got"), var_10_3)
	UIItemList.StaticAlign(var_10_0:Find("BG/Items"), var_10_0:Find("BG/Items"):GetChild(0), #var_10_5, function(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0

		if arg_11_0 ~= UIItemList.EventUpdate then
			do return end

			var_11_0 = {
				type = var_10_5[arg_11_1 + 1][1],
				id = var_10_5[arg_11_1 + 1][2]
			}
		end

		;({
			type = var_10_5[arg_11_1 + 1][1],
			id = var_10_5[arg_11_1 + 1][2]
		}).count = var_10_5[arg_11_1 + 1][3]

		updateDrop(arg_11_2:Find("Icon"), {
			type = var_10_5[arg_11_1 + 1][1],
			id = var_10_5[arg_11_1 + 1][2]
		})
		onButton(arg_10_0, arg_11_2, function()
			arg_10_0:emit(BaseUI.ON_DROP, var_11_0)

			return
		end)
		setActive(arg_11_2:Find("Completed"), var_10_3)

		return
	end)
	onButton(arg_10_0, var_10_0:Find("BG/Go"), function()
		arg_10_0:emit(AnniversaryIslandSpringTask2023Mediator.TASK_GO, {
			taskVO = var_0
		})

		return
	end, SFX_PANEL)
	onButton(arg_10_0, var_10_0:Find("BG/Commit"), function()
		arg_10_0:emit(AnniversaryIslandSpringTask2023Mediator.SHOW_SUBMIT_WINDOW, var_0)

		return
	end, SFX_PANEL)
	onButton(arg_10_0, var_10_0:Find("BG/Reward"), function()
		arg_10_0:emit(AnniversaryIslandSpringTask2023Mediator.SUBMIT_TASK, var_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_16_0)
	onButton(arg_16_0, arg_16_0._tf:Find("Top/Back"), function()
		arg_16_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_16_0, arg_16_0._tf:Find("Top/Home"), function()
		arg_16_0:quickExitFunc()

		return
	end, SFX_CANCEL)
	onButton(arg_16_0, arg_16_0._tf:Find("Top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("springtask_help")
		})

		return
	end, SFX_PANEL)
	arg_16_0:BuildTaskVOs()
	arg_16_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_20_0)
	arg_20_0.taskListRect:SetTotalCount(#arg_20_0.taskVOs)

	return
end

function var_0_0.willExit(arg_21_0)
	return
end

return var_0_0
