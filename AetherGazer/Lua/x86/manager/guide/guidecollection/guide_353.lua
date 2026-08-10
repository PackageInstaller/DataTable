local var_0_0 = class("Guide_353", BaseGuide)
local var_0_1 = 8

local function var_0_2()
	return gameContext:IsOpenRoute("summerRaceUnlockPopView") ~= nil or gameContext:IsOpenRoute("summerRaceUnlockBannerView") ~= nil
end

function var_0_0.CheckGuide(arg_2_0)
	if var_0_2() or SummerRaceData:HasPendingUnlockPop() == true then
		return false
	end

	return var_0_0.super.CheckGuide(arg_2_0)
end

function var_0_0.Check(arg_3_0)
	if var_0_2() then
		manager.guide.view:Hide()

		return false
	end

	if arg_3_0:IsPlaying() then
		local var_3_0 = arg_3_0._steps[1]

		if var_3_0 ~= nil and var_3_0:GetStepId() == 35301 then
			local var_3_1 = gameContext:GetOpenPageHandler("summerRaceTournamentView")

			if var_3_1 ~= nil and var_3_1.RefreshStageScrollByItemIndex ~= nil then
				var_3_1:RefreshStageScrollByItemIndex(var_0_1)
			end
		end
	end

	return var_0_0.super.Check(arg_3_0)
end

return var_0_0
