local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveSummerWaterTemplate", var_0_0)

function var_0_1.GetTrialHeroList(arg_1_0)
	return SummerWaterTools.GetSingleMoleTrialHeroList()
end

return var_0_1
