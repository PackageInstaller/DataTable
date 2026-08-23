local PetData = class("PetData")

function PetData:createPet()
	return PetData.new(self)
end

function PetData:ctor(arg_2_1)
	self._petCfg = loadCfg("core.config.cfg.pet_info").get(arg_2_1)
end

function PetData:getExtraSkill(arg_3_1)
	if self._petCfg.passive_skill_1 > 0 and self._petCfg.passive_skill_1 == arg_3_1 then
		return self._petCfg.link_passive_skill_1
	end

	if self._petCfg.passive_skill_2 > 0 and self._petCfg.passive_skill_2 == arg_3_1 then
		return self._petCfg.link_passive_skill_2
	end

	if self._petCfg.passive_skill_3 > 0 and self._petCfg.passive_skill_3 == arg_3_1 then
		return self._petCfg.link_passive_skill_3
	end

	return 0
end

function PetData:getQuality()
	return self._petCfg.quality
end

function PetData:getAdvanceId()
	return self._petCfg.advance_id
end

function PetData:getStar()
	return self._petCfg.star
end

return PetData
