local ChapterChallengeAdvanceTestItemView = class("ChapterChallengeAdvanceTestItemView", (import(".ChapterChallengeItemView")))

function ChapterChallengeAdvanceTestItemView:ClickItem(arg_1_1)
	if self:CheckLock() then
		return
	end

	JumpTools.OpenPageByJump("advanceTestEntrace")
end

function ChapterChallengeAdvanceTestItemView:IsLock()
	self.isLock_ = false
end

return ChapterChallengeAdvanceTestItemView
