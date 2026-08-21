local var_0_0 = class("CultivateHeroSwitchItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()

	arg_2_0.normalRewardList_ = {}
	arg_2_0.upgradeRewardList_ = {}
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.costBtn_, nil, function()
		ShowPopItem(POP_ITEM, {
			CurrencyConst.CURRENCY_TYPE_NEW_RETURN_COIN
		})
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.taskID_ = arg_6_1

	local var_6_0 = RegressionData:GetBPTaskIsRecharge()
	local var_6_1 = RegressionData:GetAccumulateCurrency()
	local var_6_2 = RegressionBPTaskCfg[arg_6_1].need
	local var_6_3 = 0
	local var_6_4 = 0

	if var_6_2 <= var_6_1 then
		local var_6_5 = RegressionData:GetBPTaskStatus()

		var_6_3 = var_6_5[arg_6_1] and var_6_5[arg_6_1].is_receive_reward == 1 and 2 or 1

		if var_6_0 >= 1 then
			var_6_4 = var_6_5[arg_6_1] and var_6_5[arg_6_1].is_receive_recharge_reward == 1 and 2 or 1
		end
	end

	local var_6_6 = RegressionBPTaskCfg[arg_6_0.taskID_].reward

	for iter_6_0, iter_6_1 in ipairs(var_6_6) do
		if not arg_6_0.normalRewardList_[iter_6_0] then
			arg_6_0.normalRewardList_[iter_6_0] = RegressionBPRewardItem.New(arg_6_0.normalRewardPanel_, arg_6_0.rewardGo_, true, nil, handler(arg_6_0, arg_6_0.OnClickReward))
		end

		arg_6_0.normalRewardList_[iter_6_0]:SetData(iter_6_1)
		arg_6_0.normalRewardList_[iter_6_0]:RefreshStatus(var_6_3)
	end

	for iter_6_2 = #var_6_6 + 1, #arg_6_0.normalRewardList_ do
		arg_6_0.normalRewardList_[iter_6_2]:Show(false)
	end

	local var_6_7 = RegressionBPTaskCfg[arg_6_0.taskID_].recharge_reward

	for iter_6_3, iter_6_4 in ipairs(var_6_7) do
		if not arg_6_0.upgradeRewardList_[iter_6_3] then
			arg_6_0.upgradeRewardList_[iter_6_3] = RegressionBPRewardItem.New(arg_6_0.upgradeRewardPanel_, arg_6_0.rewardGo_, true, nil, handler(arg_6_0, arg_6_0.OnClickReward))
		end

		arg_6_0.upgradeRewardList_[iter_6_3]:SetData(iter_6_4, false, var_6_0)
		arg_6_0.upgradeRewardList_[iter_6_3]:RefreshStatus(var_6_4)
	end

	for iter_6_5 = #var_6_7 + 1, #arg_6_0.upgradeRewardList_ do
		arg_6_0.upgradeRewardList_[iter_6_5]:Show(false)
	end

	local var_6_8 = RegressionBPTaskCfg[arg_6_0.taskID_].need
	local var_6_9 = RegressionData:GetAccumulateCurrency()

	var_6_9 = var_6_9 <= var_6_8 and var_6_9 or var_6_8
	arg_6_0.progressText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), var_6_9, var_6_8)
	arg_6_0.progress_.value = var_6_9 / var_6_8
	arg_6_0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_NEW_RETURN_COIN)
	arg_6_0.descText_.text = GetTips("RETURN_MATERIAL_MAX_POINT")
	arg_6_0.numText_.text = "x" .. var_6_8
end

function var_0_0.OnClickReward(arg_7_0, arg_7_1)
	if not RegressionData:IsRegressionOpen() then
		ShowTips("TIME_OVER")

		return
	end

	local var_7_0 = arg_7_0:GetCanReceiveTaskList()

	if #var_7_0 > 0 then
		RegressionAction.ReceiveBPReward(var_7_0, arg_7_0.receiveHandler_)

		return true
	else
		ShowPopItem(POP_ITEM, {
			arg_7_1.id,
			arg_7_1.number
		})
	end

	return false
end

function var_0_0.GetCanReceiveTaskList(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = RegressionData:GetRegressionVersion()
	local var_8_2 = RegressionCfg[var_8_1].regression_bp
	local var_8_3 = RegressionData:GetBPTaskStatus()
	local var_8_4 = RegressionData:GetBPTaskIsRecharge()
	local var_8_5 = RegressionData:GetAccumulateCurrency()

	for iter_8_0, iter_8_1 in ipairs(var_8_2) do
		if var_8_5 >= RegressionBPTaskCfg[iter_8_1].need then
			if var_8_3[iter_8_1] then
				if var_8_3[iter_8_1].is_receive_reward < 1 then
					var_8_0[#var_8_0 + 1] = {
						receive_type = 1,
						id = iter_8_1
					}
				end

				if var_8_4 >= 1 and var_8_3[iter_8_1].is_receive_recharge_reward < 1 then
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

				if var_8_4 >= 1 then
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

function var_0_0.SetReceiveHandler(arg_9_0, arg_9_1)
	arg_9_0.receiveHandler_ = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)

	if arg_10_0.upgradeRewardList_ then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.upgradeRewardList_) do
			iter_10_1:Dispose()
		end

		arg_10_0.upgradeRewardList_ = nil
	end

	if arg_10_0.normalRewardList_ then
		for iter_10_2, iter_10_3 in ipairs(arg_10_0.normalRewardList_) do
			iter_10_3:Dispose()
		end

		arg_10_0.normalRewardList_ = nil
	end

	arg_10_0.receiveHandler_ = nil
end

return var_0_0
