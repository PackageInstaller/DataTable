local NewServerBPTaskItem = class("NewServerBPTaskItem", ReduxView)

function NewServerBPTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function NewServerBPTaskItem:Init()
	self:InitUI()
	self:AddUIListeners()

	self.normalRewardList_ = {}
	self.normalItemDataList_ = {}
	self.upgradeRewardList_ = {}
	self.upgradeItemDataList_ = {}
end

function NewServerBPTaskItem:InitUI()
	self:BindCfgUI()

	self.progressController_ = self.controllerEx_:GetController("active")
	self.progressHeadController_ = self.controllerEx_:GetController("isHead")
end

function NewServerBPTaskItem:AddUIListeners()
	return
end

function NewServerBPTaskItem:SetData(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.taskID_ = arg_5_1
	self.activityID_ = arg_5_2
	self.isHead_ = arg_5_3

	local var_5_0 = NewServerData:GetBPTaskIsRecharge()
	local var_5_1 = NewServerBPTaskCfg[self.taskID_].need
	local var_5_2 = NewServerData:GetAccumulateCurrency()
	local var_5_3 = 0
	local var_5_4 = 0

	if NewServerBPTaskCfg[self.taskID_].need <= var_5_2 then
		local var_5_5 = NewServerData:GetBPTaskStatus()

		var_5_3 = var_5_5[arg_5_1] and var_5_5[arg_5_1].is_receive_reward == 1 and 2 or 1

		if var_5_0 >= 1 then
			var_5_4 = var_5_5[arg_5_1] and var_5_5[arg_5_1].is_receive_recharge_reward == 1 and 2 or 1
		end
	end

	for iter_5_0, iter_5_1 in ipairs(NewServerBPTaskCfg[self.taskID_].reward) do
		self.normalRewardList_[iter_5_0] = self.normalRewardList_[iter_5_0] or CommonItemView.New(self.normalRewardPanel_:GetChild(iter_5_0 - 1).gameObject)

		if not self.normalItemDataList_[iter_5_0] then
			self.normalItemDataList_[iter_5_0] = clone(ItemTemplateData)
			self.normalItemDataList_[iter_5_0].clickFun = handler(self, self.OnClickReward)
		end

		self.normalItemDataList_[iter_5_0].id = iter_5_1[1]
		self.normalItemDataList_[iter_5_0].number = iter_5_1[2]
		self.normalItemDataList_[iter_5_0].highLight = var_5_3 == 1
		self.normalItemDataList_[iter_5_0].completedFlag = var_5_3 == 2

		self.normalRewardList_[iter_5_0]:SetData(self.normalItemDataList_[iter_5_0])
	end

	for iter_5_2, iter_5_3 in ipairs(NewServerBPTaskCfg[self.taskID_].recharge_reward) do
		self.upgradeRewardList_[iter_5_2] = self.upgradeRewardList_[iter_5_2] or CommonItemView.New(self.upgradeRewardPanel_:GetChild(iter_5_2 - 1).gameObject)

		if not self.upgradeItemDataList_[iter_5_2] then
			self.upgradeItemDataList_[iter_5_2] = clone(ItemTemplateData)
			self.upgradeItemDataList_[iter_5_2].clickFun = handler(self, self.OnClickReward)
		end

		self.upgradeItemDataList_[iter_5_2].id = iter_5_3[1]
		self.upgradeItemDataList_[iter_5_2].number = iter_5_3[2]
		self.upgradeItemDataList_[iter_5_2].highLight = var_5_4 == 1
		self.upgradeItemDataList_[iter_5_2].completedFlag = var_5_4 == 2
		self.upgradeItemDataList_[iter_5_2].locked = var_5_0 < 1

		self.upgradeRewardList_[iter_5_2]:SetData(self.upgradeItemDataList_[iter_5_2])
	end

	self.progressController_:SetSelectedState(var_5_1 <= var_5_2 and "true" or "false")
	self.progressHeadController_:SetSelectedState(tostring(self.isHead_))

	self.targetText_.text = var_5_1

	local var_5_6
	local var_5_7

	if arg_5_4 then
		var_5_6 = var_5_1 - NewServerBPTaskCfg[arg_5_4].need
		var_5_7 = var_5_2 - NewServerBPTaskCfg[arg_5_4].need
	else
		var_5_6 = var_5_1
		var_5_7 = var_5_2
	end

	local var_5_8 = var_5_7 / var_5_6

	if var_5_7 / var_5_6 < 0 then
		var_5_8 = 0
	elseif var_5_8 > 1 then
		var_5_8 = 1
	end

	if arg_5_3 then
		self.headSlider_.value = var_5_8
	else
		self.middleSlider_.value = var_5_8
	end
end

function NewServerBPTaskItem:OnClickReward(arg_6_1)
	if not ActivityTools.ActivityOpenCheck(self.activityID_) then
		return
	end

	local var_6_0 = self:GetCanReceiveTaskList()

	if #var_6_0 > 0 then
		NewServerAction.ReceiveBPReward(var_6_0, self.receiveHandler_)

		return true
	else
		ShowPopItem(POP_ITEM, {
			arg_6_1.id,
			arg_6_1.number
		})
	end

	return false
end

function NewServerBPTaskItem:GetCanReceiveTaskList()
	local var_7_0 = {}
	local var_7_1 = NewServerData:GetBPTaskStatus()
	local var_7_2 = NewServerData:GetBPTaskIsRecharge()
	local var_7_3 = NewServerData:GetAccumulateCurrency()

	for iter_7_0, iter_7_1 in ipairs(NewServerCfg[self.activityID_].bp) do
		if var_7_3 >= NewServerBPTaskCfg[iter_7_1].need then
			if var_7_1[iter_7_1] then
				if var_7_1[iter_7_1].is_receive_reward < 1 then
					var_7_0[#var_7_0 + 1] = {
						receive_type = 1,
						id = iter_7_1
					}
				end

				if var_7_2 >= 1 and var_7_1[iter_7_1].is_receive_recharge_reward < 1 then
					var_7_0[#var_7_0 + 1] = {
						receive_type = 2,
						id = iter_7_1
					}
				end
			else
				var_7_0[#var_7_0 + 1] = {
					receive_type = 1,
					id = iter_7_1
				}

				if var_7_2 >= 1 then
					var_7_0[#var_7_0 + 1] = {
						receive_type = 2,
						id = iter_7_1
					}
				end
			end
		end
	end

	return var_7_0
end

function NewServerBPTaskItem:SetReceiveHandler(arg_8_1)
	self.receiveHandler_ = arg_8_1
end

function NewServerBPTaskItem:Dispose()
	NewServerBPTaskItem.super.Dispose(self)

	if self.upgradeRewardList_ then
		for iter_9_0, iter_9_1 in ipairs(self.upgradeRewardList_) do
			iter_9_1:Dispose()
		end

		self.upgradeRewardList_ = nil
	end

	if self.normalRewardList_ then
		for iter_9_2, iter_9_3 in ipairs(self.normalRewardList_) do
			iter_9_3:Dispose()
		end

		self.normalRewardList_ = nil
	end

	self.receiveHandler_ = nil
end

return NewServerBPTaskItem
