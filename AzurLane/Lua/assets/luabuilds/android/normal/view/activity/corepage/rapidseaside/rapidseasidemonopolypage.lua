class = var_0_10000

local var_0_0 = "RapidSeasideMonopolyPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))

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
	local var_1_5 = var_1.Find(var_1_4, "AD/loop_cnt/turn")
	local var_1_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.turnTxt = var_1_6(var_1_5, var_3(var_1_10004))

	local var_1_7 = arg_1_0._tf
	local var_1_8 = var_1.Find(var_1_7, "AD/loop_cnt/turn_cnt")
	local var_1_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.turnCntTxt = var_1_9(var_1_8, var_3(var_1_10004))

	local var_1_10 = arg_1_0._tf
	local var_1_11 = var_1.Find(var_1_10, "AD/loop_cnt/progress")
	local var_1_12 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.progressTxt = var_1_12(var_1_11, var_3(var_1_10004))

	local var_1_13 = arg_1_0._tf
	local var_1_14 = var_1.Find(var_1_13, "AD/loop_cnt/progress_cnt")
	local var_1_15 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_1_0.progressCntTxt = var_1_15(var_1_14, var_3(var_1_10004))

	local var_1_16 = {}
	local var_1_17 = arg_1_0._tf

	var_1_16[1] = var_2.Find(var_1_17, "AD/turn_awards/award_1")

	local var_1_18 = arg_1_0._tf

	var_1_16[2] = var_2.Find(var_1_18, "AD/turn_awards/award_2")

	local var_1_19 = arg_1_0._tf

	var_1_16[3] = var_2.Find(var_1_19, "AD/turn_awards/award_3")
	arg_1_0.turnAwards = var_1_16

	local var_1_20 = arg_1_0._tf

	arg_1_0.turnGetBtn = var_1.Find(var_1_20, "AD/turn_awards/get_btn")

	local var_1_21 = arg_1_0._tf

	arg_1_0.turnGotBtn = var_1.Find(var_1_21, "AD/turn_awards/got_btn")

	local var_1_22 = arg_1_0._tf

	arg_1_0.progressImage = var_1.Find(var_1_22, "AD/turn_awards/progress/bar")

	local var_1_23 = arg_1_0._tf

	arg_1_0.title = var_1.Find(var_1_23, "AD/RapidSeasideTitle Variant/Main/title")

	local var_1_24 = arg_1_0._tf

	arg_1_0._paintingParticles = var_1.Find(var_1_24, "AD/RapidSeasideTitle Variant/Main/title/title_2/Particle System")

	local var_1_25 = arg_1_0._paintingParticles
	local var_1_26 = var_1.GetComponent

	typeof = var_3
	ParticleSystem = var_4
	arg_1_0._paintingParticleSystem = var_1_26(var_1_25, var_3(var_4))

	local var_1_27 = arg_1_0._tf

	arg_1_0.btnManual = var_1.Find(var_1_27, "TopPage/top/manual")

	local var_1_28 = arg_1_0.btnManual

	arg_1_0.Txtmanual = var_1.Find(var_1_28, "Text")

	local var_1_29 = arg_1_0.btnManual

	arg_1_0.redMalPoint = var_1.Find(var_1_29, "tip")
	ipairs = var_1

	for iter_1_0, iter_1_1 in var_1(arg_1_0.turnAwards) do
		setActive = var_1_10006

		var_1_10006(iter_1_1:Find("can_get_mask"), false)
	end

	onButton = var_1

	local var_1_30 = arg_1_0
	local var_1_31 = arg_1_0.startBtn

	local function var_1_32()
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

			setActive = var_2_2

			var_2_2(arg_1_0.title, false)

			local var_2_3 = arg_1_0._paintingParticleSystem

			var_0.Stop(var_2_3, true)

			local var_2_4 = arg_1_0
			local var_2_5 = var_0.emit

			ActivityMediator = var_2

			var_2_5(var_2_4, var_2.GO_MONOPOLY2026, arg_1_0.activity.id, function()
				setActive = var_3_10000

				var_3_10000(arg_1_0.title, true)

				local var_3_0 = arg_1_0._paintingParticleSystem

				var_0.Play(var_3_0)

				local var_3_1 = arg_1_0

				var_0.OnUpdateFlush(var_3_1)

				return
			end)

			return
		end
	end

	SFX_PANEL = iter_1_1

	var_1(var_1_30, var_1_31, var_1_32, iter_1_1)

	local var_1_33 = arg_1_0._tf

	arg_1_0.taskGoBtn = var_1.Find(var_1_33, "AD/loop_progress/go_btn")

	local var_1_34 = arg_1_0._tf

	arg_1_0.taskGetBtn = var_1.Find(var_1_34, "AD/loop_progress/get_btn")

	local var_1_35 = arg_1_0._tf

	arg_1_0.taskGotBtn = var_1.Find(var_1_35, "AD/loop_progress/got_btn")

	local var_1_36 = arg_1_0._tf
	local var_1_37 = var_1.Find(var_1_36, "AD/loop_progress/Text")
	local var_1_38 = var_1.GetComponent

	typeof = var_3
	Text = var_1_32
	arg_1_0.taskDesc = var_1_38(var_1_37, var_3(var_1_32))

	local var_1_39 = arg_1_0._tf

	arg_1_0.taskAward = var_1.Find(var_1_39, "AD/loop_progress/award")

	local var_1_40 = arg_1_0._tf

	arg_1_0.taskProgress = var_1.Find(var_1_40, "AD/loop_progress/taskProgress")

	return
end

function var_0_1.OnDataSetting(arg_4_0)
	return
end

function var_0_1.OnFirstFlush(arg_5_0)
	ipairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.turnAwards) do
		setText = var_1_10006

		local var_5_0 = iter_5_1
		local var_5_1 = iter_5_1.Find(var_5_0, "bg_lock/Text")

		i18n = var_5_0

		var_1_10006(var_5_1, var_5_0("RapidSeasideMonopolyPage_award_loop" .. iter_5_0))

		setText = var_1_10006

		local var_5_2 = iter_5_1
		local var_5_3 = iter_5_1.Find(var_5_2, "bg_unlock/Text")

		i18n = var_5_2

		var_1_10006(var_5_3, var_5_2("RapidSeasideMonopolyPage_award_loop" .. iter_5_0))
	end

	onButton = var_1

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.btnManual

	local function var_5_6()
		Context = var_2_10000

		local var_6_0 = var_2_10000.New
		local var_6_1 = {}

		MedalAlbumTemplateMediator = var_2_10002
		var_6_1.mediator = var_2_10002
		RapidSeasideMedalAlbumView = var_2_10002
		var_6_1.viewComponent = var_2_10002

		local var_6_2 = var_6_0(var_6_1)
		local var_6_3 = arg_5_0
		local var_6_4 = var_1.emit

		ActivityMediator = var_2_10003

		var_6_4(var_6_3, var_2_10003.ON_ADD_SUBLAYER, var_6_2)

		return
	end

	SFX_PANEL = iter_5_1

	var_1(var_5_4, var_5_5, var_5_6, iter_5_1)

	setText = var_1

	local var_5_7 = arg_5_0.Txtmanual

	i18n = var_5_5

	var_1(var_5_7, var_5_5("anniversary_nine_main_page"))
	arg_5_0:UpdateRed()

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	arg_7_0:UpdateTurnAwards()
	arg_7_0:UpdateTask()
	arg_7_0:UpdateRed()

	return
end

function var_0_1.UpdateTurnAwards(arg_8_0)
	local var_8_0 = arg_8_0.activity
	local var_8_1 = "MONOPOLY_AWARD_LIST"

	pg = var_1_10003

	if var_1_10003.gameset[var_8_1] then
		pg = var_3

		local var_8_2

		if not var_3.gameset[var_8_1].description then
			var_8_2 = {
				3,
				6,
				9
			}
		end

		local var_8_3 = var_8_2[3]
		local var_8_4

		if not var_8_0.data1_list[3] then
			var_8_4 = 1
		end

		local var_8_5 = var_8_4 - 1
		local var_8_6

		if not var_8_0.data1_list[6] then
			var_8_6 = 0
		end

		local var_8_7 = arg_8_0.turnTxt

		i18n = var_1_10008
		var_8_7.text = var_1_10008("RapidSeasideMonopolyPage_turn_cnt_tip")

		local var_8_8 = arg_8_0.turnCntTxt

		var_8_8.text = var_8_5 .. "/" .. var_8_3
		math = var_8_8

		local var_8_9 = var_8_8.max(var_8_0.data2, 1) - 1
		local var_8_10

		if not var_8_0:getDataConfig("map") then
			var_8_10 = {}
		end

		local var_8_11

		if var_8_9 / #var_8_10 == 0 and var_8_5 > 0 then
			var_8_11 = 1
		end

		local var_8_12 = arg_8_0.progressTxt

		i18n = var_1_10012
		var_8_12.text = var_1_10012("RapidSeasideMonopolyPage_progress_tip")

		local var_8_13 = arg_8_0.progressCntTxt

		string = var_12
		var_8_13.text = var_12.format("%.1f", var_8_11 * 100) .. "%"

		local var_8_14 = var_8_0:getDataConfig("sum_lap_reward_show")
		local var_8_15 = false
		local var_8_16 = 0

		ipairs = var_14

		for iter_8_0, iter_8_1 in var_14(arg_8_0.turnAwards) do
			local var_8_17 = var_8_14[iter_8_0]

			Drop = var_1_10020
			var_1_10020 = var_1_10020.New({
				type = var_8_17[1],
				id = var_8_17[2],
				count = var_8_17[3]
			})

			local var_8_18 = var_8_2[iter_8_0] <= var_8_5 and var_8_6 < var_21

			updateDrop = var_1_10023

			var_1_10023(iter_8_1:Find("mask"), var_1_10020)

			onButton = var_1_10023

			local var_8_19 = arg_8_0
			local var_8_20 = iter_8_1

			function var_1_10026()
				local var_9_0 = arg_8_0
				local var_9_1 = var_0.emit

				BaseUI = var_2_10002

				var_9_1(var_9_0, var_2_10002.ON_DROP, var_1_10020)

				return
			end

			SFX_PANEL = var_1_10027

			var_1_10023(var_8_19, var_8_20, var_1_10026, var_1_10027)

			setActive = var_1_10023

			var_1_10023(iter_8_1:Find("got"), var_21 <= var_8_6)

			setActive = var_1_10023

			var_1_10023(iter_8_1:Find("bg_lock"), var_21 <= var_8_5)

			setActive = var_1_10023

			var_1_10023(iter_8_1:Find("bg_unlock"), var_8_5 < var_21)

			if var_8_16 == 0 and var_8_18 then
				var_8_16 = var_21
			end

			setActive = var_1_10023

			var_1_10023(iter_8_1:Find("can_get_mask"), var_8_18)

			var_8_15 = var_8_15 or var_8_18
		end

		setActive = var_14

		var_14(arg_8_0.turnGotBtn, not var_8_15)

		setActive = var_14

		var_14(arg_8_0.turnGetBtn, var_8_15)

		pg = var_14

		local var_8_21 = var_14.TimeMgr.GetInstance()
		local var_8_22 = var_14.GetServerTime(var_8_21)
		local var_8_23 = var_8_0.data1

		math = var_16

		local var_8_24 = var_16.ceil((var_8_22 - var_8_23) / 0) * var_8_0:getDataConfig("daily_time")
		local var_8_25

		if not var_8_0.data1_list[1] then
			var_8_25 = 0
		end

		local var_8_26 = var_8_24 + var_8_25
		local var_8_27

		if not var_8_0.data1_list[2] then
			var_8_27 = 0
		end

		local var_8_28 = var_8_26 - var_8_27
		local var_8_29 = arg_8_0.leftCountTxt

		i18n = var_1_10023
		var_8_29.text = var_1_10023("MonopolyCar2024Game_total_num_tip", var_8_28)
		onButton = var_8_29

		local var_8_30 = arg_8_0
		local var_8_31 = arg_8_0.turnGetBtn

		local function var_8_32()
			pg = var_2_10000

			local var_10_0 = var_2_10000.m02
			local var_10_1 = var_0.sendNotification

			GAME = var_2_10002

			local var_10_2 = var_2_10002.MONOPOLY_OP
			local var_10_3 = {
				activity_id = var_8_0.id,
				arg1 = var_8_16
			}

			ActivityConst = var_4
			var_10_3.cmd = var_4.MONOPOLY_OP_ROUND_AWD

			var_10_1(var_10_0, var_10_2, var_10_3)

			return
		end

		SFX_PANEL = var_1_10026

		var_8_29(var_8_30, var_8_31, var_8_32, var_1_10026)

		return
	end
end

function var_0_1.UpdateTask(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.activity_template[arg_11_0.activity.id].config_data[1]

	pg = var_2

	local var_11_1 = var_2.activity_template[var_11_0].config_data[1]

	getProxy = var_1_10003
	TaskProxy = var_1_10004

	local var_11_2 = var_1_10003(var_1_10004)
	local var_11_3

	if not var_3.getTaskById(var_11_2, var_11_1) and not var_3:getFinishTaskById(var_11_1) then
		Task = var_11_3
		var_11_3 = var_11_3.New({
			id = var_11_1
		})
	end

	local var_11_4 = var_3:getTaskById(var_11_1)
	local var_11_5 = var_11_3
	local var_11_6 = var_11_3.getConfig(var_11_5, "award_display")[1]

	Drop = var_11_5

	local var_11_7 = var_11_5.New({
		type = var_11_6[1],
		id = var_11_6[2],
		count = var_11_6[3]
	})

	updateDrop = var_8

	local var_11_8 = arg_11_0.taskAward

	var_8(var_9.Find(var_11_8, "mask"), var_11_7)

	onButton = var_8

	local var_11_9 = arg_11_0
	local var_11_10 = arg_11_0.taskAward

	local function var_11_11()
		local var_12_0 = arg_11_0
		local var_12_1 = var_0.emit

		BaseUI = var_2_10002

		var_12_1(var_12_0, var_2_10002.ON_DROP, var_11_7)

		return
	end

	SFX_PANEL = var_1_10012

	var_8(var_11_9, var_11_10, var_11_11, var_1_10012)

	local var_11_12 = var_11_3
	local var_11_13 = var_11_3.getConfig(var_11_12, "target_num")
	local var_11_15

	if var_11_4 ~= nil then
		math = var_11_12
		var_11_12 = var_11_12.min(var_11_3:getProgress(), var_11_13)
		setSlider = var_11_15

		var_11_15(arg_11_0.taskProgress, 0, var_11_13, var_11_12)

		local var_11_14 = var_11_3

		var_11_15 = var_11_3.getConfig(var_11_14, "desc")
		ipairs = var_11_14

		for iter_11_0, iter_11_1 in var_11_14({
			var_11_12
		}) do
			string = var_1_10016
			var_11_15 = var_1_10016.gsub(var_11_15, "$" .. iter_11_0, iter_11_1)
		end

		arg_11_0.taskDesc.text = var_11_15

		local var_11_16 = var_11_3:isFinish()

		var_1_10013 = var_11_3

		local var_11_17 = var_11_3.isReceive(var_1_10013)

		setActive = var_1_10013

		var_1_10013(arg_11_0.taskGoBtn, not var_11_16 and not var_11_17)

		setActive = var_1_10013

		var_1_10013(arg_11_0.taskGetBtn, var_11_16 and not var_11_17)

		setActive = var_1_10013

		var_1_10013(arg_11_0.taskGotBtn, var_11_17)
	else
		var_11_12 = var_11_13
		setSlider = var_11_15

		var_11_15(arg_11_0.taskProgress, 0, var_11_13, var_11_12)

		local var_11_18 = var_11_3
		local var_11_19 = var_11_3.getConfig(var_11_18, "desc")

		ipairs = var_11_18

		for iter_11_2, iter_11_3 in var_11_18({
			var_11_12
		}) do
			string = var_1_10016
			var_11_19 = var_1_10016.gsub(var_11_19, "$" .. iter_11_2, iter_11_3)
		end

		local var_11_20 = arg_11_0.taskDesc

		var_11_20.text = var_11_19
		setActive = var_11_20

		var_11_20(arg_11_0.taskGoBtn, false)

		setActive = var_11_20

		var_11_20(arg_11_0.taskGetBtn, false)

		setActive = var_11_20

		var_11_20(arg_11_0.taskGotBtn, true)
	end

	onButton = var_11_12

	local var_11_21 = arg_11_0
	local var_11_22 = arg_11_0.taskGetBtn

	local function var_11_23()
		local var_13_0 = arg_11_0
		local var_13_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_13_1(var_13_0, var_2_10002.ON_TASK_SUBMIT, var_11_3, function(arg_14_0)
			if arg_14_0 then
				local var_14_0 = arg_11_0

				var_1.OnUpdateFlush(var_14_0)
			end

			return
		end)

		return
	end

	SFX_PANEL = var_1_10013

	var_11_12(var_11_21, var_11_22, var_11_23, var_1_10013)

	onButton = var_11_12

	local var_11_24 = arg_11_0
	local var_11_25 = arg_11_0.taskGoBtn

	local function var_11_26()
		local var_15_0 = arg_11_0
		local var_15_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_15_1(var_15_0, var_2_10002.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10013

	var_11_12(var_11_24, var_11_25, var_11_26, var_1_10013)

	return
end

function var_0_1.UpdateRed(arg_16_0)
	pg = var_1_10001

	if var_1_10001.activity_template[arg_16_0.activity.id].config_client.is_showMedal then
		local var_16_0 = var_1.medal_group_id

		setActive = var_1_10003

		local var_16_1 = arg_16_0.redMalPoint

		ActivityMedalGroup = var_1_10005

		var_1_10003(var_16_1, var_1_10005.showTip(var_16_0))
	end

	return
end

function var_0_1.OnHideFlush(arg_17_0)
	return
end

function var_0_1.OnDestroy(arg_18_0)
	return
end

return var_0_1
