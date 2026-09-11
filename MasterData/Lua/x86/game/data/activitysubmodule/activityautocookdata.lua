local var_0_0 = singletonClass("ActivityAutoCookData")

function var_0_0:Init()
	self.curTimeStep_ = 0
	self.curGetGold_ = 0
	self.curHaveGold_ = 0
	self.curSubGoldRate_ = 0
	self.cacheGoldRate_ = nil
	self.curElementList_ = {}
	self.cacheElementList_ = {}
	self.stageData_ = {}

	self:InitFoodInfo()

	self.firstInitData_ = true
	self.speedTipsID_ = 0
	self.localSpeedRateList_ = {}
	self.login_ = false
end

function var_0_0:InitFoodInfo()
	self.zeroFoodInfo_ = {}
	self.threeFoodInfo_ = {}
	self.fourFoodInfo_ = {}
	self.zeroFoodIndex_ = 1

	for iter_2_0, iter_2_1 in pairs(ActivityAutoCookFoodCfg.all) do
		if #ActivityAutoCookFoodCfg[iter_2_1].recipe == 0 then
			table.insert(self.zeroFoodInfo_, iter_2_1)
		elseif #ActivityAutoCookFoodCfg[iter_2_1].recipe == 3 then
			table.insert(self.threeFoodInfo_, iter_2_1)
		elseif #ActivityAutoCookFoodCfg[iter_2_1].recipe == 4 then
			table.insert(self.fourFoodInfo_, iter_2_1)
		end
	end
end

function var_0_0:Cook(arg_3_1)
	if #arg_3_1 == 3 then
		for iter_3_0, iter_3_1 in pairs(self.threeFoodInfo_) do
			local var_3_0 = true

			for iter_3_2, iter_3_3 in pairs(ActivityAutoCookFoodCfg[iter_3_1].recipe) do
				if not table.indexof(arg_3_1, iter_3_3) then
					var_3_0 = false

					break
				end
			end

			if var_3_0 then
				return iter_3_1
			end
		end

		self.zeroFoodIndex_ = self.zeroFoodIndex_ + 1

		if self.zeroFoodIndex_ > #self.zeroFoodInfo_ then
			self.zeroFoodIndex_ = 1
		end

		return self.zeroFoodInfo_[self.zeroFoodIndex_]
	elseif #arg_3_1 == 4 then
		for iter_3_4, iter_3_5 in pairs(self.fourFoodInfo_) do
			local var_3_1 = true

			for iter_3_6, iter_3_7 in pairs(ActivityAutoCookFoodCfg[iter_3_5].recipe) do
				if not table.indexof(arg_3_1, iter_3_7) then
					var_3_1 = false

					break
				end
			end

			if var_3_1 then
				return iter_3_5
			end
		end

		self.zeroFoodIndex_ = self.zeroFoodIndex_ + 1

		if self.zeroFoodIndex_ > #self.zeroFoodInfo_ then
			self.zeroFoodIndex_ = 1
		end

		return self.zeroFoodInfo_[self.zeroFoodIndex_]
	end
end

function var_0_0:SetData(arg_4_1)
	self.curTimeStep_ = arg_4_1.data.timestamp
	self.curGetGold_ = arg_4_1.data.week_token_num
	self.curHaveGold_ = arg_4_1.data.profit_num
	self.curSubGoldRate_ = arg_4_1.data.token_rate
	self.curElementList_ = cleanProtoTable(arg_4_1.data.rate_list)

	if self.cacheGoldRate_ and self.curSubGoldRate_ > self.cacheGoldRate_ then
		if not self.firstInitData_ then
			self:UpdateSpeedTips()
		end

		self.cacheElementList_ = clone(self.curElementList_)
	end

	self.cacheGoldRate_ = self.curSubGoldRate_
	self.curHaveGoldMax_ = arg_4_1.data.profit_max
	self.stageData_ = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.data.stage_info_list) do
		self.stageData_[iter_4_1.stage_id] = iter_4_1.stage_num
	end

	self.curSubGold_ = 0

	if self.firstInitData_ and self:CheckWillRewardMaxToLimit() then
		if self:GetCurWeekCanGet() <= 0 then
			return
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_AUTO_COOK_GOLDMAX .. ActivityConst.AUTO_COOK, 1)
	end

	self.firstInitData_ = false
end

function var_0_0:CheckWillRewardMaxToLimit()
	local var_5_0 = self:GetCurHaveGold()

	if var_5_0 >= self:GetCurHaveGoldMax() or var_5_0 >= self:GetCurWeekCanGet() then
		return true
	end

	return false
end

function var_0_0:UpdateAutoCookReward()
	local var_6_0 = GameSetting.auto_cook_item_week_max.value[1] - self.curGetGold_ - self.curHaveGold_
	local var_6_1 = self.curHaveGoldMax_ - self.curHaveGold_

	if GameSetting.auto_cook_item_week_max.value[1] - self.curGetGold_ - self.curHaveGold_ < 0 then
		var_6_0 = 0
	end

	if var_6_1 < 0 then
		var_6_1 = 0
	end

	self.curSubGold_ = math.min(math.floor((manager.time:GetServerTime() - self.curTimeStep_) / 360) * self.curSubGoldRate_, var_6_0, var_6_1)
end

function var_0_0:GetCurHaveGold()
	self:UpdateAutoCookReward()

	return self.curHaveGold_ + self.curSubGold_
end

function var_0_0:GetCurWeekCanGet()
	return GameSetting.auto_cook_item_week_max.value[1] - self.curGetGold_ - self.curHaveGold_
end

function var_0_0:GetCurGetGold()
	return self.curGetGold_
end

function var_0_0:GetCurHaveGoldMax()
	return self.curHaveGoldMax_
end

function var_0_0:GetCurElemontList()
	return self.curElementList_
end

function var_0_0:FinishStage(arg_12_1)
	if self.stageData_[arg_12_1] == nil then
		self.stageData_[arg_12_1] = 1
	end

	if self.stageData_[arg_12_1] == 1 then
		self:SetFirstFinishStageID(arg_12_1)
	end
end

function var_0_0:GetStageIsFinish(arg_13_1)
	if self.stageData_[arg_13_1] and self.stageData_[arg_13_1] > 0 then
		return true
	else
		return false
	end
end

function var_0_0:GetFirstFinishStageID()
	return self.firstFinishStageID_
end

function var_0_0.SetFirstFinishStageID(arg_15_0, arg_15_1)
	arg_15_0.firstFinishStageID_ = arg_15_1
end

function var_0_0:UpdateSpeedTips()
	local var_16_0 = self:GetDiffientID()

	if var_16_0 == nil then
		return
	end

	local var_16_1 = ActivityAutoCookSpeedCfg[var_16_0]

	if ActivityAutoCookSpeedCfg[var_16_0] == nil or var_16_1.tips_id == 0 then
		return
	end

	local var_16_2 = var_16_1.tips_id

	if var_16_1.type == 11802 then
		QWorldData:AddHint(var_16_2)
	else
		self.speedTipsID_ = var_16_2
	end
end

function var_0_0:GetDiffientID()
	for iter_17_0, iter_17_1 in ipairs(self.curElementList_) do
		if not table.keyof(self.cacheElementList_, iter_17_1) then
			return iter_17_1
		end
	end
end

function var_0_0:GetSpeedTipsID()
	return self.speedTipsID_
end

function var_0_0.ClearSpeedTipsID(arg_19_0)
	arg_19_0.speedTipsID_ = 0
end

function var_0_0:GetLocalSpeedRate(arg_20_1)
	local var_20_0 = self.localSpeedRateList_[arg_20_1]

	if not self.localSpeedRateList_[arg_20_1] then
		var_20_0 = getData("AutoCook", "goldRate" .. arg_20_1)
		var_20_0 = var_20_0 or 0
	end

	self.localSpeedRateList_[arg_20_1] = var_20_0

	return self.localSpeedRateList_[arg_20_1]
end

function var_0_0:SetLocalSpeedRate(arg_21_1, arg_21_2)
	self.localSpeedRateList_[arg_21_1] = arg_21_2

	saveData("AutoCook", "goldRate" .. arg_21_1, arg_21_2)
end

function var_0_0:GetCurSpeedRate()
	return self.curSubGoldRate_
end

return var_0_0
