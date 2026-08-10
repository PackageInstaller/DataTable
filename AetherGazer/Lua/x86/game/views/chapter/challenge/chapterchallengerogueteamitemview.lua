local var_0_0 = import(".ChapterChallengeItemView")
local var_0_1 = class("ChapterChallengeRogueTeamItemView", var_0_0)

function var_0_1.ClickItem(arg_1_0, arg_1_1)
	if arg_1_0.isLock_ then
		ShowTips(arg_1_0.lockTips_)

		return
	end

	if arg_1_0:CheckLock() then
		return
	end

	arg_1_0:Go("/challengeRogueTeamEntrace", {
		templateID = ChallengeRogueTeamData:GetCacheTemplateID()
	})
end

return var_0_1
