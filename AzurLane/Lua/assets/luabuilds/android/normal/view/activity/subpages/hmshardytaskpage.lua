class = var_0_10000

local var_0_0 = "HMSHardyTaskPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PassChaptersTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.notGetBtn = var_1.Find(var_1_0, "not_get_btn")

	local var_1_1 = arg_1_0.bg

	arg_1_0.goHuntBtn = var_1.Find(var_1_1, "gohunt_btn")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.goHuntBtn

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_3_2 = var_2_10002.SELECT_ACTIVITY

		pg = var_2_10003

		var_3_1(var_3_0, var_3_2, var_2_10003.activity_const.HMS_Hunter_PT_ID.act_id)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.notGetBtn

	local function var_2_5()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_3, var_2_4, var_2_5, var_1_10005)

	onButton = var_1

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.battleBtn

	local function var_2_8()
		pg = var_2_10000

		local var_5_0 = var_2_10000.m02
		local var_5_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_5_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_5_1(var_5_0, var_5_2, var_2_10003.TASK)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_6, var_2_7, var_2_8, var_1_10005)

	onButton = var_1

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.buildBtn

	local function var_2_11()
		pg = var_2_10000

		local var_6_0 = var_2_10000.m02
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_6_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		local var_6_3 = var_2_10003.GETBOAT
		local var_6_4 = {}

		BuildShipScene = var_2_10005
		var_6_4.page = var_2_10005.PAGE_BUILD
		BuildShipScene = var_5
		var_6_4.projectName = var_5.PROJECTS.LIGHT

		var_6_1(var_6_0, var_6_2, var_6_3, var_6_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_9, var_2_10, var_2_11, var_1_10005)

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

		BaseUI = var_2_10002

		var_8_1(var_8_0, var_2_10002.ON_DROP, var_7_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_7_3, var_7_4, var_7_5, var_1_10007)

	if arg_7_0.step then
		setText = var_3

		var_3(arg_7_0.step, arg_7_0.taskIndex)
	end

	local var_7_6 = arg_7_0.taskVO
	local var_7_7 = var_3.getProgress(var_7_6)
	local var_7_8 = arg_7_0.taskVO
	local var_7_9 = var_4.getConfig(var_7_8, "target_num")

	setText = var_7_8

	local var_7_10 = arg_7_0.desc
	local var_7_11 = arg_7_0.taskVO

	var_7_8(var_7_10, var_7.getConfig(var_7_11, "desc"))

	setText = var_7_8

	var_7_8(arg_7_0.progress, var_7_7 .. "/" .. var_7_9)

	setSlider = var_7_8

	var_7_8(arg_7_0.slider, 0, var_7_9, var_7_7)

	local var_7_12 = arg_7_0.taskVO
	local var_7_13 = var_5.getTaskStatus(var_7_12)

	setActive = var_7_12

	var_7_12(arg_7_0.notGetBtn, var_7_13 == 0)

	setActive = var_7_12

	var_7_12(arg_7_0.getBtn, var_7_13 == 1)

	setActive = var_7_12

	var_7_12(arg_7_0.gotBtn, var_7_13 == 2)

	return
end

return var_0_1
