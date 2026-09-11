local ChapterChallengeAbyssItemView = class("ChapterChallengeAbyssItemView", (import(".ChapterChallengeItemWithCD")))

function ChapterChallengeAbyssItemView:ClickItem(arg_1_1)
	if self.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_abyss_above")

		self.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_abyss_below")
	end

	if self:CheckLock() then
		return
	end

	JumpTools.GoToSystem("/abyssMain", {}, ViewConst.SYSTEM_ID.BATTLE_ABYSS)
end

function ChapterChallengeAbyssItemView:GetLostTime()
	return AbyssData:GetRefreshTimestamp()
end

return ChapterChallengeAbyssItemView
