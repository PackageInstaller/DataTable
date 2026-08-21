local var_0_0 = import("game.views.puzzleNew.IndiaPuzzleNewTaskItem")
local var_0_1 = class("PuzzleNewTaskItem_Resident", var_0_0)

function var_0_1.InitController(arg_1_0)
	arg_1_0.controller_ = arg_1_0.itemCon_:GetController("state")
	arg_1_0.typeController_ = arg_1_0.itemCon_:GetController("type")
end

return var_0_1
