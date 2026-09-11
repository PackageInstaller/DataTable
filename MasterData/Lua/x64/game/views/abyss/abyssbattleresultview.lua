BattleScoreResultView = import("game.views.battleResult.score.BattleScoreResultView")

local AbyssBattleResultView = class("AbyssBattleResultView", BattleScoreResultView)

function AbyssBattleResultView:InitUI()
	AbyssBattleResultView.super.InitUI(self)
	SetActive(self.closePanel_, true)
	SetActive(self.onceMoreGo_, false)
	SetActive(self.closeBtnGo_, false)
end

return AbyssBattleResultView
