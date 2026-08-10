local var_0_0 = import("game.views.osiris.raceTrial.RaceTrialBattleItem")
local var_0_1 = class("RaceTrialBattleItem_2_10", var_0_0)

function var_0_1.RefreshRace(arg_1_0)
	arg_1_0.raceIcon_.sprite = getSprite("Atlas/JapanRegionUI_2_10", tostring(arg_1_0.cfg_.race))
end

return var_0_1
