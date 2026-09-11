local HodurMainlineEventItem = class("HodurMainlineEventItem", ReduxView)

function HodurMainlineEventItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function HodurMainlineEventItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.mainControllerEx_:GetController("state")
	self.selectController_ = self.mainControllerEx_:GetController("select")
	self.selected_ = false
end

function HodurMainlineEventItem:AddUIListener()
	self:AddBtnListener(self.eventBtn_, nil, function()
		if self.onClickHandler_ then
			self.onClickHandler_(self.eventID_)
		end
	end)
end

function HodurMainlineEventItem:SetData(arg_5_1, arg_5_2)
	self.eventID_ = arg_5_1
	self.chapterID_ = arg_5_2

	self:RefreshUI()
end

function HodurMainlineEventItem:SetClickHandler(arg_6_1)
	self.onClickHandler_ = arg_6_1
end

function HodurMainlineEventItem:SetSelected(arg_7_1)
	self.selected_ = arg_7_1

	self:RefreshUI()
end

function HodurMainlineEventItem:RefreshUI()
	self.titleText_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")

	self.selectController_:SetSelectedState(self.selected_ and "on" or "off")

	if HodurTools.GetEventComplete(self.eventID_, self.chapterID_) then
		self.stateController_:SetSelectedState("Complete")
	else
		self.stateController_:SetSelectedState("Normal")
	end

	if HodurTools.GetEventUnlock(self.eventID_, self.chapterID_) and not getData("activity_hodur", "first_unlock_event_" .. self.eventID_) then
		saveData("activity_hodur", "first_unlock_event_" .. self.eventID_, true)
		FrameTimer.New(function()
			if self.aniTimer_ then
				self.aniTimer_:Stop()

				self.aniTimer_ = nil
				self.isAni_ = false
			end

			self.aniTimer_ = Timer.New(function()
				if self.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
					if self.aniTimer_ then
						self.aniTimer_:Stop()

						self.aniTimer_ = nil
					end

					manager.ui:UIEventEnabledByUI(true, false)

					self.isAni_ = false
				end
			end, 0.033, -1)

			self.aniTimer_:Start()
		end, 1, 1):Start()
		self.animator_:Play("UI_itemEvent_unlock", -1, 0)
		manager.ui:UIEventEnabledByUI(false, true)

		self.isAni_ = true
	end
end

function HodurMainlineEventItem:Dispose()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
		self.isAni_ = false
	end

	HodurMainlineEventItem.super.Dispose(self)
end

return HodurMainlineEventItem
