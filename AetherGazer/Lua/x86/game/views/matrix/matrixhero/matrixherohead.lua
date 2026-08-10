local var_0_0 = import("game.views.newHero.NewHeroHead")
local var_0_1 = class("MatrixHeroHead", var_0_0)

function var_0_1.SetHeroId(arg_1_0, arg_1_1)
	arg_1_0.standardId_ = arg_1_1
	arg_1_0.heroId_ = HeroStandardSystemCfg[arg_1_1].hero_id
	arg_1_0.heroCfg_ = HeroCfg[arg_1_0.heroId_]

	local var_1_0, var_1_1 = GetVirtualData(arg_1_1)

	arg_1_0.heroInfo_ = var_1_0

	arg_1_0:UpdateView()
end

function var_0_1.GetHeroStandardId(arg_2_0)
	return arg_2_0.standardId_
end

function var_0_1.UpdateView(arg_3_0)
	local var_3_0 = MatrixData:GetHeroSkin(arg_3_0.heroId_)

	arg_3_0.headIcon_.sprite = HeroTools.GetHeadSprite(var_3_0)

	arg_3_0.headIcon_:SetNativeSize()
	arg_3_0.campController_:SetSelectedState(arg_3_0.heroCfg_.race)
	arg_3_0.lockedController_:SetSelectedState("false")

	arg_3_0.levelText_.text = tostring(arg_3_0.heroInfo_.level or 1)

	local var_3_1 = HeroStarCfg[arg_3_0.heroInfo_.star].star

	arg_3_0.gradeController_:SetSelectedState(var_3_1)
end

return var_0_1
