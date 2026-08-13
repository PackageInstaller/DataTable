class = var_0_10000

local var_0_0 = "USDefenceMainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PreviewTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)
	arg_1_0:initUI()

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)
	arg_2_0:initData()
	arg_2_0:submitFinishedTask()

	return
end

function var_0_1.OnDataSetting(arg_3_0)
	return
end

function var_0_1.OnUpdateFlush(arg_4_0)
	arg_4_0:updateAwardBtn()

	return
end

function var_0_1.OnDestroy(arg_5_0)
	return
end

function var_0_1.initData(arg_6_0)
	local var_6_0 = arg_6_0.activity

	arg_6_0.finalTaskID = var_1.getConfig(var_6_0, "config_client")[1]
	Clone = var_1
	pg = var_6_0
	arg_6_0.taskIDList = var_1(var_6_0.task_data_template[arg_6_0.finalTaskID].target_id)
	getProxy = var_1
	TaskProxy = var_2
	arg_6_0.taskProxy = var_1(var_2)
	USDefTaskWindowView = var_1
	arg_6_0.taskListView = var_1.New(arg_6_0.subViewContainer, arg_6_0.event, arg_6_0.activity)

	return
end

function var_0_1.initUI(arg_7_0)
	local var_7_0 = arg_7_0.bg

	arg_7_0.awardTF = var_1.Find(var_7_0, "Item")

	local var_7_1 = arg_7_0.awardTF

	arg_7_0.activeTF = var_1.Find(var_7_1, "Active")

	local var_7_2 = arg_7_0.awardTF

	arg_7_0.finishedTF = var_1.Find(var_7_2, "Finished")

	local var_7_3 = arg_7_0.awardTF

	arg_7_0.achievedTF = var_1.Find(var_7_3, "Achieved")
	setActive = var_1

	var_1(arg_7_0.activeTF, false)

	setActive = var_1

	var_1(arg_7_0.finishedTF, false)

	setActive = var_1

	var_1(arg_7_0.achievedTF, false)

	local var_7_4 = arg_7_0.bg

	arg_7_0.achievementBtn = var_1.Find(var_7_4, "AchieveMentBtn")

	local var_7_5 = arg_7_0._tf

	arg_7_0.subViewContainer = var_1.Find(var_7_5, "SubViewContainer")

	return
end

function var_0_1.updateAwardBtn(arg_8_0)
	local var_8_0 = arg_8_0

	if arg_8_0.getFinalTaskStatus(var_8_0) == 0 then
		setActive = var_8_0

		var_8_0(arg_8_0.activeTF, true)

		setActive = var_8_0

		var_8_0(arg_8_0.finishedTF, false)

		setActive = var_8_0

		var_8_0(arg_8_0.achievedTF, false)

		onButton = var_8_0

		local var_8_1 = arg_8_0
		local var_8_2 = arg_8_0.awardTF

		local function var_8_3()
			local var_9_0 = arg_8_0.taskListView

			var_0.Load(var_9_0)

			return
		end

		SFX_PANEL = var_1_10006

		var_8_0(var_8_1, var_8_2, var_8_3, var_1_10006)

		onButton = var_8_0

		local var_8_4 = arg_8_0
		local var_8_5 = arg_8_0.achievementBtn

		local function var_8_6()
			local var_10_0 = arg_8_0.taskListView

			var_0.Load(var_10_0)

			return
		end

		SFX_PANEL = var_1_10006

		var_8_0(var_8_4, var_8_5, var_8_6, var_1_10006)
	elseif var_1 == 1 then
		setActive = var_8_0

		var_8_0(arg_8_0.activeTF, false)

		setActive = var_8_0

		var_8_0(arg_8_0.finishedTF, true)

		setActive = var_8_0

		var_8_0(arg_8_0.achievedTF, false)

		onButton = var_8_0

		local var_8_7 = arg_8_0
		local var_8_8 = arg_8_0.awardTF

		local function var_8_9()
			local var_11_0 = arg_8_0.taskProxy
			local var_11_1 = var_0.getTaskVO(var_11_0, arg_8_0.finalTaskID)
			local var_11_2 = arg_8_0
			local var_11_3 = var_1.emit

			ActivityMediator = var_2_10003

			var_11_3(var_11_2, var_2_10003.ON_TASK_SUBMIT, var_11_1)

			return
		end

		SFX_PANEL = var_1_10006

		var_8_0(var_8_7, var_8_8, var_8_9, var_1_10006)

		onButton = var_8_0

		local var_8_10 = arg_8_0
		local var_8_11 = arg_8_0.achievementBtn

		local function var_8_12()
			local var_12_0 = arg_8_0.taskProxy
			local var_12_1 = var_0.getTaskVO(var_12_0, arg_8_0.finalTaskID)
			local var_12_2 = arg_8_0
			local var_12_3 = var_1.emit

			ActivityMediator = var_2_10003

			var_12_3(var_12_2, var_2_10003.ON_TASK_SUBMIT, var_12_1)

			return
		end

		SFX_PANEL = var_1_10006

		var_8_0(var_8_10, var_8_11, var_8_12, var_1_10006)
	elseif var_1 == 2 then
		setActive = var_8_0

		var_8_0(arg_8_0.activeTF, false)

		setActive = var_8_0

		var_8_0(arg_8_0.finishedTF, false)

		setActive = var_8_0

		var_8_0(arg_8_0.achievedTF, true)

		setButtonEnabled = var_8_0

		var_8_0(arg_8_0.awardTF, false)

		setButtonEnabled = var_8_0

		var_8_0(arg_8_0.achievementBtn, false)
	end

	return
end

function var_0_1.submitFinishedTask(arg_13_0)
	ipairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.taskIDList) do
		local var_13_0 = arg_13_0.taskProxy

		if var_6.getTaskById(var_13_0, iter_13_1) and var_6:isFinish() then
			local var_13_1 = arg_13_0
			local var_13_2 = arg_13_0.emit

			ActivityMediator = var_1_10009

			var_13_2(var_13_1, var_1_10009.ON_TASK_SUBMIT, var_6)
		end
	end

	return
end

function var_0_1.getFinalTaskStatus(arg_14_0)
	local var_14_0 = arg_14_0.taskProxy
	local var_14_1 = var_1.getTaskVO(var_14_0, arg_14_0.finalTaskID)

	return var_1.getTaskStatus(var_14_1)
end

return var_0_1
