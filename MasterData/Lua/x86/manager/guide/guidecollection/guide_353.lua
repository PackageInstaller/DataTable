local Guide_353 = class("Guide_353", BaseGuide)
local var_0_1 = 8

local function var_0_2()
	return gameContext:IsOpenRoute("summerRaceUnlockPopView") ~= nil or gameContext:IsOpenRoute("summerRaceUnlockBannerView") ~= nil
end

function Guide_353:CheckGuide()
	if var_0_2() or SummerRaceData:HasPendingUnlockPop() == true then
		return false
	end

	return Guide_353.super.CheckGuide(self)
end

function Guide_353:Check()
	if var_0_2() then
		manager.guide.view:Hide()

		return false
	end

	if self:IsPlaying() then
		if self._steps[1] ~= nil and self._steps[1]:GetStepId() == 35301 then
			local var_3_0 = gameContext:GetOpenPageHandler("summerRaceTournamentView")

			if var_3_0 ~= nil and var_3_0.RefreshStageScrollByItemIndex ~= nil then
				var_3_0:RefreshStageScrollByItemIndex(var_0_1)
			end
		end
	end

	return Guide_353.super.Check(self)
end

return Guide_353
