class = var_0_10000

local var_0_0 = "I56SkinPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	local var_1_0 = arg_1_0.uilist

	var_1.make(var_1_0, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_2_1 + 1
			local var_2_1 = arg_2_2:Find("item")
			local var_2_2 = arg_1_0.taskGroup[arg_1_0.nday][var_2_0]
			local var_2_3 = arg_1_0.taskProxy
			local var_2_5

			if not var_6.getTaskById(var_2_3, var_2_2) then
				local var_2_4 = arg_1_0.taskProxy

				var_2_5 = var_6.getFinishTaskById(var_2_4, var_2_2)
			end

			assert = var_7

			var_7(var_2_5, "without this task by id: " .. var_2_2)

			local var_2_6 = var_2_5:getConfig("award_display")[1]
			local var_2_7 = {
				type = var_2_6[1],
				id = var_2_6[2],
				count = var_2_6[3]
			}

			updateDrop = var_9

			var_9(var_2_1, var_2_7)

			onButton = var_9

			local var_2_8 = arg_1_0
			local var_2_9 = var_2_1

			local function var_2_10()
				local var_3_0 = arg_1_0
				local var_3_1 = var_0.emit

				BaseUI = var_3_10003

				var_3_1(var_3_0, var_3_10003.ON_DROP, var_2_7)

				return
			end

			SFX_PANEL = var_2_10014

			var_9(var_2_8, var_2_9, var_2_10, var_2_10014)

			local var_2_11 = var_2_5:getProgress()
			local var_2_12 = var_2_5:getConfig("target_num")
			local var_2_13 = var_2_5:getConfig("desc")
			local var_2_14 = "(" .. var_2_11 .. "/" .. var_2_12 .. ")"

			setText = var_13

			var_13(arg_2_2:Find("description"), var_2_13 .. " " .. var_2_14)

			setSlider = var_13

			var_13(arg_2_2:Find("progress"), 0, var_2_12, var_2_11)

			local var_2_15 = arg_2_2:Find("go_btn")
			local var_2_16 = arg_2_2:Find("get_btn")
			local var_2_17 = arg_2_2
			local var_2_18 = arg_2_2.Find(var_2_17, "got_btn")
			local var_2_19 = var_2_5:getTaskStatus()

			setActive = var_2_17

			var_2_17(var_2_15, var_2_19 == 0)

			setActive = var_2_17

			var_2_17(var_2_16, var_2_19 == 1)

			setActive = var_2_17

			var_2_17(var_2_18, var_2_19 == 2)

			onButton = var_2_17

			local var_2_20 = arg_1_0
			local var_2_21 = var_2_15

			local function var_2_22()
				local var_4_0 = arg_1_0
				local var_4_1 = var_0.emit

				ActivityMediator = var_3_10003

				var_4_1(var_4_0, var_3_10003.ON_TASK_GO, var_2_5)

				return
			end

			SFX_PANEL = var_2_10022

			var_2_17(var_2_20, var_2_21, var_2_22, var_2_10022)

			onButton = var_2_17

			local var_2_23 = arg_1_0
			local var_2_24 = var_2_16

			local function var_2_25()
				local var_5_0 = arg_1_0
				local var_5_1 = var_0.emit

				ActivityMediator = var_3_10003

				var_5_1(var_5_0, var_3_10003.ON_TASK_SUBMIT, var_2_5)

				return
			end

			SFX_PANEL = var_2_10022

			var_2_17(var_2_23, var_2_24, var_2_25, var_2_10022)
		end

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	var_0_1.super.OnUpdateFlush(arg_6_0)

	setText = var_1

	var_1(arg_6_0.dayTF, arg_6_0.nday .. " " .. #arg_6_0.taskGroup)

	eachChild = var_1

	var_1(arg_6_0.items, function(arg_7_0)
		local var_7_0 = arg_7_0
		local var_7_1 = arg_7_0.Find(var_7_0, "get_btn")
		local var_7_2 = arg_7_0
		local var_7_3 = arg_7_0.Find(var_7_2, "got_btn")

		isActive = var_7_0

		local var_7_4 = var_7_0(var_7_3)

		setButtonEnabled = var_7_2

		var_7_2(var_7_3, false)

		setButtonEnabled = var_7_2

		var_7_2(var_7_1, not var_7_4)

		if var_7_4 then
			setActive = var_7_2

			var_7_2(var_7_1, true)
		end

		return
	end)

	return
end

return var_0_1
