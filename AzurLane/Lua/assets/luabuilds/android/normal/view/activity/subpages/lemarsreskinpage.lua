class = var_0_10000

local var_0_0 = "LeMarsReSkinPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.displayBtn = var_1.Find(var_1_0, "display_btn")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.displayBtn

	local function var_2_2()
		local var_3_0 = {}
		local var_3_1 = {}
		local var_3_2 = arg_2_0.taskGroup[arg_2_0.nday][1]
		local var_3_3 = arg_2_0.taskProxy
		local var_3_5

		if not var_3.getTaskById(var_3_3, var_3_2) then
			local var_3_4 = arg_2_0.taskProxy

			var_3_5 = var_3.getFinishTaskById(var_3_4, var_3_2)
		end

		local var_3_6 = var_3_5:getProgress()
		local var_3_7 = arg_2_0.nday

		ipairs = var_2_10006

		local var_3_8 = arg_2_0.activity

		for iter_3_0, iter_3_1 in var_2_10006(var_7.getConfig(var_3_8, "config_data")) do
			ipairs = var_2_10011

			for iter_3_2, iter_3_3 in var_2_10011(iter_3_1) do
				pg = var_2_10016

				if var_2_10016.task_data_template[iter_3_3] and var_2_10016.award_display and var_2_10016.award_display[1] then
					table = var_17

					var_17.insert(var_3_0, var_2_10016.award_display[1])

					table = var_17

					var_17.insert(var_3_1, var_2_10016.target_num)
				end
			end
		end

		if var_3_5:getTaskStatus() ~= 2 then
			var_3_7 = var_3_7 - 1
		end

		local var_3_9 = arg_2_0
		local var_3_10 = var_6.emit

		ActivityMediator = var_8

		local var_3_11 = var_8.ON_AWARD_WINDOW
		local var_3_12 = var_3_0
		local var_3_13 = var_3_7
		local var_3_14 = {}

		i18n = var_2_10012
		var_3_14[1] = var_2_10012("LeMarsReSkinPage_reward_target")
		i18n = var_12
		var_3_14[2] = var_12("LeMarsReSkinPage_reward_title")

		var_3_10(var_3_9, var_3_11, var_3_12, var_3_13, var_3_14, {
			targetList = var_3_1,
			nowGet = var_3_6
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_0, var_2_1, var_2_2, var_1_10005)

	return
end

function var_0_1.UpdateTask(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1 + 1
	local var_4_1 = arg_4_2:Find("award")
	local var_4_2 = arg_4_0.taskGroup[arg_4_0.nday][1]
	local var_4_3 = arg_4_0.taskProxy
	local var_4_4

	if not var_6.getTaskById(var_4_3, var_4_2) then
		var_4_3 = arg_4_0.taskProxy
		var_4_4 = var_6.getFinishTaskById(var_4_3, var_4_2)
	end

	assert = var_4_3

	var_4_3(var_4_4, "without this task by id: " .. var_4_2)

	Drop = var_4_3

	local var_4_5 = var_4_3.Create(var_4_4:getConfig("award_display")[1])

	updateDrop = var_8

	var_8(var_4_1, var_4_5)

	onButton = var_8

	local var_4_6 = arg_4_0
	local var_4_7 = var_4_1

	local function var_4_8()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.emit

		BaseUI = var_2_10002

		var_5_1(var_5_0, var_2_10002.ON_DROP, var_4_5)

		return
	end

	SFX_PANEL = var_1_10012

	var_8(var_4_6, var_4_7, var_4_8, var_1_10012)

	local var_4_9 = var_4_4:getProgress()
	local var_4_10 = var_4_4
	local var_4_11 = var_4_4.getConfig(var_4_10, "target_num")

	setScrollText = var_4_10

	var_4_10(arg_4_2:Find("mask/description"), var_4_4:getConfig("desc"))

	local var_4_12, var_4_13 = arg_4_0:GetProgressColor()

	if var_4_12 then
		setColorStr = var_12

		local var_4_14

		if not var_12(var_4_9, var_4_12) then
			::label_4_0::

			var_4_14 = var_4_9
		end

		if var_4_13 then
			setColorStr = var_12

			local var_4_15

			if not var_12("/" .. var_4_11, var_4_13) then
				::label_4_1::

				var_4_15 = "/" .. var_4_11
			end

			setText = var_12

			var_12(arg_4_2:Find("progress"), var_4_14 .. var_4_15)

			setSlider = var_12

			var_12(arg_4_2:Find("slider"), 0, var_4_11, var_4_9)

			local var_4_16 = arg_4_2:Find("go_btn")
			local var_4_17 = arg_4_2:Find("get_btn")
			local var_4_18 = arg_4_2:Find("got_btn")
			local var_4_19 = var_4_4
			local var_4_20 = var_4_4.getTaskStatus(var_4_19)

			setActive = var_4_19

			var_4_19(var_4_16, var_4_20 == 0)

			setActive = var_4_19

			var_4_19(var_4_17, var_4_20 == 1)

			setActive = var_4_19

			var_4_19(var_4_18, var_4_20 == 2)

			onButton = var_4_19

			local var_4_21 = arg_4_0
			local var_4_22 = var_4_16

			local function var_4_23()
				local var_6_0 = arg_4_0
				local var_6_1 = var_0.emit

				ActivityMediator = var_2_10002

				var_6_1(var_6_0, var_2_10002.ON_TASK_GO, var_4_4)

				return
			end

			SFX_PANEL = var_1_10020

			var_4_19(var_4_21, var_4_22, var_4_23, var_1_10020)

			onButton = var_4_19

			local var_4_24 = arg_4_0
			local var_4_25 = var_4_17

			local function var_4_26()
				local var_7_0 = {}
				local var_7_1 = var_4_4
				local var_7_2 = var_1.getConfig(var_7_1, "award_display")

				getProxy = var_7_1
				PlayerProxy = var_3

				local var_7_3 = var_7_1(var_3)
				local var_7_4 = var_2.getRawData(var_7_3)

				pg = var_7_3

				local var_7_5 = var_7_3.gameset.urpt_chapter_max.description[1]

				LOCK_UR_SHIP = var_2_10005

				if var_2_10005 then
					var_2_10005 = 0
				else
					getProxy = var_2_10005
					BagProxy = var_2_10006
					var_2_10006 = var_2_10005(var_2_10006)
					var_2_10005 = var_2_10005.GetLimitCntById(var_2_10006, var_7_5)
				end

				Task = var_2_10006

				local var_7_6, var_7_7 = var_2_10006.StaticJudgeOverflow(var_7_4.gold, var_7_4.oil, var_2_10005, true, true, var_7_2)

				if var_7_6 then
					table = var_8

					var_8.insert(var_7_0, function(arg_8_0)
						pg = var_3_10001

						local var_8_0 = var_3_10001.MsgboxMgr.GetInstance()
						local var_8_1 = var_1.ShowMsgBox
						local var_8_2 = {}

						MSGBOX_TYPE_ITEM_BOX = var_3_10004
						var_8_2.type = var_3_10004
						i18n = var_3_10004
						var_8_2.content = var_3_10004("award_max_warning")
						var_8_2.items = var_7_7
						var_8_2.onYes = arg_8_0

						var_8_1(var_8_0, var_8_2)

						return
					end)
				end

				seriesAsync = var_8

				var_8(var_7_0, function()
					local var_9_0 = arg_4_0
					local var_9_1 = var_0.emit

					ActivityMediator = var_3_10002

					var_9_1(var_9_0, var_3_10002.ON_TASK_SUBMIT, var_4_4)

					return
				end)

				return
			end

			SFX_PANEL = var_1_10020

			var_4_19(var_4_24, var_4_25, var_4_26, var_1_10020)

			return
		end
	end
end

function var_0_1.GetProgressColor(arg_10_0)
	return "#1EA2ACFF", "#3DCCD7"
end

return var_0_1
