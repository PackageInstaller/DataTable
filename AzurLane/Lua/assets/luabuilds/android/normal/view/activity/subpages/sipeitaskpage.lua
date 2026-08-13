class = var_0_10000

local var_0_0 = "SipeiTaskPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg
	local var_1_2 = var_1.Find(var_1_1, "slider")
	local var_1_3 = var_1.GetComponent

	typeof = var_3
	Slider = var_1_10004
	arg_1_0.slider = var_1_3(var_1_2, var_3(var_1_10004))

	local var_1_4 = arg_1_0.bg
	local var_1_5 = var_1.Find(var_1_4, "step")
	local var_1_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.step = var_1_6(var_1_5, var_3(var_1_10004))

	local var_1_7 = arg_1_0.bg
	local var_1_8 = var_1.Find(var_1_7, "progress")
	local var_1_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.progress = var_1_9(var_1_8, var_3(var_1_10004))

	local var_1_10 = arg_1_0.bg
	local var_1_11 = var_1.Find(var_1_10, "desc")
	local var_1_12 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.desc = var_1_12(var_1_11, var_3(var_1_10004))

	local var_1_13 = arg_1_0.bg

	arg_1_0.awardTF = var_1.Find(var_1_13, "award")

	local var_1_14 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_14, "battle_btn")

	local var_1_15 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_15, "get_btn")

	local var_1_16 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_16, "got_btn")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
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
	local var_3_1 = arg_3_0.battleBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.getBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.ON_TASK_SUBMIT, arg_3_0.taskVO)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	local var_6_0 = arg_6_0.taskVO
	local var_6_1 = var_1.getConfig(var_6_0, "award_display")[1]
	local var_6_2 = {
		type = var_6_1[1],
		id = var_6_1[2],
		count = var_6_1[3]
	}

	updateDrop = var_3

	var_3(arg_6_0.awardTF, var_6_2)

	onButton = var_3

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.awardTF

	local function var_6_5()
		local var_7_0 = arg_6_0
		local var_7_1 = var_0.emit

		BaseUI = var_2_10002

		var_7_1(var_7_0, var_2_10002.ON_DROP, var_6_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_6_3, var_6_4, var_6_5, var_1_10007)

	if arg_6_0.step then
		setText = var_3

		var_3(arg_6_0.step, arg_6_0.taskIndex .. "/" .. #arg_6_0.taskList)
	end

	local var_6_6 = arg_6_0.taskVO
	local var_6_7 = var_3.getProgress(var_6_6)
	local var_6_8 = arg_6_0.taskVO
	local var_6_9 = var_4.getConfig(var_6_8, "target_num")

	setText = var_6_8

	local var_6_10 = arg_6_0.desc
	local var_6_11 = arg_6_0.taskVO

	var_6_8(var_6_10, var_7.getConfig(var_6_11, "desc"))

	setText = var_6_8

	var_6_8(arg_6_0.progress, var_6_7 .. "/" .. var_6_9)

	setSlider = var_6_8

	var_6_8(arg_6_0.slider, 0, var_6_9, var_6_7)

	local var_6_12 = arg_6_0.taskVO
	local var_6_13 = var_5.getTaskStatus(var_6_12)

	setActive = var_6_12

	var_6_12(arg_6_0.battleBtn, var_6_13 == 0)

	setActive = var_6_12

	var_6_12(arg_6_0.getBtn, var_6_13 == 1)

	setActive = var_6_12

	var_6_12(arg_6_0.gotBtn, var_6_13 == 2)

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
