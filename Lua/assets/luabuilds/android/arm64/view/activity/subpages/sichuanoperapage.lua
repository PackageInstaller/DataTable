local var_0_0 = class("SiChuanOperaPage", import(".TemplatePage.LoginTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.dayText = arg_1_0._tf:Find("AD/DayText")
	arg_1_0.url = arg_1_0._tf:Find("AD/url")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.url, function()
		Application.OpenURL(arg_2_0.activity:getConfig("config_client"))

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_4_0)
	var_0_0.super.OnUpdateFlush(arg_4_0)
	setText(arg_4_0.dayText, string.format("%02d", arg_4_0.nday))

	return
end

return var_0_0
