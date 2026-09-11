local StoryChapterBtnView = class("StoryChapterBtnView", ReduxView)

function StoryChapterBtnView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.chapterID_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function StoryChapterBtnView:OnEnter(arg_2_1)
	self.isLock_ = table.length(StoryStageActivityData:GetStageData(self.chapterID_)) <= 0

	self:RefreshBtn(arg_2_1)
end

function StoryChapterBtnView:OnExit()
	self:StopTimer()
end

function StoryChapterBtnView:OnUpdate(arg_4_1)
	self:RefreshBtn(arg_4_1)
end

function StoryChapterBtnView:RefreshBtn(arg_5_1)
	if self.chapterID_ == arg_5_1 then
		self.controller_:SetSelectedState("value_2")
		StoryStageActivityData:SetUnlockState(self.chapterID_)
	elseif self.isLock_ then
		self.controller_:SetSelectedState("false")
	else
		self.controller_:SetSelectedState("true")

		if StoryStageActivityData:GetUnlockState(self.chapterID_) then
			self.animator_:Play("Ani_unselect", -1, 1)
		else
			self:AddTimer()
		end
	end
end

function StoryChapterBtnView:Dispose()
	StoryChapterBtnView.super.Dispose(self)
end

function StoryChapterBtnView:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.isLock_ then
			local var_8_0 = table.keyof(ActivityStoryChapterCfg.get_id_list_by_activity_id[ActivityStoryChapterCfg[self.chapterID_].activity_id], self.chapterID_) or 1

			if var_8_0 <= 1 then
				return
			end

			ShowTips(string.format(GetTips("NOTE_TASK_UNLOCK"), (GetI18NText(ActivityStoryChapterCfg[ActivityStoryChapterCfg.get_id_list_by_activity_id[ActivityStoryChapterCfg[self.chapterID_].activity_id][var_8_0 - 1]].name))))

			return
		else
			local var_8_1 = ActivityStoryChapterCfg[self.chapterID_]

			StoryStageActivityData:SaveHistoryChapter(ActivityStoryChapterCfg[self.chapterID_].activity_id, self.chapterID_)
			self:Go("/storyStageActivity", {
				chapterID = self.chapterID_,
				theme = ActivityCfg[var_8_1.activity_id].activity_theme
			})
		end
	end)
end

function StoryChapterBtnView:AddTimer()
	self:StopTimer()

	local var_9_0 = self.animator_:GetCurrentAnimatorStateInfo(0)

	self.timer_ = Timer.New(function()
		if var_9_0.normalizedTime > 0.5 then
			StoryStageActivityData:SetUnlockState(self.chapterID_)
			self:StopTimer()
		end
	end, 0.033, -1)

	self.timer_:Start()
end

function StoryChapterBtnView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return StoryChapterBtnView
