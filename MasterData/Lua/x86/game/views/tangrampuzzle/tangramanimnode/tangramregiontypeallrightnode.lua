local TangramRegionTypeAllRightNode = class("TangramRegionTypeAllRightNode", (import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")))

function TangramRegionTypeAllRightNode:RunFunc()
	local var_1_0 = self.blackboard_.allRightRegionTypeList_

	for iter_1_0 = 1, #self.blackboard_.allRightRegionTypeList_ do
		local var_1_1 = self.manager_.regionContentItemList_[self.blackboard_.allRightRegionTypeList_[iter_1_0]]

		self.manager_.regionContentItemList_[self.blackboard_.allRightRegionTypeList_[iter_1_0]]:PlayCompletedAnim(function()
			var_1_1:RefreshStatus()

			if iter_1_0 == #var_1_0 then
				manager.audio:PlayEffect("minigame_activity_2_5", "minigame_activity_2_5_Puzzle_complete2", "")
				self.root_:SetNodeRunComplete()
			end
		end)
	end
end

return TangramRegionTypeAllRightNode
