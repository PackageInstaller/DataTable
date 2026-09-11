local ChapterChallengeSoloHeartDemonItemView = class("ChapterChallengeSoloHeartDemonItemView", (import(".ChapterChallengeItemView")))

function ChapterChallengeSoloHeartDemonItemView:InitUI()
	ChapterChallengeSoloHeartDemonItemView.super.InitUI(self)
end

function ChapterChallengeSoloHeartDemonItemView:ClickItem(arg_2_1)
	if self:CheckLock() then
		return
	end

	JumpTools.GoToSystem("/soloHeartDemonMain", {})
end

function ChapterChallengeSoloHeartDemonItemView:GetLostTime()
	return SoloHeartDemonData:GetDataByPara("remainTime")
end

return ChapterChallengeSoloHeartDemonItemView
