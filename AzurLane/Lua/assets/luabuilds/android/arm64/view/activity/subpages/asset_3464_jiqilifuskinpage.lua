class = var_0_10000

local var_0_0 = "JiqilifuSkinPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".DachaolifuSkinPage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.step_txt = var_1.Find(var_1_0, "step_text")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	local var_2_0 = arg_2_0.uilist

	var_1.make(var_2_0, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_3_1 + 1
			local var_3_1 = arg_3_2:Find("item")
			local var_3_2 = arg_2_0.taskGroup[arg_2_0.nday][var_3_0]
			local var_3_3 = arg_2_0.taskProxy
			local var_3_5

			if not var_6.getTaskById(var_3_3, var_3_2) then
				local var_3_4 = arg_2_0.taskProxy

				var_3_5 = var_6.getFinishTaskById(var_3_4, var_3_2)
			end

			assert = var_7

			var_7(var_3_5, "without this task by id: " .. var_3_2)

			local var_3_6 = var_3_5:getConfig("award_display")[1]
			local var_3_7 = {
				type = var_3_6[1],
				id = var_3_6[2],
				count = var_3_6[3]
			}

			updateDrop = var_9

			var_9(var_3_1, var_3_7)

			onButton = var_9

			local var_3_8 = arg_2_0
			local var_3_9 = var_3_1

			local function var_3_10()
				local var_4_0 = arg_2_0
				local var_4_1 = var_0.emit

				BaseUI = var_3_10003

				var_4_1(var_4_0, var_3_10003.ON_DROP, var_3_7)

				return
			end

			SFX_PANEL = var_2_10014

			var_9(var_3_8, var_3_9, var_3_10, var_2_10014)

			local var_3_11 = var_3_5
			local var_3_12 = var_3_5.getProgress(var_3_11)
			local var_3_13 = var_3_5:getConfig("target_num")

			setText = var_3_11

			var_3_11(arg_3_2:Find("description"), var_3_5:getConfig("desc"))

			setText = var_3_11

			var_3_11(arg_3_2:Find("progressText"), var_3_12 .. "/" .. var_3_13)

			setSlider = var_3_11

			var_3_11(arg_3_2:Find("progress"), 0, var_3_13, var_3_12)

			local var_3_14 = arg_3_2:Find("go_btn")
			local var_3_15 = arg_3_2:Find("get_btn")
			local var_3_16 = arg_3_2
			local var_3_17 = arg_3_2.Find(var_3_16, "got_btn")
			local var_3_18 = var_3_5:getTaskStatus()

			setActive = var_3_16

			var_3_16(var_3_14, var_3_18 == 0)

			setActive = var_3_16

			var_3_16(var_3_15, var_3_18 == 1)

			setActive = var_3_16

			var_3_16(var_3_17, var_3_18 == 2)

			onButton = var_3_16

			local var_3_19 = arg_2_0
			local var_3_20 = var_3_14

			local function var_3_21()
				local var_5_0 = arg_2_0
				local var_5_1 = var_0.emit

				ActivityMediator = var_3_10003

				var_5_1(var_5_0, var_3_10003.ON_TASK_GO, var_3_5)

				return
			end

			SFX_PANEL = var_2_10020

			var_3_16(var_3_19, var_3_20, var_3_21, var_2_10020)

			onButton = var_3_16

			local var_3_22 = arg_2_0
			local var_3_23 = var_3_15

			local function var_3_24()
				local var_6_0 = arg_2_0
				local var_6_1 = var_0.emit

				ActivityMediator = var_3_10003

				var_6_1(var_6_0, var_3_10003.ON_TASK_SUBMIT, var_3_5)

				return
			end

			SFX_PANEL = var_2_10020

			var_3_16(var_3_22, var_3_23, var_3_24, var_2_10020)
		end

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	var_0_1.super.OnUpdateFlush(arg_7_0)

	setText = var_1

	local var_7_0 = arg_7_0.step_txt

	setColorStr = var_1_10004

	var_1(var_7_0, var_1_10004(arg_7_0.nday, "#6CF7C1FF") .. "/" .. #arg_7_0.taskGroup)

	return
end

return var_0_1
