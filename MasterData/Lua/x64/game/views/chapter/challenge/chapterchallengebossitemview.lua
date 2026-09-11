local ChapterChallengeBossItemView = class("ChapterChallengeBossItemView", (import(".ChapterChallengeItemWithCD")))

function ChapterChallengeBossItemView:GetLostTime()
	local var_1_0 = BattleBossChallengeData:GetNextRefreshTime()

	if var_1_0 < manager.time:GetServerTime() then
		return manager.time:GetServerTime() + 604800
	end

	return var_1_0
end

function ChapterChallengeBossItemView:ClickItem()
	if self.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_boss_above")

		self.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_boss_below")
	end

	if self:CheckLock() then
		return
	end

	BattleBossChallengeAction.EnterBossChallenge()
end

return ChapterChallengeBossItemView
