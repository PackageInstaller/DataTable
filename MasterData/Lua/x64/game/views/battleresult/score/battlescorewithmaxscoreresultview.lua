NewBattleScoreResultView = import("game.views.battleResult.score.NewBattleScoreResultView")

local BattleScoreWithMaxScoreResultView = class("BattleScoreWithMaxScoreResultView", NewBattleScoreResultView)

function BattleScoreWithMaxScoreResultView:PostRenderView()
	self.btnController:SetSelectedState("nobtn")
	SetActive(self.statisticsBtn_.gameObject, false)
end

function BattleScoreWithMaxScoreResultView:OnAddListner()
	SetActive(self.emptyMaskBtn_.gameObject, true)
	self:AddBtnListener(self.emptyMaskBtn_, nil, function()
		BattleInstance.QuitBattle(self.stageData)
	end)
end

return BattleScoreWithMaxScoreResultView
