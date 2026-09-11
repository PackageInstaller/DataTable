local MultHeartDemonWinHeadItem = class("MultHeartDemonWinHeadItem", (import("game.views.battleResult.newBattleSettlement.module.BattleSettlementHeroHeadModule")))

function MultHeartDemonWinHeadItem:SetHp(arg_1_1)
	self.hpImage_.fillAmount = arg_1_1 / 100
	self.hpTxt_.text = arg_1_1 .. "%"

	SetActive(self.deathGo_, arg_1_1 == 0)
end

return MultHeartDemonWinHeadItem
