local BattleStatisticsMatrixOverItem = class("BattleStatisticsMatrixOverItem", (import("..BattleStatisticsMatrixHeroItem")))

function BattleStatisticsMatrixOverItem:RefreshUI()
	if self.heroData_ then
		self.haveHeroController_:SetSelectedState("true")

		local var_1_1 = self.data_
		local var_1_2 = self.maxData_

		self.battleCountIcon_.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[self.heroData_.skin_id].picture_id)

		SetActive(self.battleCountIcon_.gameObject, true)

		self.battleCountLv_.text = self.heroData_.level
		self.battleCountDamageNum_.text = var_1_1.damage
		self.battleCountHurtNum_.text = var_1_1.hurt
		self.battleCountCureNum_.text = var_1_1.cure
		self.battleCountDamageImg_.enabled = var_1_2.damage == var_1_1.damage and var_1_2.damage > 0
		self.battleCountHurtNumImg_.enabled = var_1_2.hurt == var_1_1.hurt and var_1_2.hurt > 0
		self.battleCountCureNumImg_.enabled = var_1_2.cure == var_1_1.cure and var_1_2.cure > 0

		if var_1_1.damage == 0 then
			self.controllers_[1]:SetSelectedState("true")

			self.battleCountDamageNum_.text = "--"
		else
			self.controllers_[1]:SetSelectedState("false")
		end

		if var_1_1.hurt == 0 then
			self.controllers_[2]:SetSelectedState("true")

			self.battleCountHurtNum_.text = "--"
		else
			self.controllers_[2]:SetSelectedState("false")
		end

		if var_1_1.cure == 0 then
			self.controllers_[3]:SetSelectedState("true")

			self.battleCountCureNum_.text = "--"
		else
			self.controllers_[3]:SetSelectedState("false")
		end
	else
		self.haveHeroController_:SetSelectedState("false")
	end
end

return BattleStatisticsMatrixOverItem
