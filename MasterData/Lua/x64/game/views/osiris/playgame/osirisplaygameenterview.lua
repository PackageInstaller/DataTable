local OsirisPlayGameEnterView = class("OsirisPlayGameEnterView", ReduxView)

function OsirisPlayGameEnterView:UIName()
	return "Widget/System/Activity_Osiris/Activity_Osiris_ChapterUI"
end

function OsirisPlayGameEnterView:UIParent()
	return manager.ui.uiMain.transform
end

function OsirisPlayGameEnterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function OsirisPlayGameEnterView:InitUI()
	self:BindCfgUI()

	self.items_ = {}

	for iter_4_0 = 1, 6 do
		self.items_[iter_4_0] = OsirisPlayGameChapterItem.New(self["itemGo_" .. iter_4_0], iter_4_0)
	end

	self.challengeCon_ = self.challengeCtrl_:GetController("Challenge")
end

function OsirisPlayGameEnterView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_GENERALITY_DESC")
end

function OsirisPlayGameEnterView:OnEnter()
	self.activityID_ = self.params_.activityID_

	self:RefreshStory()
	self:RefreshUI()
	self:RefreshChallenge()
	self:RefreshItems()

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME) then
		manager.redPoint:bindUIandKey(self.limitRewardBtn_.transform, RedPointConst.OSIRIS_PLAY_GAME_TASK_ALL .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK)
	end

	manager.redPoint:bindUIandKey(self.recordBtn_.transform, RedPointConst.OSIRIS_PLAY_GAME_LEVEL_REWARD .. "_" .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME)
end

function OsirisPlayGameEnterView:AddUIListener()
	self:AddBtnListener(self.limitRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/osirisPlayGameLimitRewardView", {
			activityID = ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK
		})
	end)
	self:AddBtnListener(self.recordBtn_, nil, function()
		JumpTools.OpenPageByJump("/osirisPlayGameBattleRecordView", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.challengeBtn_, nil, function()
		if OsirisPlayGameData:IsPassStagesByStageId(5260163) then
			JumpTools.OpenPageByJump("/osirisPlayGameChallegeStageView", {
				activityID_ = self.activityID_
			})
		else
			ShowTips("CAPTURE_GAME_PRE_SECTION_UNREACHED")
		end
	end)
end

function OsirisPlayGameEnterView:RefreshStory()
	if OsirisPlayGameData:GetPlayStory(GameSetting.activity_generality_start_story.value[1]) ~= 1 then
		manager.story:StartStory(GameSetting.activity_generality_start_story.value[1])
		OsirisPlayGameData:SetPlayStory(GameSetting.activity_generality_start_story.value[1])
	end
end

function OsirisPlayGameEnterView:RefreshChallenge()
	local var_12_0 = OsirisPlayGameData:IsPassStagesByStageId(5260163)

	self.challengeAnim_:Play("UI_Challenge_cx", -1, 0)
	self.challengeAnim_:Update(0)

	self.firstUnlockChapterId = OsirisPlayGameData:GetFirstUnlock()

	if self.firstUnlockChapterId == 7 then
		self.challengeCon_:SetSelectedIndex(0)

		self.challengeTimer_ = Timer.New(function()
			self:ChallengeStopTimer_()
			self.challengeCon_:SetSelectedIndex(1)
			self.challengeAnim_:Play("UI_Challenge_cx_01", -1, 0)
			self.challengeAnim_:Update(0)
			OsirisPlayGameData:SetFirstUnlock(0)
		end, 0.5, 1)

		self.challengeTimer_:Start()
	else
		self.challengeCon_:SetSelectedIndex(var_12_0 and 1 or 0)
	end
end

function OsirisPlayGameEnterView:ChallengeStopTimer_()
	if self.challengeTimer_ then
		self.challengeTimer_:Stop()

		self.challengeTimer_ = nil
	end
end

function OsirisPlayGameEnterView:RefreshUI()
	if ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]] and ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].name ~= "" and self.titleTxt_ then
		self.titleTxt_.text = GetI18NText(ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].name)
	end

	self.curLv_, self.maxLv_ = self:GetLevelInfo()
	self.recordNumTxt_.text = self.curLv_ .. "/" .. self.maxLv_

	self:RefreshLimitTime()
end

function OsirisPlayGameEnterView:GetLevelInfo()
	return OsirisPlayGameData:GetNum(), #ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_]
end

function OsirisPlayGameEnterView:RefreshLimitTime()
	local var_17_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK) then
		SetActive(self.limitRewardBtn_.gameObject, true)

		self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_17_0.stopTime)
	else
		SetActive(self.limitRewardBtn_.gameObject, false)
	end

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(self.activityID_) then
				self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_17_0.stopTime)
			else
				if manager.time:GetServerTime() < var_17_0.startTime then
					self.limitTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_17_0.startTime))
				elseif manager.time:GetServerTime() > var_17_0.stopTime then
					self.limitTimeTxt_.text = GetTips("TIME_OVER")
				end

				SetActive(self.limitRewardBtn_, false)
			end
		end, 1, -1)
	end

	self.timer_:Start()
end

function OsirisPlayGameEnterView:RefreshItems()
	for iter_19_0 = 1, #self.items_ do
		self.items_[iter_19_0]:RefreshView()
	end
end

function OsirisPlayGameEnterView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function OsirisPlayGameEnterView:OnExit()
	self:StopTimer()
	manager.windowBar:HideBar()
	self:ChallengeStopTimer_()

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME) then
		manager.redPoint:unbindUIandKey(self.limitRewardBtn_.transform, RedPointConst.OSIRIS_PLAY_GAME_TASK_ALL .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK)
	end

	manager.redPoint:unbindUIandKey(self.recordBtn_.transform, RedPointConst.OSIRIS_PLAY_GAME_LEVEL_REWARD .. "_" .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME)
	OsirisPlayGameEnterView.super.OnExit(self)
end

function OsirisPlayGameEnterView:Dispose()
	for iter_22_0 = 1, #self.items_ do
		self.items_[iter_22_0]:Dispose()
	end

	OsirisPlayGameEnterView.super.Dispose(self)
end

return OsirisPlayGameEnterView
