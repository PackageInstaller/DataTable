local var_0_0 = class("VoteExchangeScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "VoteExchangeUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("blur_panel/adapt/top/back_btn")
	arg_2_0.dailyTask = arg_2_0._tf:Find("left/task/slider/bar")
	arg_2_0.dailyTaskTxt = arg_2_0._tf:Find("left/task/Text"):GetComponent(typeof(Text))
	arg_2_0.timeTxt = arg_2_0._tf:Find("right/title/Text/Text"):GetComponent(typeof(Text))
	arg_2_0.dailyTaskGoBtn = arg_2_0._tf:Find("left/go")
	arg_2_0.totalCntTxt = arg_2_0._tf:Find("right/total/Text"):GetComponent(typeof(Text))
	arg_2_0.uiItemList = UIItemList.New(arg_2_0._tf:Find("right/view/content"), arg_2_0._tf:Find("right/view/content/tpl"))
	arg_2_0.taskContainer = arg_2_0._tf:Find("right/view")
	arg_2_0.emptyTr = arg_2_0._tf:Find("right/empty")

	setText(arg_2_0._tf:Find("left/bg/Text"), i18n("vote_lable_daily_task_title"))

	local var_2_0 = string.split(i18n("vote_lable_daily_task_tip"), "$1")

	setText(arg_2_0._tf:Find("left/task/desc/label1"), var_2_0[1])
	setText(arg_2_0._tf:Find("left/task/desc/labe2"), var_2_0[2])
	setText(arg_2_0._tf:Find("right/title/Text"), i18n("vote_lable_task_title"))
	setText(arg_2_0.emptyTr:Find("Image/Text"), i18n("vote_lable_task_list_is_empty"))

	return
end

function var_0_0.didEnter(arg_3_0)
	assert(arg_3_0.contextData.voteGroup)
	onButton(arg_3_0, arg_3_0.dailyTaskGoBtn, function()
		arg_3_0:emit(VoteExchangeMediator.GO_TASK)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_PANEL)

	arg_3_0.taskList = arg_3_0:GetTaskList()
	arg_3_0.dailyTaskList = arg_3_0:GetDailyTaskList()

	arg_3_0:Flush()

	return
end

function var_0_0.Flush(arg_6_0)
	arg_6_0:UpdateDailyTask()
	arg_6_0:UpdateTitle()
	arg_6_0:UpdateTicket()
	arg_6_0:UpdateTaskList()

	return
end

function var_0_0.UpdateTitle(arg_7_0)
	arg_7_0.timeTxt.text = arg_7_0.contextData.voteGroup:getConfig("name") .. " " .. arg_7_0.contextData.voteGroup:getTimeDesc()

	return
end

function var_0_0.GetActivity(arg_8_0)
	local var_8_0

	for iter_8_0, iter_8_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_VOTE))) do
		if iter_8_1:getConfig("config_id") == arg_8_0.contextData.voteGroup.configId then
			var_8_0 = iter_8_1

			break
		end
	end

	return var_8_0
end

function var_0_0.UpdateTicket(arg_9_0)
	local var_9_0 = arg_9_0:GetActivity()

	arg_9_0.totalCntTxt.text = var_9_0 and var_9_0.data3 .. "/" .. arg_9_0.contextData.voteGroup:getConfig("ticket_period") or ""

	return
end

function var_0_0.GetTaskList(arg_10_0)
	local var_10_0 = arg_10_0:GetActivity()

	if var_10_0 and var_10_0.data3 >= arg_10_0.contextData.voteGroup:getConfig("ticket_period") then
		return {}
	end

	local var_10_1 = Clone(arg_10_0.contextData.voteGroup:getConfig("task_period"))
	local var_10_2 = getProxy(TaskProxy)

	for iter_10_0 = #var_10_1, 1, -1 do
		for iter_10_1 = #var_10_1[iter_10_0], 1, -1 do
			local var_10_3 = var_10_2:getTaskById(var_10_1[iter_10_0][iter_10_1]) or var_10_2:getFinishTaskById(var_10_1[iter_10_0][iter_10_1])

			if not var_10_3 or var_10_3:isFinish() and var_10_3:isReceive() then
				table.remove(var_10_1[iter_10_0], iter_10_1)
			end
		end

		if #var_10_1[iter_10_0] <= 0 then
			table.remove(var_10_1, iter_10_0)
		end
	end

	return var_10_1
end

function var_0_0.GetDailyTaskList(arg_11_0)
	return (arg_11_0.contextData.voteGroup:getConfig("task_daily"))
end

function var_0_0.UpdateDailyTask(arg_12_0)
	local var_12_0 = 0
	local var_12_1 = getProxy(TaskProxy)

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.dailyTaskList) do
		local var_12_2 = var_12_1:getTaskById(iter_12_1) or var_12_1:getFinishTaskById(iter_12_1)

		if var_12_2 and var_12_2:isFinish() and var_12_2:isReceive() then
			var_12_0 = var_12_0 + 1
		end
	end

	arg_12_0.dailyTaskTxt.text = var_12_0 .. "/" .. #arg_12_0.dailyTaskList

	setFillAmount(arg_12_0.dailyTask, var_12_0 / #arg_12_0.dailyTaskList)

	return
end

function var_0_0.UpdateTaskList(arg_13_0)
	arg_13_0.uiItemList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			arg_13_0:UpdateTaskCard(arg_13_0.taskList[arg_14_1 + 1], arg_14_2)
		end

		return
	end)
	arg_13_0.uiItemList:align(#arg_13_0.taskList)

	local var_13_0 = #arg_13_0.taskList <= 0

	setActive(arg_13_0.emptyTr, #arg_13_0.taskList <= 0)
	setActive(arg_13_0.taskContainer, not var_13_0)

	return
end

function var_0_0.UpdateTaskCard(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = UIItemList.New(arg_15_2:Find("content"), arg_15_2:Find("content/extend_tpl"))

	var_15_0:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			arg_15_0:UpdateTaskDesc(arg_15_1[arg_16_1 + 2], arg_16_2)
		end

		return
	end)
	var_15_0:align(#arg_15_1 - 1)
	arg_15_0:UpdateTaskDesc(arg_15_1[1], arg_15_2:Find("info"))

	return
end

function var_0_0.UpdateTaskDesc(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = getProxy(TaskProxy):getTaskById(arg_17_1)

	var_17_0 = var_17_0 or getProxy(TaskProxy):getFinishTaskById(arg_17_1)

	assert(var_17_0, arg_17_1)

	local var_17_1 = var_17_0:isFinish()
	local var_17_2 = var_17_0:isReceive()
	local var_17_3 = arg_17_2:Find("go")
	local var_17_4 = arg_17_2:Find("get")

	setActive(var_17_3, not var_17_1)
	setActive(arg_17_2:Find("got"), var_17_1 and var_17_2)
	setActive(var_17_4, var_17_1 and not var_17_2)

	local var_17_5 = var_17_0:getConfig("award_display")

	updateDrop(arg_17_2:Find("IconTpl"), {
		type = var_17_5[1][1],
		id = var_17_5[1][2],
		count = var_17_5[1][3]
	})

	local var_17_6 = var_17_0:getProgress()
	local var_17_7 = var_17_0:getConfig("target_num")

	setText(arg_17_2:Find("Text"), var_17_6 .. "/" .. var_17_7)
	setText(arg_17_2:Find("desc"), var_17_0:getConfig("desc"))
	setFillAmount(arg_17_2:Find("Slider/Fill"), var_17_6 / var_17_7)
	onButton(arg_17_0, var_17_3, function()
		arg_17_0:emit(VoteExchangeMediator.SKIP_TASK, var_17_0)

		return
	end, SFX_PANEL)
	onButton(arg_17_0, var_17_4, function()
		arg_17_0:emit(VoteExchangeMediator.SUBMIT_TASK, var_17_0.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.onBackPressed(arg_20_0)
	var_0_0.super.onBackPressed(arg_20_0)

	return
end

function var_0_0.willExit(arg_21_0)
	return
end

return var_0_0
