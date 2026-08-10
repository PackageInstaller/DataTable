local var_0_0 = class("RegressionBPTaskPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/ReturnTwo/RT2stBPUI")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_1)

	arg_1_0.gameObject_ = var_1_1
	arg_1_0.transform_ = var_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.taskItemList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiList_, RegressionBPTaskItem)
	arg_2_0.gsPayCallback_ = handler(arg_2_0, arg_2_0.OnPaySuccess)
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.ReceiveBtn_, nil, function()
		if not RegressionData:IsRegressionOpen() then
			ShowTips("TIME_OVER")

			return
		end

		RegressionAction.ReceiveBPReward(arg_3_0:GetCanReceiveTaskList(), handler(arg_3_0, arg_3_0.OnRegressionBPTaskReceive))
	end)
	arg_3_0:AddBtnListener(arg_3_0.UpgradeBtn_, nil, function()
		if not RegressionData:IsRegressionOpen() then
			ShowTips("TIME_OVER")

			return
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_regression_bp_buy = 0
		})
		PayAction.RequestGSPay(601, 1)
	end)
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)

	if arg_7_0.taskItemList_ then
		arg_7_0.taskItemList_:Dispose()

		arg_7_0.taskItemList_ = nil
	end

	arg_7_0.gsPayCallback_ = nil

	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.transform_ = nil
	arg_7_0.gameObject_ = nil
end

function var_0_0.SetData(arg_8_0)
	local var_8_0 = RegressionData:GetRegressionVersion()

	arg_8_0.taskList_ = RegressionCfg[var_8_0].regression_bp

	local var_8_1 = RegressionData:GetBPTaskStatus()
	local var_8_2 = RegressionData:GetBPTaskIsRecharge()
	local var_8_3 = RegressionData:GetAccumulateCurrency()
	local var_8_4 = 1
	local var_8_5 = false

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.taskList_) do
		if var_8_3 >= RegressionBPTaskCfg[iter_8_1].need then
			if var_8_1[iter_8_1] == nil then
				var_8_5 = true
			elseif var_8_1[iter_8_1].is_receive_reward < 1 or var_8_2 >= 1 and var_8_1[iter_8_1].is_receive_recharge_reward < 1 then
				var_8_5 = true
			end
		end

		if var_8_5 == true then
			var_8_4 = iter_8_0

			break
		end
	end

	arg_8_0.ReceiveBtn_.interactable = var_8_5

	arg_8_0.taskItemList_:StartScroll(#arg_8_0.taskList_, var_8_4)
	SetActive(arg_8_0.UpgradeGo_, var_8_2 < 1)
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_0.taskList_[arg_9_1])
	arg_9_2:SetReceiveHandler(handler(arg_9_0, arg_9_0.OnRegressionBPTaskReceive))
end

function var_0_0.SetActive(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)

	if arg_10_1 == true then
		manager.redPoint:bindUIandKey(arg_10_0.ReceiveBtn_.transform, RedPointConst.REGRESSION_BP)
		manager.notify:RegistListener(RECHARGE_SUCCESS, arg_10_0.gsPayCallback_)
	else
		manager.redPoint:unbindUIandKey(arg_10_0.ReceiveBtn_.transform, RedPointConst.REGRESSION_BP)
		manager.notify:RemoveListener(RECHARGE_SUCCESS, arg_10_0.gsPayCallback_)
	end
end

function var_0_0.OnPaySuccess(arg_11_0)
	RegressionAction.SetBPTaskIsRecharge()
	arg_11_0:SetData()
end

function var_0_0.OnRegressionBPTaskReceive(arg_12_0)
	arg_12_0:SetData()
end

function var_0_0.UpdateBar(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.GetCanReceiveTaskList(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = RegressionData:GetRegressionVersion()
	local var_14_2 = RegressionCfg[var_14_1].regression_bp
	local var_14_3 = RegressionData:GetBPTaskStatus()
	local var_14_4 = RegressionData:GetBPTaskIsRecharge()
	local var_14_5 = RegressionData:GetAccumulateCurrency()

	for iter_14_0, iter_14_1 in ipairs(var_14_2) do
		if var_14_5 >= RegressionBPTaskCfg[iter_14_1].need then
			if var_14_3[iter_14_1] then
				if var_14_3[iter_14_1].is_receive_reward < 1 then
					var_14_0[#var_14_0 + 1] = {
						receive_type = 1,
						id = iter_14_1
					}
				end

				if var_14_4 >= 1 and var_14_3[iter_14_1].is_receive_recharge_reward < 1 then
					var_14_0[#var_14_0 + 1] = {
						receive_type = 2,
						id = iter_14_1
					}
				end
			else
				var_14_0[#var_14_0 + 1] = {
					receive_type = 1,
					id = iter_14_1
				}

				if var_14_4 >= 1 then
					var_14_0[#var_14_0 + 1] = {
						receive_type = 2,
						id = iter_14_1
					}
				end
			end
		end
	end

	return var_14_0
end

return var_0_0
