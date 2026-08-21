local var_0_0 = import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")
local var_0_1 = class("TangramMovePuzzleNode", var_0_0)

function var_0_1.RunFunc(arg_1_0)
	arg_1_0.updatingPuzzleCount_ = 0

	local var_1_0 = arg_1_0.blackboard_.moveOriginPuzzleIndex_
	local var_1_1 = arg_1_0.blackboard_.moveTargetPuzzleIndex_
	local var_1_2 = arg_1_0.manager_.puzzleItemList_[var_1_0]
	local var_1_3 = arg_1_0.manager_.puzzleItemList_[var_1_1]

	arg_1_0:UpdatePuzzle(var_1_0, var_1_3.transform_.position)
	arg_1_0:UpdatePuzzle(var_1_1, var_1_2.transform_.position)
end

function var_0_1.UpdatePuzzle(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.updatingPuzzleCount_ = arg_2_0.updatingPuzzleCount_ + 1

	local var_2_0 = arg_2_0.manager_.puzzleItemList_[arg_2_1]

	var_2_0:SetTransParent(arg_2_0.manager_.editPanelTrans_)
	var_2_0:UpdatePosition(arg_2_2, function()
		arg_2_0.manager_:UpdatePuzzleData(arg_2_1)

		arg_2_0.updatingPuzzleCount_ = arg_2_0.updatingPuzzleCount_ - 1

		if arg_2_0.updatingPuzzleCount_ == 0 then
			arg_2_0.root_:SetNodeRunComplete()
		end
	end)
end

return var_0_1
