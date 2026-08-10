local var_0_0 = {
	GetCardName = function(arg_1_0)
		local var_1_0 = AutoChessCardCfg[arg_1_0]

		if not var_1_0 then
			return ""
		end

		local var_1_1 = AutoChessCfg.get_id_list_by_group_id[var_1_0.group_id][1]

		if not var_1_1 then
			return ""
		end

		local var_1_2 = AutoChessCfg[var_1_1]

		if not var_1_2 then
			return ""
		end

		return var_1_2.name
	end,
	GetExpByCardType = function(arg_2_0)
		local var_2_0 = AutoChessCardCfg[arg_2_0]

		if not var_2_0 then
			return 0
		end

		if var_2_0.type == AutoChessCardConst.CARD_TYPE.R then
			return GameSetting.auto_chess_2_bronze_exp_provide.value[1]
		elseif var_2_0.type == AutoChessCardConst.CARD_TYPE.SR then
			return GameSetting.auto_chess_2_silver_exp_provide.value[1]
		elseif var_2_0.type == AutoChessCardConst.CARD_TYPE.UR then
			return GameSetting.auto_chess_2_gold_exp_provide.value[1]
		end
	end,
	GetExpByType = function(arg_3_0)
		if arg_3_0 == AutoChessCardConst.CARD_TYPE.R then
			return GameSetting.auto_chess_2_bronze_exp_provide.value[1]
		elseif arg_3_0 == AutoChessCardConst.CARD_TYPE.SR then
			return GameSetting.auto_chess_2_silver_exp_provide.value[1]
		elseif arg_3_0 == AutoChessCardConst.CARD_TYPE.UR then
			return GameSetting.auto_chess_2_gold_exp_provide.value[1]
		end
	end,
	GetMixExpByCardType = function(arg_4_0)
		local var_4_0 = AutoChessCardCfg[arg_4_0]

		if var_4_0.type == AutoChessCardConst.CARD_TYPE.SR then
			return GameSetting.auto_chess_2_silver_exp_need.value[1]
		elseif var_4_0.type == AutoChessCardConst.CARD_TYPE.UR then
			return GameSetting.auto_chess_2_gold_exp_need.value[1]
		else
			return 0
		end
	end,
	GetChessId = function(arg_5_0)
		local var_5_0 = AutoChessCardCfg[arg_5_0]

		if not var_5_0 then
			return 0
		end

		return AutoChessCfg.get_id_list_by_group_id[var_5_0.group_id][1]
	end
}

function var_0_0.GetCardExp()
	local var_6_0 = AutoChessCardData:GetCardList()
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if iter_6_1 > 1 then
			var_6_1 = var_6_1 + var_0_0.GetExpByCardType(iter_6_0) * (iter_6_1 - 1)
		end
	end

	return var_6_1
end

function var_0_0.JumpChatPage(arg_7_0)
	if not FriendsData:GetFreshFlag() then
		FriendsAction:TryToRefreshFriendsView(1, function()
			ChatFriendData:AddCacheFriend(arg_7_0)
			JumpTools.OpenPageByJump("chat", {
				ignoreBG = true,
				chatToggleID = ChatConst.CHAT_CHANNEL_FRIEND,
				friendID = arg_7_0
			}, ViewConst.SYSTEM_ID.CHAT)
		end)

		return
	end

	ChatFriendData:AddCacheFriend(arg_7_0)
	JumpTools.OpenPageByJump("chat", {
		ignoreBG = true,
		chatToggleID = ChatConst.CHAT_CHANNEL_FRIEND,
		friendID = arg_7_0
	}, ViewConst.SYSTEM_ID.CHAT)
end

function var_0_0.GetMixCombinations(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	for iter_9_0 = math.min(arg_9_0, arg_9_3), 0, -1 do
		local var_9_0 = arg_9_3 - iter_9_0 * var_0_0.GetExpByType(AutoChessCardConst.CARD_TYPE.R)

		if var_9_0 == 0 then
			return iter_9_0, 0, 0
		end

		local var_9_1 = math.floor(var_9_0 / var_0_0.GetExpByType(AutoChessCardConst.CARD_TYPE.SR))

		for iter_9_1 = math.min(arg_9_1, var_9_1), 0, -1 do
			local var_9_2 = var_9_0 - iter_9_1 * var_0_0.GetExpByType(AutoChessCardConst.CARD_TYPE.SR)

			if var_9_2 == 0 then
				return iter_9_0, iter_9_1, 0
			end

			max_k = math.floor(var_9_2 / var_0_0.GetExpByType(AutoChessCardConst.CARD_TYPE.UR))

			for iter_9_2 = math.min(arg_9_2, max_k), 0, -1 do
				if var_9_2 - iter_9_2 * var_0_0.GetExpByType(AutoChessCardConst.CARD_TYPE.UR) == 0 then
					return iter_9_0, iter_9_1, iter_9_2
				end
			end
		end
	end

	if arg_9_3 < arg_9_0 * var_0_0.GetExpByType(AutoChessCardConst.CARD_TYPE.R) + arg_9_1 * var_0_0.GetExpByType(AutoChessCardConst.CARD_TYPE.SR) + arg_9_2 * var_0_0.GetExpByType(AutoChessCardConst.CARD_TYPE.UR) then
		return var_0_0.GetMixCombinations(arg_9_0, arg_9_1, arg_9_2, arg_9_3 + 1)
	else
		return arg_9_0, arg_9_1, arg_9_2
	end
end

return var_0_0
