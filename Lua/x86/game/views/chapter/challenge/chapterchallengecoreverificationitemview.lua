local var_0_0 = import(".ChapterChallengeItemWithCD")
local var_0_1 = class("ChapterChallengeCoreVerificationItemView", var_0_0)

function var_0_1.GetLostTime(arg_1_0)
	local var_1_0 = CoreVerificationData:GetRefreshTime()

	if var_1_0 < manager.time:GetServerTime() then
		return manager.time:GetServerTime() + 604800
	end

	return var_1_0
end

function var_0_1.ClickItem(arg_2_0)
	if arg_2_0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_attribute_above")

		arg_2_0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_attribute_below")
	end

	if arg_2_0:CheckLock() then
		return
	end

	JumpTools.GoToSystem("/coreVerificationMain", nil, ViewConst.SYSTEM_ID.CORE_VERIFICATION)
end

function var_0_1.AddRedPoint(arg_3_0)
	var_0_1.super.AddRedPoint(arg_3_0)
end

function var_0_1.RemoveRedPoint(arg_4_0)
	var_0_1.super.RemoveRedPoint(arg_4_0)
end

return var_0_1
