ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityChapterPageView = class("ActivityChapterPageView", ActivityMainBasePanel)
local var_0_1 = {
	[4312001] = {
		10300,
		10301,
		10302,
		10303,
		10304,
		10305
	}
}

function ActivityChapterPageView:GetUIName()
	return ActivityChapterPageCfg[self.activityID_].prefab_path
end

function ActivityChapterPageView:GetTargetChapterID()
	if var_0_1[self.activityID_] then
		for iter_2_0 = #var_0_1[self.activityID_], 1, -1 do
			if ChapterCfg[var_0_1[self.activityID_][iter_2_0]] and #ChapterCfg[var_0_1[self.activityID_][iter_2_0]].section_id_list > 0 and ChapterTools.IsUnlockChapter(var_0_1[self.activityID_][iter_2_0]) and ChapterTools.IsFinishPreChapter(var_0_1[self.activityID_][iter_2_0]) then
				return var_0_1[self.activityID_][iter_2_0]
			end
		end
	end

	return ChapterTools.GetChapterIDByClient(self.chapterClientID_)
end

function ActivityChapterPageView:Init()
	ActivityChapterPageView.super.Init(self)

	if self.videoGo_ then
		self.criManaExMultipleVedio_ = self.videoGo_.transform:GetComponent(typeof(CriManaExMultipleVedio))
	end

	if self.dlcController_ then
		self.getController_ = self.dlcController_:GetController("get")
		self.timeController_ = self.dlcController_:GetController("time")
	end
end

function ActivityChapterPageView:OnEnter()
	self:CheckLimitTimeChapter()
	ActivityChapterPageView.super.OnEnter(self)

	if self.activityID_ == ActivityConst.ACTIVITY_SUMMER_MAIN_5_2 then
		self:RegistEventListener(SUMMER_RACE_SKIN_UPDATE_5_2, handler(self, self.OnSummerRaceSkinDlc_5_2))
		manager.redPoint:bindUIandKey(self.chapterBtn_.transform, RedPointConst.ACTIVITY_COMMON .. "_" .. ActivityConst.ACTIVITY_SUMMER_MAIN_LIMITTIME_5_2)
	else
		manager.redPoint:bindUIandKey(self.chapterBtn_.transform, ActivityTools.GetRedPointKey(self.activityID_) .. self.activityID_)
	end

	if self.redTrs_ then
		manager.redPoint:bindUIandKey(self.redTrs_, RedPointConst.ACTIVITY_COMMON .. "_" .. ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC)
	end

	if self.videoGo_ and ActivityVersionData:GetFirstEnterActivityFlag(self.activityID_) then
		self.criManaExMultipleVedio_:PlayByIndex(1)
	end

	ActivityVersionData:SetFirstEnterActivityFlag(self.activityID_)
	self:SetSkinDlcActivityId()

	if self.dlcController_ then
		self:RefreshDlcController()
	end
end

function ActivityChapterPageView:OnSummerRaceSkinDlc_5_2()
	self:RefreshDlcController()
end

function ActivityChapterPageView:RefreshDlcController()
	local var_6_0 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC] or {}
	local var_6_1 = 0

	for iter_6_0 = 1, 2 do
		if var_6_0[iter_6_0] and TaskData2:GetTaskComplete(var_6_0[iter_6_0]) then
			var_6_1 = var_6_1 + 1
		end
	end

	if var_6_1 == 2 then
		if self.getController_ then
			self.getController_:SetSelectedIndex(1)
		end

		if self.timeController_ then
			self.timeController_:SetSelectedIndex(0)
		end
	else
		if self.getController_ then
			self.getController_:SetSelectedIndex(0)
		end

		if self.timeController_ then
			self.timeController_:SetSelectedIndex(1)
		end
	end
end

function ActivityChapterPageView:SetSkinDlcActivityId()
	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC) then
		self.skinDlcActivityId = ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC

		local var_7_0 = ActivityData:GetActivityData(self.skinDlcActivityId)

		self.startDlcTime_ = var_7_0.startTime
		self.stopDlcTime_ = var_7_0.stopTime

		self:AddDlcTimer()
	end
end

function ActivityChapterPageView:OnExit()
	self:StopDlcTimer()
	self:RemoveAllEventListener()
	ActivityChapterPageView.super.OnExit(self)

	if self.activityID_ == ActivityConst.ACTIVITY_SUMMER_MAIN_5_2 then
		manager.redPoint:unbindUIandKey(self.chapterBtn_.transform, RedPointConst.ACTIVITY_COMMON .. "_" .. ActivityConst.ACTIVITY_SUMMER_MAIN_LIMITTIME_5_2)
	else
		manager.redPoint:unbindUIandKey(self.chapterBtn_.transform, ActivityTools.GetRedPointKey(self.activityID_) .. self.activityID_)
	end

	if self.redTrs_ then
		manager.redPoint:unbindUIandKey(self.redTrs_, RedPointConst.ACTIVITY_COMMON .. "_" .. ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC)
	end
end

function ActivityChapterPageView:AddListeners()
	self:AddBtnListener(self.chapterBtn_, nil, function()
		if ActivityTools.CheckActivityIsSuspended(self.activityID_) then
			return
		end

		if not self:IsActivityTime() then
			return
		end

		if ActivityChapterPageCfg[self.activityID_].chapter_type == 1 then
			local var_10_0 = self:GetTargetChapterID()

			if ChapterTools.IsFinishPreChapter(var_10_0) then
				OperationRecorder.RecordButtonTouch({
					button_name = "activity_story_chapter_jump",
					chapter_id = self.chapterClientID_
				})
				ChapterTools.GotoChapterSection(var_10_0)

				return
			end

			ShowTips("TIME_OVER")
		else
			OperationRecorder.RecordButtonTouch({
				button_name = "activity_story_chapter_jump",
				chapter_id = self.chapterClientID_
			})
			JumpTools.Jump2SubPlot(self.chapterClientID_, nil, true)
		end
	end)

	if self.dlcBtn_ then
		self:AddBtnListener(self.dlcBtn_, nil, function()
			JumpTools.OpenPageByJump("summerRaceSkinPopView_5_2")
		end)
	end
end

function ActivityChapterPageView:CheckLimitTimeChapter()
	self.chapterClientID_ = ActivityChapterPageCfg[self.activityID_].chapter_client_id

	if self.timeGo_ then
		if ChapterTools.GetChapterShowTypeData(self.chapterClientID_) == "limitTime" then
			self.timeText_ = self.timeGo_.transform:Find("iconbg/texttime"):GetComponent("Text")

			self.timeGo_:SetActive(true)
		else
			self.timeGo_:SetActive(false)
		end
	end
end

function ActivityChapterPageView:AddDlcTimer()
	self:StopDlcTimer()
	self:RefreshDlcTimeText()

	self.dlc_timer_ = Timer.New(function()
		if manager.time:GetServerTime() > self.stopDlcTime_ then
			return
		end

		self:RefreshTimeText()
	end, 1, -1)

	self.dlc_timer_:Start()
end

function ActivityChapterPageView:StopDlcTimer()
	if self.dlc_timer_ then
		self.dlc_timer_:Stop()

		self.dlc_timer_ = nil
	end
end

function ActivityChapterPageView:RefreshDlcTimeText()
	if self.timeDlcText_ then
		self.timeDlcText_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
	end
end

return ActivityChapterPageView
