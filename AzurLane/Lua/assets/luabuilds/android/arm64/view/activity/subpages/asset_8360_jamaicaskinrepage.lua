class = var_0_10000

local var_0_0 = "JamaicaSkinRePage"

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

	arg_1_0.awardTF = var_1.Find(var_1_4, "award")

	local var_1_5 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_5, "battle_btn")

	local var_1_6 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_6, "get_btn")

	local var_1_7 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_7, "got_btn")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_data")

	_ = var_1_10002
	arg_2_0.taskIDList = var_1_10002.flatten(var_2_1)
	arg_2_0.dropList = {}
	arg_2_0.descs = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_0.taskIDList) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.task_data_template[iter_2_1].award_display[1]
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_2_2 = arg_2_0.dropList

		Clone = var_1_10011

		var_1_10008(var_2_2, var_1_10011(var_1_10007))

		pg = var_1_10008
		var_1_10008 = var_1_10008.task_data_template[iter_2_1].desc
		table = var_1_10009

		var_1_10009.insert(arg_2_0.descs, var_1_10008)
	end

	updateActivityTaskStatus = var_2

	return var_2(arg_2_0.activity)
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.battleBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.SPECIAL_BATTLE_OPERA)

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

		var_5_1(var_5_0, var_2_10003.ON_TASK_SUBMIT, arg_3_0.curTaskVO)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	getActivityTask = var_1_10001

	local var_6_0, var_6_1 = var_1_10001(arg_6_0.activity)

	arg_6_0.curTaskVO = var_6_1

	local var_6_2 = var_6_1:getConfig("award_display")[1]
	local var_6_3 = {
		type = var_6_2[1],
		id = var_6_2[2],
		count = var_6_2[3]
	}

	updateDrop = var_5

	var_5(arg_6_0.awardTF, var_6_3)

	onButton = var_5

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.awardTF

	local function var_6_6()
		local var_7_0 = arg_6_0
		local var_7_1 = var_0.emit

		BaseUI = var_2_10003

		var_7_1(var_7_0, var_2_10003.ON_DROP, var_6_3)

		return
	end

	SFX_PANEL = var_1_10010

	var_5(var_6_4, var_6_5, var_6_6, var_1_10010)

	local var_6_7 = var_6_1
	local var_6_8 = var_6_1.getProgress(var_6_7)
	local var_6_9 = var_6_1
	local var_6_10 = var_6_1.getConfig(var_6_9, "target_num")

	setText = var_6_7

	local var_6_11 = arg_6_0.progress

	if var_6_10 <= var_6_8 then
		setColorStr = var_1_10010

		local var_6_12 = var_6_8

		COLOR_GREEN = var_1_10013

		local var_6_13

		if not var_1_10010(var_6_12, var_1_10013) then
			var_6_13 = var_6_8
		end

		var_6_7(var_6_11, var_6_13 .. "/" .. var_6_10)

		setSlider = var_6_7

		var_6_7(arg_6_0.slider, 0, var_6_10, var_6_8)

		table = var_6_7

		local var_6_14 = var_6_7.indexof(arg_6_0.taskIDList, var_6_0, 1)

		setText = var_6_9

		var_6_9(arg_6_0.step, var_6_14 .. "/" .. #arg_6_0.taskIDList)

		local var_6_15 = var_6_1:getTaskStatus()

		setActive = var_9

		var_9(arg_6_0.battleBtn, var_6_15 == 0)

		setActive = var_9

		var_9(arg_6_0.getBtn, var_6_15 == 1)

		setActive = var_9

		var_9(arg_6_0.gotBtn, var_6_15 == 2)

		if var_6_15 == 2 then
			arg_6_0.finishedIndex = var_6_14
		else
			arg_6_0.finishedIndex = var_6_14 - 1
		end

		return
	end
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
