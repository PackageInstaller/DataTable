-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/config/BountyPKCompeteConfig.lua

module("logic.extensions.bountypkcompete.config.BountyPKCompeteConfig", package.seeall)

local BountyPKCompeteConfig = class("BountyPKCompeteConfig", BaseConfig)

function BountyPKCompeteConfig:onInit()
	BountyPKCompeteConfig.super.onInit(self)

	self._bounty_pk_season = nil
	self._bounty_pk_common = nil
	self._bounty_pk_gate = nil
	self._bounty_pk_round = nil
	self._bounty_pk_level = nil
	self._bounty_pk_task = nil
	self._bounty_pk_sys_pet = nil
	self._bounty_pk_level_prize = nil
	self._bounty_pk_rank_prize = nil
	self._bounty_pk_battle_buff = nil
end

function BountyPKCompeteConfig:getNames()
	return {
		"bounty_pk_season",
		"bounty_pk_common",
		"bounty_pk_gate",
		"bounty_pk_round",
		"bounty_pk_level",
		"bounty_pk_task",
		"bounty_pk_sys_pet",
		"bounty_pk_level_prize",
		"bounty_pk_rank_prize",
		"bounty_pk_battle_buff"
	}
end

function BountyPKCompeteConfig:handleConfig(name, content)
	if name == "bounty_pk_season" then
		self._bounty_pk_season = content
	elseif name == "bounty_pk_common" then
		self._bounty_pk_common = content
	elseif name == "bounty_pk_gate" then
		self._bounty_pk_gate = content
	elseif name == "bounty_pk_round" then
		self._bounty_pk_round = content
	elseif name == "bounty_pk_level" then
		self._bounty_pk_level = content
	elseif name == "bounty_pk_task" then
		self._bounty_pk_task = content
	elseif name == "bounty_pk_sys_pet" then
		self._bounty_pk_sys_pet = content
	elseif name == "bounty_pk_level_prize" then
		self._bounty_pk_level_prize = content
	elseif name == "bounty_pk_rank_prize" then
		self._bounty_pk_rank_prize = content
	elseif name == "bounty_pk_battle_buff" then
		self._bounty_pk_battle_buff = content
	end
end

function BountyPKCompeteConfig:getTaskConfigsByPlan(planId)
	return self._bounty_pk_task[planId]
end

function BountyPKCompeteConfig:getCommonValue(key, isToNumber)
	local str = ""

	if self._bounty_pk_common and self._bounty_pk_common[key] then
		str = not string.nilorempty(self._bounty_pk_common[key].value2) and self._bounty_pk_common[key].value2 or self._bounty_pk_common[key].value
	end

	if isToNumber then
		str = tonumber(str)
	end

	return str
end

function BountyPKCompeteConfig:getSeasonConfig(activityId)
	return self._bounty_pk_season[activityId]
end

function BountyPKCompeteConfig:getGateConfigs()
	return self._bounty_pk_gate
end

function BountyPKCompeteConfig:getRoundConfigs()
	return self._bounty_pk_round
end

function BountyPKCompeteConfig:getSystemPetConfig(creepsId)
	return self._bounty_pk_sys_pet[creepsId]
end

function BountyPKCompeteConfig:getSystemPetConfigs()
	return self._bounty_pk_sys_pet
end

function BountyPKCompeteConfig:getBuffConfigs(buffPlanId)
	return self._bounty_pk_battle_buff[buffPlanId]
end

BountyPKCompeteConfig.instance = BountyPKCompeteConfig.New()

return BountyPKCompeteConfig
