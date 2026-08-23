local ComboSkill = class("ComboSkill")

function ComboSkill:create(arg_1_1)
	return ComboSkill.new(self, arg_1_1)
end

function ComboSkill:ctor(arg_2_1, arg_2_2)
	local var_2_0 = loadCfg("core.config.cfg.unite_token_info").get(arg_2_1)

	self._skillCfg, self._advId = loadCfg("core.config.cfg.skill_info").get(var_2_0.skill_id), var_2_0.advance_id
	self._curCDTime = 0
	self.level = arg_2_2 or 0
	self._quality = var_2_0.quality
	self._star = var_2_0.star
end

function ComboSkill:isReady()
	return not self:isCooling()
end

function ComboSkill:isCooling()
	return self._curCDTime > 0
end

function ComboSkill:getCD()
	return self._curCDTime
end

function ComboSkill:calmdown()
	self._curCDTime = self._skillCfg.extra_cost_value

	return self._curCDTime
end

function ComboSkill:recover()
	if self._curCDTime > 0 then
		self._curCDTime = self._curCDTime - 1

		return true
	end

	return false
end

function ComboSkill:calCd(arg_8_1)
	self._curCDTime = math.max(self._curCDTime - arg_8_1, 0)
end

function ComboSkill:getSkillCfg()
	return self._skillCfg
end

function ComboSkill:getAdvId()
	return self._advId
end

function ComboSkill:getQuality()
	return self._quality
end

function ComboSkill:getStar()
	return self._star
end

return ComboSkill
