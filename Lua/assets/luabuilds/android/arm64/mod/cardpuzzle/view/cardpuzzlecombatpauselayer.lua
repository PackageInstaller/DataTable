local var_0_0 = class("CardPuzzleCombatPauseLayer", BaseUI)

function var_0_0.getUIName(arg_1_0)
	return "CardTowerCombatPause"
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)
	onButton(arg_2_0, arg_2_0._tf:Find("btn_quit"), function()
		arg_2_0:emit(CardPuzzleCombatPauseMediator.QUIT_COMBAT, {})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0._tf:Find("btn_resume"), function()
		arg_2_0:OnBackward()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnBackward(arg_5_0)
	arg_5_0:emit(CardPuzzleCombatPauseMediator.RESUME_COMBAT)
	arg_5_0:closeView()

	return true
end

function var_0_0.willExit(arg_6_0)
	return
end

return var_0_0
