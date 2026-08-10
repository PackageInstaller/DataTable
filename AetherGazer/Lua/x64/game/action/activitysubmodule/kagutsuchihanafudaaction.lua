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

function var_0_0.handleHanafudaGameOverResult(arg_4_0, arg_4_1, arg_4_2)
	if isSuccess(arg_4_0.result) then
		local var_4_0 = KagutsuchiWorkData:GetStamina()
		local var_4_1 = math.min(GameSetting.activity_kagutsuchi_fatigue_hanafuda_card_recover.value[1], GameSetting.activity_kagutsuchi_battle_fatigue_max.value[1] - var_4_0)
		local var_4_2 = math.max(0, var_4_1)

		HanafudaData:UpdateStreakInfo(arg_4_1.is_success)
		HanafudaData:AddToCompleteCardCombineList(arg_4_1.combine_id_list)

		if arg_4_2 then
			arg_4_2()
		end

		var_0_0.RefreshRedPonit()
	else
		ShowTips(arg_4_0.result)
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

function var_0_0.handleGetCombineRewardResult(arg_7_0, arg_7_1, arg_7_2)
	if isSuccess(arg_7_0.result) then
		local var_7_0 = HanafudaCardCombineCfg[arg_7_1.combine_id]

		getReward(formatRewardCfgList(var_7_0.reward_item_list))
		HanafudaData:RewardedCardCombineListByID(arg_7_1.combine_id)

		if arg_7_2 then
			arg_7_2()
		end

		var_0_0.RefreshRedPonit()
	else
		ShowTips(arg_7_0.result)
	end
end

function var_0_0.RefreshRedPonit()
	local var_8_0 = HanafudaData:GetIsTasksUnRewarded()
	local var_8_1 = HanafudaData:GetActivityID()

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA_REWARDED, var_8_1), var_8_0 and 1 or 0)
end

return var_0_0
