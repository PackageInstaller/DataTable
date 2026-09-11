local PreviewTaskMainView = class("PreviewTaskMainView", ReduxView)

function PreviewTaskMainView:UIName()
	return "UI/Task/AdvanceTaskUIPop"
end

function PreviewTaskMainView:UIParent()
	return manager.ui.uiMain.transform
end

function PreviewTaskMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PreviewTaskMainView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.scrollView_, PreviewTaskItem)
end

function PreviewTaskMainView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
end

function PreviewTaskMainView:OnEnter()
	self.activityID_ = PreviewTaskData:GetCurActivityID()
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	if self.lastPosition_ then
		self:RefreshScroll(true)

		self.lastPosition_ = nil
	else
		self:RefreshScroll()
	end

	self:RefreshTimeText()
end

function PreviewTaskMainView:RefreshScroll(arg_8_1)
	self:UpdateData()

	if arg_8_1 then
		if self.lastPosition_ then
			local var_8_0 = clone(self.lastPosition_)
			local var_8_1

			var_8_1 = FrameTimer.New(function()
				self.scrollHelper_:StartScrollWithoutAnimator(#self._taskIDList, var_8_0)
				var_8_1:Stop()

				var_8_1 = nil
			end, 1, 1)

			;(nil):Start()
		else
			self.scrollHelper_:StartScrollWithoutAnimator(#self._taskIDList)
		end
	else
		self.scrollHelper_:StartScroll(#self._taskIDList)
	end
end

function PreviewTaskMainView:indexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self._taskIDList[arg_10_1], self.activityID_)
end

function PreviewTaskMainView:OnExit()
	if self.dailyTimer_ then
		self.dailyTimer_:Stop()

		self.dailyTimer_ = nil
	end

	self.lastPosition_ = self.scrollHelper_:GetScrolledPosition()

	self:StopTimer()
end

function PreviewTaskMainView:Dispose()
	self.scrollHelper_:Dispose()
	self:StopTimer()
	PreviewTaskMainView.super.Dispose(self)
end

function PreviewTaskMainView:UpdateData()
	self._taskIDList = PreviewTaskData:GetSortTaskIDList(self.activityID_)
end

function PreviewTaskMainView:OnPreviewTaskListChange()
	self:RefreshScroll(true)
end

function PreviewTaskMainView:RefreshTimeText()
	if not ActivityData:GetActivityIsOpen(self.activityID_) then
		self.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	self.remainTimeText_.text = manager.time:GetLostTimeStr(self.stopTime_)

	self:StopTimer()

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		self.remainTimeText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function PreviewTaskMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()
	end

	self.timer_ = nil
end

return PreviewTaskMainView
