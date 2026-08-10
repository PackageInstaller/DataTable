local var_0_0 = import("game.views.sectionSelectHero.NewSectionSelectHeroBaseView")
local var_0_1 = class("SummerWaterSelectHeroView", var_0_0)

function var_0_1.OnWaterResult(arg_1_0)
	ShowTips("TIME_OVER")
	arg_1_0:Back()
end

return var_0_1
