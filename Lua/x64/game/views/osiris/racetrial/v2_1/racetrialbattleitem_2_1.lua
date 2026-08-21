local var_0_0 = import("game.views.osiris.raceTrial.RaceTrialBattleItem")
local var_0_1 = class("RaceTrialBattleItem_2_1", var_0_0)

function var_0_1.RefreshRace(arg_1_0)
	arg_1_0.raceNameIcon_.sprite = getSprite("Atlas/XuHeng2ndUI", string.format("name_%d", arg_1_0.cfg_.race))
	arg_1_0.raceIcon_.sprite = getSprite("Atlas/XuHeng2ndUI", tostring(arg_1_0.cfg_.race))
end

return var_0_1
