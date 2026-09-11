local ActivitySpringFestivalGiveDayItem = class("ActivitySpringFestivalGiveDayItem", ReduxView)

function ActivitySpringFestivalGiveDayItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivitySpringFestivalGiveDayItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySpringFestivalGiveDayItem:InitUI()
	self:BindCfgUI()

	self.stateCon_ = self.controllerEx_:GetController("state")
	self.selectedCon_ = self.controllerEx_:GetController("selected")
	self.rewardItemList_ = {}
	self.itemDataList_ = {}

	for iter_3_0 = 1, 2 do
		self.rewardItemList_[iter_3_0] = CommonItemView.New(self["rewardGo_" .. iter_3_0], true)
	end
end

function ActivitySpringFestivalGiveDayItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.receiveFunc_ then
			self.receiveFunc_(self.cfg.state, self.index)
		end
	end)
	self:AddBtnListener(self.btn_complete, nil, function()
		self.selectedCon_:SetSelectedIndex(0)

		if self.receiveFunc_ then
			self.receiveFunc_(self.cfg.state, self.index)
		end
	end)
	self:AddBtnListener(self.btn_lock, nil, function()
		ShowTips(string.format(GetTips("ACTIVITY_AREA_BATTLE_UNLOCK_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ActivitySpringFestivalGive2100Cfg[ActivitySpringFestivalGive2100Cfg.all[self.index]].sub_id).startTime)))
	end)
end

function ActivitySpringFestivalGiveDayItem:RefreshSelect(arg_8_1)
	self.selectedCon_:SetSelectedIndex(self.index == arg_8_1 and 0 or 1)
end

function ActivitySpringFestivalGiveDayItem:SetData(arg_9_1)
	self.index = arg_9_1
	self.cfg = ActivitySpringFestivalGive2100Data:GetDayListInfoByIndex(arg_9_1)

	local var_9_0 = ActivitySpringFestivalGive2100Cfg[ActivitySpringFestivalGive2100Cfg.all[arg_9_1]]

	if ActivityData:GetActivityIsOpen(ActivitySpringFestivalGive2100Cfg[ActivitySpringFestivalGive2100Cfg.all[arg_9_1]].sub_id) and ActivityData:GetActivityData(ActivitySpringFestivalGive2100Cfg[ActivitySpringFestivalGive2100Cfg.all[arg_9_1]].sub_id).startTime < manager.time:GetServerTime() then
		if self.cfg.state == "reward" then
			self.stateCon_:SetSelectedIndex(1)
		else
			self.stateCon_:SetSelectedIndex(2)
		end
	else
		self.stateCon_:SetSelectedIndex(0)
	end

	self:RefreshReward(var_9_0.reward)

	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. var_9_0.hero_id)
	self.day_.text = GetI18NText(var_9_0.title)
end

function ActivitySpringFestivalGiveDayItem:RefreshReward(arg_10_1)
	local var_10_0 = ActivitySpringFestivalGive2100Data:GetDayListInfoByIndex(self.index)

	for iter_10_0, iter_10_1 in ipairs((getRewardFromDropCfg(arg_10_1, true))) do
		if not self.itemDataList_[iter_10_0] then
			self.itemDataList_[iter_10_0] = clone(ItemTemplateData)
			self.itemDataList_[iter_10_0].clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end

		self.itemDataList_[iter_10_0].id = iter_10_1.id
		self.itemDataList_[iter_10_0].number = iter_10_1.num
		self.itemDataList_[iter_10_0].completedFlag = var_10_0.state == "complete"
		self.itemDataList_[iter_10_0].grayFlag = var_10_0.state == "complete"

		self.rewardItemList_[iter_10_0]:SetData(self.itemDataList_[iter_10_0])
	end
end

function ActivitySpringFestivalGiveDayItem:RegisterClickFunc(arg_12_1)
	self.receiveFunc_ = arg_12_1
end

function ActivitySpringFestivalGiveDayItem:Dispose()
	for iter_13_0, iter_13_1 in pairs(self.rewardItemList_) do
		iter_13_1:Dispose()
	end

	self:RemoveAllListeners()
	ActivitySpringFestivalGiveDayItem.super.Dispose(self)
end

return ActivitySpringFestivalGiveDayItem
