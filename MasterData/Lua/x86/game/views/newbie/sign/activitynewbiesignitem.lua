local ActivityNewbieSignItem = class("ActivityNewbieSignItem", ReduxView)

function ActivityNewbieSignItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.transform_, "conName")

	self:AddListeners()

	self.refreshHandler_ = handler(self, self.ZeroTimeRefresh)

	manager.notify:RegistListener(ZERO_REFRESH, self.refreshHandler_)
end

function ActivityNewbieSignItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		self:OnSign()
	end)
end

function ActivityNewbieSignItem:OnSign()
	if manager.time:GetTodayFreshTime() > ActivityNewbieData:GetSignTimestamp() and ActivityNewbieData:GetSignDay() + 1 == table.keyof(ActivityNewbieTools.GetSignCfg(), self.id_) then
		ActivityNewbieAction.NewbieSignIn(function(arg_5_0)
			if isSuccess(arg_5_0.result) then
				ActivityNewbieData:SignIn()
				getReward2(arg_5_0.reward_list)
				self.controller_:SetSelectedState("2")
			else
				ShowTips(arg_5_0.result)
			end
		end)
	end
end

function ActivityNewbieSignItem:ZeroTimeRefresh()
	self:RefreshUI(self.id_)
end

function ActivityNewbieSignItem:RefreshUI(arg_7_1)
	if self.id_ ~= arg_7_1 then
		self.itemData_ = clone(ItemTemplateData)
		self.itemData_.id = SignCfg[arg_7_1].reward[1]
		self.itemData_.number = SignCfg[arg_7_1].reward[2]

		function self.itemData_:clickFun()
			if manager.time:GetTodayFreshTime() > ActivityNewbieData:GetSignTimestamp() and ActivityNewbieData:GetSignDay() + 1 == table.keyof(ActivityNewbieTools.GetSignCfg(), arg_7_1) then
				self:OnSign()
			else
				ShowPopItem(POP_SOURCE_ITEM, {
					self.id,
					self.number
				})
			end
		end

		self.id_ = arg_7_1
	end

	self.rewardGo_ = self.rewardGo_ or CommonItemView.New(self.itemGo_)

	self.rewardGo_:SetData(self.itemData_)

	local var_7_0 = table.keyof(ActivityNewbieTools.GetSignCfg(), arg_7_1)

	self.textDay_.text = var_7_0

	if var_7_0 <= ActivityNewbieData:GetSignDay() then
		self.controller_:SetSelectedState("2")
	else
		self.controller_:SetSelectedState("0")
	end

	if manager.time:GetTodayFreshTime() > ActivityNewbieData:GetSignTimestamp() and ActivityNewbieData:GetSignDay() + 1 == var_7_0 then
		self.controller_:SetSelectedState("1")
	end
end

function ActivityNewbieSignItem:Dispose()
	manager.notify:RemoveListener(ZERO_REFRESH, self.refreshHandler_)

	self.refreshHandler_ = nil

	if self.rewardGo_ then
		self.rewardGo_:Dispose()

		self.rewardGo_ = nil
	end

	ActivityNewbieSignItem.super.Dispose(self)
end

return ActivityNewbieSignItem
