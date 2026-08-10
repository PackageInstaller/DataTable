local var_0_0 = import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")
local var_0_1 = class("TangramRegionTypeAllRightNode", var_0_0)

function var_0_1.RunFunc(arg_1_0)
	local var_1_0 = arg_1_0.blackboard_.allRightRegionTypeList_

	for iter_1_0 = 1, #var_1_0 do
		local var_1_1 = arg_1_0.manager_.regionContentItemList_[var_1_0[iter_1_0]]

		var_1_1:PlayCompletedAnim(function()
			var_1_1:RefreshStatus()

			if iter_1_0 == #var_1_0 then
				manager.audio:PlayEffect("minigame_activity_2_5", "minigame_activity_2_5_Puzzle_complete2", "")
				arg_1_0.root_:SetNodeRunComplete()
			end
		end)
	end
end

return var_0_1
