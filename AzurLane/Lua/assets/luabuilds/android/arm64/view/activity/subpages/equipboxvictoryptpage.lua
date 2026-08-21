local var_0_0 = class("EquipBoxVictoryPtPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)
	onButton(arg_1_0, arg_1_0.battleBtn, function()
		arg_1_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	var_0_0.super.OnUpdateFlush(arg_3_0)

	local var_3_0, var_3_1, var_3_2 = arg_3_0.ptData:GetResProgress()

	setText(arg_3_0.progress, setColorStr(var_3_0, "#bff192") .. "/" .. var_3_1)

	return
end

return var_0_0
