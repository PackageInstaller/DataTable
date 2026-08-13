class = var_0_10000

local var_0_0 = "PSSSkinPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreLoginTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	return
end

function var_0_1.UpdateTask(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1 + 1
	local var_2_1 = arg_2_2:Find("item")
	local var_2_2 = arg_2_0.taskGroup[arg_2_0.nday][var_2_0]
	local var_2_3 = arg_2_0.taskProxy
	local var_2_4

	if not var_6.getTaskById(var_2_3, var_2_2) then
		var_2_3 = arg_2_0.taskProxy
		var_2_4 = var_6.getFinishTaskById(var_2_3, var_2_2)
	end

	assert = var_7

	var_7(var_2_4, "without this task by id: " .. var_2_2)

	Drop = var_7

	local var_2_5 = var_7.Create(var_2_4:getConfig("award_display")[1])

	updateDrop = var_2_3

	var_2_3(var_2_1, var_2_5)

	onButton = var_2_3

	local var_2_6 = arg_2_0
	local var_2_7 = var_2_1

	local function var_2_8()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		BaseUI = var_2_10003

		var_3_1(var_3_0, var_2_10003.ON_DROP, var_2_5)

		return
	end

	SFX_PANEL = var_1_10013

	var_2_3(var_2_6, var_2_7, var_2_8, var_1_10013)

	local var_2_9 = var_2_4
	local var_2_10 = var_2_4.getProgress(var_2_9)
	local var_2_11 = var_2_4:getConfig("target_num")

	setText = var_2_9

	var_2_9(arg_2_2:Find("description"), var_2_4:getConfig("desc"))

	setText = var_2_9

	var_2_9(arg_2_2:Find("progressText"), var_2_10)

	setText = var_2_9

	var_2_9(arg_2_2:Find("progressText_1"), "/" .. var_2_11)

	setSlider = var_2_9

	var_2_9(arg_2_2:Find("progress"), 0, var_2_11, var_2_10)

	local var_2_12 = arg_2_2:Find("go_btn")
	local var_2_13 = arg_2_2
	local var_2_14 = arg_2_2.Find(var_2_13, "get_btn")
	local var_2_15 = arg_2_2
	local var_2_16 = arg_2_2.Find(var_2_15, "got_btn")

	setText = var_2_13

	local var_2_17 = arg_2_2:Find("go_btn/Text")

	i18n = var_16

	var_2_13(var_2_17, var_16("island_word_go"))

	setText = var_2_13

	local var_2_18 = arg_2_2:Find("get_btn/Text")

	i18n = var_16

	var_2_13(var_2_18, var_16("handbook_research_final_task_btn_claim"))

	setText = var_2_13

	local var_2_19 = arg_2_2:Find("got_btn/Text")

	i18n = var_16

	var_2_13(var_2_19, var_16("handbook_research_final_task_btn_finished"))

	local var_2_20 = var_2_4:getTaskStatus()

	setActive = var_2_15

	var_2_15(var_2_12, var_2_20 == 0)

	setActive = var_2_15

	var_2_15(var_2_14, var_2_20 == 1)

	setActive = var_2_15

	var_2_15(var_2_16, var_2_20 == 2)

	onButton = var_2_15

	local var_2_21 = arg_2_0
	local var_2_22 = var_2_12

	local function var_2_23()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.ON_TASK_GO, var_2_4)

		return
	end

	SFX_PANEL = var_1_10019

	var_2_15(var_2_21, var_2_22, var_2_23, var_1_10019)

	onButton = var_2_15

	local var_2_24 = arg_2_0
	local var_2_25 = var_2_14

	local function var_2_26()
		local var_5_0 = {}
		local var_5_1 = var_2_4
		local var_5_2 = var_1.getConfig(var_5_1, "award_display")

		getProxy = var_2_10002
		PlayerProxy = var_4

		local var_5_3 = var_2_10002(var_4)
		local var_5_4 = var_2.getRawData(var_5_3)

		pg = var_4

		local var_5_5 = var_4.gameset.urpt_chapter_max.description[1]

		LOCK_UR_SHIP = var_5_3

		if var_5_3 then
			var_5_3 = 0
		else
			getProxy = var_5_3
			BagProxy = var_2_10007

			local var_5_6 = var_5_3(var_2_10007)

			var_5_3 = var_5_3.GetLimitCntById(var_5_6, var_5_5)
		end

		Task = var_2_10006

		local var_5_7, var_5_8 = var_2_10006.StaticJudgeOverflow(var_5_4.gold, var_5_4.oil, var_5_3, true, true, var_5_2)

		if var_5_7 then
			table = var_8

			var_8.insert(var_5_0, function(arg_6_0)
				pg = var_3_10001

				local var_6_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_6_1 = var_1.ShowMsgBox
				local var_6_2 = {}

				MSGBOX_TYPE_ITEM_BOX = var_3_10005
				var_6_2.type = var_3_10005
				i18n = var_3_10005
				var_6_2.content = var_3_10005("award_max_warning")
				var_6_2.items = var_5_8
				var_6_2.onYes = arg_6_0

				var_6_1(var_6_0, var_6_2)

				return
			end)
		end

		seriesAsync = var_8

		var_8(var_5_0, function()
			local var_7_0 = arg_2_0
			local var_7_1 = var_0.emit

			ActivityMediator = var_3_10003

			var_7_1(var_7_0, var_3_10003.ON_TASK_SUBMIT, var_2_4)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10019

	var_2_15(var_2_24, var_2_25, var_2_26, var_1_10019)

	return
end

return var_0_1
