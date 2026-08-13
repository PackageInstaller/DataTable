class = var_0_10000

local var_0_0 = "AnniversaryIslandSpringTask2023Scene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AnniversaryIslandSpringTask2023UI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "TaskList/ScrollView")

	GetComponent = var_2_0
	arg_2_0.taskListRect = var_2_0(var_2_1, "LScrollRect")

	local var_2_2 = arg_2_0.taskListRect

	function var_2_2.onUpdateItem(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.UpdateTaskListItem(var_3_0, arg_3_0, arg_3_1)

		return
	end

	setText = var_2_2

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_3.Find(var_2_3, "Desc/Text")

	i18n = var_2_3

	var_2_2(var_2_4, var_2_3("springtask_tip"))

	setActive = var_2_2

	local var_2_5 = arg_2_0._tf

	var_2_2(var_3.Find(var_2_5, "Top/Help"), false)

	return
end

function var_0_1.BuildTaskVOs(arg_4_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)
	local var_4_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_4_2 = var_4_1(var_4_0, var_1_10003.ACTIVITY_TYPE_HOTSPRING_2)
	local var_4_3 = var_1.GetUnlockTaskIds(var_4_2)
	local var_4_4 = var_1

	arg_4_0.activityId = var_1.GetConfigID(var_4_4)
	getProxy = var_4_4
	ActivityTaskProxy = var_1_10005

	local var_4_5 = var_4_4(var_1_10005)
	local var_4_6 = var_4.getTaskVOsByActId(var_4_5, var_3)

	arg_4_0.lockTasks = {}
	_ = var_5
	arg_4_0.taskVOs = var_5.map(var_4_3, function(arg_5_0)
		_ = var_2_10001

		local var_5_0

		if not var_2_10001.detect(var_4_6, function(arg_6_0)
			return arg_6_0:GetConfigID() == arg_5_0
		end) then
			ActivityTask = var_2
			var_5_0 = var_2.New(var_0, {
				id = arg_5_0
			})
			arg_4_0.lockTasks[var_5_0] = true
		end

		return var_5_0
	end)
	CompareFuncs = var_5

	local var_4_7 = var_5({
		function(arg_7_0)
			return arg_7_0:isOver() and 1 or 0
		end,
		function(arg_8_0)
			return arg_4_0.lockTasks[arg_8_0] and 1 or 0
		end,
		function(arg_9_0)
			return arg_9_0:GetConfigID()
		end
	})

	table = var_6

	var_6.sort(arg_4_0.taskVOs, var_4_7)

	return
end

function var_0_1.UpdateTaskListItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1 = arg_10_1 + 1
	tf = var_1_10003

	local var_10_0 = var_1_10003(arg_10_2)
	local var_10_1 = arg_10_0.taskVOs[arg_10_1]
	local var_10_2 = var_4.GetConfigID(var_10_1)

	pg = var_10_1

	local var_10_3 = var_10_1.task_data_template[var_10_2]
	local var_10_4 = var_4:isFinish()
	local var_10_5 = var_4:isOver()
	local var_10_6 = var_4:isSubmit()
	local var_10_7 = var_10_3.award_display
	local var_10_8 = var_4:getProgress()
	local var_10_9 = var_4
	local var_10_10 = var_4.getTargetNumber(var_10_9)

	setActive = var_10_9

	var_10_9(var_10_0:Find("Lock"), arg_10_0.lockTasks[var_4])

	setText = var_10_9

	var_10_9(var_10_0:Find("BG/Progress"), var_10_8 .. "/" .. var_10_10)

	setSlider = var_10_9

	var_10_9(var_10_0:Find("BG/ProgressBar"), 0, var_10_10, var_10_8)

	changeToScrollText = var_10_9

	var_10_9(var_10_0:Find("BG/Name/Text"), var_10_3.name)

	setActive = var_10_9

	var_10_9(var_10_0:Find("BG/Go"), not var_10_5 and not var_10_4)

	setActive = var_10_9

	var_10_9(var_10_0:Find("BG/Commit"), not var_10_5 and var_10_4 and var_10_6)

	setActive = var_10_9

	var_10_9(var_10_0:Find("BG/Reward"), not var_10_5 and var_10_4 and not var_10_6)

	setActive = var_10_9

	var_10_9(var_10_0:Find("BG/Got"), var_10_5)

	UIItemList = var_10_9

	local var_10_11 = var_10_9.StaticAlign
	local var_10_12 = var_10_0:Find("BG/Items")
	local var_10_13 = var_10_0:Find("BG/Items")

	var_10_11(var_10_12, var_15.GetChild(var_10_13, 0), #var_10_7, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_11_0 = var_10_7[arg_11_1 + 1]
		local var_11_1 = {
			type = var_11_0[1],
			id = var_11_0[2],
			count = var_11_0[3]
		}

		updateDrop = var_5

		var_5(arg_11_2:Find("Icon"), var_11_1)

		onButton = var_5

		var_5(arg_10_0, arg_11_2, function()
			local var_12_0 = arg_10_0
			local var_12_1 = var_0.emit

			BaseUI = var_3_10002

			var_12_1(var_12_0, var_3_10002.ON_DROP, var_11_1)

			return
		end)

		setActive = var_5

		var_5(arg_11_2:Find("Completed"), var_10_5)

		return
	end)

	onButton = var_10_11

	local var_10_14 = arg_10_0
	local var_10_15 = var_10_0:Find("BG/Go")

	local function var_10_16()
		local var_13_0 = arg_10_0
		local var_13_1 = var_0.emit

		AnniversaryIslandSpringTask2023Mediator = var_2_10002

		var_13_1(var_13_0, var_2_10002.TASK_GO, {
			taskVO = var_0
		})

		return
	end

	SFX_PANEL = var_17

	var_10_11(var_10_14, var_10_15, var_10_16, var_17)

	onButton = var_10_11

	local var_10_17 = arg_10_0
	local var_10_18 = var_10_0:Find("BG/Commit")

	local function var_10_19()
		local var_14_0 = arg_10_0
		local var_14_1 = var_0.emit

		AnniversaryIslandSpringTask2023Mediator = var_2_10002

		var_14_1(var_14_0, var_2_10002.SHOW_SUBMIT_WINDOW, var_0)

		return
	end

	SFX_PANEL = var_17

	var_10_11(var_10_17, var_10_18, var_10_19, var_17)

	onButton = var_10_11

	local var_10_20 = arg_10_0
	local var_10_21 = var_10_0:Find("BG/Reward")

	local function var_10_22()
		local var_15_0 = arg_10_0
		local var_15_1 = var_0.emit

		AnniversaryIslandSpringTask2023Mediator = var_2_10002

		var_15_1(var_15_0, var_2_10002.SUBMIT_TASK, var_0)

		return
	end

	SFX_PANEL = var_17

	var_10_11(var_10_20, var_10_21, var_10_22, var_17)

	return
end

function var_0_1.didEnter(arg_16_0)
	onButton = var_1_10001

	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0._tf
	local var_16_2 = var_3.Find(var_16_1, "Top/Back")

	local function var_16_3()
		local var_17_0 = arg_16_0

		var_0.onBackPressed(var_17_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_16_0, var_16_2, var_16_3, var_5)

	onButton = var_1_10001

	local var_16_4 = arg_16_0
	local var_16_5 = arg_16_0._tf
	local var_16_6 = var_3.Find(var_16_5, "Top/Home")

	local function var_16_7()
		local var_18_0 = arg_16_0

		var_0.quickExitFunc(var_18_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_16_4, var_16_6, var_16_7, var_5)

	onButton = var_1_10001

	local var_16_8 = arg_16_0
	local var_16_9 = arg_16_0._tf
	local var_16_10 = var_3.Find(var_16_9, "Top/Help")

	local function var_16_11()
		pg = var_2_10000

		local var_19_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_19_1 = var_0.ShowMsgBox
		local var_19_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_19_2.type = var_2_10003
		i18n = var_2_10003
		var_19_2.helps = var_2_10003("springtask_help")

		var_19_1(var_19_0, var_19_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_16_8, var_16_10, var_16_11, var_5)
	arg_16_0:BuildTaskVOs()
	arg_16_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_20_0)
	local var_20_0 = arg_20_0.taskListRect

	var_1.SetTotalCount(var_20_0, #arg_20_0.taskVOs)

	return
end

function var_0_1.willExit(arg_21_0)
	return
end

return var_0_1
