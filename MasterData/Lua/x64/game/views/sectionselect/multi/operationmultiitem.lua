local OperationMultiItem = class("OperationMultiItem", ReduxView)

function OperationMultiItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function OperationMultiItem:Init()
	self:InitUI()
end

function OperationMultiItem:InitUI()
	self:BindCfgUI()

	self.typeStateController_ = self.controller_:GetController("type")
end

function OperationMultiItem:RefreshActMulti(arg_4_1, arg_4_2)
	local var_4_0, var_4_1 = ActivityMultiRewardData:GetCountByActivityID(arg_4_2)

	self.multipleTxt_.text = string.format(GetTips("DOUBLE_REWARD_DESC"), var_4_0, var_4_1)
	self.ratioTxt_.text = arg_4_1 / 100
	self.endTimeTxt_.text = manager.time:STimeDescS(ActivityData:GetActivityData(arg_4_2).stopTime, "!%Y/%m/%d %H:%M")
	self.multiTimeRefresh_ = ActivityMultiRewardData:GetTimeByActivityID(arg_4_2)
	self.refreshTimeTxt_.text = manager.time:GetServerTime() >= self.multiTimeRefresh_ and string.format(GetTips("REFRESH_LOST_TIME"), 1 .. GetTips("SECOND")) or string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(self.multiTimeRefresh_))

	self.typeStateController_:SetSelectedState("normal")
	self:AddTimer(self.multiTimeRefresh_)
end

function OperationMultiItem:AddTimer(arg_5_1)
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			if manager.time:GetServerTime() >= arg_5_1 then
				self.refreshTimeTxt_.text = string.format(GetTips("REFRESH_LOST_TIME"), 1 .. GetTips("SECOND"))

				manager.notify:Invoke(MULT_TIMES_UPDATE)

				if self.timer_ then
					self.timer_:Stop()

					self.timer_ = nil
				end
			else
				self.refreshTimeTxt_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(arg_5_1))
			end
		end, 1, -1)

		self.timer_:Start()
	end
end

function OperationMultiItem:RefreshRegressionMulti()
	local var_7_0, var_7_1, var_7_2 = RegressionDataNew:GetMultipleValue()

	self.multipleTxt_.text = string.format(GetTips("NEW_REGRESSION_DOUBLE_REWARD_DESC"), var_7_0, var_7_1)
	self.ratioTxt_.text = var_7_2 / 100

	self.typeStateController_:SetSelectedState("return")

	self.endTimeTxt_.text = manager.time:STimeDescS(RegressionDataNew:GetRegressionEndTime(), "!%Y/%m/%d %H:%M")
end

function OperationMultiItem:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function OperationMultiItem:Dispose()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	OperationMultiItem.super.Dispose(self)
end

return OperationMultiItem
