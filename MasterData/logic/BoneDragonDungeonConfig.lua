-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragondungeon/config/BoneDragonDungeonConfig.lua

module("logic.extensions.bonedragondungeon.config.BoneDragonDungeonConfig", package.seeall)

local BoneDragonDungeonConfig = class("BoneDragonDungeonConfig", BaseConfig)

function BoneDragonDungeonConfig:onInit()
	BoneDragonDungeonConfig.super.onInit(self)
end

function BoneDragonDungeonConfig:getNames()
	return {
		"bone_dragon_dungeon_role",
		"bone_dragon_dungeon_master",
		"bone_dragon_dungeon_progress_prize",
		"bone_dragon_dungeon_buff",
		"bone_dragon_dungeon_stage",
		"bone_dragon_dungeon_creeps",
		"bone_dragon_dungeon_pet_shop",
		"bone_dragon_dungeon_activity",
		"bone_dragon_dungeon_event"
	}
end

function BoneDragonDungeonConfig:handleConfig(name, content)
	if name == "bone_dragon_dungeon_role" then
		self._bone_dragon_dungeon_role = content
	elseif name == "bone_dragon_dungeon_master" then
		self._bone_dragon_dungeon_master = content
	elseif name == "bone_dragon_dungeon_progress_prize" then
		self._bone_dragon_dungeon_progress_prize = content
	elseif name == "bone_dragon_dungeon_buff" then
		self._bone_dragon_dungeon_buff = content
	elseif name == "bone_dragon_dungeon_stage" then
		self._bone_dragon_dungeon_stage = content
	elseif name == "bone_dragon_dungeon_creeps" then
		self._bone_dragon_dungeon_creeps = content
	elseif name == "bone_dragon_dungeon_pet_shop" then
		self._bone_dragon_dungeon_pet_shop = content
	elseif name == "bone_dragon_dungeon_activity" then
		self._bone_dragon_dungeon_activity = content
	elseif name == "bone_dragon_dungeon_event" then
		self._bone_dragon_dungeon_event = content
	end
end

function BoneDragonDungeonConfig:getActivityCfg(activityId)
	return self._bone_dragon_dungeon_activity[activityId]
end

function BoneDragonDungeonConfig:getProgressCfgs(activityId)
	return self._bone_dragon_dungeon_progress_prize[activityId]
end

function BoneDragonDungeonConfig:getStageCfgs(activityId)
	return self._bone_dragon_dungeon_stage[activityId]
end

function BoneDragonDungeonConfig:getStageCfg(activityId, stageId)
	if self._bone_dragon_dungeon_stage[activityId] then
		return self._bone_dragon_dungeon_stage[activityId][stageId]
	end
end

function BoneDragonDungeonConfig:getEventCfgs(eventPlanId)
	return self._bone_dragon_dungeon_event[eventPlanId]
end

function BoneDragonDungeonConfig:getEventCfg(eventPlanId, eventId)
	if self._bone_dragon_dungeon_event[eventPlanId] then
		return self._bone_dragon_dungeon_event[eventPlanId][eventId]
	end
end

function BoneDragonDungeonConfig:getRoleCfg(activityId, roleId)
	if self._bone_dragon_dungeon_role[activityId] then
		return self._bone_dragon_dungeon_role[activityId][roleId]
	end
end

function BoneDragonDungeonConfig:getTeamCfg(creepsMasterId)
	return self._bone_dragon_dungeon_master[creepsMasterId]
end

function BoneDragonDungeonConfig:getCreepsCfg(creepsMasterId)
	return self._bone_dragon_dungeon_creeps[creepsMasterId]
end

function BoneDragonDungeonConfig:getPetShopCfgs(activityId)
	return self._bone_dragon_dungeon_pet_shop[activityId]
end

function BoneDragonDungeonConfig:getPetShopCfg(activityId, shopPosId)
	if self._bone_dragon_dungeon_pet_shop[activityId] then
		return self._bone_dragon_dungeon_pet_shop[activityId][shopPosId]
	end
end

function BoneDragonDungeonConfig:getBuffCfgs(activityId)
	return self._bone_dragon_dungeon_buff[activityId]
end

function BoneDragonDungeonConfig:getBuffCfg(activityId, num)
	if self._bone_dragon_dungeon_buff[activityId] then
		return self._bone_dragon_dungeon_buff[activityId][num]
	end
end

BoneDragonDungeonConfig.instance = BoneDragonDungeonConfig.New()

return BoneDragonDungeonConfig
