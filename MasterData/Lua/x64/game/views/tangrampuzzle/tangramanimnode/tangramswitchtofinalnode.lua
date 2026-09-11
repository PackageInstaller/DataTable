local TangramSwitchToFinalNode = class("TangramSwitchToFinalNode", (import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")))

function TangramSwitchToFinalNode:RunFunc()
	ShowTips("ACTIVITY_PUZZLE_FINISH")
	self.manager_:SwitchToFinal()
	self.root_:SetNodeRunComplete()
end

return TangramSwitchToFinalNode
