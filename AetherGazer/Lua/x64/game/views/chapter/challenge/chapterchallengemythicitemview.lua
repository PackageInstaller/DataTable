local var_0_0 = import(".ChapterChallengeItemWithCD")
local var_0_1 = class("ChapterChallengeMythicItemView", var_0_0)

function var_0_1.GetLostTime(arg_1_0)
	return MythicData:GetNextRefreshTime()
end

function var_0_1.ClickItem(arg_2_0)
	if arg_2_0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_mythic_above")

		arg_2_0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_mythic_below")
	end

	if arg_2_0:CheckLock() then
		return
	end

	if MythicData:GetDifficulty() == MythicData:GetFinalId() then
		JumpTools.GoToSystem("/mythicUltimateView", nil, ViewConst.SYSTEM_ID.MYTHIC)
	else
		JumpTools.GoToSystem("/mythic", nil, ViewConst.SYSTEM_ID.MYTHIC)
	end
end

return var_0_1
