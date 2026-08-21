local var_0_0 = class("RaceTrialScoreRewardItem_3_8", RaceTrialScoreRewardItem)

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.rewardList = {}

	for iter_1_0 = 1, 3 do
		local var_1_0 = arg_1_0[string.format("rewardItem%d_", iter_1_0)]

		arg_1_0.rewardList[iter_1_0] = CommonItemView.New(var_1_0)
	end

	arg_1_0.controllers_ = arg_1_0.transform_:GetComponent("ControllerExCollection")
	arg_1_0.stateController = arg_1_0.controllers_:GetController("status")
	arg_1_0.itemCntController = arg_1_0.controllers_:GetController("Reward")

	arg_1_0:AddUIListeners()
end

function var_0_0.DisposeRewardItems(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.rewardList) do
		iter_2_1:Dispose()
	end

	arg_2_0.rewardList = nil
end

function var_0_0.AddUIListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityID) then
			ShowTips("TIME_OVER")

			return
		end

		RaceTrialAction:ReceiveScoreReward(arg_3_0.id)
	end)
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.id = arg_5_1
	arg_5_0.activityID = arg_5_3

	local var_5_0 = ActivityPointRewardCfg[arg_5_1]
	local var_5_1 = RaceTrialData:GetScoreRewardByID(arg_5_1)

	for iter_5_0 = 1, 3 do
		local var_5_2 = var_5_0.reward_item_list[iter_5_0]

		if var_5_2 then
			local var_5_3 = formatReward(var_5_2)
			local var_5_4 = rewardToItemTemplate(var_5_3, nil, true)

			arg_5_0.rewardList[iter_5_0]:SetData(var_5_4)
		else
			arg_5_0.rewardList[iter_5_0]:SetData(nil)
		end
	end

	local var_5_5 = math.max(1, math.min(3, #var_5_0.reward_item_list))

	arg_5_0.itemCntController:SetSelectedState(tostring(var_5_5))

	arg_5_0.descText_.text = GetTips("ACCUMULATED_POINTS_REACHED") .. var_5_0.need

	if var_5_1.receive_flag then
		arg_5_0.stateController:SetSelectedState("state3")
	elseif arg_5_2 >= var_5_0.need then
		arg_5_0.stateController:SetSelectedState("state1")
	else
		arg_5_0.stateController:SetSelectedState("state2")
	end
end

return var_0_0
