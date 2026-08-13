class = var_0_10000

local var_0_0 = "VoteExchangeScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "VoteExchangeUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "blur_panel/adapt/top/back_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.dailyTask = var_1.Find(var_2_1, "left/task/slider/bar")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "left/task/Text")
	local var_2_4 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.dailyTaskTxt = var_2_4(var_2_3, var_4(var_1_10006))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "right/title/Text/Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.timeTxt = var_2_7(var_2_6, var_4(var_1_10006))

	local var_2_8 = arg_2_0._tf

	arg_2_0.dailyTaskGoBtn = var_1.Find(var_2_8, "left/go")

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "right/total/Text")
	local var_2_11 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.totalCntTxt = var_2_11(var_2_10, var_4(var_1_10006))
	UIItemList = var_1

	local var_2_12 = var_1.New
	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_3.Find(var_2_13, "right/view/content")
	local var_2_15 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_12(var_2_14, var_4.Find(var_2_15, "right/view/content/tpl"))

	local var_2_16 = arg_2_0._tf

	arg_2_0.taskContainer = var_1.Find(var_2_16, "right/view")

	local var_2_17 = arg_2_0._tf

	arg_2_0.emptyTr = var_1.Find(var_2_17, "right/empty")
	setText = var_1

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_3.Find(var_2_18, "left/bg/Text")

	i18n = var_4

	var_1(var_2_19, var_4("vote_lable_daily_task_title"))

	string = var_1

	local var_2_20 = var_1.split

	i18n = var_2_19

	local var_2_21 = var_2_20(var_2_19("vote_lable_daily_task_tip"), "$1")

	setText = var_1_10002

	local var_2_22 = arg_2_0._tf

	var_1_10002(var_4.Find(var_2_22, "left/task/desc/label1"), var_2_21[1])

	setText = var_1_10002

	local var_2_23 = arg_2_0._tf

	var_1_10002(var_4.Find(var_2_23, "left/task/desc/labe2"), var_2_21[2])

	setText = var_1_10002

	local var_2_24 = arg_2_0._tf
	local var_2_25 = var_4.Find(var_2_24, "right/title/Text")

	i18n = var_5

	var_1_10002(var_2_25, var_5("vote_lable_task_title"))

	setText = var_1_10002

	local var_2_26 = arg_2_0.emptyTr
	local var_2_27 = var_4.Find(var_2_26, "Image/Text")

	i18n = var_5

	var_1_10002(var_2_27, var_5("vote_lable_task_list_is_empty"))

	return
end

function var_0_1.didEnter(arg_3_0)
	assert = var_1_10001

	var_1_10001(arg_3_0.contextData.voteGroup)

	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.dailyTaskGoBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		VoteExchangeMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.GO_TASK)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	arg_3_0.taskList = arg_3_0:GetTaskList()
	arg_3_0.dailyTaskList = arg_3_0:GetDailyTaskList()

	arg_3_0:Flush()

	return
end

function var_0_1.Flush(arg_6_0)
	arg_6_0:UpdateDailyTask()
	arg_6_0:UpdateTitle()
	arg_6_0:UpdateTicket()
	arg_6_0:UpdateTaskList()

	return
end

function var_0_1.UpdateTitle(arg_7_0)
	local var_7_0 = arg_7_0.contextData.voteGroup
	local var_7_1 = var_1.getConfig(var_7_0, "name")
	local var_7_2 = arg_7_0.contextData.voteGroup
	local var_7_3 = var_2.getTimeDesc(var_7_2)

	arg_7_0.timeTxt.text = var_7_1 .. " " .. var_7_3

	return
end

function var_0_1.GetActivity(arg_8_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)
	local var_8_1 = var_1.getActivitiesByType

	ActivityConst = var_1_10004

	local var_8_2 = var_8_1(var_8_0, var_1_10004.ACTIVITY_TYPE_VOTE)
	local var_8_3

	ipairs = var_8_0

	for iter_8_0, iter_8_1 in var_8_0(var_8_2) do
		if iter_8_1:getConfig("config_id") == arg_8_0.contextData.voteGroup.configId then
			var_8_3 = iter_8_1

			break
		end
	end

	return var_8_3
end

function var_0_1.UpdateTicket(arg_9_0)
	if arg_9_0:GetActivity() then
		local var_9_0 = arg_9_0.contextData.voteGroup
		local var_9_1 = var_2.getConfig(var_9_0, "ticket_period")

		arg_9_0.totalCntTxt.text = var_1.data3 .. "/" .. var_9_1
	else
		arg_9_0.totalCntTxt.text = ""
	end

	return
end

function var_0_1.GetTaskList(arg_10_0)
	local var_10_0 = arg_10_0

	if arg_10_0.GetActivity(var_10_0) then
		var_1_10002 = var_1.data3
		var_1_10005 = arg_10_0.contextData.voteGroup

		if var_10_0.getConfig(var_1_10005, "ticket_period") <= var_1_10002 then
			return {}
		end
	end

	Clone = var_1_10002

	local var_10_1 = arg_10_0.contextData.voteGroup
	local var_10_2 = var_1_10002(var_4.getConfig(var_10_1, "task_period"))

	getProxy = var_10_0
	TaskProxy = var_1_10005

	local var_10_3 = var_10_0(var_1_10005)

	for iter_10_0 = #var_10_2, 1, -1 do
		for iter_10_1 = #var_10_2[iter_10_0], 1, -1 do
			local var_10_4 = var_8[iter_10_1]
			local var_10_5

			if not var_10_3:getTaskById(var_10_4) then
				var_10_5 = var_10_3:getFinishTaskById(var_10_4)
			end

			if not var_10_5 or var_10_5:isFinish() and var_10_5:isReceive() then
				table = var_1_10015

				var_1_10015.remove(var_8, iter_10_1)
			end
		end

		if #var_8 <= 0 then
			table = var_9

			var_9.remove(var_10_2, iter_10_0)
		end
	end

	return var_10_2
end

function var_0_1.GetDailyTaskList(arg_11_0)
	local var_11_0 = arg_11_0.contextData.voteGroup

	return (var_1.getConfig(var_11_0, "task_daily"))
end

function var_0_1.UpdateDailyTask(arg_12_0)
	local var_12_0 = 0

	getProxy = var_1_10002
	TaskProxy = var_1_10004

	local var_12_1 = var_1_10002(var_1_10004)

	ipairs = var_1_10003

	for iter_12_0, iter_12_1 in var_1_10003(arg_12_0.dailyTaskList) do
		local var_12_2

		if not var_12_1:getTaskById(iter_12_1) then
			var_12_2 = var_12_1:getFinishTaskById(iter_12_1)
		end

		if var_12_2 and var_12_2:isFinish() and var_12_2:isReceive() then
			var_12_0 = var_12_0 + 1
		end
	end

	local var_12_3 = arg_12_0.dailyTaskTxt

	var_12_3.text = var_12_0 .. "/" .. #arg_12_0.dailyTaskList
	setFillAmount = var_12_3

	var_12_3(arg_12_0.dailyTask, var_12_0 / #arg_12_0.dailyTaskList)

	return
end

function var_0_1.UpdateTaskList(arg_13_0)
	local var_13_0 = arg_13_0.uiItemList

	var_1.make(var_13_0, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = arg_13_0

			var_3.UpdateTaskCard(var_14_0, arg_13_0.taskList[arg_14_1 + 1], arg_14_2)
		end

		return
	end)

	local var_13_1 = arg_13_0.uiItemList

	var_1.align(var_13_1, #arg_13_0.taskList)

	local var_13_2 = #arg_13_0.taskList <= 0

	setActive = var_2

	var_2(arg_13_0.emptyTr, var_13_2)

	setActive = var_2

	var_2(arg_13_0.taskContainer, not var_13_2)

	return
end

function var_0_1.UpdateTaskCard(arg_15_0, arg_15_1, arg_15_2)
	UIItemList = var_1_10003

	local var_15_0 = var_1_10003.New(arg_15_2:Find("content"), arg_15_2:Find("content/extend_tpl"))

	var_3.make(var_15_0, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = arg_15_0

			var_3.UpdateTaskDesc(var_16_0, arg_15_1[arg_16_1 + 2], arg_16_2)
		end

		return
	end)
	var_3:align(#arg_15_1 - 1)
	arg_15_0:UpdateTaskDesc(arg_15_1[1], arg_15_2:Find("info"))

	return
end

function var_0_1.UpdateTaskDesc(arg_17_0, arg_17_1, arg_17_2)
	getProxy = var_1_10003
	TaskProxy = var_1_10005

	local var_17_0 = var_1_10003(var_1_10005)
	local var_17_2

	if not var_3.getTaskById(var_17_0, arg_17_1) then
		getProxy = var_17_2
		TaskProxy = var_17_0

		local var_17_1 = var_17_2(var_17_0)

		var_17_2 = var_17_2.getFinishTaskById(var_17_1, arg_17_1)
	end

	assert = var_1_10004

	var_1_10004(var_17_2, arg_17_1)

	local var_17_3 = var_17_2:isFinish()
	local var_17_4 = var_17_2:isReceive()
	local var_17_5 = arg_17_2
	local var_17_6 = arg_17_2.Find(var_17_5, "go")
	local var_17_7 = arg_17_2
	local var_17_8 = arg_17_2.Find(var_17_7, "get")

	setActive = var_17_5

	var_17_5(var_17_6, not var_17_3)

	setActive = var_17_5

	var_17_5(arg_17_2:Find("got"), var_17_3 and var_17_4)

	setActive = var_17_5

	var_17_5(var_17_8, var_17_3 and not var_17_4)

	local var_17_9 = var_17_2:getConfig("award_display")

	updateDrop = var_17_7

	var_17_7(arg_17_2:Find("IconTpl"), {
		type = var_17_9[1][1],
		id = var_17_9[1][2],
		count = var_17_9[1][3]
	})

	local var_17_10 = var_17_2
	local var_17_11 = var_17_2.getProgress(var_17_10)
	local var_17_12 = var_17_2:getConfig("target_num")

	setText = var_17_10

	var_17_10(arg_17_2:Find("Text"), var_17_11 .. "/" .. var_17_12)

	setText = var_17_10

	var_17_10(arg_17_2:Find("desc"), var_17_2:getConfig("desc"))

	setFillAmount = var_17_10

	var_17_10(arg_17_2:Find("Slider/Fill"), var_17_11 / var_17_12)

	onButton = var_17_10

	local var_17_13 = arg_17_0
	local var_17_14 = var_17_6

	local function var_17_15()
		local var_18_0 = arg_17_0
		local var_18_1 = var_0.emit

		VoteExchangeMediator = var_2_10003

		var_18_1(var_18_0, var_2_10003.SKIP_TASK, var_17_2)

		return
	end

	SFX_PANEL = var_16

	var_17_10(var_17_13, var_17_14, var_17_15, var_16)

	onButton = var_17_10

	local var_17_16 = arg_17_0
	local var_17_17 = var_17_8

	local function var_17_18()
		local var_19_0 = arg_17_0
		local var_19_1 = var_0.emit

		VoteExchangeMediator = var_2_10003

		var_19_1(var_19_0, var_2_10003.SUBMIT_TASK, var_17_2.id)

		return
	end

	SFX_PANEL = var_16

	var_17_10(var_17_16, var_17_17, var_17_18, var_16)

	return
end

function var_0_1.onBackPressed(arg_20_0)
	var_0_1.super.onBackPressed(arg_20_0)

	return
end

function var_0_1.willExit(arg_21_0)
	return
end

return var_0_1
