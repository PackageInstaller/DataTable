class = var_0_10000

local var_0_0 = "GloryAwardWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".PtAwardWindow"))

local function var_0_2(arg_1_0)
	local var_1_0 = arg_1_0.taskList

	getProxy = var_1_10002
	TaskProxy = var_1_10003

	local var_1_1 = var_1_10002(var_1_10003)
	local var_1_2 = arg_1_0.UIlist

	var_3.make(var_1_2, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = var_1_0[arg_2_1 + 1]
			local var_2_1 = var_1_1
			local var_2_2 = var_4.getTaskVO(var_2_1, var_2_0)

			setText = var_2_1

			var_2_1(arg_2_2:Find("title/Text"), "PHASE " .. arg_2_1 + 1)

			setText = var_2_1

			var_2_1(arg_2_2:Find("target/title"), var_2_2:getConfig("desc"))

			setText = var_2_1

			var_2_1(arg_2_2:Find("target/Text"), "")

			local var_2_3 = var_2_2:getConfig("award_display")[1]
			local var_2_4 = {
				type = var_2_3[1],
				id = var_2_3[2],
				count = var_2_3[3]
			}

			updateDrop = var_7

			var_7(arg_2_2:Find("award"), var_2_4)

			onButton = var_7

			local var_2_5 = arg_1_0.binder
			local var_2_6 = arg_2_2:Find("award")

			local function var_2_7()
				local var_3_0 = arg_1_0.binder
				local var_3_1 = var_0.emit

				BaseUI = var_3_10002

				var_3_1(var_3_0, var_3_10002.ON_DROP, var_2_4)

				return
			end

			SFX_PANEL = var_11

			var_7(var_2_5, var_2_6, var_2_7, var_11)

			setActive = var_7

			var_7(arg_2_2:Find("award/mask"), var_2_2:isReceive())
		end

		return
	end)

	local var_1_3 = arg_1_0.UIlist

	var_3.align(var_1_3, #var_1_0)

	return
end

function var_0_1.Show(arg_4_0, arg_4_1)
	arg_4_0.taskList = arg_4_1.taskList
	arg_4_0.taskVO = arg_4_1.taskVO

	var_0_2(arg_4_0)

	local var_4_0 = arg_4_0.totalTxt
	local var_4_1 = arg_4_0.taskVO

	var_4_0.text = var_3.getProgress(var_4_1)

	local var_4_2 = arg_4_0.totalTitleTxt

	i18n = var_3

	local var_4_3 = "pt_total_count"

	i18n = var_1_10005
	var_4_2.text = var_3(var_4_3, var_1_10005("pass_times"))
	setActive = var_4_2

	var_4_2(arg_4_0._tf, true)

	return
end

return var_0_1
