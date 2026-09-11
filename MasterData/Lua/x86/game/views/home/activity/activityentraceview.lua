local ActivityEntraceView = class("ActivityEntraceView", ReduxView)

function ActivityEntraceView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.itemUiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, ActivityEntraceItem)
	self.activityOpenHandler_ = handler(self, self.ActivityOpen)
end

function ActivityEntraceView:OnEnter()
	manager.notify:RegistListener(ACTIVITY_UPDATE, self.activityOpenHandler_)
	manager.notify:RegistListener(ACTIVITY_ENTRACE_OPEN, self.activityOpenHandler_)
	self:InitItemList()
	self:AddTimer()
	self:RefreshScrollView()
end

function ActivityEntraceView:OnExit()
	manager.notify:RemoveListener(ACTIVITY_UPDATE, self.activityOpenHandler_)
	manager.notify:RemoveListener(ACTIVITY_ENTRACE_OPEN, self.activityOpenHandler_)
	self:StopTimer()

	for iter_3_0, iter_3_1 in pairs(self.itemUiList_:GetItemList()) do
		iter_3_1:OnExit()
	end
end

function ActivityEntraceView:AddTimer()
	self:StopTimer()

	self.activiteTime_ = Timer.New(function()
		for iter_5_0, iter_5_1 in ipairs(self.idList_) do
			if ActivityData:GetActivityIsOpen(iter_5_1) == false then
				manager.notify:Invoke(ACTIVITY_ENTRACE_OPEN, iter_5_1)
			end
		end
	end, 1, -1)

	self.activiteTime_:Start()
end

function ActivityEntraceView:StopTimer()
	if self.activiteTime_ then
		self.activiteTime_:Stop()

		self.activiteTime_ = nil
	end
end

function ActivityEntraceView:Dispose()
	ActivityEntraceView.super.Dispose(self)

	self.activityOpenHandler_ = nil

	self.itemUiList_:Dispose()

	self.itemUiList_ = nil
end

function ActivityEntraceView:IndexItem(arg_8_1, arg_8_2)
	arg_8_2:SetData(self.idList_[arg_8_1])
end

function ActivityEntraceView:InitItemList()
	self.idList_ = {}

	for iter_9_0, iter_9_1 in ipairs(ActivityEntraceCfg.all) do
		if ActivityData:GetActivityIsOpen(iter_9_1) then
			table.insert(self.idList_, iter_9_1)
		end
	end

	self.itemUiList_:StartScroll(#self.idList_)
end

function ActivityEntraceView:ActivityOpen(arg_10_1)
	if ActivityTemplateConst.MAIN_ACTIVITY ~= ActivityTools.GetActivityType(arg_10_1) then
		return
	end

	if not table.indexof(self.idList_, arg_10_1) then
		if ActivityEntraceCfg[arg_10_1] == nil then
			return
		end

		if ActivityData:GetActivityIsOpen(arg_10_1) then
			table.insert(self.idList_, arg_10_1)
			table.sort(self.idList_)
		end
	elseif not ActivityData:GetActivityIsOpen(arg_10_1) then
		table.removebyvalue(self.idList_, arg_10_1)
	end

	self.itemUiList_:StartScroll(#self.idList_)
	self:RefreshScrollView()
end

function ActivityEntraceView:RefreshScrollView()
	if #self.idList_ > 1 then
		self.scrollView_.enabled = true
	else
		self.scrollView_.verticalNormalizedPosition = 0
		self.scrollView_.enabled = false
	end
end

return ActivityEntraceView
