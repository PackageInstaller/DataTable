local var_0_0 = import("game.views.newHero.items.HeroSkillItem")
local var_0_1 = class("MatrixHeroSkillItem", var_0_0)

function var_0_1.RefreshLv(arg_1_0, arg_1_1)
	arg_1_0.lvText_.text = string.format("%d", arg_1_1.lv + arg_1_1.addSkillLv)
end

function var_0_1.GetRealSkillId(arg_2_0, arg_2_1)
	return SkillTools.GetRealSkillIdByWeaponServantId(arg_2_1.heroId, arg_2_1.servantId, arg_2_1.id)
end

return var_0_1
