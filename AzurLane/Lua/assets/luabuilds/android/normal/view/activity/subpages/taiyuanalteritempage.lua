class = var_0_10000

local var_0_0 = "TaiyuanAlterItemPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

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

	assert = var_1_3

	var_1_3(var_1_4, "without this task by id: " .. var_1_2)

	Drop = var_1_3

	local var_1_5 = var_1_3.Create(var_1_4:getConfig("award_display")[1])

	updateDrop = var_8

	var_8(var_1_1, var_1_5)

	onButton = var_8

	local var_1_6 = arg_1_0
	local var_1_7 = var_1_1

	local function var_1_8()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		BaseUI = var_2_10002

		var_2_1(var_2_0, var_2_10002.ON_DROP, var_1_5)

		return
	end

	SFX_PANEL = var_1_10012

	var_8(var_1_6, var_1_7, var_1_8, var_1_10012)

	local var_1_9 = var_1_4:getProgress()
	local var_1_10 = var_1_4
	local var_1_11 = var_1_4.getConfig(var_1_10, "target_num")

	setText = var_1_10

	var_1_10(arg_1_2:Find("description"), var_1_4:getConfig("desc"))

	local var_1_12, var_1_13 = arg_1_0:GetProgressColor()

	if var_1_12 then
		setColorStr = var_12

		local var_1_14

		if not var_12(var_1_9, var_1_12) then
			::label_1_0::

			var_1_14 = var_1_9
		end

		if var_1_13 then
			setColorStr = var_12

			local var_1_15

			if not var_12("/" .. var_1_11, var_1_13) then
				::label_1_1::

				var_1_15 = "/" .. var_1_11
			end

			setText = var_12

			var_12(arg_1_2:Find("progressText"), "<color=#E95545>" .. var_1_14 .. "</color><color=#6D8189>" .. var_1_15 .. "</color>")

			setSlider = var_12

			var_12(arg_1_2:Find("progress"), 0, var_1_11, var_1_9)

			local var_1_16 = arg_1_2:Find("go_btn")
			local var_1_17 = arg_1_2:Find("get_btn")
			local var_1_18 = arg_1_2:Find("got_btn")
			local var_1_19 = var_1_4
			local var_1_20 = var_1_4.getTaskStatus(var_1_19)

			setActive = var_1_19

			var_1_19(var_1_16, var_1_20 == 0)

			setActive = var_1_19

			var_1_19(var_1_17, var_1_20 == 1)

			setActive = var_1_19

			var_1_19(var_1_18, var_1_20 == 2)

			onButton = var_1_19

			local var_1_21 = arg_1_0
			local var_1_22 = var_1_16

			local function var_1_23()
				local var_3_0 = arg_1_0
				local var_3_1 = var_0.emit

				ActivityMediator = var_2_10002

				var_3_1(var_3_0, var_2_10002.ON_TASK_GO, var_1_4)

				return
			end

			SFX_PANEL = var_1_10020

			var_1_19(var_1_21, var_1_22, var_1_23, var_1_10020)

			onButton = var_1_19

			local var_1_24 = arg_1_0
			local var_1_25 = var_1_17

			local function var_1_26()
				local var_4_0 = arg_1_0
				local var_4_1 = var_0.emit

				ActivityMediator = var_2_10002

				var_4_1(var_4_0, var_2_10002.ON_TASK_SUBMIT, var_1_4)

				return
			end

			SFX_PANEL = var_1_10020

			var_1_19(var_1_24, var_1_25, var_1_26, var_1_10020)

			return
		end
	end
end

return var_0_1
