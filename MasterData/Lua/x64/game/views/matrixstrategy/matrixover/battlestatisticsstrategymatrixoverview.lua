local BattleStatisticsStrategyMatrixOverView = class("BattleStatisticsStrategyMatrixOverView", (import("game.views.battleResult.statistics.matrix.over.BattleStatisticsMatrixOverView")))

function BattleStatisticsStrategyMatrixOverView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	BattleStatisticsStrategyMatrixOverView.super.OnEnter(self)
end

function BattleStatisticsStrategyMatrixOverView:GetGameState()
	return StrategyMatrixData:GetGameState(self.matrix_activity_id)
end

function BattleStatisticsStrategyMatrixOverView:GetCurrentClearTime()
	return StrategyMatrixData:GetCurrentClearTime(self.matrix_activity_id)
end

function BattleStatisticsStrategyMatrixOverView:GetMatrixHeroTeam()
	return StrategyMatrixData:GetMatrixHeroTeam(self.matrix_activity_id)
end

function BattleStatisticsStrategyMatrixOverView:GetHeroData(arg_5_1)
	return StrategyMatrixData:GetHeroDataNew(arg_5_1)
end

function BattleStatisticsStrategyMatrixOverView:GetHeroSkin(arg_6_1)
	return StrategyMatrixData:GetHeroSkin(self.matrix_activity_id, arg_6_1)
end

return BattleStatisticsStrategyMatrixOverView
