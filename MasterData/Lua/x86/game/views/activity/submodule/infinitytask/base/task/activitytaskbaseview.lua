local ActivityTaskBaseView = class("ActivityTaskBaseView", ReduxView)

function ActivityTaskBaseView:GetAssetName()
	return "UI/VersionUI/OsirisUI/OsirisTaskContent"
end

function ActivityTaskBaseView:GetTaskClass()
	return ActivityTaskBaseItem
end

function ActivityTaskBaseView:Ctor(arg_3_1, arg_3_2)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:GetAssetName()), arg_3_1.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.activityID_ = arg_3_2
	self.scrollHelper_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, self:GetTaskClass())
	self.osirisTaskUpdateHandler_ = handler(self, self.OsirisTaskUpdate)

	self:OnEnter()
end

function ActivityTaskBaseView:OnEnter()
	self.scrollHelper_:StartScroll(#TaskData2:GetActivityTaskSortList(self.activityID_))
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, self.osirisTaskUpdateHandler_)

	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:AddTimer()
end

function ActivityTaskBaseView:OnExit()
	self:StopTimer()
	manager.notify:RemoveListener(OSIRIS_TASK_UPDATE, self.osirisTaskUpdateHandler_)
end

function ActivityTaskBaseView:Dispose()
	ActivityTaskBaseView.super.Dispose(self)

	self.osirisTaskUpdateHandler_ = nil

	self.scrollHelper_:Dispose()
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ActivityTaskBaseView:RefreshItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(TaskData2:GetActivityTaskSortList(self.activityID_)[arg_7_1].id)
end

function ActivityTaskBaseView:Show(arg_8_1)
	if self.gameObject_.activeSelf == arg_8_1 then
		return
	end

	SetActive(self.gameObject_, arg_8_1)
end

function ActivityTaskBaseView:OsirisTaskUpdate()
	self.scrollHelper_:StartScroll(#TaskData2:GetActivityTaskSortList(self.activityID_))
end

function ActivityTaskBaseView:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.textTime_.text = GetTips("TIME_OVER")

		ShowTips("TIME_OVER")
		self:Back()

		return
	end

	self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.textTime_.text = GetTips("TIME_OVER")

			ShowTips("TIME_OVER")
			self:Back()

			return
		end

		self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function ActivityTaskBaseView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ActivityTaskBaseView
