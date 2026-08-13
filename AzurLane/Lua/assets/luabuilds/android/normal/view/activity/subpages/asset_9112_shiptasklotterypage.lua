class = var_0_10000

local var_0_0 = "ShipTaskLotteryPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	findTF = var_1_10001
	arg_1_0.stepText = var_1_10001(arg_1_0._tf, "ad/step")
	findTF = var_1
	arg_1_0.progressSlider = var_1(arg_1_0._tf, "ad/progressSlider")
	findTF = var_1
	arg_1_0.iconTf = var_1(arg_1_0._tf, "ad/IconTpl")
	findTF = var_1
	arg_1_0.btnGet = var_1(arg_1_0._tf, "ad/btnGet")
	findTF = var_1
	arg_1_0.btnGot = var_1(arg_1_0._tf, "ad/btnGot")
	findTF = var_1
	arg_1_0.btnGo = var_1(arg_1_0._tf, "ad/btnGo")
	findTF = var_1
	arg_1_0.taskDesc = var_1(arg_1_0._tf, "ad/taskDesc")
	findTF = var_1
	arg_1_0.titleDesc = var_1(arg_1_0._tf, "ad/titleDesc")
	findTF = var_1
	arg_1_0.progressDesc = var_1(arg_1_0._tf, "ad/progressDesc")
	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.btnGet

	local function var_1_2()
		if arg_1_0.currentTask then
			local var_2_0 = arg_1_0
			local var_2_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_2_1(var_2_0, var_2_10002.ON_TASK_SUBMIT, arg_1_0.currentTask)
		end

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_1_0, var_1_1, var_1_2, var_1_10005)

	onButton = var_1

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.btnGo

	local function var_1_5()
		if arg_1_0.currentTask then
			local var_3_0 = arg_1_0
			local var_3_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_3_1(var_3_0, var_2_10002.ON_TASK_GO, arg_1_0.currentTask)
		end

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_1_3, var_1_4, var_1_5, var_1_10005)

	onButton = var_1

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.iconTf

	local function var_1_8()
		local var_4_0 = arg_1_0
		local var_4_1 = var_0.emit

		BaseUI = var_2_10002

		var_4_1(var_4_0, var_2_10002.ON_DROP, arg_1_0.drop)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_6, var_1_7, var_1_8, var_1_10005)

	setText = var_1

	local var_1_9 = arg_1_0.titleDesc

	i18n = var_1_7

	var_1(var_1_9, var_1_7("ship_task_lottery_title"))

	return
end

function var_0_1.OnFirstFlush(arg_5_0)
	local var_5_0 = arg_5_0.activity

	arg_5_0.taskIds = var_1.getConfig(var_5_0, "config_data")

	arg_5_0:updateUI()

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	arg_6_0:updateUI()

	return
end

function var_0_1.updateUI(arg_7_0)
	local var_7_0

	for iter_7_0 = 1, #arg_7_0.taskIds do
		if not var_7_0 then
			getProxy = var_1_10006
			TaskProxy = var_1_10007
			var_1_10007 = var_1_10006(var_1_10007)

			if var_1_10006.getTaskById(var_1_10007, arg_7_0.taskIds[iter_7_0]) then
				break
			end
		end
	end

	if not var_7_0 then
		for iter_7_1 = #arg_7_0.taskIds, 1, -1 do
			getProxy = var_1_10006
			TaskProxy = var_1_10007
			var_1_10007 = var_1_10006(var_1_10007)

			if var_1_10006.getFinishTaskById(var_1_10007, arg_7_0.taskIds[iter_7_1]) then
				break
			end
		end
	end

	if var_7_0 then
		arg_7_0.currentTask = var_7_0

		arg_7_0:showTaskUI()
	end

	return
end

function var_0_1.showTaskUI(arg_8_0)
	local var_8_0 = arg_8_0.currentTask
	local var_8_1 = var_1.getConfig(var_8_0, "award_display")

	arg_8_0.drop = {
		type = var_8_1[1][1],
		id = var_8_1[1][2],
		count = var_8_1[1][3]
	}
	updateDrop = var_2

	var_2(arg_8_0.iconTf, arg_8_0.drop)

	setText = var_2

	local var_8_2 = arg_8_0.taskDesc
	local var_8_3 = arg_8_0.currentTask

	var_2(var_8_2, var_4.getConfig(var_8_3, "desc"))

	setText = var_2

	local var_8_4 = arg_8_0.progressDesc
	local var_8_5 = arg_8_0.currentTask
	local var_8_6 = var_4.getProgress(var_8_5)
	local var_8_7 = "/"
	local var_8_8 = arg_8_0.currentTask

	var_2(var_8_4, var_8_6 .. var_8_7 .. var_6.getConfig(var_8_8, "target_num"))

	setSlider = var_2

	local var_8_9 = arg_8_0.progressSlider
	local var_8_10 = 0
	local var_8_11 = arg_8_0.currentTask
	local var_8_12 = var_5.getConfig(var_8_11, "target_num")
	local var_8_13 = arg_8_0.currentTask

	var_2(var_8_9, var_8_10, var_8_12, var_6.getProgress(var_8_13))

	setActive = var_2

	local var_8_14 = arg_8_0.btnGet
	local var_8_15 = arg_8_0.currentTask

	var_2(var_8_14, var_4.getTaskStatus(var_8_15) == 1)

	setActive = var_2

	local var_8_16 = arg_8_0.btnGo
	local var_8_17 = arg_8_0.currentTask

	var_2(var_8_16, var_4.getTaskStatus(var_8_17) == 0)

	setActive = var_2

	local var_8_18 = arg_8_0.btnGot
	local var_8_19 = arg_8_0.currentTask

	var_2(var_8_18, var_4.getTaskStatus(var_8_19) == 2)

	return
end

function var_0_1.OnDestroy(arg_9_0)
	return
end

return var_0_1
