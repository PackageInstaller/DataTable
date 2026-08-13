class = var_0_10000

local var_0_0 = "U110BattleRePage"

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

	arg_1_0.desc = var_1.Find(var_1_4, "desc")

	local var_1_5 = arg_1_0.bg

	arg_1_0.awardTF = var_1.Find(var_1_5, "award")

	local var_1_6 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_6, "battle_btn")

	local var_1_7 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_7, "get_btn")

	local var_1_8 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_8, "got_btn")

	local var_1_9 = arg_1_0.bg

	arg_1_0.buildBtn = var_1.Find(var_1_9, "build_btn")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_data")

	_ = var_2_0
	arg_2_0.taskIDList = var_2_0.flatten(var_2_1)
	getProxy = var_2
	TaskProxy = var_3
	arg_2_0.taskProxy = var_2(var_3)

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.battleBtn

	local function var_3_2()
		local var_4_0 = arg_3_0.activity
		local var_4_1

		if var_0.getConfig(var_4_0, "config_client").fightLinkActID then
			::label_4_0::

			getProxy = var_4_0
			ActivityProxy = var_4_1
			var_4_1 = var_4_0(var_4_1)
			var_4_0 = var_4_0.getActivityById(var_4_1, var_0)
		end

		if not var_4_0 or var_4_0:isEnd() then
			pg = var_4_1

			local var_4_2 = var_4_1.TipsMgr.GetInstance()
			local var_4_3 = var_2.ShowTips

			i18n = var_2_10004

			var_4_3(var_4_2, var_2_10004("challenge_end_tip"))

			return
		end

		local var_4_4 = arg_3_0
		local var_4_5 = var_2.emit

		ActivityMediator = var_2_10004

		var_4_5(var_4_4, var_2_10004.SPECIAL_BATTLE_OPERA)

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

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.buildBtn

	local function var_3_8()
		local var_6_0 = arg_3_0.activity
		local var_6_1

		if var_0.getConfig(var_6_0, "config_client").buildLinkActID then
			::label_6_0::

			getProxy = var_6_0
			ActivityProxy = var_6_1
			var_6_1 = var_6_0(var_6_1)
			var_6_0 = var_6_0.getActivityById(var_6_1, var_0)
		end

		if not var_6_0 or var_6_0:isEnd() then
			pg = var_6_1

			local var_6_2 = var_6_1.TipsMgr.GetInstance()
			local var_6_3 = var_2.ShowTips

			i18n = var_2_10004

			var_6_3(var_6_2, var_2_10004("challenge_end_tip"))

			return
		end

		local var_6_4 = arg_3_0
		local var_6_5 = var_2.emit

		ActivityMediator = var_2_10004

		local var_6_6 = var_2_10004.EVENT_GO_SCENE

		SCENE = var_2_10005

		local var_6_7 = var_2_10005.GETBOAT
		local var_6_8 = {}

		BuildShipScene = var_2_10007
		var_6_8.projectName = var_2_10007.PROJECTS.SPECIAL

		var_6_5(var_6_4, var_6_6, var_6_7, var_6_8)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.findCurTaskIndex(var_7_0)

	setText = var_7_0

	var_7_0(arg_7_0.step, var_7_1 .. "/" .. #arg_7_0.taskIDList)

	local var_7_2 = arg_7_0.taskIDList[var_7_1]
	local var_7_3 = arg_7_0.taskProxy

	arg_7_0.curTaskVO = var_3.getTaskVO(var_7_3, var_7_2)

	local var_7_4 = var_3:getProgress()
	local var_7_5 = var_3
	local var_7_6 = var_3.getConfig(var_7_5, "target_num")

	setText = var_7_5

	local var_7_7 = arg_7_0.progress

	if var_7_6 <= var_7_4 then
		setColorStr = var_1_10008

		local var_7_8 = var_7_4

		COLOR_GREEN = var_1_10010

		local var_7_9

		if not var_1_10008(var_7_8, var_1_10010) then
			var_7_9 = var_7_4
		end

		var_7_5(var_7_7, var_7_9 .. "/" .. var_7_6)

		setSlider = var_7_5

		var_7_5(arg_7_0.slider, 0, var_7_6, var_7_4)

		local var_7_10 = var_3:getConfig("award_display")[1]
		local var_7_11 = {
			type = var_7_10[1],
			id = var_7_10[2],
			count = var_7_10[3]
		}

		updateDrop = var_8

		var_8(arg_7_0.awardTF, var_7_11)

		onButton = var_8

		local var_7_12 = arg_7_0
		local var_7_13 = arg_7_0.awardTF

		local function var_7_14()
			local var_8_0 = arg_7_0
			local var_8_1 = var_0.emit

			BaseUI = var_2_10002

			var_8_1(var_8_0, var_2_10002.ON_DROP, var_7_11)

			return
		end

		SFX_PANEL = var_1_10012

		var_8(var_7_12, var_7_13, var_7_14, var_1_10012)

		pg = var_8

		local var_7_15 = var_8.task_data_template[var_7_2].desc

		setText = var_7_12

		var_7_12(arg_7_0.desc, var_7_15)

		local var_7_16 = var_3
		local var_7_17 = var_3.getTaskStatus(var_7_16)

		setActive = var_7_16

		var_7_16(arg_7_0.battleBtn, var_7_17 == 0)

		setActive = var_7_16

		var_7_16(arg_7_0.getBtn, var_7_17 == 1)

		setActive = var_7_16

		var_7_16(arg_7_0.gotBtn, var_7_17 == 2)

		return
	end
end

function var_0_1.OnDestroy(arg_9_0)
	return
end

function var_0_1.findCurTaskIndex(arg_10_0)
	local var_10_0

	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.taskIDList) do
		local var_10_1 = arg_10_0.taskProxy
		local var_10_2 = var_7.getTaskVO(var_10_1, iter_10_1)

		if var_7.getTaskStatus(var_10_2) <= 1 then
			var_10_0 = iter_10_0

			break
		elseif iter_10_0 == #arg_10_0.taskIDList then
			var_10_0 = iter_10_0
		end
	end

	return var_10_0
end

return var_0_1
