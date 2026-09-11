local ChapterChallengeWarChessItemView = class("ChapterChallengeWarChessItemView", import(".ChapterChallengeItemView"))

function ChapterChallengeWarChessItemView:ClickItem(arg_1_1)
	if self.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_warchess_above")

		self.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_warchess_below")
	end

	if self:CheckLock() then
		return
	end

	JumpTools.GoToSystem("/warChessStage", {
		chapterClientID = arg_1_1
	}, ViewConst.SYSTEM_ID.WARCHESS)
end

return ChapterChallengeWarChessItemView
