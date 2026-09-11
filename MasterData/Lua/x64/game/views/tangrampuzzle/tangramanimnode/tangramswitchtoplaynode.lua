local TangramSwitchToPlayNode = class("TangramSwitchToPlayNode", (import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")))

function TangramSwitchToPlayNode:RunFunc()
	self.manager_:SwitchToPlay()
	self.root_:SetNodeRunComplete()
end

return TangramSwitchToPlayNode
