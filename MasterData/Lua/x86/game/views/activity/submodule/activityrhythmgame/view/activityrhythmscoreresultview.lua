NewBattleScoreResultView = import("game.views.battleResult.score.NewBattleScoreResultView")

local ActivityRhythmScoreResultView = class("ActivityRhythmScoreResultView", NewBattleScoreResultView)

function ActivityRhythmScoreResultView:PostRenderView()
	self.btnController:SetSelectedState("nobtn")
	SetActive(self.statisticsBtn_.gameObject, false)
end

function ActivityRhythmScoreResultView:OnAddListner()
	SetActive(self.emptyMaskBtn_.gameObject, true)
	self:AddBtnListener(self.emptyMaskBtn_, nil, function()
		BattleInstance.QuitBattle(self.stageData)
	end)
end

return ActivityRhythmScoreResultView
