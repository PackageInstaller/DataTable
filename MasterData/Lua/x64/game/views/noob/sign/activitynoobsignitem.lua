local ActivityNoobSignItem = class("ActivityNoobSignItem", ReduxView)

function ActivityNoobSignItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.transform_, "conName")

	self:AddListeners()

	self.refreshHandler_ = handler(self, self.ZeroTimeRefresh)

	manager.notify:RegistListener(ZERO_REFRESH, self.refreshHandler_)
end

function ActivityNoobSignItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		self:OnSign()
	end)
end

function ActivityNoobSignItem:OnSign()
	if manager.time:GetTodayFreshTime() > ActivityNoobData:GetSignTimestamp() and ActivityNoobData:GetSignDay() + 1 == table.keyof(ActivityNewbieTools.GetSignCfg(), self.id_) then
		ActivityNoobAction.NoobSignIn(function(arg_5_0)
			if isSuccess(arg_5_0.result) then
				ActivityNoobData:SignIn()
				getReward2(arg_5_0.reward_list)
				self.controller_:SetSelectedState("2")
				manager.notify:CallUpdateFunc(NOOB_SIGN)
			else
				ShowTips(arg_5_0.result)
			end
		end)
	end
end

function ActivityNoobSignItem:ZeroTimeRefresh()
	self:RefreshUI(self.id_, self.pageIndex_, self.index_)
end

function ActivityNoobSignItem:RefreshUI(arg_7_1, arg_7_2, arg_7_3)
	if self.id_ ~= arg_7_1 then
		self.itemData_ = clone(ItemTemplateData)
		self.itemData_.id = SignCfg[arg_7_1].reward[1]
		self.itemData_.number = SignCfg[arg_7_1].reward[2]

		function self.itemData_:clickFun()
			if manager.time:GetTodayFreshTime() > ActivityNoobData:GetSignTimestamp() and ActivityNoobData:GetSignDay() + 1 == table.keyof(ActivityNewbieTools.GetSignCfg(), arg_7_1) then
				self:OnSign()
			else
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end

		self.id_ = arg_7_1
	end

	self.rewardGo_ = self.rewardGo_ or CommonItemView.New(self.itemGo_)

	self.rewardGo_:SetData(self.itemData_)

	local var_7_0 = (arg_7_2 - 1) * 7 + arg_7_3

	self.index_ = arg_7_3
	self.pageIndex_ = arg_7_2
	self.textDay_.text = string.format(GetTips("ACTIVITY_GREENHORN_TASK_STAGE"), var_7_0)
	self.textDat2_.text = var_7_0 < 10 and "0" .. var_7_0 or var_7_0

	if var_7_0 <= ActivityNoobData:GetSignDay() then
		self.controller_:SetSelectedState("2")
	else
		self.controller_:SetSelectedState("0")
	end

	if manager.time:GetTodayFreshTime() > ActivityNoobData:GetSignTimestamp() and ActivityNoobData:GetSignDay() + 1 == var_7_0 then
		self.controller_:SetSelectedState("1")
	end
end

function ActivityNoobSignItem:Dispose()
	manager.notify:RemoveListener(ZERO_REFRESH, self.refreshHandler_)

	self.refreshHandler_ = nil

	if self.rewardGo_ then
		self.rewardGo_:Dispose()

		self.rewardGo_ = nil
	end

	ActivityNoobSignItem.super.Dispose(self)
end

return ActivityNoobSignItem
