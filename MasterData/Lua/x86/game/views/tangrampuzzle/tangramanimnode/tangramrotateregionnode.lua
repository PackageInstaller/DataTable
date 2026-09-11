local TangramRotateRegionNode = class("TangramRotateRegionNode", (import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")))

function TangramRotateRegionNode:RunFunc()
	local var_1_0 = self.blackboard_.rotateRegionID_

	if self.blackboard_.rotateTimes_ == 0 then
		self.root_:SetNodeRunComplete()

		return
	end

	local var_1_1 = self.manager_.regionItemList_[self.blackboard_.rotateRegionID_]

	self.manager_.regionItemList_[self.blackboard_.rotateRegionID_]:SetTransParent(self.manager_.editPanelTrans_)
	var_1_1:Rotate(TangramPuzzleTools.GetRegionRotateAngle(self.manager_.activityID_, self.blackboard_.rotateRegionID_) * self.blackboard_.rotateTimes_, function()
		var_1_1:RecoverTrans()

		for iter_2_0, iter_2_1 in ipairs(TangramPuzzleTools.GetPuzzleGlobalIndexListByRegionID(self.manager_.activityID_)[var_1_0]) do
			self.manager_:UpdatePuzzleData(iter_2_1)
		end

		self.root_:SetNodeRunComplete()
	end)
	manager.audio:PlayEffect("minigame_activity_2_5", "minigame_activity_2_5_Puzzle_rotate", "")
end

return TangramRotateRegionNode
