local NewServerBPTaskPage = class("NewServerBPTaskPage", ReduxView)

function NewServerBPTaskPage:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("Widget/System/NewServer/NewServerPasserUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function NewServerBPTaskPage:Init()
	self:InitUI()
	self:AddUIListener()

	self.taskItemList_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, NewServerBPTaskItem)
	self.gsPayCallback_ = handler(self, self.OnPaySuccess)
end

function NewServerBPTaskPage:AddUIListener()
	self:AddBtnListener(self.ReceiveBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(self.activityID_) then
			return
		end

		NewServerAction.ReceiveBPReward(self:GetCanReceiveTaskList(), handler(self, self.OnBPTaskReceive))
	end)
	self:AddBtnListener(self.UpgradeBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(self.activityID_) then
			return
		end

		PayAction.RequestGSPay(NewServerCfg[self.activityID_].bp_goods_id, 1)
	end)
end

function NewServerBPTaskPage:InitUI()
	self:BindCfgUI()
end

function NewServerBPTaskPage:Dispose()
	if self.taskItemList_ then
		self.taskItemList_:Dispose()

		self.taskItemList_ = nil
	end

	self.gsPayCallback_ = nil

	NewServerBPTaskPage.super.Dispose(self)
end

function NewServerBPTaskPage:SetData(arg_8_1)
	self.activityID_ = arg_8_1
	self.taskList_ = NewServerCfg[self.activityID_].bp

	local var_8_0 = NewServerData:GetBPTaskStatus()
	local var_8_1 = NewServerData:GetBPTaskIsRecharge()
	local var_8_2 = NewServerData:GetAccumulateCurrency()

	self.progressText_.text = var_8_2

	local var_8_3 = 1
	local var_8_4 = false

	for iter_8_0, iter_8_1 in ipairs(self.taskList_) do
		if var_8_2 >= NewServerBPTaskCfg[iter_8_1].need then
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

	SetActive(self.recevieBtnGo_, var_8_4)
	SetActive(self.UpgradeGo_, var_8_1 < 1)
	self.taskItemList_:StartScroll(#self.taskList_, var_8_3)
end

function NewServerBPTaskPage:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.taskList_[arg_9_1], self.activityID_, arg_9_1 == 1, self.taskList_[arg_9_1 - 1])
	arg_9_2:SetReceiveHandler(handler(self, self.OnBPTaskReceive))
end

function NewServerBPTaskPage:SetActive(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

function NewServerBPTaskPage:OnEnter()
	manager.redPoint:bindUIandKey(self.ReceiveBtn_.transform, RedPointConst.ACTIVITY_NEW_SERVER_BP)
	manager.notify:RegistListener(RECHARGE_SUCCESS, self.gsPayCallback_)
end

function NewServerBPTaskPage:OnExit()
	manager.redPoint:unbindUIandKey(self.ReceiveBtn_.transform, RedPointConst.ACTIVITY_NEW_SERVER_BP)
	manager.notify:RemoveListener(RECHARGE_SUCCESS, self.gsPayCallback_)
end

function NewServerBPTaskPage:OnPaySuccess()
	NewServerAction.SetBPTaskIsRecharge()
	self:SetData(self.activityID_)
end

function NewServerBPTaskPage:OnBPTaskReceive()
	self:SetData(self.activityID_)
end

function NewServerBPTaskPage:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function NewServerBPTaskPage:GetCanReceiveTaskList()
	local var_16_0 = {}
	local var_16_1 = NewServerData:GetBPTaskStatus()
	local var_16_2 = NewServerData:GetBPTaskIsRecharge()
	local var_16_3 = NewServerData:GetAccumulateCurrency()

	for iter_16_0, iter_16_1 in ipairs(NewServerCfg[self.activityID_].bp) do
		if var_16_3 >= NewServerBPTaskCfg[iter_16_1].need then
			if var_16_1[iter_16_1] then
				if var_16_1[iter_16_1].is_receive_reward < 1 then
					var_16_0[#var_16_0 + 1] = {
						receive_type = 1,
						id = iter_16_1
					}
				end

				if var_16_2 >= 1 and var_16_1[iter_16_1].is_receive_recharge_reward < 1 then
					var_16_0[#var_16_0 + 1] = {
						receive_type = 2,
						id = iter_16_1
					}
				end
			else
				var_16_0[#var_16_0 + 1] = {
					receive_type = 1,
					id = iter_16_1
				}

				if var_16_2 >= 1 then
					var_16_0[#var_16_0 + 1] = {
						receive_type = 2,
						id = iter_16_1
					}
				end
			end
		end
	end

	return var_16_0
end

return NewServerBPTaskPage
