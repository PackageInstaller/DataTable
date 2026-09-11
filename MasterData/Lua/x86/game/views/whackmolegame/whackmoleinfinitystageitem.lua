local WhackMoleInfinityStageItem = class("WhackMoleInfinityStageItem", (import("game.views.whackMoleGame.WhackMoleStageItem")))

function WhackMoleInfinityStageItem:RefreshState()
	local var_1_0 = WhackMoleData:GetStageScore(self.whackMoleID_)

	if WhackMoleTools.GetStageIsLock(self.whackMoleID_) then
		self.state_ = WhackMoleConst.STAGE_STATE.LOCK
	elseif var_1_0 > 0 then
		self.state_ = WhackMoleConst.STAGE_STATE.UNLOCK
		self.score_.text = var_1_0
	else
		self.state_ = WhackMoleConst.STAGE_STATE.UNLOCK
		self.score_.text = GetTips("ACTIVITY_ZUMA_NO_DATA")
	end

	self.stateController_:SetSelectedState(self.state_)
end

return WhackMoleInfinityStageItem
