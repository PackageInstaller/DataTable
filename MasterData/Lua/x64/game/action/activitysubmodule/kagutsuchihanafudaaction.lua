local var_0_0 = {}

manager.net:Bind(76001, function(arg_1_0)
	HanafudaData:InitFromServer(arg_1_0)
	var_0_0.RefreshRedPonit()
end)

function var_0_0.SendHanafudaGameOver(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_1 = arg_2_1 and 0 or 1

	manager.net:SendWithLoadingNew(76010, {
		activity_id = arg_2_0,
		is_success = arg_2_1,
		combine_id_list = arg_2_2
	}, 76011, function(arg_3_0, arg_3_1)
		var_0_0.handleHanafudaGameOverResult(arg_3_0, arg_3_1, arg_2_3)
	end)
end

function var_0_0:handleHanafudaGameOverResult(arg_4_1, arg_4_2)
	if isSuccess(self.result) then
		local var_4_0 = math.max(0, (math.min(GameSetting.activity_kagutsuchi_fatigue_hanafuda_card_recover.value[1], GameSetting.activity_kagutsuchi_battle_fatigue_max.value[1] - KagutsuchiWorkData:GetStamina())))

		HanafudaData:UpdateStreakInfo(arg_4_1.is_success)
		HanafudaData:AddToCompleteCardCombineList(arg_4_1.combine_id_list)

		if arg_4_2 then
			arg_4_2()
		end

		var_0_0.RefreshRedPonit()
	else
		ShowTips(self.result)
	end
end

function var_0_0.SendGetCombineReward(arg_5_0, arg_5_1, arg_5_2)
	manager.net:SendWithLoadingNew(76012, {
		activity_id = arg_5_0,
		combine_id = arg_5_1
	}, 76013, function(arg_6_0, arg_6_1)
		var_0_0.handleGetCombineRewardResult(arg_6_0, arg_6_1, arg_5_2)
	end)
end

function var_0_0:handleGetCombineRewardResult(arg_7_1, arg_7_2)
	if isSuccess(self.result) then
		getReward(formatRewardCfgList(HanafudaCardCombineCfg[arg_7_1.combine_id].reward_item_list))
		HanafudaData:RewardedCardCombineListByID(arg_7_1.combine_id)

		if arg_7_2 then
			arg_7_2()
		end

		var_0_0.RefreshRedPonit()
	else
		ShowTips(self.result)
	end
end

function var_0_0.RefreshRedPonit()
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA_REWARDED, (HanafudaData:GetActivityID())), HanafudaData:GetIsTasksUnRewarded() and 1 or 0)
end

return var_0_0
