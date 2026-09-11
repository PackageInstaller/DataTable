local CultivateHeroSwitchItem = class("CultivateHeroSwitchItem", ReduxView)

function CultivateHeroSwitchItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CultivateHeroSwitchItem:Init()
	self:InitUI()
	self:AddUIListeners()

	self.normalRewardList_ = {}
	self.upgradeRewardList_ = {}
end

function CultivateHeroSwitchItem:InitUI()
	self:BindCfgUI()
end

function CultivateHeroSwitchItem:AddUIListeners()
	self:AddBtnListener(self.costBtn_, nil, function()
		ShowPopItem(POP_ITEM, {
			CurrencyConst.CURRENCY_TYPE_NEW_RETURN_COIN
		})
	end)
end

function CultivateHeroSwitchItem:SetData(arg_6_1)
	self.taskID_ = arg_6_1

	local var_6_0 = RegressionData:GetBPTaskIsRecharge()
	local var_6_1 = 0
	local var_6_2 = 0

	if RegressionBPTaskCfg[arg_6_1].need <= RegressionData:GetAccumulateCurrency() then
		local var_6_3 = RegressionData:GetBPTaskStatus()

		var_6_1 = var_6_3[arg_6_1] and var_6_3[arg_6_1].is_receive_reward == 1 and 2 or 1

		if var_6_0 >= 1 then
			var_6_2 = var_6_3[arg_6_1] and var_6_3[arg_6_1].is_receive_recharge_reward == 1 and 2 or 1
		end
	end

	local var_6_4 = RegressionBPTaskCfg[self.taskID_].reward

	for iter_6_0, iter_6_1 in ipairs(RegressionBPTaskCfg[self.taskID_].reward) do
		self.normalRewardList_[iter_6_0] = self.normalRewardList_[iter_6_0] or RegressionBPRewardItem.New(self.normalRewardPanel_, self.rewardGo_, true, nil, handler(self, self.OnClickReward))

		self.normalRewardList_[iter_6_0]:SetData(iter_6_1)
		self.normalRewardList_[iter_6_0]:RefreshStatus(var_6_1)
	end

	for iter_6_2 = #var_6_4 + 1, #self.normalRewardList_ do
		self.normalRewardList_[iter_6_2]:Show(false)
	end

	for iter_6_3, iter_6_4 in ipairs(RegressionBPTaskCfg[self.taskID_].recharge_reward) do
		self.upgradeRewardList_[iter_6_3] = self.upgradeRewardList_[iter_6_3] or RegressionBPRewardItem.New(self.upgradeRewardPanel_, self.rewardGo_, true, nil, handler(self, self.OnClickReward))

		self.upgradeRewardList_[iter_6_3]:SetData(iter_6_4, false, var_6_0)
		self.upgradeRewardList_[iter_6_3]:RefreshStatus(var_6_2)
	end

	for iter_6_5 = #RegressionBPTaskCfg[self.taskID_].recharge_reward + 1, #self.upgradeRewardList_ do
		self.upgradeRewardList_[iter_6_5]:Show(false)
	end

	local var_6_5 = RegressionBPTaskCfg[self.taskID_].need
	local var_6_6 = RegressionData:GetAccumulateCurrency()

	var_6_6 = var_6_6 <= RegressionBPTaskCfg[self.taskID_].need and var_6_6 or var_6_5
	self.progressText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), var_6_6, var_6_5)
	self.progress_.value = var_6_6 / var_6_5
	self.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_NEW_RETURN_COIN)
	self.descText_.text = GetTips("RETURN_MATERIAL_MAX_POINT")
	self.numText_.text = "x" .. var_6_5
end

function CultivateHeroSwitchItem:OnClickReward(arg_7_1)
	if not RegressionData:IsRegressionOpen() then
		ShowTips("TIME_OVER")

		return
	end

	local var_7_0 = self:GetCanReceiveTaskList()

	if #var_7_0 > 0 then
		RegressionAction.ReceiveBPReward(var_7_0, self.receiveHandler_)

		return true
	else
		ShowPopItem(POP_ITEM, {
			arg_7_1.id,
			arg_7_1.number
		})
	end

	return false
end

function CultivateHeroSwitchItem:GetCanReceiveTaskList()
	local var_8_0 = {}
	local var_8_1 = RegressionData:GetBPTaskStatus()
	local var_8_2 = RegressionData:GetBPTaskIsRecharge()
	local var_8_3 = RegressionData:GetAccumulateCurrency()

	for iter_8_0, iter_8_1 in ipairs(RegressionCfg[RegressionData:GetRegressionVersion()].regression_bp) do
		if var_8_3 >= RegressionBPTaskCfg[iter_8_1].need then
			if var_8_1[iter_8_1] then
				if var_8_1[iter_8_1].is_receive_reward < 1 then
					var_8_0[#var_8_0 + 1] = {
						receive_type = 1,
						id = iter_8_1
					}
				end

				if var_8_2 >= 1 and var_8_1[iter_8_1].is_receive_recharge_reward < 1 then
					var_8_0[#var_8_0 + 1] = {
						receive_type = 2,
						id = iter_8_1
					}
				end
			else
				var_8_0[#var_8_0 + 1] = {
					receive_type = 1,
					id = iter_8_1
				}

				if var_8_2 >= 1 then
					var_8_0[#var_8_0 + 1] = {
						receive_type = 2,
						id = iter_8_1
					}
				end
			end
		end
	end

	return var_8_0
end

function CultivateHeroSwitchItem:SetReceiveHandler(arg_9_1)
	self.receiveHandler_ = arg_9_1
end

function CultivateHeroSwitchItem:Dispose()
	CultivateHeroSwitchItem.super.Dispose(self)

	if self.upgradeRewardList_ then
		for iter_10_0, iter_10_1 in ipairs(self.upgradeRewardList_) do
			iter_10_1:Dispose()
		end

		self.upgradeRewardList_ = nil
	end

	if self.normalRewardList_ then
		for iter_10_2, iter_10_3 in ipairs(self.normalRewardList_) do
			iter_10_3:Dispose()
		end

		self.normalRewardList_ = nil
	end

	self.receiveHandler_ = nil
end

return CultivateHeroSwitchItem
