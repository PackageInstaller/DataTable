local ChapterVariantBaseItem = class("ChapterVariantBaseItem", ReduxView)

function ChapterVariantBaseItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "lockState")
end

function ChapterVariantBaseItem:OnEnter(arg_2_1)
	self.chapterID_ = arg_2_1
	self.isLock_ = not BattleStageData:GetStageData()[ChapterCfg[arg_2_1].section_id_list[1]]

	self:BindRedPoint()

	if ChapterCfg[arg_2_1].unlock_activity_id ~= 0 then
		self:AddTimer()
	else
		self:RefreshControllerState()
	end
end

function ChapterVariantBaseItem:OnExit()
	self:UnBindRedPoint()
	self:StopTimer()
end

function ChapterVariantBaseItem:Dispose()
	ChapterVariantBaseItem.super.Dispose(self)
end

function ChapterVariantBaseItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.timeLock_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ChapterCfg[self.chapterID_].unlock_activity_id).startTime)))

			return
		end

		if self.chapterID_ == 11112 and not SkuldTravelData:IsCollectAllPhoto() then
			ShowTips(GetTips("TRAVEL_SKULD_COLLECT_ALL_PHOTO"))

			return
		end

		if self.isLock_ then
			ShowTips("NEED_FINISH_PRE_NORMAL_STAGE")

			return
		end

		self:Go("/chapterSection", {
			chapterID = self.chapterID_
		})
	end)
end

function ChapterVariantBaseItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, self.chapterID_))
end

function ChapterVariantBaseItem:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, self.chapterID_))
end

function ChapterVariantBaseItem:AddTimer()
	self:StopTimer()

	local var_9_0 = ActivityData:GetActivityData(ChapterCfg[self.chapterID_].unlock_activity_id)

	self.timeLock_ = false

	if manager.time:GetServerTime() > var_9_0.startTime then
		self:RefreshControllerState()

		return
	end

	self.controller_:SetSelectedState("timeLock")

	self.timerText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_9_0.startTime))
	self.timeLock_ = true
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_9_0.startTime then
			self.timeLock_ = false

			self:RefreshControllerState()
			self:StopTimer()
		else
			self.timerText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_9_0.startTime))
		end
	end, 1, -1)

	self.timer_:Start()
end

function ChapterVariantBaseItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ChapterVariantBaseItem:RefreshControllerState()
	if self.timeLock_ then
		self.controller_:SetSelectedState("timeLock")
	elseif self.isLock_ then
		self.controller_:SetSelectedState("lock")
	else
		self.controller_:SetSelectedState("normal")
	end
end

return ChapterVariantBaseItem
