local var_0_0 = import(".ChapterChallengeItemView")
local var_0_1 = class("ChapterChallengeTownItemView", var_0_0)

function var_0_1.ClickItem(arg_1_0, arg_1_1)
	if arg_1_0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_tower_above")

		arg_1_0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_tower_below")
	end

	if arg_1_0:CheckLock() then
		return
	end

	JumpTools.GoToSystem("/towerStage", nil, ViewConst.SYSTEM_ID.TOWER)
end

return var_0_1
