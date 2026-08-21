local var_0_0 = class("TestView", import("..BaseMiniGameView"))

function var_0_0.getUIName(arg_1_0)
	return "MailBoxUI2"
end

function var_0_0.init(arg_2_0)
	print("初始化")

	arg_2_0._closeBtn = arg_2_0._tf:Find("main/top/btnBack")
	arg_2_0._btn1 = arg_2_0._tf:Find("main/delete_all_button")
	arg_2_0._btn2 = arg_2_0._tf:Find("main/get_all_button")

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._closeBtn, function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end)
	onButton(arg_3_0, arg_3_0._btn1, function()
		arg_3_0:SendSuccess(1)

		return
	end)
	onButton(arg_3_0, arg_3_0._btn2, function()
		arg_3_0:SendFailure(1)

		return
	end)

	return
end

return var_0_0
