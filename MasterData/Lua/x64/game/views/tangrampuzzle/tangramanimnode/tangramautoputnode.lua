local TangramAutoPutNode = class("TangramAutoPutNode", (import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")))

function TangramAutoPutNode:RunFunc()
	self.manager_:RefreshPuzzleList()
	SetActive(self.manager_.autoPutPanelGo_, true)
	self.manager_:PlayAnim(self.manager_.autoPutAnim_, "regionContentPanel", function()
		SetActive(self.manager_.autoPutPanelGo_, false)
		self.root_:SetNodeRunComplete()
	end)
	manager.audio:PlayEffect("minigame_activity_2_5", "minigame_activity_2_5_Puzzle_complete1", "")
end

return TangramAutoPutNode
