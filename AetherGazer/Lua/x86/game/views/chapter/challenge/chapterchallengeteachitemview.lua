local var_0_0 = import(".ChapterChallengeItemView")
local var_0_1 = class("ChapterChallengeTeachItemView", var_0_0)

function var_0_1.ClickItem(arg_1_0, arg_1_1)
	if arg_1_0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_teach_above")

		arg_1_0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_teach_below")
	end

	if arg_1_0:CheckLock() then
		return
	end

	JumpTools.GoToSystem("/teachStage", {}, ViewConst.SYSTEM_ID.BATTLE_TEACH)
end

function var_0_1.AddRedPoint(arg_2_0)
	manager.redPoint:bindUIandKey(arg_2_0.panelTf_, RedPointConst.TEACH)
end

function var_0_1.RemoveRedPoint(arg_3_0)
	manager.redPoint:unbindUIandKey(arg_3_0.panelTf_, RedPointConst.TEACH)
end

return var_0_1
