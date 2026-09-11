local ActivityChessItem = class("ActivityChessItem", ReduxView)

function ActivityChessItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.chapterID_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function ActivityChessItem:OnEnter()
	self.ACTIVITY_CONST = WarchessLevelCfg[self.chapterID_].type
	self.reprintActivityID_ = ActivityTools.GetReprintActivityID(self.ACTIVITY_CONST)

	self:RefreshUI()
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, self.reprintActivityID_, self.chapterID_))
	self:AddTimer()
end

function ActivityChessItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, self.reprintActivityID_, self.chapterID_))
	self:StopTimer()
end

function ActivityChessItem:Dispose()
	ActivityChessItem.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ActivityChessItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if manager.time:GetServerTime() < self:GetOpenTimestamp() then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self:GetOpenTimestamp())))

			return
		end

		if self:IsPrestageLock() then
			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(ActivityCfg[WarchessLevelCfg[WarchessLevelCfg[self.chapterID_].unlock_level].type].remark), WarchessLevelCfg[WarchessLevelCfg[self.chapterID_].unlock_level].name_level))

			return
		end

		if self:IsLock() then
			if WarchessLevelCfg[self.chapterID_].unlock_condition[1] == 1 then
				ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(ActivityStoryChapterCfg[WarchessLevelCfg[self.chapterID_].unlock_condition[2][1]].name), BattleActivityStoryStageCfg[WarchessLevelCfg[self.chapterID_].unlock_condition[2][2]].name))
			elseif WarchessLevelCfg[self.chapterID_].unlock_condition[1] == 2 then
				ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(ChapterCfg[WarchessLevelCfg[self.chapterID_].unlock_condition[2][1]].subhead), BattleActivityStoryStageCfg[WarchessLevelCfg[self.chapterID_].unlock_condition[2][2]].name))
			end

			return
		end

		ChessTools.EnterChessMap(self.chapterID_, true)
	end)
end

function ActivityChessItem:RefreshUI()
	local var_7_0 = ChessTools.GetChapterProgress(self.chapterID_)

	self.imageProgress_.fillAmount = var_7_0 / 100
	self.textProress_.text = var_7_0
	self.textName_.text = GetI18NText(WarchessLevelCfg[self.chapterID_].name_level)
end

function ActivityChessItem:IsPrestageLock()
	if WarchessLevelCfg[self.chapterID_].unlock_level ~= 0 and ChessTools.GetChapterProgress(WarchessLevelCfg[self.chapterID_].unlock_level) < WarchessLevelCfg[self.chapterID_].success_progress then
		return true
	end

	return false
end

function ActivityChessItem:IsLock()
	if WarchessLevelCfg[self.chapterID_].type == self.ACTIVITY_CONST then
		if WarchessLevelCfg[self.chapterID_].unlock_condition ~= "" then
			if WarchessLevelCfg[self.chapterID_].unlock_condition[1] == 1 then
				local var_9_0 = StoryStageActivityData:GetStageData(WarchessLevelCfg[self.chapterID_].unlock_condition[2][1])[WarchessLevelCfg[self.chapterID_].unlock_condition[2][2]]

				if var_9_0 and var_9_0.clear_times >= 1 then
					-- block empty
				else
					return true
				end
			elseif WarchessLevelCfg[self.chapterID_].unlock_condition[1] == 2 then
				return not ChapterTools.IsClearStage(WarchessLevelCfg[self.chapterID_].unlock_condition[2][2])
			end
		end
	end

	return false
end

function ActivityChessItem:GetOpenTimestamp()
	return WarChessData:GetChessTime(self.chapterID_) or 0
end

function ActivityChessItem:AddTimer()
	self:RefreshState()

	local var_11_0 = manager.time:GetServerTime() - self:GetOpenTimestamp()

	if var_11_0 >= 0 then
		return
	end

	self.textTime_.text = string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(self:GetOpenTimestamp())))

	self:StopTimer()

	self.timer_ = Timer.New(function()
		var_11_0 = manager.time:GetServerTime() - self:GetOpenTimestamp()

		self:RefreshState()

		self.textTime_.text = string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(self:GetOpenTimestamp())))

		if var_11_0 >= 0 then
			self:StopTimer()
		end
	end, 1, -1)

	self.timer_:Start()
end

function ActivityChessItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityChessItem:RefreshState()
	if manager.time:GetServerTime() >= self:GetOpenTimestamp() then
		if self:IsPrestageLock() or self:IsLock() then
			self.controller_:SetSelectedState("open")

			return
		end

		if WarChessData:GetCurrentChapter(WarchessLevelCfg[self.chapterID_].type) == self.chapterID_ then
			self.controller_:SetSelectedState("challenge")
		else
			self.controller_:SetSelectedState("normal")
		end
	else
		self.controller_:SetSelectedState("lock")
	end
end

return ActivityChessItem
