local MatrixHeroSkillItem = class("MatrixHeroSkillItem", (import("game.views.newHero.items.HeroSkillItem")))

function MatrixHeroSkillItem:RefreshLv(arg_1_1)
	self.lvText_.text = string.format("%d", arg_1_1.lv + arg_1_1.addSkillLv)
end

function MatrixHeroSkillItem:GetRealSkillId(arg_2_1)
	return SkillTools.GetRealSkillIdByWeaponServantId(arg_2_1.heroId, arg_2_1.servantId, arg_2_1.id)
end

return MatrixHeroSkillItem
