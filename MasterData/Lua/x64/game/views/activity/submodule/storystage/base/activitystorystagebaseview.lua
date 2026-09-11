local ActivityStoryStageBaseView = class("ActivityStoryStageBaseView", ReduxView)

function ActivityStoryStageBaseView:UIName()
	return "UI/BranchlineUI/OsirisPlotUI"
end

function ActivityStoryStageBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityStoryStageBaseView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.stageItemList_ = {}
	self.scrollMoveView_ = ScrollMoveView.New(self, self.scrollViewGo_)
end

function ActivityStoryStageBaseView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenSectionInfo() then
			self.isOpenInfoView_ = false
		end

		JumpTools.Back()
	end)
	manager.ui:SetMainCamera("null")
	self:RefreshData()
	self:RefreshUI()
	self:AddTimer()
end

function ActivityStoryStageBaseView:OnExit()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	self.scrollMoveView_:OnExit()
	self:StopTimer()
end

function ActivityStoryStageBaseView:OnUpdate()
	self:RefreshData()
	self:RefreshUI()
end

function ActivityStoryStageBaseView:Dispose()
	ActivityStoryStageBaseView.super.Dispose(self)

	for iter_8_0, iter_8_1 in pairs(self.stageItemList_) do
		iter_8_1:Dispose()
	end

	self.stageItemList_ = nil

	self.scrollMoveView_:Dispose()

	self.scrollMoveView_ = nil
end

function ActivityStoryStageBaseView:AddListeners()
	return
end

function ActivityStoryStageBaseView:RefreshData()
	if self.params_.chapterID == nil then
		self.activityIDList_ = ActivityTools.GetStoryActivityIDList(self.params_.theme)
		self.chapterID_ = self.params_.chapterID or StoryStageActivityData:GetHistoryChapter(StoryStageActivityData:GetDefaultActivityID(self.params_.theme) or self.activityIDList_[1])
	else
		self.chapterID_ = self.params_.chapterID
	end

	self.stageData_ = StoryStageActivityData:GetStageData(self.chapterID_)
	self.stageList_ = ActivityStoryChapterCfg[self.chapterID_].stage_list
	self.selectStageID_ = StoryStageActivityData:GetHistoryStage(self.chapterID_) or self.stageList_[1]
end

function ActivityStoryStageBaseView:RefreshUI()
	self.scrollMoveView_:RefreshUI(self:GetScrollPos(), (self:GetScrollWidth()))

	local var_11_0 = table.length(self.stageData_)

	for iter_11_0 = #self.stageItemList_, var_11_0 + 1, -1 do
		self.stageItemList_[iter_11_0]:Dispose()

		self.stageItemList_[iter_11_0] = nil
	end

	for iter_11_1 = 1, var_11_0 do
		if self.stageItemList_[iter_11_1] == nil then
			self.stageItemList_[iter_11_1] = self:GetItemClass().New(self.sectionItem_, self.content_)
		end

		self.stageItemList_[iter_11_1]:SetData(self.stageList_[iter_11_1], self.chapterID_)
	end

	self:RefreshSelectItem()
end

function ActivityStoryStageBaseView:RefreshSelectItem()
	for iter_12_0, iter_12_1 in pairs(self.stageItemList_) do
		iter_12_1:SelectorItem(self.selectStageID_)
	end
end

function ActivityStoryStageBaseView:GetItemClass()
	return ActivityStoryStageBaseItem
end

function ActivityStoryStageBaseView:GetScrollWidth()
	local var_14_0 = self.stageList_[1]

	for iter_14_0, iter_14_1 in ipairs(self.stageList_) do
		if not self.stageData_[iter_14_1] then
			break
		end

		var_14_0 = iter_14_1
	end

	return (BattleActivityStoryStageCfg[var_14_0] or nil) and (BattleActivityStoryStageCfg[var_14_0].position[1] or 0)
end

function ActivityStoryStageBaseView:GetScrollPos()
	return (BattleActivityStoryStageCfg[self.selectStageID_] or nil) and (BattleActivityStoryStageCfg[self.selectStageID_].position[1] or 0)
end

function ActivityStoryStageBaseView:IsOpenSectionInfo()
	return self:IsOpenRoute("storyStageInfoActivity")
end

function ActivityStoryStageBaseView:AddTimer()
	self.stopTime_ = ActivityData:GetActivityData(ActivityStoryChapterCfg[self.chapterID_].activity_id).stopTime

	self:StopTimer()

	if manager.time:GetServerTime() >= self.stopTime_ then
		self.textTime_.text = GetTips("TIME_OVER")

		return
	end

	self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.textTime_.text = GetTips("TIME_OVER")

			return
		end

		self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function ActivityStoryStageBaseView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ActivityStoryStageBaseView
