local BattleStatisticsMatrixView = class("BattleStatisticsMatrixView", (import("..BattleStatisticsView")))

function BattleStatisticsMatrixView:OnEnter()
	self.stageData = self.params_.stageData

	local var_1_0 = self.stageData:GetHeroTeam()

	self.statisticsHeroItem_ = {}

	local var_1_1, var_1_2, var_1_3 = BattleTools.GetBattleStatisticsData()

	for iter_1_0 = 1, 3 do
		self.statisticsHeroItem_[iter_1_0] = self:GetStatisticsItem().New(self.heroItem_[iter_1_0], (var_1_0[iter_1_0] and var_1_0[iter_1_0] ~= 0 or nil) and {
			level = 1,
			id = var_1_0[iter_1_0],
			skin_id = MatrixData:GetHeroSkin(var_1_0[iter_1_0])
		}, var_1_2, var_1_3, var_1_1[1])
	end

	self:SetLevelTitle()
	self:RefreshTimeText()
end

function BattleStatisticsMatrixView:GetStatisticsItem()
	return BattleStatisticsMatrixHeroItem
end

function BattleStatisticsMatrixView:SetLevelTitle(arg_3_1)
	local var_3_0 = self.stageData:GetStageId()

	self.lvText_.text = ""
	self.stareText_.text = ""

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.titleTransform_)
end

return BattleStatisticsMatrixView
