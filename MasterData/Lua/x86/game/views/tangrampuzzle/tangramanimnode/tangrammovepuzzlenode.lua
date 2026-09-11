local TangramMovePuzzleNode = class("TangramMovePuzzleNode", (import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")))

function TangramMovePuzzleNode:RunFunc()
	self.updatingPuzzleCount_ = 0

	self:UpdatePuzzle(self.blackboard_.moveOriginPuzzleIndex_, self.manager_.puzzleItemList_[self.blackboard_.moveTargetPuzzleIndex_].transform_.position)
	self:UpdatePuzzle(self.blackboard_.moveTargetPuzzleIndex_, self.manager_.puzzleItemList_[self.blackboard_.moveOriginPuzzleIndex_].transform_.position)
end

function TangramMovePuzzleNode:UpdatePuzzle(arg_2_1, arg_2_2)
	self.updatingPuzzleCount_ = self.updatingPuzzleCount_ + 1

	self.manager_.puzzleItemList_[arg_2_1]:SetTransParent(self.manager_.editPanelTrans_)
	self.manager_.puzzleItemList_[arg_2_1]:UpdatePosition(arg_2_2, function()
		self.manager_:UpdatePuzzleData(arg_2_1)

		self.updatingPuzzleCount_ = self.updatingPuzzleCount_ - 1

		if self.updatingPuzzleCount_ == 0 then
			self.root_:SetNodeRunComplete()
		end
	end)
end

return TangramMovePuzzleNode
