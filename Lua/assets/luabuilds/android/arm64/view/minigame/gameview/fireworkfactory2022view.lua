local var_0_0 = class("FireworkFactory2022View", import(".FireworkFactoryView"))

function var_0_0.getUIName(arg_1_0)
	return "FireworkFactory2022UI"
end

function var_0_0.didEnter(arg_2_0)
	var_0_0.super.didEnter(arg_2_0)
	onButton(arg_2_0, arg_2_0.btn_help, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_xinnian2022_firework.tip
		})

		return
	end)

	return
end

return var_0_0
