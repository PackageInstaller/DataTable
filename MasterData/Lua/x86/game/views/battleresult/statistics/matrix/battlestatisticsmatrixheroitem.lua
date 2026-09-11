local BattleStatisticsMatrixHeroItem = class("BattleStatisticsMatrixHeroItem", (import("..BattleStatisticsHeroItem")))

function BattleStatisticsMatrixHeroItem:InitUI()
	BattleStatisticsMatrixHeroItem.super.InitUI(self)
	SetActive(self.LVGo_, false)
end

return BattleStatisticsMatrixHeroItem
