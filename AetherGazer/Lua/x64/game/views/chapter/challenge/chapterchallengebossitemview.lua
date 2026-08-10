local var_0_0 = import(".ChapterChallengeItemWithCD")
local var_0_1 = class("ChapterChallengeBossItemView", var_0_0)

function var_0_1.GetLostTime(arg_1_0)
	local var_1_0 = BattleBossChallengeData:GetNextRefreshTime()

	if var_1_0 < manager.time:GetServerTime() then
		return manager.time:GetServerTime() + 604800
	end

	return var_1_0
end

function var_0_1.ClickItem(arg_2_0)
	if arg_2_0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_boss_above")

		arg_2_0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_boss_below")
	end

	if arg_2_0:CheckLock() then
		return
	end

	BattleBossChallengeAction.EnterBossChallenge()
end

return var_0_1
