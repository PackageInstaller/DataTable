local RegressionBPTaskPage = class("RegressionBPTaskPage", ReduxView)

function RegressionBPTaskPage:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("Widget/System/ReturnTwo/RT2stBPUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function RegressionBPTaskPage:Init()
	self:InitUI()
	self:AddUIListener()

	self.taskItemList_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, RegressionBPTaskItem)
	self.gsPayCallback_ = handler(self, self.OnPaySuccess)
end

function RegressionBPTaskPage:AddUIListener()
	self:AddBtnListener(self.ReceiveBtn_, nil, function()
		if not RegressionData:IsRegressionOpen() then
			ShowTips("TIME_OVER")

			return
		end

		RegressionAction.ReceiveBPReward(self:GetCanReceiveTaskList(), handler(self, self.OnRegressionBPTaskReceive))
	end)
	self:AddBtnListener(self.UpgradeBtn_, nil, function()
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

function RegressionBPTaskPage:InitUI()
	self:BindCfgUI()
end

function RegressionBPTaskPage:Dispose()
	RegressionBPTaskPage.super.Dispose(self)

	if self.taskItemList_ then
		self.taskItemList_:Dispose()

		self.taskItemList_ = nil
	end

	self.gsPayCallback_ = nil

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function RegressionBPTaskPage:SetData()
	self.taskList_ = RegressionCfg[RegressionData:GetRegressionVersion()].regression_bp

	local var_8_0 = RegressionData:GetBPTaskStatus()
	local var_8_1 = RegressionData:GetBPTaskIsRecharge()
	local var_8_2 = RegressionData:GetAccumulateCurrency()
	local var_8_3 = 1
	local var_8_4 = false

	for iter_8_0, iter_8_1 in ipairs(self.taskList_) do
		if var_8_2 >= RegressionBPTaskCfg[iter_8_1].need then
			if var_8_0[iter_8_1] == nil then
				var_8_4 = true
			elseif var_8_0[iter_8_1].is_receive_reward < 1 or var_8_1 >= 1 and var_8_0[iter_8_1].is_receive_recharge_reward < 1 then
				var_8_4 = true
			end
		end

		if var_8_4 == true then
			var_8_3 = iter_8_0

			break
		end
	end

	self.ReceiveBtn_.interactable = var_8_4

	self.taskItemList_:StartScroll(#self.taskList_, var_8_3)
	SetActive(self.UpgradeGo_, var_8_1 < 1)
end

function RegressionBPTaskPage:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.taskList_[arg_9_1])
	arg_9_2:SetReceiveHandler(handler(self, self.OnRegressionBPTaskReceive))
end

function RegressionBPTaskPage:SetActive(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)

	if arg_10_1 == true then
		manager.redPoint:bindUIandKey(self.ReceiveBtn_.transform, RedPointConst.REGRESSION_BP)
		manager.notify:RegistListener(RECHARGE_SUCCESS, self.gsPayCallback_)
	else
		manager.redPoint:unbindUIandKey(self.ReceiveBtn_.transform, RedPointConst.REGRESSION_BP)
		manager.notify:RemoveListener(RECHARGE_SUCCESS, self.gsPayCallback_)
	end
end

function RegressionBPTaskPage:OnPaySuccess()
	RegressionAction.SetBPTaskIsRecharge()
	self:SetData()
end

function RegressionBPTaskPage:OnRegressionBPTaskReceive()
	self:SetData()
end

function RegressionBPTaskPage:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function RegressionBPTaskPage:GetCanReceiveTaskList()
	local var_14_0 = {}
	local var_14_1 = RegressionData:GetBPTaskStatus()
	local var_14_2 = RegressionData:GetBPTaskIsRecharge()
	local var_14_3 = RegressionData:GetAccumulateCurrency()

	for iter_14_0, iter_14_1 in ipairs(RegressionCfg[RegressionData:GetRegressionVersion()].regression_bp) do
		if var_14_3 >= RegressionBPTaskCfg[iter_14_1].need then
			if var_14_1[iter_14_1] then
				if var_14_1[iter_14_1].is_receive_reward < 1 then
					var_14_0[#var_14_0 + 1] = {
						receive_type = 1,
						id = iter_14_1
					}
				end

				if var_14_2 >= 1 and var_14_1[iter_14_1].is_receive_recharge_reward < 1 then
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

				if var_14_2 >= 1 then
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

return RegressionBPTaskPage
