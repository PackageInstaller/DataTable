local BossRushDALBattleResultLayer = class("BossRushDALBattleResultLayer", import("..BossRushBattleResultLayer"))

function BossRushDALBattleResultLayer:didEnter()
	BossRushDALBattleResultLayer.super.didEnter(self)
	removeOnButton(self.rightBottomPanel:Find("confirmBtn"))
	onButton(self, self.rightBottomPanel:Find("confirmBtn"), function()
		self:emit(BossRushDALBattleResultMediator.ON_SETTLE)

		return
	end, SFX_PANEL)

	return
end

return BossRushDALBattleResultLayer
