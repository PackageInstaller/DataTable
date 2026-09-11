local PuzzleNewTaskView_Resident = class("PuzzleNewTaskView_Resident", (import("game.views.puzzleNew.IndiaPuzzleNewTaskView")))

function PuzzleNewTaskView_Resident:InitController()
	self.allReceiveController_ = self.taskControllerEx_:GetController("clear")
	self.btnController_ = self.btnControllerEx_:GetController("open")
end

function PuzzleNewTaskView_Resident:RefreshAcvanceStatus(arg_2_1)
	self.btnController_:SetSelectedState(tostring(arg_2_1))
end

return PuzzleNewTaskView_Resident
