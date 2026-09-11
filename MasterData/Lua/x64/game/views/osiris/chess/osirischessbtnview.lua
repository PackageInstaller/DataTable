local OsirisChessBtnView = class("OsirisChessBtnView", ReduxView)

function OsirisChessBtnView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.chapterID_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function OsirisChessBtnView:OnEnter()
	local var_2_0 = ChessTools.GetChapterProgress(self.chapterID_)

	self.imageProgress_.fillAmount = var_2_0 / 100
	self.textProress_.text = var_2_0
	self.textName_.text = WarchessLevelCfg[self.chapterID_].name_level

	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, ActivityConst.OSIRIS_CHESS, self.chapterID_))
	self:AddTimer()
end

function OsirisChessBtnView:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, ActivityConst.OSIRIS_CHESS, self.chapterID_))
	self:StopTimer()
end

function OsirisChessBtnView:Dispose()
	OsirisChessBtnView.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

function OsirisChessBtnView:AddListeners()
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
			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(ActivityStoryChapterCfg[WarchessLevelCfg[self.chapterID_].unlock_condition[2][1]].name), BattleActivityStoryStageCfg[WarchessLevelCfg[self.chapterID_].unlock_condition[2][2]].name))

			return
		end

		ChessTools.EnterChessMap(self.chapterID_, true)
	end)
end

function OsirisChessBtnView:IsPrestageLock()
	if WarchessLevelCfg[self.chapterID_].unlock_level ~= 0 and ChessTools.GetChapterProgress(WarchessLevelCfg[self.chapterID_].unlock_level) < WarchessLevelCfg[self.chapterID_].success_progress then
		return true
	end

	return false
end

function OsirisChessBtnView:IsLock()
	if WarchessLevelCfg[self.chapterID_].type == ActivityConst.OSIRIS_CHESS then
		if WarchessLevelCfg[self.chapterID_].unlock_condition ~= "" then
			local var_8_0 = StoryStageActivityData:GetStageData(WarchessLevelCfg[self.chapterID_].unlock_condition[1])[WarchessLevelCfg[self.chapterID_].unlock_condition[2]]

			if var_8_0 and var_8_0.clear_times >= 1 then
				-- block empty
			else
				return true
			end
		end
	end

	return false
end

function OsirisChessBtnView:GetOpenTimestamp()
	return WarChessData:GetChessTime(self.chapterID_) or 0
end

function OsirisChessBtnView:AddTimer()
	self:RefreshState()

	local var_10_0 = manager.time:GetServerTime() - self:GetOpenTimestamp()

	if var_10_0 >= 0 then
		return
	end

	self.textTime_.text = string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(self:GetOpenTimestamp())))

	self:StopTimer()

	self.timer_ = Timer.New(function()
		var_10_0 = manager.time:GetServerTime() - self:GetOpenTimestamp()

		self:RefreshState()

		self.textTime_.text = string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(self:GetOpenTimestamp())))

		if var_10_0 >= 0 then
			self:StopTimer()
		end
	end, 1, -1)

	self.timer_:Start()
end

function OsirisChessBtnView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function OsirisChessBtnView:RefreshState()
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

return OsirisChessBtnView
