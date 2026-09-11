local SummerStageBaseView = class("SummerStageBaseView", ReduxView)

function SummerStageBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerStageBaseView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.scrollMoveView_ = ScrollMoveView.New(self, self.scrollView_)
	self.stageItem_ = {}
end

function SummerStageBaseView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenSectionInfo() then
			self.isOpenInfoView_ = false
		end

		JumpTools.Back()
	end)

	self.stopTime_ = ActivityData:GetActivityData(self:GetActivityID()).stopTime

	self:AddTimer()
	self:RefreshData()
	self:RefreshStageList()
	self:RefreshUI()
end

function SummerStageBaseView:OnExit()
	self:StopTimer()
	self.scrollMoveView_:OnExit()
	manager.windowBar:HideBar()
end

function SummerStageBaseView:Dispose()
	SummerStageBaseView.super.Dispose(self)

	for iter_6_0, iter_6_1 in ipairs(self.stageItem_) do
		iter_6_1:Dispose()
	end

	self.stageItem_ = nil

	self.scrollMoveView_:Dispose()

	self.scrollMoveView_ = nil
end

function SummerStageBaseView:AddListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self:IsOpenSectionInfo() then
			self.isOpenInfoView_ = false

			JumpTools.Back()
		end
	end)
end

function SummerStageBaseView:OnUpdate()
	self:RefreshData()
	self:RefreshUI()
end

function SummerStageBaseView:GetActivityID()
	return
end

function SummerStageBaseView:RefreshData()
	self.chapterID_ = self.params_.chapterID or 5
	self.stageData_ = StoryStageActivityData:GetStageData(self.chapterID_)
	self.stageList_ = ActivityStoryChapterCfg[self.chapterID_].stage_list
end

function SummerStageBaseView:RefreshUI()
	local var_12_0 = self.params_.section

	if not self.params_.section then
		var_12_0 = StoryStageActivityData:GetHistoryStage(self.chapterID_)
		var_12_0 = var_12_0 or self.stageList_[1]
	end

	self.selectStageID_ = var_12_0

	self.scrollMoveView_:RefreshUI(self:GetScrollPos(), (self:GetScrollWidth()))
	self:RefreshSelectItem()
end

function SummerStageBaseView:RefreshSelectItem()
	for iter_13_0, iter_13_1 in pairs(self.stageItem_) do
		iter_13_1:SelectorItem(self.selectStageID_)
	end
end

function SummerStageBaseView:RefreshStageList()
	for iter_14_0 = 1, #self.stageItem_ do
		self.stageItem_[iter_14_0]:Show(false)
	end

	for iter_14_1 = 1, table.length((StoryStageActivityData:GetStageData(self.chapterID_))) do
		self.stageItem_[iter_14_1] = self.stageItem_[iter_14_1] or self:GetStageItemClass().New(self.itemGo_, self.content_)

		self.stageItem_[iter_14_1]:SetData(self.stageList_[iter_14_1], self.chapterID_)
	end
end

function SummerStageBaseView:GetStageItemClass()
	return
end

function SummerStageBaseView:GetScrollWidth()
	local var_16_0 = self.stageList_[1]

	for iter_16_0, iter_16_1 in ipairs(self.stageList_) do
		if not self.stageData_[iter_16_1] then
			break
		end

		var_16_0 = iter_16_1
	end

	return (BattleActivityStoryStageCfg[var_16_0] or nil) and (BattleActivityStoryStageCfg[var_16_0].position[1] or 0)
end

function SummerStageBaseView:GetScrollPos()
	return (BattleActivityStoryStageCfg[self.selectStageID_] or nil) and (BattleActivityStoryStageCfg[self.selectStageID_].position[1] or 0)
end

function SummerStageBaseView:IsOpenSectionInfo()
	return self:IsOpenRoute("storyStageInfoActivity")
end

function SummerStageBaseView:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.timeText_.text = GetTips("TIME_OVER")

		return
	end

	self.timeText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.timeText_.text = GetTips("TIME_OVER")

			return
		end

		self.timeText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function SummerStageBaseView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return SummerStageBaseView
