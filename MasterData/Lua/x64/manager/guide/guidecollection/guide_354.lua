local Guide_354 = class("Guide_354", BaseGuide)

function Guide_354:Check()
	local var_1_0 = gameContext:GetOpenPageHandler("summerRaceMainView")

	if var_1_0 ~= nil then
		if var_1_0.IsChallengeUnlockAnimPlaying ~= nil and var_1_0:IsChallengeUnlockAnimPlaying() == true then
			manager.guide.view:Hide()

			return false
		end

		if var_1_0.IsChallengeStageTabSelected ~= nil and var_1_0:IsChallengeStageTabSelected() ~= true then
			manager.guide.view:Hide()

			return false
		end
	end

	return Guide_354.super.Check(self)
end

return Guide_354
