local FireworkFactory2022View = class("FireworkFactory2022View", import(".FireworkFactoryView"))

function FireworkFactory2022View:getUIName()
	return "FireworkFactory2022UI"
end

function FireworkFactory2022View:didEnter()
	FireworkFactory2022View.super.didEnter(self)
	onButton(self, self.btn_help, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_xinnian2022_firework.tip
		})

		return
	end)

	return
end

return FireworkFactory2022View
