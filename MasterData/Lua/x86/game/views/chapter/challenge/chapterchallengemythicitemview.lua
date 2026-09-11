local ChapterChallengeMythicItemView = class("ChapterChallengeMythicItemView", (import(".ChapterChallengeItemWithCD")))

function ChapterChallengeMythicItemView:GetLostTime()
	return MythicData:GetNextRefreshTime()
end

function ChapterChallengeMythicItemView:ClickItem()
	if self.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_mythic_above")

		self.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_mythic_below")
	end

	if self:CheckLock() then
		return
	end

	if MythicData:GetDifficulty() == MythicData:GetFinalId() then
		JumpTools.GoToSystem("/mythicUltimateView", nil, ViewConst.SYSTEM_ID.MYTHIC)
	else
		JumpTools.GoToSystem("/mythic", nil, ViewConst.SYSTEM_ID.MYTHIC)
	end
end

return ChapterChallengeMythicItemView
