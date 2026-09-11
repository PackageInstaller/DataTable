local HellaStoryChapterBtnView = class("HellaStoryChapterBtnView", ReduxView)

function HellaStoryChapterBtnView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.chapterID_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function HellaStoryChapterBtnView:OnEnter(arg_2_1)
	self.isLock_ = BattleStageData:GetStageData()[ChapterCfg[self.chapterID_].section_id_list[1]] == nil

	self:RefreshBtn(arg_2_1)
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, self.chapterID_))
end

function HellaStoryChapterBtnView:OnExit()
	self:StopTimer()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, self.chapterID_))
end

function HellaStoryChapterBtnView:OnUpdate(arg_4_1)
	self:RefreshBtn(arg_4_1)
end

function HellaStoryChapterBtnView:RefreshBtn(arg_5_1)
	if self.chapterID_ == arg_5_1 then
		self.controller_:SetSelectedState("value_2")
		StoryStageActivityData:SetUnlockState(self.chapterID_ .. "re")
	elseif self.isLock_ then
		self.controller_:SetSelectedState("false")
	else
		self.controller_:SetSelectedState("true")

		if StoryStageActivityData:GetUnlockState(self.chapterID_ .. "re") then
			self.animator_:Play("Ani_unselect", -1, 1)
		else
			self:AddTimer()
		end
	end
end

function HellaStoryChapterBtnView:Dispose()
	HellaStoryChapterBtnView.super.Dispose(self)
end

function HellaStoryChapterBtnView:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.isLock_ then
			local var_8_0 = ChapterClientCfg[getChapterClientCfgByChapterID(self.chapterID_).id].chapter_list
			local var_8_1 = table.keyof(var_8_0, self.chapterID_) or 1

			if var_8_1 <= 1 then
				return
			end

			ShowTips(string.format(GetTips("NOTE_TASK_UNLOCK"), ChapterCfg[var_8_0[var_8_1 - 1]].subhead))

			return
		else
			local var_8_2 = getChapterClientCfgByChapterID(self.chapterID_)

			BattleFieldData:SetStageByClientID(var_8_2.id, BattleFieldData:GetCacheStage(self.chapterID_) or ChapterCfg[self.chapterID_].section_id_list[1])
			BattleFieldData:SetCacheChapterClient(getChapterToggle(var_8_2.id), var_8_2.id)
			BattleFieldData:SetSecondCacheChapter(getChapterToggle(var_8_2.id), self.chapterID_, var_8_2.id)
			BattleStageAction.ClickSubPlot(self.chapterID_)
			JumpTools.Jump2SubPlot(var_8_2.id, true)
		end
	end)
end

function HellaStoryChapterBtnView:AddTimer()
	self:StopTimer()

	local var_9_0 = self.animator_:GetCurrentAnimatorStateInfo(0)

	self.timer_ = Timer.New(function()
		if var_9_0.normalizedTime > 0.5 then
			StoryStageActivityData:SetUnlockState(self.chapterID_ .. "re")
			self:StopTimer()
		end
	end, 0.033, -1)

	self.timer_:Start()
end

function HellaStoryChapterBtnView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return HellaStoryChapterBtnView
