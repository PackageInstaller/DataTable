local var_0_0 = {}

manager.net:Bind(68051, function(arg_1_0)
	BloodCardData:InitFromServer(arg_1_0)
	var_0_0.UpdateUnlockStageRedpoint()
end)
manager.net:Bind(68057, function(arg_2_0)
	BloodCardManager.Instance:ReciveEenmySufferHand(arg_2_0.exchange_num)
end)
manager.net:Bind(68059, function(arg_3_0)
	BloodCardManager.Instance:ReciveRoundStart(arg_3_0.round)
end)
manager.net:Bind(68063, function(arg_4_0)
	BloodCardManager.Instance:ReciveEnemyDrawCard(arg_4_0.round, arg_4_0.get_num)
end)
manager.net:Bind(68067, function(arg_5_0)
	BloodCardManager.Instance:ReciveEnemyPlaceCard(arg_5_0.round, arg_5_0.card_id, arg_5_0.pos, arg_5_0.influence_list)
end)
manager.net:Bind(68069, function(arg_6_0)
	if isSuccess(arg_6_0.result) then
		BloodCardManager.Instance:RecevieEndRoundResult()
	else
		ShowTips(arg_6_0.result)
	end
end)
manager.net:Bind(68071, function(arg_7_0)
	if arg_7_0.reason == 1 then
		-- block empty
	end

	BloodCardManager.Instance:ReciveEndGame(arg_7_0.success_flag, arg_7_0.red_sum_score, arg_7_0.black_sum_score)

	if arg_7_0.success_flag == 1 and not BloodCardData:GetIsMultiGame() then
		BloodCardData:SetPassStage(BloodCardData:GetSelectStageID())

		if BloodCardData:GetUnPassNpc() and not BloodCardData:GetStageHasPass(BloodCardGameNPCCfg[BloodCardData:GetUnPassNpc()].stage_list[1]) then
			saveData("bloodCard", "hasClickStage", 0)
		end

		var_0_0.UpdateUnlockStageRedpoint()
	end

	BloodCardData:SetIsMultiGame(false)
end)
manager.net:Bind(68077, function(arg_8_0)
	manager.notify:Invoke("BLOOD_CARD_MATCHING_SUCCESS")
	JumpTools.OpenPageUntilLoaded("/bloodCardGame", {
		callBack = function()
			BloodCardData:SetIsMultiGame(true)
			BloodCardManager.Instance:StartGame(arg_8_0.order, cleanProtoTable(arg_8_0.card_id_list))

			BloodCardManager.Instance.guideIndex = 0
			BloodCardManager.Instance.isMultiGame = true
		end
	})
end)

function var_0_0.InitRedPoint(arg_10_0)
	local var_10_0 = RedPointConst.ACTIVITY_BLOOD_CARD .. "_" .. arg_10_0
	local var_10_1 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, BloodCardData:GetTaskActivityID(arg_10_0))
	local var_10_2 = string.format("%s_%s", RedPointConst.ACTIVITY_BLOOD_CARD_STAGE_UNLOCK, arg_10_0)

	manager.redPoint:addGroup(var_10_0, {
		var_10_1,
		var_10_2
	})
	saveData("bloodCard", "hasClickStage", 0)
end

function var_0_0.UpdateUnlockStageRedpoint()
	local var_11_0 = BloodCardData:GetUnPassNpc()
	local var_11_1 = string.format("%s_%s", RedPointConst.ACTIVITY_BLOOD_CARD_STAGE_UNLOCK, BloodCardData:GetMainActivityID())
	local var_11_2 = getData("bloodCard", "hasClickStage") or 0

	if var_11_0 and var_11_2 ~= 1 then
		manager.redPoint:setTip(var_11_1, 1)
	else
		manager.redPoint:setTip(var_11_1, 0)
	end
end

function var_0_0.SendSaveCardGroup(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = BloodCardData:GetRecommendCardSetID()
	local var_12_1 = {
		activity_id = arg_12_0,
		card_group = {
			index = arg_12_1,
			card_id_list = arg_12_2,
			name = arg_12_3 or ""
		},
		recommend_id = var_12_0
	}

	manager.net:SendWithLoadingNew(68080, var_12_1, 68081, function(arg_13_0, arg_13_1)
		if isSuccess(arg_13_0.result) then
			BloodCardData:UpdateCardGroup(arg_12_1, arg_12_2, arg_12_3)
			manager.notify:Invoke("BLOOD_CARD_SAVE_CARD_GROUP")

			if arg_12_4 then
				arg_12_4()
			end
		else
			ShowTips(arg_13_0.result)
		end
	end)
end

function var_0_0.SendClearCardGroup(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {
		activity_id = arg_14_0,
		group_index = arg_14_1
	}

	manager.net:SendWithLoadingNew(68082, var_14_0, 68083, function(arg_15_0, arg_15_1)
		if isSuccess(arg_15_0.result) then
			BloodCardData:UpdateCardGroup(arg_14_1, {}, "")
			BloodCardData:SetUsingCardIndex(arg_15_0.current_group_index)
			manager.notify:Invoke("BLOOD_CARD_CLEAR_CARD_GROUP", arg_14_1)

			if arg_14_2 then
				arg_14_2()
			end
		else
			ShowTips(arg_15_0.result)
		end
	end)
end

function SendStartBloodardGameRequest()
	local var_16_0 = BloodCardData:GetSelectStageID()
	local var_16_1 = BloodCardData:GetUsingCardIndex()

	if BloodCardGameStageCfg[var_16_0] and BloodCardGameStageCfg[var_16_0].freedom == BloodCardConst.STAGE_CARD_GROUP_LIMIT.LIMIT then
		var_16_1 = 0
	end

	local var_16_2 = {
		stage_id = var_16_0,
		group_index = var_16_1
	}

	manager.net:SendWithLoadingNew(68052, var_16_2, 68053, function(arg_17_0, arg_17_1)
		if isSuccess(arg_17_0.result) then
			if table.indexof(BloodCardConst.guideStageList, var_16_0) then
				BloodCardManager.Instance.guideIndex = table.indexof(BloodCardConst.guideStageList, var_16_0)
				BloodCardManager.Instance.guideID = 0

				for iter_17_0, iter_17_1 in pairs(BloodCardConst.stageGuideList[var_16_0]) do
					if not GuideData:IsFinish(iter_17_1) then
						BloodCardManager.Instance.guideID = iter_17_1
					end
				end
			else
				BloodCardManager.Instance.guideIndex = 0
				BloodCardManager.Instance.guideID = 0
			end

			if BloodCardGameStageCfg[var_16_0].freedom == BloodCardConst.STAGE_CARD_GROUP_LIMIT.LIMIT then
				BloodCardManager.Instance:StartGame(arg_17_0.order, cleanProtoTable(arg_17_0.card_id_list), BloodCardGameStageCfg[var_16_0].player_cards, BloodCardGameStageCfg[var_16_0].ai_cards)
			else
				BloodCardManager.Instance:StartGame(arg_17_0.order, cleanProtoTable(arg_17_0.card_id_list), {}, {})
			end
		else
			ShowTips(arg_17_0.result)
		end
	end)
end

function SendSufferCardRequest(arg_18_0)
	timestamp = manager.time:GetServerTime() - BloodCardManager.Instance.startGameTimestamp

	local var_18_0 = {
		exchange_card_id_list = arg_18_0,
		use_seconds = timestamp
	}

	manager.net:SendWithLoadingNew(68054, var_18_0, 68055, function(arg_19_0, arg_19_1)
		if isSuccess(arg_19_0.result) then
			BloodCardManager.Instance:ReciveSufferResult(cleanProtoTable(arg_19_0.return_card_id_list))
		else
			ShowTips(arg_19_0.result)
		end
	end)
end

function SendDrawCardRequest()
	local var_20_0 = {}

	manager.net:SendWithLoadingNew(68060, var_20_0, 68061, function(arg_21_0, arg_21_1)
		if isSuccess(arg_21_0.result) then
			BloodCardManager.Instance:ReciveDrawCardResult(cleanProtoTable(arg_21_0.return_card_id_list))
		else
			ShowTips(arg_21_0.result)
		end
	end)
end

function SendPlaceCardRequest(arg_22_0, arg_22_1)
	local var_22_0 = manager.time:GetServerTime() - BloodCardManager.Instance.drawCardTimestamp
	local var_22_1 = {
		card_id = arg_22_0,
		pos = arg_22_1,
		use_seconds = var_22_0
	}

	manager.net:SendWithLoadingNew(68064, var_22_1, 68065, function(arg_23_0, arg_23_1)
		if isSuccess(arg_23_0.result) then
			BloodCardManager.Instance:RecivePlaceCardResult(arg_23_0.result, arg_23_0.influence_list, arg_23_0.use_seconds)
		elseif arg_23_0.result == 7 then
			ShowTips(arg_23_0.result)
			BloodCardManager.Instance:RecivePlaceCardResult(arg_23_0.result, arg_23_0.influence_list, arg_23_0.use_seconds)
		else
			ShowTips(arg_23_0.result)
		end
	end)
end

function SendEndRoundRequest()
	local var_24_0 = {}

	manager.net:SendWithLoadingNew(68068, var_24_0, 68069, nil)
end

function SendResetGameRequest()
	local var_25_0 = {}

	manager.net:SendWithLoadingNew(68078, var_25_0, 68079, function(arg_26_0, arg_26_1)
		if isSuccess(arg_26_0.result) then
			BloodCardManager.Instance:ResetGame()
			BloodCardData:SetIsMultiGame(false)
		else
			ShowTips(arg_26_0.result)
		end
	end)
end

function SendMultiGameMatching()
	local var_27_0 = BloodCardData:GetMainActivityID()
	local var_27_1 = {
		group_index = 1,
		activity_id = var_27_0
	}

	manager.net:SendWithLoadingNew(68072, var_27_1, 68073, function(arg_28_0, arg_28_1)
		if isSuccess(arg_28_0.result) then
			JumpTools.OpenPageByJump("bloodCardMatchPop")
		else
			ShowTips(arg_28_0.result)
		end
	end)
end

function SendCancelMultiGameMatching()
	local var_29_0 = {}

	manager.net:SendWithLoadingNew(68074, var_29_0, 68075, function(arg_30_0, arg_30_1)
		if isSuccess(arg_30_0.result) then
			manager.notify:Invoke("BLOOD_CARD_MATCHING_CANCEL")
		else
			ShowTips(arg_30_0.result)
		end
	end)
end

function var_0_0.SendSetActiveCardGroup(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0
	local var_31_1 = {
		activity_id = var_31_0,
		group_index = arg_31_1
	}

	manager.net:SendWithLoadingNew(68084, var_31_1, 68085, function(arg_32_0, arg_32_1)
		if isSuccess(arg_32_0.result) then
			BloodCardData:SetUsingCardIndex(arg_31_1)

			if arg_31_2 then
				arg_31_2()
			end
		else
			ShowTips(arg_32_0.result)
		end
	end)
end

function BloodCardGoToHome()
	LaunchQWorld(true)
end

function InvokeClickCard(arg_34_0, arg_34_1)
	manager.notify:Invoke(BLOOD_CARD_IN_GAME_CLICK_CARD, arg_34_0, arg_34_1)
end

return var_0_0
