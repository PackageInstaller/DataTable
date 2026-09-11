local MoonCakeBagGroupItem = class("MoonCakeBagGroupItem", ReduxView)

function MoonCakeBagGroupItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddListeners()
end

function MoonCakeBagGroupItem:InitUI()
	self:BindCfgUI()

	self.itemList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, MoonCakeItem)
	self.rewardItems_ = {}
	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
end

function MoonCakeBagGroupItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeAction.ReceiveCakeCollectReward(self.activityID_, self.groupID_)
	end)
end

function MoonCakeBagGroupItem:Dispose()
	for iter_5_0, iter_5_1 in pairs(self.rewardItems_) do
		iter_5_1:Dispose()
	end

	self.rewardItems_ = nil

	self.itemList_:Dispose()

	self.itemList_ = nil

	MoonCakeBagGroupItem.super.Dispose(self)
end

function MoonCakeBagGroupItem:SetData(arg_6_1, arg_6_2)
	self.groupID_ = arg_6_1
	self.activityID_ = arg_6_2
	self.groupCfg_ = MoonCakeGroupCfg[self.groupID_]
	self.groupName_.text = self.groupCfg_.group_name

	self:RefreshItem()
	self:RefreshReward()
end

function MoonCakeBagGroupItem:RefreshItem()
	self.unlockMoonCakeDic_ = MoonCakeData:GetUnlockCakeDic(self.activityID_)
	self.itemIdList_ = self.groupCfg_.collect_condition

	self.itemList_:StartScroll(#self.itemIdList_)
end

function MoonCakeBagGroupItem:IndexItem(arg_8_1, arg_8_2)
	arg_8_2:SetData(MoonCakeCfg[self.itemIdList_[arg_8_1]].moon_cakes)
	arg_8_2:SetUnlock(self.unlockMoonCakeDic_[self.itemIdList_[arg_8_1]])
end

function MoonCakeBagGroupItem:RefreshReward()
	self.taskNeed_ = #self.itemIdList_
	self.taskProgress_ = 0

	for iter_9_0, iter_9_1 in ipairs(self.itemIdList_) do
		if self.unlockMoonCakeDic_[iter_9_1] then
			self.taskProgress_ = self.taskProgress_ + 1
		end
	end

	self.descText_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_MOONCAKE_COLLECT"), self.taskProgress_, self.taskNeed_)

	for iter_9_2, iter_9_3 in ipairs(self.groupCfg_.reward) do
		if self.rewardItems_[iter_9_2] == nil then
			self.rewardItems_[iter_9_2] = RewardPoolItem.New(self.rewardPanelTrans_)
		end

		self.rewardItems_[iter_9_2]:SetData(iter_9_3)
	end

	for iter_9_4 = #self.groupCfg_.reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_9_4]:Show(false)
	end

	self:RefreshStatus()
end

function MoonCakeBagGroupItem:RefreshStatus()
	local var_10_0 = self.taskProgress_ >= self.taskNeed_

	if MoonCakeData:GetReceivedGroupDic(self.activityID_)[self.groupID_] == true == true then
		self.statusController_:SetSelectedState("received")
	elseif var_10_0 == true then
		self.statusController_:SetSelectedState("completed")
	else
		self.statusController_:SetSelectedState("uncomplete")
	end
end

return MoonCakeBagGroupItem
