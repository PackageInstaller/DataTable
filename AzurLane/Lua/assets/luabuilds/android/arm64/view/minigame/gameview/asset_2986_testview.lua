class = var_0_10000

local var_0_0 = "TestView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))

function var_0_1.getUIName(arg_1_0)
	return "MailBoxUI2"
end

function var_0_1.init(arg_2_0)
	print = var_1_10001

	var_1_10001("初始化")

	local var_2_0 = arg_2_0._tf

	arg_2_0._closeBtn = var_1.Find(var_2_0, "main/top/btnBack")

	local var_2_1 = arg_2_0._tf

	arg_2_0._btn1 = var_1.Find(var_2_1, "main/delete_all_button")

	local var_2_2 = arg_2_0._tf

	arg_2_0._btn2 = var_1.Find(var_2_2, "main/get_all_button")

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0._closeBtn, function()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_BACK)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0._btn1, function()
		local var_5_0 = arg_3_0

		var_0.SendSuccess(var_5_0, 1)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0._btn2, function()
		local var_6_0 = arg_3_0

		var_0.SendFailure(var_6_0, 1)

		return
	end)

	return
end

return var_0_1
