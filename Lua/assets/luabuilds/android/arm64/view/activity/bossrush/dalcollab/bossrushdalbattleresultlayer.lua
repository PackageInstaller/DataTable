local var_0_0 = class("BossRushDALBattleResultLayer", import("..BossRushBattleResultLayer"))

function var_0_0.didEnter(arg_1_0)
	var_0_0.super.didEnter(arg_1_0)
	removeOnButton(arg_1_0.rightBottomPanel:Find("confirmBtn"))
	onButton(arg_1_0, arg_1_0.rightBottomPanel:Find("confirmBtn"), function()
		arg_1_0:emit(BossRushDALBattleResultMediator.ON_SETTLE)

		return
	end, SFX_PANEL)

	return
end

return var_0_0
