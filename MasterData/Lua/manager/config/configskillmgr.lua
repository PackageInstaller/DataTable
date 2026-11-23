ConfigSkillMgr = {}


function ConfigSkillMgr.GetCharacterSkill(key)
	return ConfigMgr.Config.characterSkillMap[key];
end


function ConfigSkillMgr.GetCharacterPassiveSkill(key)
	return ConfigMgr.Config.characterPassiveSkillMap[key];
end


function ConfigSkillMgr.GetEquipmentSkill(id, level)
	local map = ConfigMgr.Config.equipmentSkills[id]
	if map ~= nil then
		return map[level]
	end
	return nil
end

function ConfigSkillMgr.SkillShouldHide(fullId, type)
	local ret = true
	if type == 1 then
		local skill = ConfigMgr.Config.characterSkillMap[fullId];
		if skill ~= nil then
			ret = skill.IsConceal
		end
	elseif type == 2 then
		local skill = ConfigMgr.Config.characterPassiveSkillMap[fullId];
		if skill ~= nil then
			ret = skill.IsConceal
		end
	end
	return ret
end