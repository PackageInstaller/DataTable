local var_0_0 = import("game.views.newHero.pages.HeroChipPage")
local var_0_1 = class("ForeignHeroChipPage", var_0_0)

function var_0_1.GetChipIDList(arg_1_0)
	return ForeignInfoData:GetHeroData(arg_1_0.heroInfo_.id).using_hero_chip
end

return var_0_1
