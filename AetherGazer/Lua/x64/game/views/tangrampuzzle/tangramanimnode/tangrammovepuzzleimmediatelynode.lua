local var_0_0 = import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")
local var_0_1 = class("TangramMovePuzzleImmediatelyNode", var_0_0)

function var_0_1.RunFunc(arg_1_0)
	local var_1_0 = arg_1_0.blackboard_.moveOriginPuzzleIndex_
	local var_1_1 = arg_1_0.blackboard_.moveTargetPuzzleIndex_

	arg_1_0.manager_:UpdatePuzzleData(var_1_0)
	arg_1_0.manager_:UpdatePuzzleData(var_1_1)
	manager.audio:PlayEffect("minigame_activity_2_5", "minigame_activity_2_5_Puzzle_button", "")
	arg_1_0.root_:SetNodeRunComplete()
end

return var_0_1
