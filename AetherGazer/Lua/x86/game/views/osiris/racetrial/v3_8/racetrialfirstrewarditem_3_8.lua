local var_0_0 = class("RaceTrialFirstRewardItem_3_8", RaceTrialFirstRewardItem)

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
		if not ActivityData:GetActivityIsOpen(arg_3_0.id) then
			ShowTips("TIME_OVER")

			return
		end

		RaceTrialAction:ReceiveFirstReward(arg_3_0.mainActivityID, arg_3_0.id)
	end)
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.id = arg_5_1
	arg_5_0.mainActivityID = arg_5_2

	local var_5_0 = ActivityRaceTrialCfg[arg_5_1]
	local var_5_1 = RaceTrialData:GetBattleData(arg_5_1)

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

	arg_5_0.descText_.text = GetI18NText(var_5_0.reward_desc)

	if var_5_1.state == 1 then
		arg_5_0.stateController:SetSelectedState("state2")
	elseif var_5_1.state == 2 then
		arg_5_0.stateController:SetSelectedState("state1")
	elseif var_5_1.state == 3 then
		arg_5_0.stateController:SetSelectedState("state3")
	end
end

return var_0_0
