local ChapterChallengeCoreVerificationItemView = class("ChapterChallengeCoreVerificationItemView", (import(".ChapterChallengeItemWithCD")))

function ChapterChallengeCoreVerificationItemView:GetLostTime()
	local var_1_0 = CoreVerificationData:GetRefreshTime()

	if var_1_0 < manager.time:GetServerTime() then
		return manager.time:GetServerTime() + 604800
	end

	return var_1_0
end

function ChapterChallengeCoreVerificationItemView:ClickItem()
	if self.isAbove_ then
		OperationRecorder.RecordButtonTouch("challenge_attribute_above")

		self.isAbove_ = false
	else
		OperationRecorder.RecordButtonTouch("challenge_attribute_below")
	end

	if self:CheckLock() then
		return
	end

	JumpTools.GoToSystem("/coreVerificationMain", nil, ViewConst.SYSTEM_ID.CORE_VERIFICATION)
end

function ChapterChallengeCoreVerificationItemView:AddRedPoint()
	ChapterChallengeCoreVerificationItemView.super.AddRedPoint(self)
end

function ChapterChallengeCoreVerificationItemView:RemoveRedPoint()
	ChapterChallengeCoreVerificationItemView.super.RemoveRedPoint(self)
end

return ChapterChallengeCoreVerificationItemView
