local ChapterChallengeRogueTeamItemView = class("ChapterChallengeRogueTeamItemView", (import(".ChapterChallengeItemView")))

function ChapterChallengeRogueTeamItemView:ClickItem(arg_1_1)
	if self.isLock_ then
		ShowTips(self.lockTips_)

		return
	end

	if self:CheckLock() then
		return
	end

	self:Go("/challengeRogueTeamEntrace", {
		templateID = ChallengeRogueTeamData:GetCacheTemplateID()
	})
end

return ChapterChallengeRogueTeamItemView
