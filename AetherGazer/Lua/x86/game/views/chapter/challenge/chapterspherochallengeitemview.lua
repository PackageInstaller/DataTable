local var_0_0 = import(".ChapterChallengeItemView")
local var_0_1 = class("ChapterSPHeroChallengeItemView", var_0_0)

function var_0_1.ClickItem(arg_1_0, arg_1_1)
	if arg_1_0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_sp1284_above")

		arg_1_0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_sp1284_below")
	end

	if arg_1_0:CheckLock() then
		return
	end

	SPHeroChallengeTools:EnterSystem(ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1)
end

return var_0_1
