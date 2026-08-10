local var_0_0 = class("ChapterChallengeWarChessItemView", import(".ChapterChallengeItemView"))

function var_0_0.ClickItem(arg_1_0, arg_1_1)
	if arg_1_0.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_warchess_above")

		arg_1_0.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_warchess_below")
	end

	if arg_1_0:CheckLock() then
		return
	end

	JumpTools.GoToSystem("/warChessStage", {
		chapterClientID = arg_1_1
	}, ViewConst.SYSTEM_ID.WARCHESS)
end

return var_0_0
