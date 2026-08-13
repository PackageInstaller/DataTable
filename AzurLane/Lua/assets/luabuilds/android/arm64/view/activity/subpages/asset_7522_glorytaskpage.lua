class = var_0_10000

local var_0_0 = "GloryTaskPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.slider = var_1.Find(var_1_1, "slider")

	local var_1_2 = arg_1_0.bg

	arg_1_0.step = var_1.Find(var_1_2, "step")

	local var_1_3 = arg_1_0.bg

	arg_1_0.progress = var_1.Find(var_1_3, "progress")

	local var_1_4 = arg_1_0.bg

	arg_1_0.displayBtn = var_1.Find(var_1_4, "display_btn")

	local var_1_5 = arg_1_0.bg

	arg_1_0.awardTF = var_1.Find(var_1_5, "award")

	local var_1_6 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_6, "battle_btn")

	local var_1_7 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_7, "get_btn")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_2

	if not arg_2_0.taskList then
		local var_2_1 = arg_2_0.activity

		var_2_2 = var_2.getConfig(var_2_1, "config_data")
	end

	arg_2_0.taskList = var_2_2
	ipairs = var_2_2

	for iter_2_0, iter_2_1 in var_2_2(arg_2_0.taskList) do
		arg_2_0.taskIndex = iter_2_0
		arg_2_0.taskVO = var_2_0:getTaskVO(iter_2_1)

		local var_2_3 = arg_2_0.taskVO

		if not var_7.isReceive(var_2_3) then
			break
		end
	end

	assert = var_2

	var_2(arg_2_0.taskVO, "without any taskVO!!!")

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.displayBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_4_2 = var_2_10003.SHOW_AWARD_WINDOW

		GloryAwardWindow = var_2_10004

		var_4_1(var_4_0, var_4_2, var_2_10004, {
			taskList = arg_3_0.taskList,
			taskVO = arg_3_0.taskVO
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.battleBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_5_1(var_5_0, var_2_10003.BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.getBtn

	local function var_3_8()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.ON_TASK_SUBMIT, arg_3_0.taskVO)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	local var_7_0 = arg_7_0.taskVO
	local var_7_1 = var_1.getConfig(var_7_0, "award_display")[1]
	local var_7_2 = {
		type = var_7_1[1],
		id = var_7_1[2],
		count = var_7_1[3]
	}

	updateDrop = var_3

	var_3(arg_7_0.awardTF, var_7_2)

	onButton = var_3

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.awardTF

	local function var_7_5()
		local var_8_0 = arg_7_0
		local var_8_1 = var_0.emit

		BaseUI = var_2_10003

		var_8_1(var_8_0, var_2_10003.ON_DROP, var_7_2)

		return
	end

	SFX_PANEL = var_1_10008

	var_3(var_7_3, var_7_4, var_7_5, var_1_10008)

	if arg_7_0.step then
		setText = var_3

		var_3(arg_7_0.step, arg_7_0.taskIndex .. "/" .. #arg_7_0.taskList)
	end

	local var_7_6 = arg_7_0.taskVO
	local var_7_7 = var_3.getProgress(var_7_6)
	local var_7_8 = arg_7_0.taskVO
	local var_7_9 = var_4.getConfig(var_7_8, "target_num")

	setText = var_7_6

	var_7_6(arg_7_0.progress, var_7_7 .. "/" .. var_7_9)

	setSlider = var_7_6

	var_7_6(arg_7_0.slider, 0, var_7_9, var_7_7)

	local var_7_10 = arg_7_0.taskVO
	local var_7_11 = var_5.getTaskStatus(var_7_10)

	setActive = var_7_8

	var_7_8(arg_7_0.battleBtn, var_7_11 == 0)

	setActive = var_7_8

	var_7_8(arg_7_0.getBtn, var_7_11 == 1)

	return
end

function var_0_1.OnDestroy(arg_9_0)
	return
end

return var_0_1
