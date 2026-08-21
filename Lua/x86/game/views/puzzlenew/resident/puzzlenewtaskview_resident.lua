local var_0_0 = import("game.views.puzzleNew.IndiaPuzzleNewTaskView")
local var_0_1 = class("PuzzleNewTaskView_Resident", var_0_0)

function var_0_1.InitController(arg_1_0)
	arg_1_0.allReceiveController_ = arg_1_0.taskControllerEx_:GetController("clear")
	arg_1_0.btnController_ = arg_1_0.btnControllerEx_:GetController("open")
end

function var_0_1.RefreshAcvanceStatus(arg_2_0, arg_2_1)
	arg_2_0.btnController_:SetSelectedState(tostring(arg_2_1))
end

return var_0_1
