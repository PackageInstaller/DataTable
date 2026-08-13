class = var_0_10000

local var_0_0 = "IslandMailScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.main.Mail.MailScene"))

function var_0_1.didEnter(arg_1_0)
	var_0_1.super.didEnter(arg_1_0)

	onNextTick = var_1

	var_1(function()
		local var_2_0 = arg_1_0

		var_0.ExtraHandle(var_2_0)

		return
	end)

	return
end

function var_0_1.ExtraHandle(arg_3_0)
	setActive = var_1_10001

	local var_3_0 = arg_3_0._tf

	var_1_10001(var_2.Find(var_3_0, "adapt/top/res"), false)

	setActive = var_1_10001

	local var_3_1 = arg_3_0._tf

	var_1_10001(var_2.Find(var_3_1, "adapt/top/option"), false)

	setActive = var_1_10001

	local var_3_2 = arg_3_0._tf

	var_1_10001(var_2.Find(var_3_2, "adapt/left_length/frame/tagRoot/store"), false)

	setActive = var_1_10001

	local var_3_3 = arg_3_0._tf

	var_1_10001(var_2.Find(var_3_3, "adapt/left_length/frame/tagRoot/collection"), false)

	return
end

function var_0_1.closeView(arg_4_0)
	arg_4_0.contextData.onClose()

	return
end

function var_0_1.onBackPressed(arg_5_0)
	return
end

return var_0_1
