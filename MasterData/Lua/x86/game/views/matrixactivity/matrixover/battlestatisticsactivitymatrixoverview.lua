local BattleStatisticsActivityMatrixOverView = class("BattleStatisticsActivityMatrixOverView", (import("game.views.battleResult.statistics.matrix.over.BattleStatisticsMatrixOverView")))

function BattleStatisticsActivityMatrixOverView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	BattleStatisticsActivityMatrixOverView.super.OnEnter(self)
end

function BattleStatisticsActivityMatrixOverView:GetGameState()
	return ActivityMatrixData:GetGameState(self.matrix_activity_id)
end

function BattleStatisticsActivityMatrixOverView:GetCurrentClearTime()
	return ActivityMatrixData:GetCurrentClearTime(self.matrix_activity_id)
end

function BattleStatisticsActivityMatrixOverView:GetMatrixHeroTeam()
	return ActivityMatrixData:GetMatrixHeroTeam(self.matrix_activity_id)
end

function BattleStatisticsActivityMatrixOverView:GetHeroData(arg_5_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_5_1)
end

function BattleStatisticsActivityMatrixOverView:GetHeroSkin(arg_6_1)
	return ActivityMatrixData:GetHeroSkin(self.matrix_activity_id, arg_6_1)
end

return BattleStatisticsActivityMatrixOverView
