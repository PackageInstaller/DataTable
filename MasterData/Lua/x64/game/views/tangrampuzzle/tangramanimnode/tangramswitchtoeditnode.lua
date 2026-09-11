local TangramSwitchToEditNode = class("TangramSwitchToEditNode", (import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")))

function TangramSwitchToEditNode:RunFunc()
	self.manager_:EnterEdit(self.blackboard_.newEditIndex_)
	self.root_:SetNodeRunComplete()
end

return TangramSwitchToEditNode
