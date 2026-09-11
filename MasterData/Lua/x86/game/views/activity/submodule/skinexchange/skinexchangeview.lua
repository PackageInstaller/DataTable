local SkinExchangeView = class("SkinExchangeView", ReduxView)

function SkinExchangeView:UIName()
	return SkinExchangeTool.GetMainUIName(self.params_.activityID)
end

function SkinExchangeView:UIParent()
	return manager.ui.uiMain.transform
end

function SkinExchangeView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkinExchangeView:InitUI()
	self:BindCfgUI()

	self.costList_ = {}
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, SkinExchangeCostItem)
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
end

function SkinExchangeView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.costList_[arg_5_1])
end

function SkinExchangeView:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.activityData_:IsActivitying() then
			local var_7_0, var_7_1 = SkinExchangeTool.IsCanExchange(self.activityID_)

			if var_7_0 then
				SkinExchangeAction:ExchangeSkin(self.activityID_)
			else
				ShowTips(var_7_1)
			end
		end
	end)
end

function SkinExchangeView:OnEnter()
	self:GetActivityData()
	self:RefreshData()
	self:BindRedPointUI()
end

function SkinExchangeView:GetActivityData()
	self.activityID_ = self.params_.activityID
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
end

function SkinExchangeView:RefreshData()
	self:RefreshCost()
	self:RefreshState()
	self:RefreshTime()
end

function SkinExchangeView:RefreshCost()
	self.cfg_ = ActivitySkinExchangeCfg[self.activityID_]
	self.costList_ = self.cfg_.cost

	self.scrollHelper_:StartScroll(#self.costList_)
end

function SkinExchangeView:RefreshState()
	if SkinExchangeData:GetState(self.activityID_) == 1 then
		self.stateCon_:SetSelectedState("finish")
	else
		self.stateCon_:SetSelectedState("unfinish")
	end
end

function SkinExchangeView:RefreshTime()
	local var_13_0
	local var_13_1 = manager.time:GetServerTime()

	self:StopTimer()

	if var_13_1 < self.startTime_ and self.activityData_.state == 0 then
		self.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			var_13_0 = self.startTime_ - manager.time:GetServerTime()

			if var_13_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_13_1 >= self.startTime_ and self.activityData_.state == 0 then
		self.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			self:StopTimer()
			self:RefreshTime()
		end, 10, 1)

		self.timer_:Start()
	elseif var_13_1 < self.stopTime_ then
		self.timeTxt_.text = manager.time:GetLostTimeStr(self.stopTime_, true)
		self.timer_ = Timer.New(function()
			var_13_0 = self.stopTime_ - manager.time:GetServerTime()

			if var_13_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end

			self.timeTxt_.text = manager.time:GetLostTimeStr(self.stopTime_, true)
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function SkinExchangeView:OnActivitySkinExchange()
	self:RefreshData()
end

function SkinExchangeView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SkinExchangeView:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.btn_.transform, RedPointConst.ACTIVITY_SKIN_EXCHANGE .. "_" .. self.activityID_)
end

function SkinExchangeView:UnBindRedPointUI()
	manager.redPoint:unbindUIandKey(self.btn_.transform, RedPointConst.ACTIVITY_SKIN_EXCHANGE .. "_" .. self.activityID_)
end

function SkinExchangeView:OnTop()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(self.cfg_.cost) do
		table.insert(var_21_0, iter_21_1[1])
	end

	local var_21_1 = {
		BACK_BAR,
		HOME_BAR
	}

	table.insertto(var_21_1, var_21_0)
	manager.windowBar:SwitchBar(var_21_1)

	for iter_21_2, iter_21_3 in ipairs(var_21_0) do
		manager.windowBar:SetBarCanAdd(iter_21_3, true)
	end
end

function SkinExchangeView:OnExit()
	self:StopTimer()
	self:UnBindRedPointUI()
	manager.windowBar:HideBar()
end

function SkinExchangeView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	SkinExchangeView.super.Dispose(self)
end

return SkinExchangeView
