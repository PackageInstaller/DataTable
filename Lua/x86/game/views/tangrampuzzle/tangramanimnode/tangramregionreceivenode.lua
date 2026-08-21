local var_0_0 = import("game.views.tangramPuzzle.TangramAnimNode.TangramBaseNode")
local var_0_1 = class("TangramRegionReceiveNode", var_0_0)

function var_0_1.RunFunc(arg_1_0)
	if arg_1_0.blackboard_.isOnlyRegionRewardPop_ == true then
		arg_1_0:RunCompleteFunc()

		return
	end

	local var_1_0 = arg_1_0.blackboard_.receivedRegionList_

	manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_puzzle_reward", "")

	for iter_1_0 = 1, #var_1_0 do
		if iter_1_0 == #var_1_0 then
			arg_1_0.manager_.regionItemList_[var_1_0[iter_1_0]]:PlayRewardAnim(function()
				arg_1_0:RunCompleteFunc()
			end)
		else
			arg_1_0.manager_.regionItemList_[var_1_0[iter_1_0]]:PlayRewardAnim()
		end
	end
end

function var_0_1.RunCompleteFunc(arg_3_0)
	local var_3_0 = arg_3_0.blackboard_.rewardList_

	showRewardUI(var_3_0, nil, function()
		arg_3_0.root_:SetNodeRunComplete()
	end)
end

return var_0_1
