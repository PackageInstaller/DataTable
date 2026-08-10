local var_0_0 = class("Guide_354", BaseGuide)

function var_0_0.Check(arg_1_0)
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

	return var_0_0.super.Check(arg_1_0)
end

return var_0_0
