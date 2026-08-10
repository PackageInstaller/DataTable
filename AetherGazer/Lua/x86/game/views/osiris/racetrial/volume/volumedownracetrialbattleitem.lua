local var_0_0 = import("game.views.osiris.raceTrial.RaceTrialBattleItem")
local var_0_1 = class("VolumeDownRaceTrialBattleItem", var_0_0)

function var_0_1.RefreshRace(arg_1_0)
	if arg_1_0.raceCon_ then
		arg_1_0.raceCon_:SetSelectedState(tostring(arg_1_0.cfg_.race))
	end

	arg_1_0.raceIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VolumeIIIDownUI/VolumeIIIDownChellgeUI/" .. arg_1_0.cfg_.race)
end

return var_0_1
