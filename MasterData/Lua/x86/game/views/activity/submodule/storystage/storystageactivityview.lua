local StoryStageActivityView = class("StoryStageActivityView", ReduxView)

function StoryStageActivityView:UIName()
	return "UI/BranchlineUI/HellaSelectStageUI"
end

function StoryStageActivityView:UIParent()
	return manager.ui.uiMain.transform
end

function StoryStageActivityView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.switchController_ = ControllerUtil.GetController(self.goSwitch_.transform, "name")
	self.btnLockController_ = ControllerUtil.GetController(self.btnSwitch_.transform, "name")
	self.storyChapterView_ = {}
	self.stageItemList_ = {}
	self.scrollMoveView_ = ScrollMoveView.New(self, self.goScrollView_)
	self.scrollContenLineView_ = ScrollContentLineView.New(self.goLineItem_, self.goItemParent_, self:FindCom(typeof(RectTransform), nil, self.goStageItem_.transform).rect.width, 30, 4)
end

function StoryStageActivityView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:RefreshData()

	for iter_4_0, iter_4_1 in ipairs(self.activityIDList_) do
		manager.redPoint:bindUIandKey(self[string.format("transformRedPoint%s_", iter_4_0)], ActivityTools.GetRedPointKey(iter_4_1) .. iter_4_1)
	end

	for iter_4_2, iter_4_3 in pairs(self.activityIDList_) do
		if #ActivityStoryChapterCfg.get_id_list_by_activity_id[iter_4_3] > 1 then
			local var_4_0 = self[string.format("goChapterPanel%s_", iter_4_2)]

			if var_4_0 then
				self.storyChapterView_[iter_4_2] = self.storyChapterView_[iter_4_2] or StoryChapterView.New(var_4_0, iter_4_3)
			end
		end
	end

	for iter_4_4, iter_4_5 in pairs(self.storyChapterView_) do
		iter_4_5:OnEnter(self.selectChapterID_)
	end

	self:RefreshUI()
end

function StoryStageActivityView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
	self.scrollMoveView_:OnExit()

	for iter_5_0, iter_5_1 in ipairs(self.activityIDList_) do
		manager.redPoint:unbindUIandKey(self[string.format("transformRedPoint%s_", iter_5_0)], ActivityTools.GetRedPointKey(iter_5_1) .. iter_5_1)
	end

	for iter_5_2, iter_5_3 in pairs(self.storyChapterView_) do
		iter_5_3:OnExit()
	end
end

function StoryStageActivityView:OnUpdate()
	self:RefreshData()
	self:RefreshUI()

	for iter_6_0, iter_6_1 in pairs(self.storyChapterView_) do
		iter_6_1:OnUpdate(self.selectChapterID_)
	end
end

function StoryStageActivityView:Dispose()
	StoryStageActivityView.super.Dispose(self)

	for iter_7_0, iter_7_1 in pairs(self.storyChapterView_) do
		iter_7_1:Dispose()
	end

	for iter_7_2, iter_7_3 in pairs(self.stageItemList_) do
		iter_7_3:Dispose()
	end

	self.stageItemList_ = nil

	self.scrollContenLineView_:Dispose()

	self.scrollContenLineView_ = nil

	self.scrollMoveView_:Dispose()

	self.scrollMoveView_ = nil
end

function StoryStageActivityView:AddListeners()
	self:AddBtnListener(self.btnSwitch_, nil, function()
		for iter_9_0, iter_9_1 in pairs(self.activityIDList_) do
			if ActivityStoryChapterCfg[self.selectChapterID_].activity_id ~= iter_9_1 then
				local var_9_0 = ActivityStoryChapterCfg.get_id_list_by_activity_id[iter_9_1][1]
				local var_9_1 = ActivityData:GetActivityData(ActivityStoryChapterCfg[ActivityStoryChapterCfg.get_id_list_by_activity_id[iter_9_1][1]].activity_id).startTime

				if var_9_1 > manager.time:GetServerTime() then
					ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_9_1)))
				else
					if ActivityData:GetActivityIsOpen(ActivityStoryChapterCfg[ActivityStoryChapterCfg.get_id_list_by_activity_id[iter_9_1][1]].activity_id) == false then
						ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(manager.time:GetServerTime() + 1)))

						return
					end

					var_9_0 = StoryStageActivityData:GetHistoryChapter(iter_9_1) or var_9_0

					ActivityStoryAction.UpdateRedPoint(ActivityStoryChapterCfg[ActivityStoryChapterCfg.get_id_list_by_activity_id[iter_9_1][1]].activity_id, 0)
					StoryStageActivityData:SaveDefaultActivityID(ActivityCfg[ActivityStoryChapterCfg[ActivityStoryChapterCfg.get_id_list_by_activity_id[iter_9_1][1]].activity_id].activity_theme, ActivityStoryChapterCfg[ActivityStoryChapterCfg.get_id_list_by_activity_id[iter_9_1][1]].activity_id)
					self:Go("/storyStageActivity", {
						chapterID = var_9_0,
						theme = ActivityCfg[ActivityStoryChapterCfg[ActivityStoryChapterCfg.get_id_list_by_activity_id[iter_9_1][1]].activity_id].activity_theme
					})
				end

				return
			end
		end
	end)
end

function StoryStageActivityView:RefreshData()
	self.activityIDList_ = ActivityTools.GetStoryActivityIDList(self.params_.theme)
	self.selectChapterID_ = self.params_.chapterID or StoryStageActivityData:GetHistoryChapter(StoryStageActivityData:GetDefaultActivityID(self.params_.theme) or self.activityIDList_[1])
	self.selectStageIndex_ = table.keyof(ActivityStoryChapterCfg[self.selectChapterID_].stage_list, (StoryStageActivityData:GetHistoryStage(self.selectChapterID_))) or 1
	self.stageData_ = StoryStageActivityData:GetStageData(self.selectChapterID_)
	self.stageList_ = ActivityStoryChapterCfg[self.selectChapterID_].stage_list
end

function StoryStageActivityView:RefreshUI()
	self:RefreshStageList()
	self.scrollMoveView_:RefreshUI(self:GetScrollPos(), (self:GetScrollWidth()))
	self:RefreshSwitchBtn()
	self:AddTimer()
	self:RefreshSelectItem()
end

function StoryStageActivityView:RefreshSwitchBtn()
	if ActivityStoryChapterCfg[self.selectChapterID_].activity_id == self.activityIDList_[1] then
		self.switchController_:SetSelectedState("1")

		self.upChapter_.text = GetTips("FRONT_CHAPTER")
		self.downLockChapter_.text = GetTips("AFTER_CHAPTER")
		self.downUnLockChapter_.text = GetTips("AFTER_CHAPTER")
	else
		self.switchController_:SetSelectedState("2")

		self.upChapter_.text = GetTips("AFTER_CHAPTER")
		self.downLockChapter_.text = GetTips("FRONT_CHAPTER")
		self.downUnLockChapter_.text = GetTips("FRONT_CHAPTER")
	end

	local var_12_0 = ActivityStoryChapterCfg[self.selectChapterID_]

	for iter_12_0, iter_12_1 in pairs(self.activityIDList_) do
		if var_12_0.activity_id ~= iter_12_1 then
			self.textTime_.text = manager.time:STimeDescS(ActivityData:GetActivityData(iter_12_1).startTime, "!%m/%d %H:%M")

			break
		end
	end
end

function StoryStageActivityView:AddTimer()
	if self.timer_ then
		self.timer_:Stop()
	end

	local var_13_0
	local var_13_1 = 0

	for iter_13_0, iter_13_1 in pairs(self.activityIDList_) do
		if ActivityStoryChapterCfg[self.selectChapterID_].activity_id ~= iter_13_1 then
			var_13_0 = iter_13_1
			var_13_1 = ActivityData:GetActivityData(iter_13_1).startTime

			if var_13_1 > manager.time:GetServerTime() then
				self.btnLockController_:SetSelectedState("false")

				break
			end

			self.btnLockController_:SetSelectedState("true")

			do return end

			break
		end
	end

	self.timer_ = Timer.New(function()
		if ActivityData:GetActivityIsOpen(var_13_0) == false then
			return
		end

		if manager.time:GetServerTime() >= var_13_1 then
			self.btnLockController_:SetSelectedState("true")
			self:StopTimer()
		end
	end, 1, -1)

	self.timer_:Start()
end

function StoryStageActivityView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function StoryStageActivityView:GetScrollWidth()
	local var_16_0 = self.stageList_[1]

	for iter_16_0, iter_16_1 in ipairs(self.stageList_) do
		if not self.stageData_[iter_16_1] then
			break
		end

		var_16_0 = iter_16_1
	end

	return (BattleActivityStoryStageCfg[var_16_0] or nil) and (BattleActivityStoryStageCfg[var_16_0].position[1] or 0)
end

function StoryStageActivityView:GetScrollPos()
	return (BattleActivityStoryStageCfg[ActivityStoryChapterCfg[self.selectChapterID_].stage_list[self.selectStageIndex_]] or nil) and (BattleActivityStoryStageCfg[ActivityStoryChapterCfg[self.selectChapterID_].stage_list[self.selectStageIndex_]].position[1] or 0)
end

function StoryStageActivityView:RefreshStageList()
	self.lastChapterID_ = self.selectChapterID_

	for iter_18_0 = 1, #self.stageItemList_ do
		self.stageItemList_[iter_18_0]:Show(false)
	end

	for iter_18_1 = 1, table.length((StoryStageActivityData:GetStageData(self.selectChapterID_))) do
		self.stageItemList_[iter_18_1] = self.stageItemList_[iter_18_1] or self:GetStageItemClass().New(self.goStageItem_, self.goItemParent_)

		self.stageItemList_[iter_18_1]:SetData(self.stageList_[iter_18_1], self.selectChapterID_)
	end

	self.scrollContenLineView_:CreateLineItemList(self.stageData_, self.stageList_, self.stageItemList_)
end

function StoryStageActivityView:RefreshSelectItem()
	for iter_19_0, iter_19_1 in pairs(self.stageItemList_) do
		iter_19_1:SelectorItem(ActivityStoryChapterCfg[self.selectChapterID_].stage_list[self.selectStageIndex_])
	end
end

function StoryStageActivityView:IsOpenSectionInfo()
	return self:IsOpenRoute("storyStageInfoActivity")
end

function StoryStageActivityView:GetStageItemClass()
	return StoryStageItemView
end

return StoryStageActivityView
