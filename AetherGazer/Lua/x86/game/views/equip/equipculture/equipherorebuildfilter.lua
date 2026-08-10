HeroListFilterView = import("game.views.newHero.HeroListFilterView")

local var_0_0 = class("EquipHeroRebuildFilter", HeroListFilterView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.heroSorter_ = HeroSorter.New()
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

return var_0_0
