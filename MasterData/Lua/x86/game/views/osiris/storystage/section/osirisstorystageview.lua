local OsirisStoryStageView = class("OsirisStoryStageView", ReduxView)

function OsirisStoryStageView:UIName()
	return "UI/BranchlineUI/OsirisPlotUI"
end

function OsirisStoryStageView:UIParent()
	return manager.ui.uiMain.transform
end

function OsirisStoryStageView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.scrollMoveView_ = ScrollMoveView.New(self, self.scrollViewGo_)
	self.missionItem_ = {}
end

function OsirisStoryStageView:OnEnter()
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

	self.stopTime_ = ActivityData:GetActivityData(ActivityConst.OSIRIS_STROY).stopTime

	self:AddTimer()
	self:RefreshData()
	self:RefreshUI()
end

function OsirisStoryStageView:OnExit()
	self:StopTimer()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	self.scrollMoveView_:OnExit()

	self.lastChapterID_ = nil
end

function OsirisStoryStageView:Dispose()
	OsirisStoryStageView.super.Dispose(self)

	for iter_7_0, iter_7_1 in ipairs(self.missionItem_) do
		iter_7_1:Dispose()
	end

	self.missionItem_ = nil

	self.scrollMoveView_:Dispose()

	self.scrollMoveView_ = nil
end

function OsirisStoryStageView:OnUpdate()
	self:RefreshData()
	self:RefreshUI()
end

function OsirisStoryStageView:AddListeners()
	self:AddBtnListener(self.btnBg_, nil, function()
		if self:IsOpenSectionInfo() then
			self.isOpenInfoView_ = false

			JumpTools.Back()
		end
	end)
end

function OsirisStoryStageView:RefreshData()
	self.chapterID_ = self.params_.chapterID or 1
	self.stageData_ = StoryStageActivityData:GetStageData(self.chapterID_)
	self.stageList_ = ActivityStoryChapterCfg[self.chapterID_].stage_list
end

function OsirisStoryStageView:RefreshUI()
	self:RefreshMissionList()

	local var_12_0 = self.params_.section

	if not self.params_.section then
		var_12_0 = StoryStageActivityData:GetHistoryStage(self.chapterID_)
		var_12_0 = var_12_0 or self.stageList_[1]
	end

	self.selectSection_ = var_12_0

	self.scrollMoveView_:RefreshUI(self:GetScrollPos(), (self:GetScrollWidth()))
	self:RefreshSelectItem()
end

function OsirisStoryStageView:RefreshSelectItem()
	for iter_13_0, iter_13_1 in pairs(self.missionItem_) do
		iter_13_1:SelectorItem(self.selectSection_)
	end
end

function OsirisStoryStageView:RefreshMissionList()
	if self.lastChapterID_ == self.chapterID_ then
		return
	end

	self.lastChapterID_ = self.chapterID_

	for iter_14_0 = 1, #self.missionItem_ do
		self.missionItem_[iter_14_0]:Show(false)
	end

	for iter_14_1 = 1, #self.stageList_ do
		if self.missionItem_[iter_14_1] then
			self.missionItem_[iter_14_1]:SetData(self.stageList_[iter_14_1], self.chapterID_)
		else
			local var_14_0 = self:GetSectionItemClass().New

			self.missionItem_[iter_14_1] = self:GetSectionItemClass().New(Object.Instantiate(self.sectionItem_, self.content_.transform), self.stageList_[iter_14_1], self.chapterID_)
		end
	end
end

function OsirisStoryStageView:GetSectionItemClass()
	return OsirisStoryStageItem
end

function OsirisStoryStageView:GetScrollWidth()
	local var_16_0 = self.stageList_[1]

	for iter_16_0, iter_16_1 in ipairs(self.stageList_) do
		if not self.stageData_[iter_16_1] then
			break
		end

		var_16_0 = iter_16_1
	end

	return (BattleActivityStoryStageCfg[var_16_0] or nil) and (BattleActivityStoryStageCfg[var_16_0].position[1] or 0)
end

function OsirisStoryStageView:GetScrollPos()
	return (BattleActivityStoryStageCfg[self.selectSection_] or nil) and (BattleActivityStoryStageCfg[self.selectSection_].position[1] or 0)
end

function OsirisStoryStageView:IsOpenSectionInfo()
	return self:IsOpenRoute("osirisStoryStageInfo")
end

function OsirisStoryStageView:AddTimer()
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

function OsirisStoryStageView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return OsirisStoryStageView
