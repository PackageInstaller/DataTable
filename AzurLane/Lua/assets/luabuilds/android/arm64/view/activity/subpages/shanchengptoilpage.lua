local var_0_0 = class("ShanchengPTOilPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)

	var_0_0.scrolltext = arg_1_0.awardTF:Find("name")

	return
end

function var_0_0.OnUpdateFlush(arg_2_0)
	var_0_0.super.OnUpdateFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.battleBtn, function()
		arg_2_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	arg_2_0:SetAwardName()

	local var_2_0, var_2_1, var_2_2 = arg_2_0.ptData:GetResProgress()
	local var_2_3 = var_2_2 >= 1 and setColorStr(var_2_0, "#A2A2A2FF") or var_2_0

	setText(arg_2_0.progress, var_2_3 .. "/" .. var_2_1)

	return
end

function var_0_0.SetAwardName(arg_4_0)
	local var_4_0 = arg_4_0.ptData:GetAward()

	if Item.getConfigData(var_4_0.id) then
		changeToScrollText(var_0_0.scrolltext, var_4_0:getName())
	else
		setActive(arg_4_0.awardTF:Find("name"), false)
	end

	return
end

return var_0_0
