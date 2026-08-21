local var_0_0 = class("SaratogaPermanentSkinPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	var_0_0.super.OnUpdateFlush(arg_1_0)
	onButton(arg_1_0, arg_1_0.battleBtn, function()
		arg_1_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	local var_1_0, var_1_1, var_1_2 = arg_1_0.ptData:GetResProgress()

	setText(arg_1_0.progress, setColorStr(var_1_0, "#FF8DB5") .. "/" .. var_1_1)
	setText(arg_1_0.bg:Find("Text"), i18n("activity_kill"))

	return
end

return var_0_0
