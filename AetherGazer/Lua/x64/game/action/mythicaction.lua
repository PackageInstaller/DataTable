local var_0_0 = {}

manager.net:Bind(44007, function(arg_1_0)
	MythicData:InitMythicData(arg_1_0)
	manager.notify:CallUpdateFunc(MYTHIC_UPDATE)
end)
manager.net:Bind(44039, function(arg_2_0)
	MythicData:SetCurPoint(arg_2_0.score)
end)
manager.net:Bind(44019, function(arg_3_0)
	MythicData:InitMythicUserPublicData(arg_3_0)
	MythicAction:UpdateMythicRedTip()
	MythicAction:UpdateMythicFinalRedPoint()
	manager.notify:CallUpdateFunc(MYTHIC_UPDATE)
end)
manager.net:Bind(44009, function(arg_4_0)
	MythicData:InitMythicUserData(arg_4_0)
	MythicAction:UpdateMythicRedTip()
	MythicAction:UpdateMythicFinalRedPoint()
end)
manager.net:Bind(44021, function(arg_5_0)
	MythicData:InitFinalMythicData(arg_5_0)
end)
manager.net:Bind(44023, function(arg_6_0)
	MythicData:InitFinalMythicUserData(arg_6_0)
	MythicAction.UpdateMythicFinalRedPoint()
	manager.notify:CallUpdateFunc(MYTHIC_FINAL_UPDATE)
end)

function var_0_0.QueryMythicInfo(arg_7_0)
	manager.net:SendWithLoading(44010, {}, 44011):next(function(arg_8_0)
		if isSuccess(arg_8_0.result) then
			ShowTips("HAZARD_ZONE_REFRESH")
			MythicData:SetIsNew(true)
		else
			print("QueryMythicInfo error")
		end
	end)
end

function var_0_0.QueryMythicRead(arg_9_0)
	MythicData:SetIsNewDifficulty(false)
	manager.net:SendWithLoading(44014, {}, 44015):next(function(arg_10_0)
		if isSuccess(arg_10_0.result) then
			-- block empty
		end
	end)
end

function var_0_0.QueryMythicFinalRead(arg_11_0)
	MythicData:SetIsNewHotLevel(false)
	manager.net:SendWithLoading(44032, {}, 44033):next(function(arg_12_0)
		if isSuccess(arg_12_0.result) then
			-- block empty
		end
	end)
end

function var_0_0.QueryMythicStar(arg_13_0)
	manager.net:SendWithLoadingNew(44012, {
		star = arg_13_0
	}, 44013, var_0_0.MythicStarBack)
end

function var_0_0.MythicStarBack(arg_14_0, arg_14_1)
	if isSuccess(arg_14_0.result) then
		local var_14_0 = arg_14_1.star
		local var_14_1 = MythicData:GetDifficulty()

		if MythicCfg[var_14_1].difficulty == 1 then
			local var_14_2 = {}

			for iter_14_0, iter_14_1 in ipairs(arg_14_0.item_list) do
				table.insert(var_14_2, {
					id = iter_14_1.id,
					num = iter_14_1.num
				})
			end

			sortMergeGetReward(var_14_2)
			MythicData:SetStarRewardState(var_14_0)
			MythicAction:UpdateMythicRedTip()
			manager.notify:CallUpdateFunc(MYTHIC_STAR_REWARD_UPDATE)
		end
	else
		ShowTips(arg_14_0.result)
	end
end

function var_0_0.QueryChangeDifficulty(arg_15_0)
	manager.net:SendWithLoadingNew(44016, {
		difficulty = arg_15_0
	}, 44017, var_0_0.OnQueryChangeDifficulyuBack)
end

function var_0_0.OnQueryChangeDifficulyuBack(arg_16_0, arg_16_1)
	if isSuccess(arg_16_0.result) then
		MythicData:SetDifficulty(arg_16_1.difficulty)

		if arg_16_1.difficulty == MythicData:GetFinalId() then
			gameContext:Go("/mythicUltimateView", nil, true)
			var_0_0.UpdateMythicFinalRedPoint()
		else
			gameContext:Go("/mythic", nil, true)
			var_0_0.UpdateMythicRedTip()
		end
	else
		ShowTips(arg_16_0.result)
	end
end

function var_0_0.UpdateMythicRedTip(arg_17_0)
	if MythicData:GetDifficulty() ~= MythicData:GetFinalId() then
		local var_17_0 = MythicData:GetDifficulty()

		if var_17_0 and var_17_0 ~= 0 then
			local var_17_1 = MythicData:GetStarCount()

			for iter_17_0 = 1, var_17_1 do
				if not MythicData:GetStarRewardState(iter_17_0) then
					manager.redPoint:setTip(RedPointConst.MYTHIC_TIMES_AWARD, 1)

					return
				end
			end
		end

		manager.redPoint:setTip(RedPointConst.MYTHIC_TIMES_AWARD, 0)
	end
end

function var_0_0.UpdateMythicFinalRedPoint()
	if MythicData:GetFinalRewardNotGet() then
		manager.redPoint:setTip(RedPointConst.MYTHIC_FINAL_AWARD, 1)
	else
		manager.redPoint:setTip(RedPointConst.MYTHIC_FINAL_AWARD, 0)
	end
end

function var_0_0.GetFinalReward(arg_19_0, arg_19_1)
	manager.net:SendWithLoadingNew(44028, {
		difficulty_id = arg_19_1
	}, 44029, function(arg_20_0, arg_20_1)
		if isSuccess(arg_20_0.result) then
			local var_20_0 = {}

			for iter_20_0, iter_20_1 in ipairs(arg_20_0.item_list) do
				table.insert(var_20_0, {
					id = iter_20_1.id,
					num = iter_20_1.num
				})
			end

			sortMergeGetReward(var_20_0)
			MythicData:GetFinalReward(arg_20_1.difficulty_id)
			MythicAction.UpdateMythicFinalRedPoint()
			manager.notify:CallUpdateFunc(MYTHIC_FINAL_GETREWARD)
		else
			ShowTips(arg_20_0.result)
		end
	end)
end

function var_0_0.GetAllFinalReward(arg_21_0)
	manager.net:SendWithLoadingNew(44030, {}, 44031, function(arg_22_0, arg_22_1)
		if isSuccess(arg_22_0.result) then
			local var_22_0 = {}

			for iter_22_0, iter_22_1 in ipairs(arg_22_0.item_list) do
				table.insert(var_22_0, {
					id = iter_22_1.id,
					num = iter_22_1.num
				})
			end

			sortMergeGetReward(var_22_0)
			MythicData:GetAllFinalReward()
			MythicAction.UpdateMythicFinalRedPoint()
			manager.notify:CallUpdateFunc(MYTHIC_FINAL_GETREWARD)
		else
			ShowTips(arg_22_0.result)
		end
	end)
end

function var_0_0.QuitBattle()
	manager.net:SendWithLoadingNew(44026, {}, 44027, function(arg_24_0)
		if isSuccess(arg_24_0.result) then
			MythicData:ClearBattleData()
			manager.notify:CallUpdateFunc(MYTHIC_FINAL_QUITBATTLE)
		else
			ShowTips(arg_24_0.result)
		end
	end)
end

function var_0_0.SelectLevel(arg_25_0, arg_25_1)
	manager.net:SendWithLoadingNew(44024, {
		difficulty_id = arg_25_1
	}, 44025, function(arg_26_0, arg_26_1)
		if isSuccess(arg_26_0.result) then
			MythicData:SetCurHotLevelId(arg_26_1.difficulty_id)
			manager.notify:CallUpdateFunc(MYTHIC_FINAL_HOTITEM_CLICK)
		else
			ShowTips(arg_26_0.result)
		end
	end)
end

function var_0_0.ReSetTeam(arg_27_0)
	manager.net:SendWithLoadingNew(44026, {}, 44027, function(arg_28_0)
		if isSuccess(arg_28_0.result) then
			MythicData:ClearBattleData()
			ReserveTools.ResetContData(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI)

			if arg_27_0 then
				arg_27_0()
			end
		else
			ShowTips(arg_28_0.result)
		end
	end)
end

return var_0_0
