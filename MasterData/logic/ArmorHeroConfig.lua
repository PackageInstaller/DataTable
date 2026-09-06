-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorhero/config/ArmorHeroConfig.lua

module("logic.extensions.armorhero.config.ArmorHeroConfig", package.seeall)

local ArmorHeroConfig = class("ArmorHeroConfig", BaseConfig)

function ArmorHeroConfig:getNames()
	return {
		"armor_hero_creeps",
		"armor_hero_summon",
		"armor_hero_activity",
		"armor_hero_stage",
		"armor_hero_master",
		"armor_hero_progress",
		"armor_hero_task_desc"
	}
end

function ArmorHeroConfig:handleConfig(name, content)
	if name == "armor_hero_creeps" then
		self._armor_hero_creeps = content
	elseif name == "armor_hero_summon" then
		self._armor_hero_summon = content
	elseif name == "armor_hero_activity" then
		self._armor_hero_activity = content
	elseif name == "armor_hero_stage" then
		self._armor_hero_stage = content
	elseif name == "armor_hero_master" then
		self._armor_hero_master = content
	elseif name == "armor_hero_progress" then
		self._armor_hero_progress = content
	elseif name == "armor_hero_task_desc" then
		self._armor_hero_task_desc = content
	end
end

function ArmorHeroConfig:getActivityCfgByActId(activityId)
	return self._armor_hero_activity[activityId]
end

function ArmorHeroConfig:getSummonCfgsByActId(activityId)
	return self._armor_hero_summon[activityId]
end

function ArmorHeroConfig:getStageCfgByIdAndStageId(activityId, stageId)
	if self._armor_hero_stage[activityId] ~= nil then
		return self._armor_hero_stage[activityId][stageId]
	end
end

function ArmorHeroConfig:getProgressCfgsByPlanId(progressPlan)
	return self._armor_hero_progress[progressPlan]
end

function ArmorHeroConfig:getCreepCfgs(creepsMasterId)
	return self._armor_hero_creeps[creepsMasterId]
end

function ArmorHeroConfig:getTeamCfg(creepsMasterId)
	return self._armor_hero_master[creepsMasterId]
end

function ArmorHeroConfig:getTaskDescCfgsByPlanId(taskDescPlanId)
	return self._armor_hero_task_desc[taskDescPlanId]
end

ArmorHeroConfig.instance = ArmorHeroConfig.New()

return ArmorHeroConfig
