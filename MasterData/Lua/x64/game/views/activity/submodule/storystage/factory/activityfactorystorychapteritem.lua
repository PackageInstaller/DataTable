local ActivityFactoryStoryChapterItem = class("ActivityFactoryStoryChapterItem", ReduxView)

function ActivityFactoryStoryChapterItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.chapterID_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
end

function ActivityFactoryStoryChapterItem:OnEnter(arg_2_1)
	self.isLock_ = BattleStageData:GetStageData()[ChapterCfg[self.chapterID_].section_id_list[1]] == nil

	self:RefreshBtn(arg_2_1)
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, self.chapterID_))
end

function ActivityFactoryStoryChapterItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, self.chapterID_))
end

function ActivityFactoryStoryChapterItem:OnUpdate(arg_4_1)
	self:RefreshBtn(arg_4_1)
end

function ActivityFactoryStoryChapterItem:RefreshBtn(arg_5_1)
	if self.chapterID_ == arg_5_1 then
		self.selectController_:SetSelectedState("true")
		BattleStageAction.ClickSubPlot(self.chapterID_)
	else
		self.selectController_:SetSelectedState("false")
	end

	if self.isLock_ then
		self.controller_:SetSelectedState("false")
	else
		self.controller_:SetSelectedState("true")
	end
end

function ActivityFactoryStoryChapterItem:Dispose()
	ActivityFactoryStoryChapterItem.super.Dispose(self)
end

function ActivityFactoryStoryChapterItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.isLock_ then
			local var_8_0 = ActivityData:GetActivityRefreshTime(ChapterCfg[self.chapterID_].activity_id)

			if var_8_0 > manager.time:GetServerTime() then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_8_0)))

				return
			end

			for iter_8_0, iter_8_1 in ipairs(ChapterCfg[self.chapterID_].pre_chapter) do
				local var_8_1 = BattleStageData:GetStageData()[ChapterCfg[iter_8_1].section_id_list[#ChapterCfg[iter_8_1].section_id_list]]

				if var_8_1 and var_8_1.clear_times > 0 then
					-- block empty
				else
					ShowTips(string.format(GetTips("NOTE_TASK_UNLOCK"), ChapterCfg[iter_8_1].subhead))

					return
				end
			end
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

return ActivityFactoryStoryChapterItem
