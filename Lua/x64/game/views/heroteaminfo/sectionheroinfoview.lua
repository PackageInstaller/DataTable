local var_0_0 = import("game.views.newHero.HeroInfoView")
local var_0_1 = class("SectionHeroInfoView", var_0_0)

function var_0_1.UpdateModuleView(arg_1_0)
	SetActive(arg_1_0.moduleView_.gameObject, false)
end

function var_0_1.UpdateUnlockBtnState(arg_2_0)
	arg_2_0.levelStateController_:SetSelectedState("maxLevel")
end

return var_0_1
