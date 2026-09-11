local TangramRegionReceiveNode = class("TangramRegionReceiveNode", (import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")))

function TangramRegionReceiveNode:RunFunc()
	if self.blackboard_.isOnlyRegionRewardPop_ == true then
		self:RunCompleteFunc()

		return
	end

	local var_1_0 = self.blackboard_.receivedRegionList_

	manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_puzzle_reward", "")

	for iter_1_0 = 1, #var_1_0 do
		if iter_1_0 == #var_1_0 then
			self.manager_.regionItemList_[var_1_0[iter_1_0]]:PlayRewardAnim(function()
				self:RunCompleteFunc()
			end)
		else
			self.manager_.regionItemList_[var_1_0[iter_1_0]]:PlayRewardAnim()
		end
	end
end

function TangramRegionReceiveNode:RunCompleteFunc()
	showRewardUI(self.blackboard_.rewardList_, nil, function()
		self.root_:SetNodeRunComplete()
	end)
end

return TangramRegionReceiveNode
