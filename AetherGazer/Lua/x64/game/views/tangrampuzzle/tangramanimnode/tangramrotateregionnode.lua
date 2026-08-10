local var_0_0 = import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")
local var_0_1 = class("TangramRotateRegionNode", var_0_0)

function var_0_1.RunFunc(arg_1_0)
	local var_1_0 = arg_1_0.blackboard_.rotateRegionID_
	local var_1_1 = arg_1_0.blackboard_.rotateTimes_

	if var_1_1 == 0 then
		arg_1_0.root_:SetNodeRunComplete()

		return
	end

	local var_1_2 = arg_1_0.manager_.regionItemList_[var_1_0]
	local var_1_3 = TangramPuzzleTools.GetRegionRotateAngle(arg_1_0.manager_.activityID_, var_1_0) * var_1_1

	var_1_2:SetTransParent(arg_1_0.manager_.editPanelTrans_)
	var_1_2:Rotate(var_1_3, function()
		var_1_2:RecoverTrans()

		local var_2_0 = TangramPuzzleTools.GetPuzzleGlobalIndexListByRegionID(arg_1_0.manager_.activityID_)[var_1_0]

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			arg_1_0.manager_:UpdatePuzzleData(iter_2_1)
		end

		arg_1_0.root_:SetNodeRunComplete()
	end)
	manager.audio:PlayEffect("minigame_activity_2_5", "minigame_activity_2_5_Puzzle_rotate", "")
end

return var_0_1
