local var_0_0 = {}

manager.net:Bind(89601, function(arg_1_0)
	RogueCardGameData:UpdateData(arg_1_0)
end)

function var_0_0.StartPost(arg_2_0)
	manager.net:SendWithLoadingNew(89602, {
		thread_id = arg_2_0
	}, 89603, var_0_0.OnStartPost)
end

function var_0_0.OnStartPost(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		local var_3_0 = 1
		local var_3_1 = arg_3_1.thread_id
		local var_3_2 = RogueCardPostingCfg[var_3_1].story_id1

		if var_3_2 > 0 then
			manager.story:StartStoryById(var_3_2, function(arg_4_0)
				var_0_0.OnCompleteStory(var_3_1, var_3_2, var_3_0)
			end, false)
			var_0_0.CompleteStory(var_3_1, var_3_2, var_3_0)
		elseif var_3_1 ~= 107 and var_3_2 == 0 then
			gameContext:Back()
			RogueCardGameBridge.EnterRogueCardGame(var_3_1, nil, nil, false)
		end
	else
		ShowTips(GetTips(arg_3_0.result))
	end
end

function var_0_0.RebackPost(arg_5_0)
	manager.net:SendWithLoadingNew(89608, {
		thread_id = arg_5_0
	}, 89609, var_0_0.OnRebackPost)
end

function var_0_0.OnRebackPost(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		local var_6_0 = 1
		local var_6_1 = arg_6_1.thread_id
		local var_6_2 = RogueCardPostingCfg[var_6_1].story_id1

		if var_6_2 > 0 then
			manager.story:StartStoryById(var_6_2, function(arg_7_0)
				var_0_0.OnCompleteStory(var_6_1, var_6_2, var_6_0)
			end, false)
			var_0_0.CompleteStory(var_6_1, var_6_2, var_6_0)
		elseif var_6_1 ~= 107 and var_6_2 == 0 then
			gameContext:Back()
			RogueCardGameBridge.EnterRogueCardGame(var_6_1, nil, nil, false)
		end
	else
		ShowTips(GetTips(arg_6_0.result))
	end
end

function var_0_0.CompletePost(arg_8_0, arg_8_1, arg_8_2)
	RogueCardGameData:SetSettleResult(arg_8_2)
	manager.net:SendWithLoadingNew(89612, {
		thread_id = arg_8_0,
		info = arg_8_1,
		joker_result = arg_8_2
	}, 89613, var_0_0.OnCompletePost)
end

function var_0_0.OnCompletePost(arg_9_0, arg_9_1)
	if isSuccess(arg_9_0.result) then
		if arg_9_1.joker_result == 1 then
			local var_9_0 = arg_9_1.thread_id
			local var_9_1 = RogueCardPostingCfg[var_9_0].story_id2
			local var_9_2 = 2

			if var_9_1 and var_9_1 > 0 then
				manager.story:StartStoryById(var_9_1, function(arg_10_0)
					var_0_0.OnCompleteStory(var_9_0, var_9_1, var_9_2, false)
				end, false)
				var_0_0.CompleteStory(var_9_0, var_9_1, var_9_2)
			else
				var_0_0.OnCompleteStory(var_9_0, var_9_1, var_9_2, false)
				var_0_0.CompleteStory(var_9_0, var_9_1, var_9_2)
			end
		else
			RogueCardGameBridge.FinishRogueCardGame(function()
				OpenPageUntilLoaded("/rogueCardGameForumView", {
					isSettle = arg_9_1.joker_result == 1 and true or false
				})
			end)
		end
	else
		ShowTips(GetTips(arg_9_0.result))
	end
end

function var_0_0.CompleteStory(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	manager.net:SendWithLoadingNew(89604, {
		thread_id = arg_12_0,
		story_id = arg_12_1,
		story_id_index = arg_12_2
	}, 89605, function(arg_13_0, arg_13_1)
		if isSuccess(arg_13_0.result) then
			-- block empty
		else
			ShowTips(GetTips(arg_13_0.result))
		end
	end)
end

function var_0_0.OnCompleteStory(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_2 == 1 then
		if arg_14_0 == 107 then
			OpenPageUntilLoaded("/rogueCardGameForumView", {
				isStory2Back = true,
				isSettle = false
			})
		else
			gameContext:Back()
			RogueCardGameBridge.EnterRogueCardGame(arg_14_0, nil, nil, false)
		end
	elseif arg_14_2 == 2 then
		local var_14_0 = RogueCardGameData:GetSettleResult()

		RogueCardGameBridge.FinishRogueCardGame(function()
			OpenPageUntilLoaded("/rogueCardGameForumView", {
				isSettle = var_14_0 == 1 and true or false,
				isStory2Back = arg_14_3
			})
		end)
	end
end

function var_0_0.RogueCardChallengeSettle(arg_16_0, arg_16_1, arg_16_2)
	manager.net:SendWithLoadingNew(89616, {
		deck = arg_16_0,
		diff = arg_16_1,
		info = arg_16_2
	}, 89617, var_0_0.OnRogueCardChallengeSettle)
end

function var_0_0.OnRogueCardChallengeSettle(arg_17_0, arg_17_1)
	if isSuccess(arg_17_0.result) then
		RogueCardGameBridge.FinishRogueCardGame(function()
			OpenPageUntilLoaded("/rogueCardGameChallengeSelectView", {
				isSettle = true
			})
		end)
	else
		ShowTips(GetTips(arg_17_0.result))
	end
end

function var_0_0.EnterRogueCardGame(arg_19_0, arg_19_1, arg_19_2)
	manager.net:SendWithLoadingNew(89618, {
		stage_id = arg_19_0,
		deck = arg_19_1,
		diff = arg_19_2
	}, 89619, var_0_0.OnEnterRogueCardGame)
end

function var_0_0.OnEnterRogueCardGame(arg_20_0, arg_20_1)
	if isSuccess(arg_20_0.result) then
		if (RogueCardStageCfg[arg_20_1.stage_id].type == 2 and 2 or 1) == 1 then
			RogueCardGameData:SetBattleId(arg_20_0.battle_id)
		else
			RogueCardGameData:SetChallengeBattleId(arg_20_0.battle_id)
		end

		RogueCardGameBridge.OnEnterRogueCardGame(arg_20_1.stage_id, arg_20_1.deck, arg_20_1.diff)
	else
		ShowTips(GetTips(arg_20_0.result))
	end
end

function var_0_0.SaveProgressPost(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = 0
	local var_21_1 = RogueCardStageCfg[arg_21_0].type == 2 and 2 or 1

	RogueCardGameData:SetSaveStageID(arg_21_0)

	if var_21_1 == 1 then
		var_21_0 = RogueCardGameData:GetBattleId()
	else
		var_21_0 = RogueCardGameData:GetChallengeBattleId()
	end

	local var_21_2 = RogueCardStageCfg[arg_21_0].type == 2 and 2 or 1

	if arg_21_2 == nil then
		manager.net:SendWithLoadingNew(89620, {
			battle_id = var_21_0,
			battle_type = var_21_2,
			save_data = arg_21_1
		}, 89621, var_0_0.OnSaveProgressPost)
	else
		manager.net:SendWithLoadingNew(89620, {
			battle_id = var_21_0,
			battle_type = var_21_2,
			save_data = arg_21_1,
			check_sum = arg_21_2
		}, 89621, var_0_0.OnSaveProgressPost)
	end
end

function var_0_0.OnSaveProgressPost(arg_22_0, arg_22_1)
	if isSuccess(arg_22_0.result) then
		RogueCardGameData:SaveStageData(arg_22_1.save_data, RogueCardGameData:GetSaveStageID())
	else
		ShowTips(GetTips(arg_22_0.result))
	end
end

function var_0_0.SaveRollBackPost(arg_23_0, arg_23_1)
	local var_23_0 = 0

	if (RogueCardStageCfg[arg_23_0].type == 2 and 2 or 1) == 1 then
		var_23_0 = RogueCardGameData:GetBattleId()
	else
		Debug.Log("Challenge Not Rollback")

		return
	end

	local var_23_1 = RogueCardStageCfg[arg_23_0].type == 2 and 2 or 1

	manager.net:SendWithLoadingNew(89626, {
		battle_id = var_23_0,
		battle_type = var_23_1,
		save_rollback = arg_23_1
	}, 89627, var_0_0.OnSaveRollBackPost)
end

function var_0_0.OnSaveRollBackPost(arg_24_0, arg_24_1)
	if isSuccess(arg_24_0.result) then
		RogueCardGameData:SaveRollbackData(arg_24_1.save_rollback, RogueCardGameData:GetSaveStageID())
	else
		ShowTips(GetTips(arg_24_0.result))
	end
end

function var_0_0.ContinueProgressPost(arg_25_0)
	local var_25_0 = 0
	local var_25_1 = RogueCardStageCfg[arg_25_0].type == 2 and 2 or 1

	if var_25_1 == 1 then
		var_25_0 = RogueCardGameData:GetBattleId()
	else
		var_25_0 = RogueCardGameData:GetChallengeBattleId()
	end

	manager.net:SendWithLoadingNew(89622, {
		battle_id = var_25_0,
		battle_type = var_25_1
	}, 89623, var_0_0.OnContinueProgressPost)
end

function var_0_0.OnContinueProgressPost(arg_26_0, arg_26_1)
	if isSuccess(arg_26_0.result) then
		if arg_26_1.battle_type == 1 then
			RogueCardGameData:SetBattleId(arg_26_0.battle_id)
		else
			RogueCardGameData:SetChallengeBattleId(arg_26_0.battle_id)
		end

		local var_26_0 = RogueCardGameTools.GetCurPostingId()

		RogueCardGameData:SaveStageData(arg_26_0.save_data, var_26_0)
		RogueCardGameData:SaveRollbackData(arg_26_0.save_rollback, var_26_0)

		local var_26_1 = RogueCardGameData:GetDeck()
		local var_26_2 = RogueCardGameData:GetDiff()

		RogueCardGameBridge.EnterRogueCardGame(var_26_0, var_26_1, var_26_2, true)
	else
		ShowTips(GetTips(arg_26_0.result))
	end
end

function var_0_0.GetStageSaveData(arg_27_0, arg_27_1, arg_27_2)
	manager.net:SendWithLoadingNew(89628, {
		battle_id = arg_27_0,
		battle_type = arg_27_1
	}, 89629, function(arg_28_0)
		if isSuccess(arg_28_0.result) then
			arg_27_2(arg_28_0.save_data)
		else
			ShowTips(GetTips(arg_28_0.result))
		end
	end)
end

function var_0_0.GetStageSaveDataJumpChallenge(arg_29_0, arg_29_1)
	if RogueCardGameData:GetChallengeState() == 0 then
		return
	end

	manager.net:SendWithLoadingNew(89628, {
		battle_id = arg_29_0,
		battle_type = arg_29_1
	}, 89629, function(arg_30_0)
		if isSuccess(arg_30_0.result) then
			RogueCardGameData:SaveSettleData(arg_30_0.save_data.settle_data)
			RogueCardGameData:SaveAllData(arg_30_0.save_data)
		else
			ShowTips(GetTips(arg_30_0.result))
		end
	end)
end

function var_0_0.InterruptPost(arg_31_0)
	local var_31_0 = 0
	local var_31_1 = RogueCardStageCfg[arg_31_0].type == 2 and 2 or 1

	if var_31_1 == 1 then
		var_31_0 = RogueCardGameData:GetBattleId()
	else
		var_31_0 = RogueCardGameData:GetChallengeBattleId()
	end

	var_0_0.GetStageSaveData(var_31_0, var_31_1, function(arg_32_0)
		RogueCardGameBridge.SendSettleTrackingPoint(arg_32_0, true, 3, nil, nil, arg_31_0)
		manager.net:SendWithLoadingNew(89624, {
			battle_id = var_31_0,
			battle_type = var_31_1
		}, 89625, var_0_0.OnInterruptPost)
	end)
end

function var_0_0.OnInterruptPost(arg_33_0, arg_33_1)
	if isSuccess(arg_33_0.result) then
		if arg_33_1.battle_type == 1 then
			RogueCardGameData:SetBattleId(arg_33_0.battle_id)
		else
			RogueCardGameData:SetChallengeBattleId(arg_33_0.battle_id)
		end

		local var_33_0 = RogueCardGameTools.GetCurPostingId()

		RogueCardGameData:SaveSettleData(arg_33_0.settle_info)

		if arg_33_1.battle_type == 2 then
			local var_33_1, var_33_2 = RogueCardGameTools.GetChallengeDeckDiff()

			OpenPageUntilLoaded("rogueCardGameChallengeSettleView", {
				deck = var_33_1,
				diff = var_33_2
			})
		end

		manager.notify:Invoke(ROGUE_CARD_GAME_INTERRUPT_SUCCESS)
	else
		ShowTips(GetTips(arg_33_0.result))
	end
end

function var_0_0.InGameInterruptPost(arg_34_0, arg_34_1)
	local var_34_0 = 0
	local var_34_1 = RogueCardStageCfg[arg_34_0].type == 2 and 2 or 1

	if var_34_1 == 1 then
		var_34_0 = RogueCardGameData:GetBattleId()
	else
		var_34_0 = RogueCardGameData:GetChallengeBattleId()
	end

	manager.net:SendWithLoadingNew(89624, {
		battle_id = var_34_0,
		battle_type = var_34_1
	}, 89625, function(arg_35_0, arg_35_1)
		var_0_0.OnInGameInterruptPost(arg_35_0, arg_35_1, arg_34_1)
	end)
end

function var_0_0.OnInGameInterruptPost(arg_36_0, arg_36_1, arg_36_2)
	if isSuccess(arg_36_0.result) then
		if arg_36_1.battle_type == 1 then
			RogueCardGameData:SetBattleId(arg_36_0.battle_id)
		else
			RogueCardGameData:SetChallengeBattleId(arg_36_0.battle_id)
		end

		local var_36_0 = RogueCardGameTools.GetCurPostingId()

		if (RogueCardStageCfg[var_36_0].type == 2 and 2 or 1) == 1 then
			RogueCardGameBridge.FinishRogueCardGame(function()
				OpenPageUntilLoaded("/rogueCardGameForumView", {
					isSettle = false
				})
			end)
		else
			RogueCardGameBridge.FinishRogueCardGame(function()
				OpenPageUntilLoaded("/rogueCardGameChallengeSelectView", {
					isSettle = false
				})
			end)
		end
	else
		ShowTips(GetTips(arg_36_0.result))
	end
end

function var_0_0.ViewThreadPost(arg_39_0)
	manager.net:SendWithLoadingNew(89610, {
		thread_id = arg_39_0
	}, 89611, var_0_0.OnViewThreadPost)
end

function var_0_0.OnViewThreadPost(arg_40_0, arg_40_1)
	if isSuccess(arg_40_0.result) then
		manager.notify:Invoke(ROGUE_CARD_GAME_REFRESH_BTNCON, arg_40_1.thread_id)
	else
		ShowTips(GetTips(arg_40_0.result))
	end
end

function var_0_0.ClickLikePost(arg_41_0)
	manager.net:SendWithLoadingNew(89606, {
		thread_id = arg_41_0
	}, 89607, var_0_0.OnClickLikePost)
end

function var_0_0.OnClickLikePost(arg_42_0, arg_42_1)
	if isSuccess(arg_42_0.result) then
		RogueCardGameData:AddLikePost(arg_42_1.thread_id)
		manager.notify:Invoke(ROGUE_CARD_GAME_REFRESH_BTNCON, arg_42_1.thread_id)
	else
		ShowTips(GetTips(arg_42_0.result))
	end
end

function var_0_0.InitRedPoint()
	RogueCardGameData:InitRedPointGroup()
	RogueCardGameData:UpdateTaskRedPoint()
end

return var_0_0
