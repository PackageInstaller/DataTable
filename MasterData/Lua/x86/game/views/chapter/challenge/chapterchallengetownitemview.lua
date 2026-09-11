local ChapterChallengeTownItemView = class("ChapterChallengeTownItemView", (import(".ChapterChallengeItemView")))

function ChapterChallengeTownItemView:ClickItem(arg_1_1)
	if self.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_tower_above")

		self.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_tower_below")
	end

	if self:CheckLock() then
		return
	end

	JumpTools.GoToSystem("/towerStage", nil, ViewConst.SYSTEM_ID.TOWER)
end

return ChapterChallengeTownItemView
