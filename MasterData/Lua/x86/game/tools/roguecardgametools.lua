local var_0_0 = {}
local var_0_1 = 0

function var_0_0.GetPostDataList(arg_1_0)
	if arg_1_0 == 1 then
		return var_0_0.SortBySequence((var_0_0.GetPostListByPre(RogueCardPostingCfg.all)))
	elseif arg_1_0 == 2 then
		return var_0_0.SortBySequence((var_0_0.GetPostListByPre(RogueCardPostingCfg.get_id_list_by_type[1])))
	elseif arg_1_0 == 3 then
		return var_0_0.SortBySequence((var_0_0.GetPostListByPre(RogueCardPostingCfg.get_id_list_by_type[3])))
	elseif arg_1_0 == 4 then
		return var_0_0.SortBySequence((var_0_0.GetPostListByPre(RogueCardPostingCfg.get_id_list_by_type[2])))
	end
end

function var_0_0.GetPostListByPre(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		if RogueCardPostingCfg[iter_2_1].pre_id and RogueCardPostingCfg[iter_2_1].pre_id ~= 0 then
			if RogueCardGameTools.GetIsFinishPreById(RogueCardPostingCfg[iter_2_1].pre_id) then
				table.insert(var_2_0, iter_2_1)
			end
		else
			table.insert(var_2_0, iter_2_1)
		end
	end

	return var_2_0
end

function var_0_0.SortBySequence(arg_3_0)
	table.sort(arg_3_0, function(arg_4_0, arg_4_1)
		local var_4_0 = RogueCardPostingCfg[arg_4_0]
		local var_4_1 = RogueCardPostingCfg[arg_4_1]

		if RogueCardPostingCfg[arg_4_0].sequence == RogueCardPostingCfg[arg_4_1].sequence then
			return false
		end

		return var_4_0.sequence > var_4_1.sequence
	end)

	return arg_3_0
end

function var_0_0.GetIsFinishPreById(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs((RogueCardGameData:GetFinishThreadList())) do
		if iter_5_1 == arg_5_0 then
			return true
		end
	end

	return false
end

function var_0_0.SetCurPostingId(arg_6_0)
	var_0_1 = arg_6_0
end

function var_0_0.GetCurPostingId()
	return var_0_1
end

function var_0_0.GetHotPostId(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(RogueCardPostingCfg.get_id_list_by_type[2]) do
		if RogueCardPostingCfg[iter_8_1].pre_id == arg_8_0 then
			var_8_0 = iter_8_1
		end
	end

	return var_8_0
end

function var_0_0.GetPostTalkNum(arg_9_0)
	local var_9_0 = 0

	if var_0_0.GetIsFinishPreById(arg_9_0) then
		var_9_0 = #RogueCardPostingCfg[arg_9_0].comments

		for iter_9_0, iter_9_1 in ipairs(RogueCardPostingCfg[arg_9_0].comments) do
			var_9_0 = var_9_0 + (#RogueCardCommentCfg[iter_9_1].comment_sub or 0)
		end
	else
		for iter_9_2, iter_9_3 in ipairs(RogueCardPostingCfg[arg_9_0].comments) do
			if RogueCardCommentCfg[iter_9_3].comment_show ~= 1 then
				var_9_0 = var_9_0 + 1
				var_9_0 = var_9_0 + (#RogueCardCommentCfg[iter_9_3].comment_sub or 0)
			end
		end
	end

	return var_9_0
end

function var_0_0.IsCompleteForum()
	return var_0_0.GetIsFinishPreById(RogueCardPostingCfg.get_id_list_by_type[1][#RogueCardPostingCfg.get_id_list_by_type[1]])
end

function var_0_0.IsUnlockDeck(arg_11_0)
	if arg_11_0 == 1 then
		return true
	else
		local var_11_0 = ConditionCfg[RogueCardDeckCfg[arg_11_0].condition]

		if ConditionCfg[RogueCardDeckCfg[arg_11_0].condition].type == 12701 then
			for iter_11_0, iter_11_1 in ipairs((RogueCardGameData:GetFinishThreadList())) do
				if iter_11_1 == var_11_0.params[1] then
					return true
				end
			end

			return false
		elseif var_11_0.type == 12702 then
			for iter_11_2, iter_11_3 in ipairs((RogueCardGameData:GetStatusList())) do
				if iter_11_3.deck == var_11_0.params[1] and iter_11_3.max_diff >= var_11_0.params[2] then
					return true
				end
			end

			return false
		end
	end
end

function var_0_0.GetMaxDiff(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs((RogueCardGameData:GetStatusList())) do
		if arg_12_0 == iter_12_1.deck then
			return iter_12_1.max_diff
		end
	end
end

function var_0_0.IsUnlockDiff(arg_13_0, arg_13_1)
	if arg_13_0 == 1 and arg_13_1 == 1 then
		return true
	end

	if var_0_0.IsUnlockDeck(arg_13_0) and arg_13_1 == 1 then
		return true
	elseif var_0_0.IsUnlockDeck(arg_13_0) and arg_13_1 > 1 then
		for iter_13_0, iter_13_1 in ipairs((RogueCardGameData:GetStatusList())) do
			if var_0_0.IsUnlockDeck(arg_13_0) and arg_13_0 == iter_13_1.deck and iter_13_1.max_diff >= arg_13_1 - 1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetJokerCardByRare(arg_14_0)
	local var_14_0 = {}

	if arg_14_0 == 1 then
		return RogueCardItemCfg.get_id_list_by_type[3]
	else
		for iter_14_0, iter_14_1 in ipairs(RogueCardItemCfg.get_id_list_by_type[3]) do
			if RogueCardItemCfg[iter_14_1].rare == arg_14_0 - 1 then
				table.insert(var_14_0, iter_14_1)
			end
		end

		return var_14_0
	end
end

function var_0_0.GetJokerCardNum(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = 0

	if arg_15_0 == 1 then
		var_15_0 = RogueCardItemCfg.get_id_list_by_type[3]
	else
		for iter_15_0, iter_15_1 in ipairs(RogueCardItemCfg.get_id_list_by_type[3]) do
			if RogueCardItemCfg[iter_15_1].rare == arg_15_0 - 1 then
				table.insert(var_15_0, iter_15_1)
			end
		end
	end

	for iter_15_2, iter_15_3 in ipairs(var_15_0) do
		if var_0_0.IsUnlockJokerCard(iter_15_3) then
			var_15_1 = var_15_1 + 1
		end
	end

	return var_15_1 .. "/" .. #var_15_0
end

function var_0_0.IsUnlockJokerCard(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs((RogueCardGameData:GetJokerCardList())) do
		if arg_16_0 == iter_16_1 then
			return true
		end
	end

	return false
end

function var_0_0.IsUnlockWcCard(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs((RogueCardGameData:GetGatherCardList())) do
		if arg_17_0 == iter_17_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetPostStateById(arg_18_0)
	if RogueCardPostingCfg[arg_18_0].type ~= 1 then
		return 3
	end

	for iter_18_0, iter_18_1 in ipairs((RogueCardGameData:GetFinishThreadList())) do
		if arg_18_0 == iter_18_1 then
			return 2
		end
	end

	if RogueCardGameData:GetThreadState() > 0 and RogueCardGameData:GetThreadId() == arg_18_0 then
		return 1
	end

	return 0
end

function var_0_0.GetIsViewsPost(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs((RogueCardGameData:GetViewThreadList())) do
		if iter_19_1 == arg_19_0 then
			return true
		end
	end

	return false
end

function var_0_0.IsViewPost(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs((RogueCardGameData:GetViewThreadList())) do
		if iter_20_1 == arg_20_0 or RogueCardPostingCfg[arg_20_0].type == 2 then
			return true
		end
	end

	return false
end

function var_0_0.IsLikesPostById(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs((RogueCardGameData:GetLikesThreadList())) do
		if iter_21_1 == arg_21_0 then
			return true
		end
	end

	return false
end

function var_0_0.GetWealWoeListByType(arg_22_0)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(RogueCardBossEffectCfg.get_id_list_by_type[arg_22_0]) do
		if RogueCardBossEffectCfg[iter_22_1].type == arg_22_0 and RogueCardBossEffectCfg[iter_22_1].weight ~= 0 then
			table.insert(var_22_0, iter_22_1)
		end
	end

	return var_22_0
end

function var_0_0.GetWealWoeListNum(arg_23_0)
	local var_23_0 = 0
	local var_23_1 = 0

	for iter_23_0, iter_23_1 in ipairs(RogueCardBossEffectCfg.get_id_list_by_type[arg_23_0]) do
		if RogueCardBossEffectCfg[iter_23_1].weight ~= 0 then
			var_23_1 = var_23_1 + 1
		end

		if var_0_0.IsUnlockWealWoeById(iter_23_1) and RogueCardBossEffectCfg[iter_23_1].weight ~= 0 then
			var_23_0 = var_23_0 + 1
		end
	end

	return var_23_0 .. "/" .. var_23_1
end

function var_0_0.IsUnlockWealWoeById(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs((RogueCardGameData:GetWealWoeList())) do
		if arg_24_0 == iter_24_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetBlackCardList()
	return RogueCardItemCfg.get_id_list_by_type[2]
end

function var_0_0.GetWhiteCardList()
	return RogueCardItemCfg.get_id_list_by_type[1]
end

function var_0_0.GetWuChangNum(arg_27_0)
	local var_27_0 = 0

	for iter_27_0, iter_27_1 in ipairs(RogueCardItemCfg.get_id_list_by_type[arg_27_0]) do
		if RogueCardGameTools.IsUnlockWcCard(iter_27_1) then
			var_27_0 = var_27_0 + 1
		end
	end

	return var_27_0 .. "/" .. #RogueCardItemCfg.get_id_list_by_type[arg_27_0]
end

function var_0_0.GetCardPowerList()
	return RogueCardEnhanceCfg.get_id_list_by_type[1]
end

function var_0_0.GetCardPowerNum()
	local var_29_0 = 0

	for iter_29_0, iter_29_1 in ipairs(RogueCardEnhanceCfg.get_id_list_by_type[1]) do
		if RogueCardGameTools.IsUnlockCardBuff(iter_29_1) then
			var_29_0 = var_29_0 + 1
		end
	end

	return var_29_0 .. "/" .. #RogueCardEnhanceCfg.get_id_list_by_type[1]
end

function var_0_0.GetCardSealList()
	return RogueCardEnhanceCfg.get_id_list_by_type[2]
end

function var_0_0.GetCardSealNum()
	local var_31_0 = 0

	for iter_31_0, iter_31_1 in ipairs(RogueCardEnhanceCfg.get_id_list_by_type[2]) do
		if RogueCardGameTools.IsUnlockCardBuff(iter_31_1) then
			var_31_0 = var_31_0 + 1
		end
	end

	return var_31_0 .. "/" .. #RogueCardEnhanceCfg.get_id_list_by_type[2]
end

function var_0_0.GetCardStyleList()
	return RogueCardEnhanceCfg.get_id_list_by_type[3]
end

function var_0_0.GetCardStyleNum()
	local var_33_0 = 0

	for iter_33_0, iter_33_1 in ipairs(RogueCardEnhanceCfg.get_id_list_by_type[3]) do
		if RogueCardGameTools.IsUnlockCardBuff(iter_33_1) then
			var_33_0 = var_33_0 + 1
		end
	end

	return var_33_0 .. "/" .. #RogueCardEnhanceCfg.get_id_list_by_type[3]
end

function var_0_0.IsUnlockCardBuff(arg_34_0)
	for iter_34_0, iter_34_1 in ipairs((RogueCardGameData:GetEnhanceList())) do
		if arg_34_0 == iter_34_1 then
			return true
		end
	end

	return false
end

local var_0_2 = 1
local var_0_3 = 1

function var_0_0.SetChallengeDeckDiff(arg_35_0, arg_35_1)
	var_0_2 = arg_35_0
	var_0_3 = arg_35_1
end

function var_0_0.GetChallengeDeckDiff()
	return var_0_2, var_0_3
end

local var_0_4

function var_0_0.SetSettleFirst(arg_37_0)
	var_0_4 = arg_37_0
end

function var_0_0.GetSettleFirst()
	return var_0_4
end

return var_0_0
