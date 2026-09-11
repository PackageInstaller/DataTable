local ActivityMatrixTreasureMiniView = class("ActivityMatrixTreasureMiniView", MatrixTreasureMiniView)

function ActivityMatrixTreasureMiniView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	ActivityMatrixTreasureMiniView.super.OnEnter(self)
end

function ActivityMatrixTreasureMiniView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, self.matrix_activity_id)
end

function ActivityMatrixTreasureMiniView:GetArtifactList()
	return ActivityMatrixData:GetArtifactList(self.matrix_activity_id)
end

return ActivityMatrixTreasureMiniView
