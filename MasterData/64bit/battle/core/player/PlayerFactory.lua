return {
	createPlayerCommand = function(self)
		local var_1_0 = self.skillId
		local var_1_1 = 0
		local var_1_2 = 0

		if not self.skillId then
			if self.isSuccubaCompare then
				var_1_0 = self.id
				var_1_1 = 0
			elseif not self.isSuccuba then
				local var_1_3 = loadCfg("core.config.cfg.unite_token_info").get(self.id)

				var_1_0 = var_1_3.skill_id
				var_1_1 = var_1_3.advance_id
				var_1_2 = var_1_3.star
			else
				local var_1_4 = loadCfg("core.config.cfg.succuba_info").get(self.id)

				var_1_0 = var_1_4.skill_id
				var_1_1 = var_1_4.advance_id
				var_1_2 = var_1_4.star
			end
		end

		local var_1_5 = self.identity
		local var_1_6 = self.battleData:getComboInfo(self.identity)
		local var_1_7 = self.serialExId or 0

		return {
			classical = 0,
			isDead = false,
			isPlayer = true,
			skillCfg = loadCfg("core.config.cfg.skill_info").get(var_1_0),
			attackCount = self.attack_count,
			identity = var_1_5,
			opIdentity = 3 - var_1_5,
			serialId = (var_1_5 - 1) * 10 + 7 + var_1_7,
			id = self.id,
			comboData = var_1_6,
			multiple = self.battleData:getMultiples(self.identity),
			isSuccuba = self.isSuccuba,
			originInfo = {
				pos = 1
			},
			baseInfo = var_1_6.baseInfo,
			advanceInfo = var_1_6.advanceInfo,
			isPet = self.isPet,
			isElemental = self.isElemental,
			isSpaceTime = self.isSpaceTime,
			succubaCompare = self.isSuccubaCompare,
			skillId = var_1_0,
			advId = var_1_1,
			star = var_1_2,
			pack = function(self)
				return {
					identity = self.identity,
					id = self.id,
					attack_count = self.attackCount
				}
			end
		}
	end
}
