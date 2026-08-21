local var_0_0 = singletonClass("ActivityAutoCookData")

function var_0_0.Init(arg_1_0)
	arg_1_0.curTimeStep_ = 0
	arg_1_0.curGetGold_ = 0
	arg_1_0.curHaveGold_ = 0
	arg_1_0.curSubGoldRate_ = 0
	arg_1_0.cacheGoldRate_ = nil
	arg_1_0.curElementList_ = {}
	arg_1_0.cacheElementList_ = {}
	arg_1_0.stageData_ = {}

	arg_1_0:InitFoodInfo()

	arg_1_0.firstInitData_ = true
	arg_1_0.speedTipsID_ = 0
	arg_1_0.localSpeedRateList_ = {}
	arg_1_0.login_ = false
end

function var_0_0.InitFoodInfo(arg_2_0)
	arg_2_0.zeroFoodInfo_ = {}
	arg_2_0.threeFoodInfo_ = {}
	arg_2_0.fourFoodInfo_ = {}
	arg_2_0.zeroFoodIndex_ = 1

	for iter_2_0, iter_2_1 in pairs(ActivityAutoCookFoodCfg.all) do
		local var_2_0 = ActivityAutoCookFoodCfg[iter_2_1]

		if #var_2_0.recipe == 0 then
			table.insert(arg_2_0.zeroFoodInfo_, iter_2_1)
		elseif #var_2_0.recipe == 3 then
			table.insert(arg_2_0.threeFoodInfo_, iter_2_1)
		elseif #var_2_0.recipe == 4 then
			table.insert(arg_2_0.fourFoodInfo_, iter_2_1)
		end
	end
end

function var_0_0.Cook(arg_3_0, arg_3_1)
	local var_3_0 = #arg_3_1

	if var_3_0 == 3 then
		for iter_3_0, iter_3_1 in pairs(arg_3_0.threeFoodInfo_) do
			local var_3_1 = ActivityAutoCookFoodCfg[iter_3_1]
			local var_3_2 = true

			for iter_3_2, iter_3_3 in pairs(var_3_1.recipe) do
				if not table.indexof(arg_3_1, iter_3_3) then
					var_3_2 = false

					break
				end
			end

			if var_3_2 then
				return iter_3_1
			end
		end

		local var_3_3 = arg_3_0.zeroFoodInfo_[arg_3_0.zeroFoodIndex_]

		arg_3_0.zeroFoodIndex_ = arg_3_0.zeroFoodIndex_ + 1

		if arg_3_0.zeroFoodIndex_ > #arg_3_0.zeroFoodInfo_ then
			arg_3_0.zeroFoodIndex_ = 1
		end

		return var_3_3
	elseif var_3_0 == 4 then
		for iter_3_4, iter_3_5 in pairs(arg_3_0.fourFoodInfo_) do
			local var_3_4 = ActivityAutoCookFoodCfg[iter_3_5]
			local var_3_5 = true

			for iter_3_6, iter_3_7 in pairs(var_3_4.recipe) do
				if not table.indexof(arg_3_1, iter_3_7) then
					var_3_5 = false

					break
				end
			end

			if var_3_5 then
				return iter_3_5
			end
		end

		local var_3_6 = arg_3_0.zeroFoodInfo_[arg_3_0.zeroFoodIndex_]

		arg_3_0.zeroFoodIndex_ = arg_3_0.zeroFoodIndex_ + 1

		if arg_3_0.zeroFoodIndex_ > #arg_3_0.zeroFoodInfo_ then
			arg_3_0.zeroFoodIndex_ = 1
		end

		return var_3_6
	end
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.curTimeStep_ = arg_4_1.data.timestamp
	arg_4_0.curGetGold_ = arg_4_1.data.week_token_num
	arg_4_0.curHaveGold_ = arg_4_1.data.profit_num
	arg_4_0.curSubGoldRate_ = arg_4_1.data.token_rate
	arg_4_0.curElementList_ = cleanProtoTable(arg_4_1.data.rate_list)

	if arg_4_0.cacheGoldRate_ and arg_4_0.curSubGoldRate_ > arg_4_0.cacheGoldRate_ then
		if not arg_4_0.firstInitData_ then
			arg_4_0:UpdateSpeedTips()
		end

		arg_4_0.cacheElementList_ = clone(arg_4_0.curElementList_)
	end

	arg_4_0.cacheGoldRate_ = arg_4_0.curSubGoldRate_
	arg_4_0.curHaveGoldMax_ = arg_4_1.data.profit_max
	arg_4_0.stageData_ = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.data.stage_info_list) do
		arg_4_0.stageData_[iter_4_1.stage_id] = iter_4_1.stage_num
	end

	arg_4_0.curSubGold_ = 0

	if arg_4_0.firstInitData_ and arg_4_0:CheckWillRewardMaxToLimit() then
		if arg_4_0:GetCurWeekCanGet() <= 0 then
			return
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_AUTO_COOK_GOLDMAX .. ActivityConst.AUTO_COOK, 1)
	end

	arg_4_0.firstInitData_ = false
end

function var_0_0.CheckWillRewardMaxToLimit(arg_5_0)
	local var_5_0 = arg_5_0:GetCurHaveGold()

	if var_5_0 >= arg_5_0:GetCurHaveGoldMax() or var_5_0 >= arg_5_0:GetCurWeekCanGet() then
		return true
	end

	return false
end

function var_0_0.UpdateAutoCookReward(arg_6_0)
	local var_6_0 = manager.time:GetServerTime() - arg_6_0.curTimeStep_
	local var_6_1 = math.floor(var_6_0 / 360) * arg_6_0.curSubGoldRate_
	local var_6_2 = GameSetting.auto_cook_item_week_max.value[1] - arg_6_0.curGetGold_ - arg_6_0.curHaveGold_
	local var_6_3 = arg_6_0.curHaveGoldMax_ - arg_6_0.curHaveGold_

	if var_6_2 < 0 then
		var_6_2 = 0
	end

	if var_6_3 < 0 then
		var_6_3 = 0
	end

	arg_6_0.curSubGold_ = math.min(var_6_1, var_6_2, var_6_3)
end

function var_0_0.GetCurHaveGold(arg_7_0)
	arg_7_0:UpdateAutoCookReward()

	return arg_7_0.curHaveGold_ + arg_7_0.curSubGold_
end

function var_0_0.GetCurWeekCanGet(arg_8_0)
	return GameSetting.auto_cook_item_week_max.value[1] - arg_8_0.curGetGold_ - arg_8_0.curHaveGold_
end

function var_0_0.GetCurGetGold(arg_9_0)
	return arg_9_0.curGetGold_
end

function var_0_0.GetCurHaveGoldMax(arg_10_0)
	return arg_10_0.curHaveGoldMax_
end

function var_0_0.GetCurElemontList(arg_11_0)
	return arg_11_0.curElementList_
end

function var_0_0.FinishStage(arg_12_0, arg_12_1)
	if arg_12_0.stageData_[arg_12_1] == nil then
		arg_12_0.stageData_[arg_12_1] = 1
	end

	if arg_12_0.stageData_[arg_12_1] == 1 then
		arg_12_0:SetFirstFinishStageID(arg_12_1)
	end
end

function var_0_0.GetStageIsFinish(arg_13_0, arg_13_1)
	if arg_13_0.stageData_[arg_13_1] and arg_13_0.stageData_[arg_13_1] > 0 then
		return true
	else
		return false
	end
end

function var_0_0.GetFirstFinishStageID(arg_14_0)
	return arg_14_0.firstFinishStageID_
end

function var_0_0.SetFirstFinishStageID(arg_15_0, arg_15_1)
	arg_15_0.firstFinishStageID_ = arg_15_1
end

function var_0_0.UpdateSpeedTips(arg_16_0)
	local var_16_0 = arg_16_0:GetDiffientID()

	if var_16_0 == nil then
		return
	end

	local var_16_1 = ActivityAutoCookSpeedCfg[var_16_0]

	if var_16_1 == nil or var_16_1.tips_id == 0 then
		return
	end

	local var_16_2 = var_16_1.tips_id

	if var_16_1.type == 11802 then
		QWorldData:AddHint(var_16_2)
	else
		arg_16_0.speedTipsID_ = var_16_2
	end
end

function var_0_0.GetDiffientID(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.curElementList_) do
		if not table.keyof(arg_17_0.cacheElementList_, iter_17_1) then
			return iter_17_1
		end
	end
end

function var_0_0.GetSpeedTipsID(arg_18_0)
	return arg_18_0.speedTipsID_
end

function var_0_0.ClearSpeedTipsID(arg_19_0)
	arg_19_0.speedTipsID_ = 0
end

function var_0_0.GetLocalSpeedRate(arg_20_0, arg_20_1)
	arg_20_0.localSpeedRateList_[arg_20_1] = arg_20_0.localSpeedRateList_[arg_20_1] or getData("AutoCook", "goldRate" .. arg_20_1) or 0

	return arg_20_0.localSpeedRateList_[arg_20_1]
end

function var_0_0.SetLocalSpeedRate(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.localSpeedRateList_[arg_21_1] = arg_21_2

	saveData("AutoCook", "goldRate" .. arg_21_1, arg_21_2)
end

function var_0_0.GetCurSpeedRate(arg_22_0)
	return arg_22_0.curSubGoldRate_
end

return var_0_0
