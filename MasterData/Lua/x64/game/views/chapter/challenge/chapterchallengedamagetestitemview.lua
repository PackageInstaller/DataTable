local ChapterChallengeDamageTestItemView = class("ChapterChallengeDamageTestItemView", (import(".ChapterChallengeItemView")))

function ChapterChallengeDamageTestItemView:ClickItem(arg_1_1)
	self:Go("/damageTestMode")
end

function ChapterChallengeDamageTestItemView:IsLock()
	self.isLock_ = false
end

return ChapterChallengeDamageTestItemView
