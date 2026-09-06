-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/config/AoQiHeroConfig.lua

module("logic.extensions.aoqigod.config.AoQiHeroConfig", package.seeall)

local AoQiHeroConfig = class("AoQiHeroConfig", BaseConfig)

function AoQiHeroConfig:onInit()
	AoQiHeroConfig.super.onInit(self)
end

function AoQiHeroConfig:getNames()
	return {
		"aoqi_hero_activity",
		"aoqi_hero_creeps",
		"aoqi_hero_endless_stage_prize",
		"aoqi_hero_team",
		"aoqi_hero_pvp_win_score",
		"aoqi_hero_pet_skill",
		"aoqi_hero_pet_property_strategy",
		"aoqi_hero_pet_race_type",
		"aoqi_hero_endless_stage",
		"aoqi_hero_rank_prize",
		"aoqi_hero_normal_stage",
		"aoqi_hero_pet",
		"aoqi_hero_pet_skill_affix",
		"aoqi_hero_position_upgrade",
		"aoqi_hero_image_rule"
	}
end

function AoQiHeroConfig:handleConfig(name, content)
	if name == "aoqi_hero_activity" then
		self._aoqi_hero_activity = content
	elseif name == "aoqi_hero_creeps" then
		self._aoqi_hero_creeps = content
	elseif name == "aoqi_hero_endless_stage_prize" then
		self._aoqi_hero_endless_stage_prize = content
	elseif name == "aoqi_hero_team" then
		self._aoqi_hero_team = content
	elseif name == "aoqi_hero_pvp_win_score" then
		self._aoqi_hero_pvp_win_score = content
	elseif name == "aoqi_hero_pet_skill" then
		self._aoqi_hero_pet_skill = content
	elseif name == "aoqi_hero_pet_property_strategy" then
		self._aoqi_hero_pet_property_strategy = content
	elseif name == "aoqi_hero_pet_race_type" then
		self._aoqi_hero_pet_race_type = content
	elseif name == "aoqi_hero_endless_stage" then
		self._aoqi_hero_endless_stage = content
	elseif name == "aoqi_hero_rank_prize" then
		self._aoqi_hero_rank_prize = content
	elseif name == "aoqi_hero_normal_stage" then
		self._aoqi_hero_normal_stage = content
	elseif name == "aoqi_hero_pet" then
		self:handlePetCfg(content)

		self._aoqi_hero_pet = content
	elseif name == "aoqi_hero_pet_skill_affix" then
		self._aoqi_hero_pet_skill_affix = content

		self:_handlerSkillAffix(content)
	elseif name == "aoqi_hero_position_upgrade" then
		self._aoqi_hero_position_upgrade = content
	elseif name == "aoqi_hero_image_rule" then
		self._aoqi_hero_image_rule = content
	end
end

function AoQiHeroConfig:getActivityCfg(activityId)
	return self._aoqi_hero_activity[activityId]
end

function AoQiHeroConfig:_handlerSkillAffix(content)
	local list = content.dataList

	self._skillAffixMap = {}

	for i, v in ipairs(list) do
		self._skillAffixMap[v.skillId] = self._skillAffixMap[v.skillId] or {}

		table.insert(self._skillAffixMap[v.skillId], v.id)
	end
end

function AoQiHeroConfig:getSkillAffixCfg(id)
	return self._aoqi_hero_pet_skill_affix[id]
end

function AoQiHeroConfig:getTeamCfg(activityId, creepsMasterId)
	if self._aoqi_hero_team[activityId] then
		return self._aoqi_hero_team[activityId][creepsMasterId]
	end
end

function AoQiHeroConfig:getCreepsCfg(activityId, creepsMasterId)
	if self._aoqi_hero_creeps[activityId] then
		return self._aoqi_hero_creeps[activityId][creepsMasterId]
	end
end

function AoQiHeroConfig:getSkillCfg(skillId)
	return self._aoqi_hero_pet_skill[skillId]
end

function AoQiHeroConfig:getAffixBySkillId(skillId)
	return self._skillAffixMap[skillId]
end

function AoQiHeroConfig:getNormalStageCfgs(activityId)
	return self._aoqi_hero_normal_stage[activityId]
end

function AoQiHeroConfig:getNormalStageCfg(activityId, stageId)
	if self._aoqi_hero_normal_stage[activityId] then
		return self._aoqi_hero_normal_stage[activityId][stageId]
	end
end

function AoQiHeroConfig:getEndlessStageCfg(activityId, stageId)
	if self._aoqi_hero_endless_stage[activityId] then
		return self._aoqi_hero_endless_stage[activityId][stageId]
	end
end

function AoQiHeroConfig:getPropertyCfgs(id)
	return self._aoqi_hero_pet_property_strategy[id]
end

function AoQiHeroConfig:getPropertyCfg(id, lv)
	if self._aoqi_hero_pet_property_strategy[id] then
		return self._aoqi_hero_pet_property_strategy[id][lv]
	end
end

function AoQiHeroConfig:getPetCfg(activityId, raceId)
	if self._aoqi_hero_pet[activityId] then
		return self._aoqi_hero_pet[activityId][raceId]
	end
end

function AoQiHeroConfig:handlePetCfg(content)
	local list = content.dataList

	self._usePetCfgList = {}

	for i, v in ipairs(list) do
		self._usePetCfgList[v.activityId] = self._usePetCfgList[v.activityId] or {}

		if v.isFormation == true then
			table.insert(self._usePetCfgList[v.activityId], v)
		end
	end
end

function AoQiHeroConfig:getUsePetCfgs(activityId)
	return self._usePetCfgList[activityId]
end

function AoQiHeroConfig:getEndlessPrizeCfg(activityId)
	return self._aoqi_hero_endless_stage_prize[activityId]
end

function AoQiHeroConfig:getSkillLvUpTips(id, isAttack)
	self._skillLvUpTips = self._skillLvUpTips or {}
	self._skillLvUpTips[id] = self._skillLvUpTips[id] or {}

	local tag = isAttack and "attack" or "defence"

	if not self._skillLvUpTips[id][tag] then
		self._skillLvUpTips[id][tag] = {}

		local propertyCfgs = self._aoqi_hero_pet_property_strategy[id]

		for i, v in ipairs(propertyCfgs) do
			if tag == "attack" and not string.nilorempty(v.skillLvUpTips) then
				table.insert(self._skillLvUpTips[id][tag], v)
			elseif tag == "defence" and not string.nilorempty(v.defenseSkillLvUpTips) then
				table.insert(self._skillLvUpTips[id][tag], v)
			end
		end
	end

	return self._skillLvUpTips[id][tag]
end

function AoQiHeroConfig:getPosUpgrade(activityId, lv)
	if self._aoqi_hero_position_upgrade[activityId] then
		return self._aoqi_hero_position_upgrade[activityId][lv]
	end
end

function AoQiHeroConfig:getRankPrizeCfgs(activityId, typeId)
	if self._aoqi_hero_rank_prize[activityId] then
		return self._aoqi_hero_rank_prize[activityId][typeId]
	end
end

function AoQiHeroConfig:getImageRuleCfg(typeId)
	return self._aoqi_hero_image_rule[typeId]
end

AoQiHeroConfig.instance = AoQiHeroConfig.New()

return AoQiHeroConfig
