local ChapterVariantSubPlotBaseItem = class("ChapterVariantSubPlotBaseItem", ReduxView)

function ChapterVariantSubPlotBaseItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "lockState")
	self.stageDataChangeHandler_ = handler(self, self.StageDataChange)
end

function ChapterVariantSubPlotBaseItem:OnEnter(arg_2_1)
	self.chapterID_ = arg_2_1

	self:RefreshStageLockState()
	self:BindRedPoint()

	if ChapterCfg[arg_2_1].activity_id ~= 0 then
		self:AddTimer()
	else
		self:RefreshControllerState()
	end

	manager.notify:RegistListener(BATTLE_STAGE_PLOT_CHANGE, self.stageDataChangeHandler_)
end

function ChapterVariantSubPlotBaseItem:OnExit()
	manager.notify:RemoveListener(BATTLE_STAGE_PLOT_CHANGE, self.stageDataChangeHandler_)
	self:UnBindRedPoint()
	self:StopTimer()
end

function ChapterVariantSubPlotBaseItem:Dispose()
	self.stageDataChangeHandler_ = nil

	ChapterVariantSubPlotBaseItem.super.Dispose(self)
end

function ChapterVariantSubPlotBaseItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		JumpTools.Jump2SubPlotByChapterID(self.chapterID_, true)
	end)
end

function ChapterVariantSubPlotBaseItem:BindRedPoint()
	return
end

function ChapterVariantSubPlotBaseItem:UnBindRedPoint()
	return
end

function ChapterVariantSubPlotBaseItem:RefreshStageLockState()
	self.isLock_ = not (ChapterCfg[self.chapterID_].section_id_list[1] == nil or BattleStageData:GetStageData()[ChapterCfg[self.chapterID_].section_id_list[1]])

	self:RefreshControllerState()
end

function ChapterVariantSubPlotBaseItem:StageDataChange()
	self:RefreshStageLockState()
end

function ChapterVariantSubPlotBaseItem:AddTimer()
	self:StopTimer()

	local var_11_0 = ActivityData:GetActivityRefreshTime(ChapterCfg[self.chapterID_].activity_id)

	self.timeLock_ = false

	if var_11_0 < manager.time:GetServerTime() then
		self:RefreshControllerState()

		return
	end

	self.controller_:SetSelectedState("timeLock")

	self.timerText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_11_0))
	self.timeLock_ = true
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_11_0 then
			self.timeLock_ = false

			self:RefreshControllerState()
			self:StopTimer()
		else
			self.timerText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_11_0))
		end
	end, 1, -1)

	self.timer_:Start()
end

function ChapterVariantSubPlotBaseItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ChapterVariantSubPlotBaseItem:RefreshControllerState()
	if self.timeLock_ then
		self.controller_:SetSelectedState("timeLock")
	elseif self.isLock_ then
		self.controller_:SetSelectedState("lock")
	else
		self.controller_:SetSelectedState("normal")
	end
end

return ChapterVariantSubPlotBaseItem
