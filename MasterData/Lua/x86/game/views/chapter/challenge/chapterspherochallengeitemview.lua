local ChapterSPHeroChallengeItemView = class("ChapterSPHeroChallengeItemView", (import(".ChapterChallengeItemView")))

function ChapterSPHeroChallengeItemView:ClickItem(arg_1_1)
	if self.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_sp1284_above")

		self.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_sp1284_below")
	end

	if self:CheckLock() then
		return
	end

	SPHeroChallengeTools:EnterSystem(ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1)
end

return ChapterSPHeroChallengeItemView
