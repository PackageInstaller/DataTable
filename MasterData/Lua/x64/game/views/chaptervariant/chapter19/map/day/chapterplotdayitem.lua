local ChapterPlotDayItem = class("ChapterPlotDayItem", ReduxView)

function ChapterPlotDayItem:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.chapterID_ = arg_1_3
	self.day_ = arg_1_4

	self:BindCfgUI()
	self:BindCfgUI()
	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = self.controllerEx_:GetController("state")
	self.dayImageController_ = self.controllerEx_:GetController("default1")
	self.newDayController_ = self.controllerEx_:GetController("newDay")

	self:Show(true)
end

function ChapterPlotDayItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.timeLock_ then
			ShowTips(string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.day_][1]].activity_id).startTime)))

			return
		end

		if self.isLock_ then
			local var_3_0 = ChapterTools.GetChapterDayList(self.chapterID_)

			if ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][var_3_0[table.keyof(var_3_0, self.day_) - 1]][1]].name == "" then
				ShowTips(string.format(GetTips("CLEAR_DAY_ALL_STAGE_THEN_UNLOCK"), var_3_0[table.keyof(var_3_0, self.day_) - 1]))
			else
				ShowTips(string.format(GetTips("CLEAR_DAY_ALL_STAGE_THEN_UNLOCK_2"), ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][var_3_0[table.keyof(var_3_0, self.day_) - 1]][1]].name))
			end

			return
		end

		if not BattleStageData:GetOperateChapterDay(self.chapterID_, self.day_) then
			BattleStageAction.OperateChapterDay(self.chapterID_, self.day_, function()
				BattleFieldData:SaveChapterMapDay(self.chapterID_, self.day_)
				manager.notify:Invoke(CHAPTER_DAY_CHANGED)
			end)
		else
			BattleFieldData:SaveChapterMapDay(self.chapterID_, self.day_)
			manager.notify:Invoke(CHAPTER_DAY_CHANGED)
		end
	end)
end

function ChapterPlotDayItem:SetData(arg_5_1, arg_5_2)
	self.day_ = arg_5_1
	self.selectDay_ = arg_5_2
	self.isLock_ = not ChapterTools.IsClearPreChapterDayAllStage(self.chapterID_, arg_5_1)

	local var_5_0 = ChapterTools.GetChapterDayList(self.chapterID_)

	if table.keyof(var_5_0, arg_5_1) == 2 and ChapterTools.IsNeedOperateFirstDayWatch(self.chapterID_, var_5_0[1]) then
		self.isLock_ = true
	end

	if ChapterTools.IsLastDay(self.chapterID_, arg_5_1) and not BattleStageData:GetOperateChapterDay(self.chapterID_, arg_5_1) then
		self.isLock_ = true
	end

	self.timeLock_ = ActivityTools.GetActivityStatus(ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][arg_5_1][1]].activity_id) == 0

	self:RefreshUI()
end

function ChapterPlotDayItem:RefreshUI()
	if ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.day_][1]].icon_id ~= "" then
		self.dayImage_.sprite = getSprite("Atlas/OperationAtlas", ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.day_][1]].icon_id)

		self.dayImageController_:SetSelectedState("image")
	else
		self.dayText_.text = string.format("%s", self.day_)

		self.dayImageController_:SetSelectedState("num")
	end

	if self.selectDay_ == self.day_ then
		self.stateController_:SetSelectedState("select")
	elseif self.isLock_ or self.timeLock_ then
		self.stateController_:SetSelectedState("lock")
	else
		self.stateController_:SetSelectedState("unlock")
	end

	self:RefreshGuild()
	self:AddTimer()
end

function ChapterPlotDayItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function ChapterPlotDayItem:Dispose()
	self:StopTimer()
	ChapterPlotDayItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChapterPlotDayItem:RefreshGuild()
	if ChapterTools.IsNeedGuildDay(self.chapterID_, self.day_) then
		self.newDayController_:SetSelectedState("true")
	else
		self.newDayController_:SetSelectedState("false")
	end
end

function ChapterPlotDayItem:AddTimer()
	self:StopTimer()

	if self.timeLock_ then
		local var_10_0 = ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.day_][1]].activity_id

		self.timer_ = Timer.New(function()
			local var_11_0 = ActivityData:GetActivityData(var_10_0)

			if var_11_0 and manager.time:GetServerTime() >= var_11_0.startTime then
				self.timeLock_ = false

				self:RefreshUI()
				self:StopTimer()
			end
		end, 1, -1)

		self.timer_:Start()
	end
end

function ChapterPlotDayItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ChapterPlotDayItem
