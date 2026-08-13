class = var_0_10000

local var_0_0 = "MonopolyCar2024Page"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.startBtn = var_1.Find(var_1_0, "AD/start")

	local var_1_1 = arg_1_0.startBtn
	local var_1_2 = var_1.Find(var_1_1, "Text")
	local var_1_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.leftCountTxt = var_1_3(var_1_2, var_3(var_1_10004))

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_1.Find(var_1_4, "AD/turn")
	local var_1_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.turnCntTxt = var_1_6(var_1_5, var_3(var_1_10004))

	local var_1_7 = arg_1_0._tf
	local var_1_8 = var_1.Find(var_1_7, "AD/progress")
	local var_1_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.progressTxt = var_1_9(var_1_8, var_3(var_1_10004))

	local var_1_10 = {}
	local var_1_11 = arg_1_0._tf

	var_1_10[1] = var_2.Find(var_1_11, "AD/turn_awards/award_1")

	local var_1_12 = arg_1_0._tf

	var_1_10[2] = var_2.Find(var_1_12, "AD/turn_awards/award_2")

	local var_1_13 = arg_1_0._tf

	var_1_10[3] = var_2.Find(var_1_13, "AD/turn_awards/award_3")
	arg_1_0.turnAwards = var_1_10

	local var_1_14 = arg_1_0._tf

	arg_1_0.turnGoBtn = var_1.Find(var_1_14, "AD/turn_awards/battle_btn")

	local var_1_15 = arg_1_0._tf

	arg_1_0.turnGetBtn = var_1.Find(var_1_15, "AD/turn_awards/get_btn")

	local var_1_16 = arg_1_0._tf

	arg_1_0.progressImage = var_1.Find(var_1_16, "AD/turn_awards/progress/bar")
	onButton = var_1

	local var_1_17 = arg_1_0
	local var_1_18 = arg_1_0.startBtn

	local function var_1_19()
		if arg_1_0.activity then
			local var_2_0 = arg_1_0.activity
			local var_2_2

			if var_2_2.isEnd(var_2_0) then
				pg = var_2_2

				local var_2_1 = var_2_2.TipsMgr.GetInstance()

				var_2_2 = var_2_2.ShowTips
				i18n = var_2_10002

				var_2_2(var_2_1, var_2_10002("common_activity_end"))

				return
			end

			ipairs = var_2_2

			for iter_2_0, iter_2_1 in var_2_2(arg_1_0.turnAwards) do
				setActive = var_2_10005

				var_2_10005(iter_2_1:Find("mark/get"), false)
			end

			local var_2_3 = arg_1_0
			local var_2_4 = var_0.emit

			ActivityMediator = var_2

			var_2_4(var_2_3, var_2.GO_MONOPOLY2024, arg_1_0.activity.id, function()
				ipairs = var_3_10000

				for iter_3_0, iter_3_1 in var_3_10000(arg_1_0.turnAwards) do
					setActive = var_3_10005

					var_3_10005(iter_3_1:Find("mark/get"), true)
				end

				return
			end)

			return
		end
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_17, var_1_18, var_1_19, var_1_10005)

	local var_1_20 = arg_1_0._tf

	arg_1_0.taskGoBtn = var_1.Find(var_1_20, "AD/battle_btn")

	local var_1_21 = arg_1_0._tf

	arg_1_0.taskGetBtn = var_1.Find(var_1_21, "AD/get_btn")

	local var_1_22 = arg_1_0._tf

	arg_1_0.taskGotBtn = var_1.Find(var_1_22, "AD/got_btn")

	local var_1_23 = arg_1_0._tf
	local var_1_24 = var_1.Find(var_1_23, "AD/Text")
	local var_1_25 = var_1.GetComponent

	typeof = var_3
	Text = var_1_19
	arg_1_0.taskDesc = var_1_25(var_1_24, var_3(var_1_19))

	local var_1_26 = arg_1_0._tf

	arg_1_0.taskAward = var_1.Find(var_1_26, "AD/award")

	local var_1_27 = arg_1_0._tf

	arg_1_0.taskProgress = var_1.Find(var_1_27, "AD/taskProgress")

	return
end

function var_0_1.OnDataSetting(arg_4_0)
	return
end

function var_0_1.OnFirstFlush(arg_5_0)
	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	arg_6_0:UpdateTurnAwards()
	arg_6_0:UpdateTask()

	return
end

function var_0_1.UpdateTurnAwards(arg_7_0)
	local var_7_0 = arg_7_0.activity
	local var_7_1 = 3
	local var_7_2

	if not var_7_0.data1_list[3] then
		var_7_2 = 1
	end

	local var_7_3 = var_7_2 - 1
	local var_7_4

	if not var_7_0.data1_list[6] then
		var_7_4 = 0
	end

	local var_7_5 = arg_7_0.turnCntTxt

	var_7_5.text = var_7_3 .. "/" .. var_7_1
	math = var_7_5

	local var_7_6 = var_7_5.max(var_7_0.data2, 1) - 1
	local var_7_7

	if not var_7_0:getDataConfig("map") then
		var_7_7 = {}
	end

	local var_7_8

	if var_7_6 / #var_7_7 == 0 and var_7_3 > 0 then
		var_7_8 = 1
	end

	local var_7_9 = arg_7_0.progressTxt

	string = var_1_10010
	var_7_9.text = var_1_10010.format("%.1f", var_7_8 * 100) .. "%"

	local var_7_10 = var_7_4 + 1
	local var_7_11 = var_7_0
	local var_7_12 = var_7_0.getDataConfig(var_7_11, "sum_lap_reward_show")

	ipairs = var_7_11

	for iter_7_0, iter_7_1 in var_7_11(arg_7_0.turnAwards) do
		var_1_10016 = var_7_12[iter_7_0]
		Drop = var_1_10017
		var_1_10017 = var_1_10017.New({
			type = var_1_10016[1],
			id = var_1_10016[2],
			count = var_1_10016[3]
		})
		updateDrop = var_18

		var_18(iter_7_1:Find("mask"), var_1_10017)

		onButton = var_18

		local var_7_13 = arg_7_0
		local var_7_14 = iter_7_1

		local function var_7_15()
			local var_8_0 = arg_7_0
			local var_8_1 = var_0.emit

			BaseUI = var_2_10002

			var_8_1(var_8_0, var_2_10002.ON_DROP, var_1_10017)

			return
		end

		SFX_PANEL = var_1_10022

		var_18(var_7_13, var_7_14, var_7_15, var_1_10022)

		setActive = var_18

		var_18(iter_7_1:Find("mark"), iter_7_0 == var_7_10)

		setActive = var_18

		var_18(iter_7_1:Find("got"), iter_7_0 <= var_7_4)
	end

	local var_7_16 = var_7_1 < var_7_10
	local var_7_17 = var_7_10 <= var_7_3

	setActive = var_13

	var_13(arg_7_0.turnGoBtn, not var_7_17 and not var_7_16)

	setActive = var_13

	var_13(arg_7_0.turnGetBtn, var_7_17 and not var_7_16)

	local var_7_18 = {
		0.183,
		0.587,
		1
	}

	if var_7_3 <= 0 then
		setFillAmount = var_14

		var_14(arg_7_0.progressImage, 0)
	else
		setFillAmount = var_14

		local var_7_19 = arg_7_0.progressImage

		if not var_7_18[var_7_3] then
			var_1_10016 = 1
		end

		var_14(var_7_19, var_1_10016)
	end

	pg = var_14

	local var_7_20 = var_14.TimeMgr.GetInstance()
	local var_7_21 = var_14.GetServerTime(var_7_20)
	local var_7_22 = var_7_0.data1

	math = var_1_10016

	local var_7_23 = var_1_10016.ceil((var_7_21 - var_7_22) / 0) * var_7_0:getDataConfig("daily_time")
	local var_7_24

	if not var_7_0.data1_list[1] then
		var_7_24 = 0
	end

	local var_7_25 = var_7_23 + var_7_24
	local var_7_26

	if not var_7_0.data1_list[2] then
		var_7_26 = 0
	end

	local var_7_27 = var_7_25 - var_7_26
	local var_7_28 = arg_7_0.leftCountTxt

	i18n = var_1_10023
	var_7_28.text = var_1_10023("MonopolyCar2024Game_total_num_tip", var_7_27)
	onButton = var_7_28

	local var_7_29 = arg_7_0
	local var_7_30 = arg_7_0.turnGetBtn

	local function var_7_31()
		pg = var_2_10000

		local var_9_0 = var_2_10000.m02
		local var_9_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_9_2 = var_2_10002.MONOPOLY_OP
		local var_9_3 = {
			activity_id = var_7_0.id,
			arg1 = var_7_10
		}

		ActivityConst = var_4
		var_9_3.cmd = var_4.MONOPOLY_OP_ROUND_AWD

		var_9_1(var_9_0, var_9_2, var_9_3)

		return
	end

	SFX_PANEL = var_1_10026

	var_7_28(var_7_29, var_7_30, var_7_31, var_1_10026)

	return
end

function var_0_1.UpdateTask(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.activity_const.MONOPOLY_TASK_ACT_ID.act_id

	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_10_1 = var_1_10002(var_1_10003)

	if not var_2.getActivityById(var_10_1, var_10_0) or var_2:isEnd() then
		return
	end

	local var_10_2 = var_2
	local var_10_3 = var_2.getConfig(var_10_2, "config_data")[1]

	getProxy = var_10_2
	TaskProxy = var_5

	local var_10_4 = var_10_2(var_5)
	local var_10_5

	if not var_4.getTaskById(var_10_4, var_10_3) and not var_4:getFinishTaskById(var_10_3) then
		Task = var_10_5
		var_10_5 = var_10_5.New({
			id = var_10_3
		})
	end

	local var_10_6 = var_4:getTaskById(var_10_3)
	local var_10_7 = var_10_5
	local var_10_8 = var_10_5.getConfig(var_10_7, "award_display")[1]

	Drop = var_10_7

	local var_10_9 = var_10_7.New({
		type = var_10_8[1],
		id = var_10_8[2],
		count = var_10_8[3]
	})

	updateDrop = var_9

	local var_10_10 = arg_10_0.taskAward

	var_9(var_10.Find(var_10_10, "mask"), var_10_9)

	onButton = var_9

	local var_10_11 = arg_10_0
	local var_10_12 = arg_10_0.taskAward

	local function var_10_13()
		local var_11_0 = arg_10_0
		local var_11_1 = var_0.emit

		BaseUI = var_2_10002

		var_11_1(var_11_0, var_2_10002.ON_DROP, var_10_9)

		return
	end

	SFX_PANEL = var_1_10013

	var_9(var_10_11, var_10_12, var_10_13, var_1_10013)

	local var_10_14 = var_10_5
	local var_10_15 = var_10_5.getConfig(var_10_14, "target_num")
	local var_10_17

	if var_10_6 ~= nil then
		math = var_10_14
		var_10_14 = var_10_14.min(var_10_5:getProgress(), var_10_15)
		setSlider = var_10_17

		var_10_17(arg_10_0.taskProgress, 0, var_10_15, var_10_14)

		local var_10_16 = var_10_5

		var_10_17 = var_10_5.getConfig(var_10_16, "desc")
		ipairs = var_10_16

		for iter_10_0, iter_10_1 in var_10_16({
			var_10_14
		}) do
			string = var_1_10017
			var_10_17 = var_1_10017.gsub(var_10_17, "$" .. iter_10_0, iter_10_1)
		end

		arg_10_0.taskDesc.text = var_10_17

		local var_10_18 = var_10_5:isFinish()

		var_1_10014 = var_10_5

		local var_10_19 = var_10_5.isReceive(var_1_10014)

		setActive = var_1_10014

		var_1_10014(arg_10_0.taskGoBtn, not var_10_18 and not var_10_19)

		setActive = var_1_10014

		var_1_10014(arg_10_0.taskGetBtn, var_10_18 and not var_10_19)

		setActive = var_1_10014

		var_1_10014(arg_10_0.taskGotBtn, var_10_19)
	else
		var_10_14 = var_10_15
		setSlider = var_10_17

		var_10_17(arg_10_0.taskProgress, 0, var_10_15, var_10_14)

		local var_10_20 = var_10_5
		local var_10_21 = var_10_5.getConfig(var_10_20, "desc")

		ipairs = var_10_20

		for iter_10_2, iter_10_3 in var_10_20({
			var_10_14
		}) do
			string = var_1_10017
			var_10_21 = var_1_10017.gsub(var_10_21, "$" .. iter_10_2, iter_10_3)
		end

		local var_10_22 = arg_10_0.taskDesc

		var_10_22.text = var_10_21
		setActive = var_10_22

		var_10_22(arg_10_0.taskGoBtn, false)

		setActive = var_10_22

		var_10_22(arg_10_0.taskGetBtn, false)

		setActive = var_10_22

		var_10_22(arg_10_0.taskGotBtn, true)
	end

	onButton = var_10_14

	local var_10_23 = arg_10_0
	local var_10_24 = arg_10_0.taskGetBtn

	local function var_10_25()
		local var_12_0 = arg_10_0
		local var_12_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_12_1(var_12_0, var_2_10002.ON_TASK_SUBMIT, var_10_5, function(arg_13_0)
			if arg_13_0 then
				local var_13_0 = arg_10_0

				var_1.OnUpdateFlush(var_13_0)
			end

			return
		end)

		return
	end

	SFX_PANEL = var_1_10014

	var_10_14(var_10_23, var_10_24, var_10_25, var_1_10014)

	return
end

function var_0_1.OnHideFlush(arg_14_0)
	return
end

function var_0_1.OnDestroy(arg_15_0)
	return
end

return var_0_1
