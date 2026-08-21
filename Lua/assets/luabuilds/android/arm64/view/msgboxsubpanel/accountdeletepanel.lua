local var_0_0 = class("AccountDeletePanel", import(".MsgboxSubPanel"))

var_0_0.ConfigData = {}

function var_0_0.getUIName(arg_1_0)
	return "AccountDeleteBox"
end

function var_0_0.UpdateView(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.onYes

	print("onYesFunc", tostring(arg_2_1.onYes))

	if arg_2_1.onYes then
		function arg_2_1.onYes()
			var_2_0((getInputText(arg_2_0.inputField)))

			return
		end
	end

	arg_2_0:PreRefresh(arg_2_1)

	rtf(arg_2_0.viewParent._window).sizeDelta = Vector2.New(1000, 638)
	arg_2_0.inputField = arg_2_0._tf:Find("InputField")

	setText(arg_2_0._tf:Find("Title"), (i18n("box_account_del_input", (i18n("box_account_del_target")))))
	setText(arg_2_0._tf:Find("InputField/Placeholder"), i18n("box_account_del_click"))
	arg_2_0:PostRefresh(arg_2_1)

	return
end

return var_0_0
