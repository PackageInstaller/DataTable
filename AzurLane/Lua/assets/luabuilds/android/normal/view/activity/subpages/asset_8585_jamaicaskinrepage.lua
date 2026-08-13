class = var_0_10000

local var_0_0 = "JamaicaSkinRePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

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

	_ = var_2_0
	arg_2_0.taskIDList = var_2_0.flatten(var_2_1)
	arg_2_0.dropList = {}
	arg_2_0.descs = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_0.taskIDList) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.task_data_template[iter_2_1].award_display[1]
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_2_2 = arg_2_0.dropList

		Clone = var_1_10010

		var_1_10008(var_2_2, var_1_10010(var_1_10007))

		pg = var_1_10008
		var_1_10008 = var_1_10008.task_data_template[iter_2_1].desc
		table = var_2_2

		var_2_2.insert(arg_2_0.descs, var_1_10008)
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

		ActivityMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.SPECIAL_BATTLE_OPERA)

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

		var_5_1(var_5_0, var_2_10002.ON_TASK_SUBMIT, arg_3_0.curTaskVO)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

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

		BaseUI = var_2_10002

		var_7_1(var_7_0, var_2_10002.ON_DROP, var_6_3)

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_6_4, var_6_5, var_6_6, var_1_10009)

	local var_6_7 = var_6_1:getProgress()
	local var_6_8 = var_6_1
	local var_6_9 = var_6_1.getConfig(var_6_8, "target_num")

	setText = var_6_8

	local var_6_10 = arg_6_0.progress

	if var_6_9 <= var_6_7 then
		setColorStr = var_1_10009

		local var_6_11 = var_6_7

		COLOR_GREEN = var_1_10011

		local var_6_12

		if not var_1_10009(var_6_11, var_1_10011) then
			var_6_12 = var_6_7
		end

		var_6_8(var_6_10, var_6_12 .. "/" .. var_6_9)

		setSlider = var_6_8

		var_6_8(arg_6_0.slider, 0, var_6_9, var_6_7)

		table = var_6_8

		local var_6_13 = var_6_8.indexof(arg_6_0.taskIDList, var_6_0, 1)

		setText = var_8

		var_8(arg_6_0.step, var_6_13 .. "/" .. #arg_6_0.taskIDList)

		local var_6_14 = var_6_1
		local var_6_15 = var_6_1.getTaskStatus(var_6_14)

		setActive = var_6_14

		var_6_14(arg_6_0.battleBtn, var_6_15 == 0)

		setActive = var_6_14

		var_6_14(arg_6_0.getBtn, var_6_15 == 1)

		setActive = var_6_14

		var_6_14(arg_6_0.gotBtn, var_6_15 == 2)

		if var_6_15 == 2 then
			arg_6_0.finishedIndex = var_6_13
		else
			arg_6_0.finishedIndex = var_6_13 - 1
		end

		return
	end
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
