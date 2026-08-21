local var_0_0 = class("SettingsServicePanle", import(".SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "SettingsServiceCH"
end

function var_0_0.GetTitle(arg_2_0)
	return "客服"
end

function var_0_0.GetTitleEn(arg_3_0)
	return "/ Service"
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.serviceBtn = findTF(arg_4_0._tf, "delete")

	onButton(arg_4_0, arg_4_0.serviceBtn, function()
		pg.SdkMgr.GetInstance():Service()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdate(arg_6_0)
	return
end

return var_0_0
