local var_0_0 = class("SanDiegoPtPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)
	onButton(arg_1_0, arg_1_0.battleBtn, function()
		arg_1_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.bg:Find("help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("littleSanDiego_npc")
		})

		return
	end, SFX_PANEL)

	return
end

return var_0_0
