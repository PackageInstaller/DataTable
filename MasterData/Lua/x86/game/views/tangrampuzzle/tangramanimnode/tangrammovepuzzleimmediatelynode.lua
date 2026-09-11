local TangramMovePuzzleImmediatelyNode = class("TangramMovePuzzleImmediatelyNode", (import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")))

function TangramMovePuzzleImmediatelyNode:RunFunc()
	self.manager_:UpdatePuzzleData(self.blackboard_.moveOriginPuzzleIndex_)
	self.manager_:UpdatePuzzleData(self.blackboard_.moveTargetPuzzleIndex_)
	manager.audio:PlayEffect("minigame_activity_2_5", "minigame_activity_2_5_Puzzle_button", "")
	self.root_:SetNodeRunComplete()
end

return TangramMovePuzzleImmediatelyNode
