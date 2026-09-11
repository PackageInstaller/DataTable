local ChapterChallengeItemWithCD = class("ChapterChallengeItemWithCD", (import(".ChapterChallengeItemView")))

function ChapterChallengeItemWithCD:AddCountdown()
	self:RefreshTimeText()
	self:RemoveCountdown()

	self.timer_ = Timer.New(function()
		self:RefreshTimeText()
	end, 1, -1)

	self.timer_:Start()
end

function ChapterChallengeItemWithCD:RefreshTimeText()
	self:IsLock()

	if self.isLock_ ~= self.isLock_ then
		self:RefreshLock()
		manager.notify:Invoke(CHALLENGE_CONTENT_REFRESH)
	end

	if self.isLock_ then
		self.timeText_.text = ""

		self.timeController_:SetSelectedState("state1")
	else
		self.timeController_:SetSelectedState("state0")

		self.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr(self:GetLostTime(), nil, true))
	end
end

return ChapterChallengeItemWithCD
