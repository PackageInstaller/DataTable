local ChapterChallengeTeachItemView = class("ChapterChallengeTeachItemView", (import(".ChapterChallengeItemView")))

function ChapterChallengeTeachItemView:ClickItem(arg_1_1)
	if self.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_teach_above")

		self.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_teach_below")
	end

	if self:CheckLock() then
		return
	end

	JumpTools.GoToSystem("/teachStage", {}, ViewConst.SYSTEM_ID.BATTLE_TEACH)
end

function ChapterChallengeTeachItemView:AddRedPoint()
	manager.redPoint:bindUIandKey(self.panelTf_, RedPointConst.TEACH)
end

function ChapterChallengeTeachItemView:RemoveRedPoint()
	manager.redPoint:unbindUIandKey(self.panelTf_, RedPointConst.TEACH)
end

return ChapterChallengeTeachItemView
