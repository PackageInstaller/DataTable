class = var_0_10000

local var_0_0 = "AccountDeletePanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MsgboxSubPanel"))

var_0_1.ConfigData = {}

function var_0_1.getUIName(arg_1_0)
	return "AccountDeleteBox"
end

function var_0_1.UpdateView(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.onYes

	print = var_1_10003

	local var_2_1 = "onYesFunc"

	tostring = var_1_10005

	var_1_10003(var_2_1, var_1_10005(var_2_0))

	if var_2_0 then
		function arg_2_1.onYes()
			getInputText = var_2_10000

			local var_3_0 = var_2_10000(arg_2_0.inputField)

			var_2_0(var_3_0)

			return
		end
	end

	arg_2_0:PreRefresh(arg_2_1)

	rtf = var_3

	local var_2_2 = var_3(arg_2_0.viewParent._window)

	Vector2 = var_4
	var_2_2.sizeDelta = var_4.New(1000, 638)

	local var_2_3 = arg_2_0._tf

	arg_2_0.inputField = var_3.Find(var_2_3, "InputField")

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_3.Find(var_2_4, "Title")
	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_4.Find(var_2_6, "InputField/Placeholder")

	i18n = var_2_6

	local var_2_8 = var_2_6("box_account_del_target")

	i18n = var_6

	local var_2_9 = var_6("box_account_del_input", var_2_8)

	setText = var_7

	var_7(var_2_5, var_2_9)

	setText = var_7

	local var_2_10 = var_2_7

	i18n = var_9

	var_7(var_2_10, var_9("box_account_del_click"))
	arg_2_0:PostRefresh(arg_2_1)

	return
end

return var_0_1
