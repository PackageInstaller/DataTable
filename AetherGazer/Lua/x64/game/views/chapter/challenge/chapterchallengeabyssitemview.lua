local var_0_0 = import(".ChapterChallengeItemWithCD")
local var_0_1 = class("ChapterChallengeAbyssItemView", var_0_0)

function var_0_1.ClickItem(arg_1_0, arg_1_1)
	if arg_1_0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_abyss_above")

		arg_1_0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_abyss_below")
	end

	if arg_1_0:CheckLock() then
		return
	end

	JumpTools.GoToSystem("/abyssMain", {}, ViewConst.SYSTEM_ID.BATTLE_ABYSS)
end

function var_0_1.GetLostTime(arg_2_0)
	return AbyssData:GetRefreshTimestamp()
end

return var_0_1
