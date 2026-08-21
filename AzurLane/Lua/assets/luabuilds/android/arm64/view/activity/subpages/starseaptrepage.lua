local var_0_0 = class("StarSeaPtRePage", import(".TemplatePage.NewPtTemplatePage"))

function var_0_0.UpdateAward(arg_1_0, arg_1_1, arg_1_2)
	updateDrop(arg_1_2:Find("icon"), arg_1_0.awardList[arg_1_1 + 1].drop)
	setText(arg_1_2:Find("pt"), arg_1_0.awardList[arg_1_1 + 1].target)

	local var_1_0 = arg_1_1 + 1 <= arg_1_0.ptData:GetLevel()
	local var_1_1 = not var_1_0 and arg_1_1 + 1 <= arg_1_0.ptData:GetMaxAvailableTargetIndex()
	local var_1_2 = not var_1_0 and not var_1_1

	setActive(arg_1_2:Find("got"), var_1_0)
	setActive(arg_1_2:Find("get"), var_1_1)
	setActive(arg_1_2:Find("lock"), not var_1_1)
	setActive(arg_1_2:Find("lock/lock"), var_1_2)
	onButton(arg_1_0, arg_1_2, function()
		arg_1_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	return
end

return var_0_0
