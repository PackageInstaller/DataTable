class = var_0_10000

local var_0_0 = "YidaliMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PreviewTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)
	arg_1_0:initUI()

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	local var_2_0 = arg_2_0.btnList

	arg_2_0.fight = var_1.Find(var_2_0, "fight")
	onButton = var_1

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.fight

	local function var_2_3()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_3_1(var_3_0, var_2_10003.BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_1, var_2_2, var_2_3, var_1_10006)

	local var_2_4 = arg_2_0.btnList

	arg_2_0.build = var_1.Find(var_2_4, "build")
	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.build

	local function var_2_7()
		local var_4_0
		local var_4_1
		local var_4_2 = arg_2_0.activity

		if var_2.getConfig(var_4_2, "config_client") ~= "" then
			local var_4_3 = arg_2_0.activity

			if var_2_10003.getConfig(var_4_3, "config_client").linkActID then
				getProxy = var_2_10003
				ActivityProxy = var_4_3

				local var_4_4 = var_2_10003(var_4_3)

				var_4_1 = var_2_10003.getActivityById(var_4_4, var_4_0)
			end
		end

		if not var_4_0 then
			local var_4_5 = arg_2_0

			var_2_10003 = var_2_10003.emit
			ActivityMediator = var_2_10006
			var_2_10006 = var_2_10006.EVENT_GO_SCENE
			SCENE = var_2_10007
			var_2_10007 = var_2_10007.GETBOAT

			local var_4_6 = {}

			BuildShipScene = var_2_10009
			var_4_6.projectName = var_2_10009.PROJECTS.ACTIVITY

			var_2_10003(var_4_5, var_2_10006, var_2_10007, var_4_6)
		elseif var_4_1 and not var_4_1:isEnd() then
			local var_4_7 = arg_2_0

			var_2_10003 = var_2_10003.emit
			ActivityMediator = var_2_10006
			var_2_10006 = var_2_10006.EVENT_GO_SCENE
			SCENE = var_2_10007

			local var_4_8 = var_2_10007.GETBOAT
			local var_4_9 = {}

			BuildShipScene = var_2_10009
			var_4_9.projectName = var_2_10009.PROJECTS.ACTIVITY

			var_2_10003(var_4_7, var_2_10006, var_4_8, var_4_9)
		else
			pg = var_2_10003

			local var_4_10 = var_2_10003.TipsMgr.GetInstance()
			local var_4_11 = var_3.ShowTips

			i18n = var_2_10006

			var_4_11(var_4_10, var_2_10006("common_activity_end"))
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_5, var_2_6, var_2_7, var_1_10006)
	arg_2_0:initData()
	arg_2_0:submitFinishedTask()

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	arg_5_0:updateAwardBtn()

	return
end

function var_0_1.initData(arg_6_0)
	local var_6_0 = arg_6_0.activity

	arg_6_0.finalTaskID = var_1.getConfig(var_6_0, "config_client")[1]

	local var_6_1 = arg_6_0.activity

	arg_6_0.YDLtaskIDList = var_1.getConfig(var_6_1, "config_data")
	Clone = var_1
	pg = var_6_1
	arg_6_0.taskIDList = var_1(var_6_1.task_data_template[arg_6_0.finalTaskID].target_id)
	getProxy = var_1
	TaskProxy = var_3
	arg_6_0.taskProxy = var_1(var_3)

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
	local var_8_0 = arg_8_0:getFinalTaskStatus()

	print = var_1_10002

	var_1_10002("final taskid:" .. arg_8_0.finalTaskID)

	print = var_1_10002

	var_1_10002("task status:" .. var_8_0)

	if var_8_0 == 0 then
		setActive = var_1_10002

		var_1_10002(arg_8_0.activeTF, true)

		setActive = var_1_10002

		var_1_10002(arg_8_0.finishedTF, false)

		setActive = var_1_10002

		var_1_10002(arg_8_0.achievedTF, false)
	elseif var_8_0 == 1 then
		setActive = var_1_10002

		var_1_10002(arg_8_0.activeTF, false)

		setActive = var_1_10002

		var_1_10002(arg_8_0.finishedTF, true)

		setActive = var_1_10002

		var_1_10002(arg_8_0.achievedTF, false)

		onButton = var_1_10002

		local var_8_1 = arg_8_0
		local var_8_2 = arg_8_0.awardTF

		local function var_8_3()
			local var_9_0 = arg_8_0.taskProxy
			local var_9_1 = var_0.getTaskVO(var_9_0, arg_8_0.finalTaskID)
			local var_9_2 = arg_8_0
			local var_9_3 = var_1.emit

			ActivityMediator = var_2_10004

			var_9_3(var_9_2, var_2_10004.ON_TASK_SUBMIT, var_9_1)

			return
		end

		SFX_PANEL = var_1_10007

		var_1_10002(var_8_1, var_8_2, var_8_3, var_1_10007)
	elseif var_8_0 == 2 then
		setActive = var_1_10002

		var_1_10002(arg_8_0.activeTF, false)

		setActive = var_1_10002

		var_1_10002(arg_8_0.finishedTF, false)

		setActive = var_1_10002

		var_1_10002(arg_8_0.achievedTF, true)

		onButton = var_1_10002

		local var_8_4 = arg_8_0
		local var_8_5 = arg_8_0.awardTF

		local function var_8_6()
			return
		end

		SFX_PANEL = var_1_10007

		var_1_10002(var_8_4, var_8_5, var_8_6, var_1_10007)
	end

	return
end

function var_0_1.submitFinishedTask(arg_11_0)
	ipairs = var_1_10001

	for iter_11_0, iter_11_1 in var_1_10001(arg_11_0.YDLtaskIDList) do
		local var_11_0 = arg_11_0.taskProxy

		if var_6.getTaskById(var_11_0, iter_11_1) and var_6:isFinish() and not var_6:isReceive() then
			print = var_7

			var_7("!!!!!!!!!!!!!20190907!!!!!!!YDLtaskIDList emit:" .. iter_11_1)

			local var_11_1 = arg_11_0
			local var_11_2 = arg_11_0.emit

			ActivityMediator = var_10

			var_11_2(var_11_1, var_10.ON_TASK_SUBMIT, var_6)
		end
	end

	return
end

function var_0_1.getFinalTaskStatus(arg_12_0)
	local var_12_0 = arg_12_0.taskProxy
	local var_12_1 = var_1.getTaskVO(var_12_0, arg_12_0.finalTaskID)

	return var_1.getTaskStatus(var_12_1)
end

return var_0_1
