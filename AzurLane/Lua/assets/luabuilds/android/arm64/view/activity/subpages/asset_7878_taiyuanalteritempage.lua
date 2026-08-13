class = var_0_10000

local var_0_0 = "TaiyuanAlterItemPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SkinTemplatePage"))

function var_0_1.UpdateTask(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1 + 1
	local var_1_1 = arg_1_2:Find("item")
	local var_1_2 = arg_1_0.taskGroup[arg_1_0.nday][var_1_0]
	local var_1_3 = arg_1_0.taskProxy
	local var_1_4

	if not var_6.getTaskById(var_1_3, var_1_2) then
		var_1_3 = arg_1_0.taskProxy
		var_1_4 = var_6.getFinishTaskById(var_1_3, var_1_2)
	end

	assert = var_7

	var_7(var_1_4, "without this task by id: " .. var_1_2)

	Drop = var_7

	local var_1_5 = var_7.Create(var_1_4:getConfig("award_display")[1])

	updateDrop = var_1_3

	var_1_3(var_1_1, var_1_5)

	onButton = var_1_3

	local var_1_6 = arg_1_0
	local var_1_7 = var_1_1

	local function var_1_8()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		BaseUI = var_2_10003

		var_2_1(var_2_0, var_2_10003.ON_DROP, var_1_5)

		return
	end

	SFX_PANEL = var_1_10013

	var_1_3(var_1_6, var_1_7, var_1_8, var_1_10013)

	local var_1_9 = var_1_4
	local var_1_10 = var_1_4.getProgress(var_1_9)
	local var_1_11 = var_1_4:getConfig("target_num")

	setText = var_1_9

	var_1_9(arg_1_2:Find("description"), var_1_4:getConfig("desc"))

	local var_1_12 = arg_1_0
	local var_1_13, var_1_14 = arg_1_0.GetProgressColor(var_1_12)

	if var_1_13 then
		setColorStr = var_1_12

		local var_1_15

		if not var_1_12(var_1_10, var_1_13) then
			::label_1_0::

			var_1_15 = var_1_10
		end

		if var_1_14 then
			setColorStr = var_1_12

			local var_1_16

			if not var_1_12("/" .. var_1_11, var_1_14) then
				::label_1_1::

				var_1_16 = "/" .. var_1_11
			end

			setText = var_1_12

			var_1_12(arg_1_2:Find("progressText"), "<color=#E95545>" .. var_1_15 .. "</color><color=#6D8189>" .. var_1_16 .. "</color>")

			setSlider = var_1_12

			var_1_12(arg_1_2:Find("progress"), 0, var_1_11, var_1_10)

			local var_1_17 = arg_1_2:Find("go_btn")
			local var_1_18 = arg_1_2:Find("get_btn")
			local var_1_19 = arg_1_2
			local var_1_20 = arg_1_2.Find(var_1_19, "got_btn")
			local var_1_21 = var_1_4:getTaskStatus()

			setActive = var_1_19

			var_1_19(var_1_17, var_1_21 == 0)

			setActive = var_1_19

			var_1_19(var_1_18, var_1_21 == 1)

			setActive = var_1_19

			var_1_19(var_1_20, var_1_21 == 2)

			onButton = var_1_19

			local var_1_22 = arg_1_0
			local var_1_23 = var_1_17

			local function var_1_24()
				local var_3_0 = arg_1_0
				local var_3_1 = var_0.emit

				ActivityMediator = var_2_10003

				var_3_1(var_3_0, var_2_10003.ON_TASK_GO, var_1_4)

				return
			end

			SFX_PANEL = var_1_10021

			var_1_19(var_1_22, var_1_23, var_1_24, var_1_10021)

			onButton = var_1_19

			local var_1_25 = arg_1_0
			local var_1_26 = var_1_18

			local function var_1_27()
				local var_4_0 = arg_1_0
				local var_4_1 = var_0.emit

				ActivityMediator = var_2_10003

				var_4_1(var_4_0, var_2_10003.ON_TASK_SUBMIT, var_1_4)

				return
			end

			SFX_PANEL = var_1_10021

			var_1_19(var_1_25, var_1_26, var_1_27, var_1_10021)

			return
		end
	end
end

return var_0_1
