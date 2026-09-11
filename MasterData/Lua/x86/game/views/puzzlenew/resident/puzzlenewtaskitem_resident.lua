local PuzzleNewTaskItem_Resident = class("PuzzleNewTaskItem_Resident", (import("game.views.puzzleNew.IndiaPuzzleNewTaskItem")))

function PuzzleNewTaskItem_Resident:InitController()
	self.controller_ = self.itemCon_:GetController("state")
	self.typeController_ = self.itemCon_:GetController("type")
end

return PuzzleNewTaskItem_Resident
