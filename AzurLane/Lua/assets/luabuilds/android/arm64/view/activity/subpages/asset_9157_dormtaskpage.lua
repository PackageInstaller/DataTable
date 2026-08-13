class = var_0_10000

local var_0_0 = "DormTaskPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg
	local var_1_2 = var_1.Find(var_1_1, "slider")
	local var_1_3 = var_1.GetComponent

	typeof = var_4
	Slider = var_1_10006
	arg_1_0.slider = var_1_3(var_1_2, var_4(var_1_10006))

	local var_1_4 = arg_1_0.bg
	local var_1_5 = var_1.Find(var_1_4, "step")
	local var_1_6 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_1_0.step = var_1_6(var_1_5, var_4(var_1_10006))

	local var_1_7 = arg_1_0.bg
	local var_1_8 = var_1.Find(var_1_7, "step_max")
	local var_1_9 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_1_0.stepMax = var_1_9(var_1_8, var_4(var_1_10006))

	local var_1_10 = arg_1_0.bg
	local var_1_11 = var_1.Find(var_1_10, "progress")
	local var_1_12 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_1_0.progress = var_1_12(var_1_11, var_4(var_1_10006))

	local var_1_13 = arg_1_0.bg
	local var_1_14 = var_1.Find(var_1_13, "desc")
	local var_1_15 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_1_0.desc = var_1_15(var_1_14, var_4(var_1_10006))

	local var_1_16 = arg_1_0.bg

	arg_1_0.awardTF = var_1.Find(var_1_16, "award")

	local var_1_17 = arg_1_0.bg

	arg_1_0.awardGot = var_1.Find(var_1_17, "award_got")

	local var_1_18 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_18, "battle_btn")

	local var_1_19 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_19, "get_btn")

	local var_1_20 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_20, "got_btn")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	arg_2_0.nday = 0
	getProxy = var_1
	TaskProxy = var_1_10003
	arg_2_0.taskProxy = var_1(var_1_10003)

	local var_2_0 = arg_2_0.activity

	arg_2_0.taskGroup = var_1.getConfig(var_2_0, "config_client").unlock_task
	updateActivityTaskStatus = var_1

	return var_1(arg_2_0.activity)
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.battleBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.ON_TASK_GO, arg_3_0.taskVO)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.getBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_5_1(var_5_0, var_2_10003.ON_TASK_SUBMIT, arg_3_0.taskVO)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	setText = var_1_10001

	var_1_10001(arg_3_0.stepMax, "/" .. #arg_3_0.taskGroup)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	arg_6_0.taskIndex = arg_6_0:getTaskIdx(arg_6_0.activity)

	local var_6_0 = arg_6_0.taskGroup[arg_6_0.taskIndex][1]
	local var_6_1 = arg_6_0.taskProxy
	local var_6_3

	if not var_2.getTaskById(var_6_1, var_6_0) then
		local var_6_2 = arg_6_0.taskProxy

		var_6_3 = var_2.getFinishTaskById(var_6_2, var_6_0)
	end

	arg_6_0.taskVO = var_6_3

	local var_6_4 = arg_6_0.taskVO
	local var_6_5 = var_2.getConfig(var_6_4, "award_display")[1]
	local var_6_6 = {
		type = var_6_5[1],
		id = var_6_5[2],
		count = var_6_5[3]
	}

	updateDrop = var_4

	var_4(arg_6_0.awardTF, var_6_6)

	onButton = var_4

	local var_6_7 = arg_6_0
	local var_6_8 = arg_6_0.awardTF

	local function var_6_9()
		local var_7_0 = arg_6_0
		local var_7_1 = var_0.emit

		BaseUI = var_2_10003

		var_7_1(var_7_0, var_2_10003.ON_DROP, var_6_6)

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_6_7, var_6_8, var_6_9, var_1_10009)

	if arg_6_0.step then
		setText = var_4

		var_4(arg_6_0.step, "DAY" .. arg_6_0.taskIndex)
	end

	local var_6_10 = arg_6_0.taskVO
	local var_6_11 = var_4.getProgress(var_6_10)
	local var_6_12 = arg_6_0.taskVO
	local var_6_13 = var_5.getConfig(var_6_12, "target_num")

	setText = var_6_10

	local var_6_14 = arg_6_0.desc
	local var_6_15 = arg_6_0.taskVO

	var_6_10(var_6_14, var_9.getConfig(var_6_15, "desc"))

	setText = var_6_10

	var_6_10(arg_6_0.progress, var_6_11 .. "/" .. var_6_13)

	setSlider = var_6_10

	var_6_10(arg_6_0.slider, 0, var_6_13, var_6_11)

	local var_6_16 = arg_6_0.taskVO
	local var_6_17 = var_6.getTaskStatus(var_6_16)

	setActive = var_6_12

	var_6_12(arg_6_0.battleBtn, var_6_17 == 0)

	setActive = var_6_12

	var_6_12(arg_6_0.getBtn, var_6_17 == 1)

	setActive = var_6_12

	var_6_12(arg_6_0.gotBtn, var_6_17 == 2)

	setActive = var_6_12

	var_6_12(arg_6_0.awardGot, var_6_17 == 2)

	return
end

function var_0_1.getTaskIdx(arg_8_0, arg_8_1)
	local var_8_0 = 1
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.getNDay(var_8_1)
	local var_8_3 = #arg_8_0.taskGroup

	math = var_8_1

	local var_8_4 = var_8_1.min(var_8_2, var_8_3)
	local var_8_5 = true

	for iter_8_0 = 1, var_8_4 do
		if not var_8_5 then
			break
		end

		var_8_0 = iter_8_0

		if iter_8_0 < var_8_4 then
			ipairs = var_1_10011

			for iter_8_1, iter_8_2 in var_1_10011(arg_8_0.taskGroup[iter_8_0]) do
				if not arg_8_0:isTaskFinished(iter_8_2) then
					var_8_5 = false

					break
				end
			end
		end
	end

	math = var_7

	return var_7.min(var_8_0, var_8_3)
end

function var_0_1.isTaskFinished(arg_9_0, arg_9_1)
	if not arg_9_0.taskProxy then
		getProxy = var_2
		TaskProxy = var_1_10004
		arg_9_0.taskProxy = var_2(var_1_10004)
	end

	local var_9_0 = arg_9_0.taskProxy
	local var_9_2

	if not var_2.getTaskById(var_9_0, arg_9_1) then
		local var_9_1 = arg_9_0.taskProxy

		var_9_2 = var_2.getFinishTaskById(var_9_1, arg_9_1)
	end

	return var_9_2 and var_9_2:getTaskStatus() == 2
end

return var_0_1
