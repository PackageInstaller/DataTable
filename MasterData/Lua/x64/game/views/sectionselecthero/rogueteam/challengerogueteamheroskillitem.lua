local ChallengeRogueTeamHeroSkillItem = class("ChallengeRogueTeamHeroSkillItem", (import("game.views.newHero.items.HeroSkillItem")))

function ChallengeRogueTeamHeroSkillItem:RefreshLv(arg_1_1)
	self.lvText_.text = string.format("%d", arg_1_1.lv + arg_1_1.addSkillLv + arg_1_1.addEquipSkillLv)

	local var_1_0 = self.heroViewProxy_:GetHeroData(arg_1_1.heroId)

	if var_1_0.modifySkill and var_1_0.modifySkill[self.index_] or var_1_0.tempID then
		self.lvBg_.color = Color(0.44, 0.64, 0.87)
		self.lvText_.color = Color.white
	else
		self.lvBg_.color = Color(1, 1, 1)
		self.lvText_.color = Color.black
	end
end

function ChallengeRogueTeamHeroSkillItem:RefreshData(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.data_ = arg_2_1
	self.info_ = arg_2_2
	self.heroViewProxy_ = arg_2_3
	self.index_ = arg_2_4

	self:Render()
end

function ChallengeRogueTeamHeroSkillItem:RefreshUI(arg_3_1)
	if arg_3_1 then
		self.skilliconImg_.sprite = getSprite("Atlas/" .. arg_3_1.heroId, (self:GetRealSkillId(arg_3_1)))

		SetActive(self.upGo_, arg_3_1.isCanUp)
		self:RefreshLv(arg_3_1)
	end
end

return ChallengeRogueTeamHeroSkillItem
