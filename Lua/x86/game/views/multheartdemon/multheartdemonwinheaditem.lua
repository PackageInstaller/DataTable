local var_0_0 = import("game.views.battleResult.newBattleSettlement.module.BattleSettlementHeroHeadModule")
local var_0_1 = class("MultHeartDemonWinHeadItem", var_0_0)

function var_0_1.SetHp(arg_1_0, arg_1_1)
	arg_1_0.hpImage_.fillAmount = arg_1_1 / 100
	arg_1_0.hpTxt_.text = arg_1_1 .. "%"

	SetActive(arg_1_0.deathGo_, arg_1_1 == 0)
end

return var_0_1
