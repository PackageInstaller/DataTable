-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/config/AceTeamConfig.lua

module("logic.extensions.aceteam.config.AceTeamConfig", package.seeall)

local AceTeamConfig = class("AceTeamConfig", BaseConfig)

function AceTeamConfig:getNames()
	return {
		"ace_team_season",
		"ace_team_group",
		"ace_team_system_pet",
		"ace_team_boss_monster",
		"ace_team_boss_creeps",
		"ace_team_rank_prize",
		"ace_team_common",
		"ace_team_level",
		"ace_team_equipment_level_up",
		"ace_team_stargod_level_up",
		"ace_team_skill_level_strategy",
		"ace_team_awaken_cost",
		"ace_team_buy_pvp_times",
		"ace_team_holy_stripe",
		"ace_team_holy_stripe_suit",
		"ace_team_source_trace"
	}
end

function AceTeamConfig:handleConfig(name, content)
	if name == "ace_team_season" then
		self.ace_team_seasonCfg = content
	elseif name == "ace_team_group" then
		self.ace_team_groupCfg = content

		self:initGroupList(content)
	elseif name == "ace_team_system_pet" then
		self.ace_team_system_petCfg = content
	elseif name == "ace_team_boss_monster" then
		self._ace_team_boss_monster = content
	elseif name == "ace_team_boss_creeps" then
		self._ace_team_boss_creeps = content
	elseif name == "ace_team_rank_prize" then
		self._ace_team_rank_prize = content
	elseif name == "ace_team_common" then
		self._ace_team_common = content
	elseif name == "ace_team_level" then
		self.ace_team_levelCfg = content
	elseif name == "ace_team_equipment_level_up" then
		self.ace_team_equipment_level_upCfg = content
	elseif name == "ace_team_stargod_level_up" then
		self.ace_team_stargod_level_upCfg = content
	elseif name == "ace_team_skill_level_strategy" then
		self.ace_team_skill_level_strategyCfg = content
	elseif name == "ace_team_awaken_cost" then
		self.ace_team_awaken_costCfg = content
	elseif name == "ace_team_buy_pvp_times" then
		self.ace_team_buy_pvp_timesCfg = content
	elseif name == "ace_team_holy_stripe" then
		self.ace_team_holy_stripeCfg = content
	elseif name == "ace_team_holy_stripe_suit" then
		self.ace_team_holy_stripe_suitCfg = content
	elseif name == "ace_team_source_trace" then
		self._ace_team_source_trace = content
	end
end

function AceTeamConfig:initGroupList(content)
	if content then
		self._ace_team_group_pool = {}

		for k, v in pairs(content) do
			if k ~= "dataList" then
				local list = {}

				for k2, v2 in pairs(v) do
					table.insert(list, v2)
				end

				ArraySort.sortOn(list, "groupId")

				self._ace_team_group_pool[k] = list
			end
		end
	end
end

function AceTeamConfig:getSeasonCfg(activityId)
	return self.ace_team_seasonCfg[activityId] or {}
end

function AceTeamConfig:getTeamListBySeasonId(seasonId)
	return self._ace_team_group_pool[seasonId] or {}
end

function AceTeamConfig:getTeamCfgById(seasonId, groupId)
	if self.ace_team_groupCfg[seasonId] then
		return self.ace_team_groupCfg[seasonId][groupId] or {}
	end

	return {}
end

function AceTeamConfig:getTeamLvlCfg()
	return self.ace_team_levelCfg.dataList
end

function AceTeamConfig:getTeamLvlDesc(medalNum)
	local list = self.ace_team_levelCfg.dataList

	for i, v in ipairs(list) do
		if medalNum >= v.medal and medalNum < ((list[i + 1] or nil) and list[i + 1].medal) then
			return v.name
		end
	end
end

function AceTeamConfig:getBuyTimeCfg(times)
	return self.ace_team_buy_pvp_timesCfg[times]
end

function AceTeamConfig:getAwakenCfgList()
	return self.ace_team_awaken_costCfg.dataList
end

function AceTeamConfig:getPetAwakenCostCfg(level)
	return self.ace_team_awaken_costCfg[level]
end

function AceTeamConfig:getStargodCfgList()
	return self.ace_team_stargod_level_upCfg.dataList
end

function AceTeamConfig:getSkillCfgList(strategyId, skillType)
	local serType = CharacterConfig.skillTypeMap[skillType]
	local obj = self.ace_team_skill_level_strategyCfg[strategyId]

	if obj then
		return obj[serType] or {}
	end

	return {}
end

function AceTeamConfig:getEquipPosCfgList(job, posId)
	local obj = self.ace_team_equipment_level_upCfg[job]

	if obj and obj[posId] then
		return obj[posId] or {}
	end

	return {}
end

function AceTeamConfig:getEquipCfg(job, posId, lvl)
	local obj = self.ace_team_equipment_level_upCfg[job]

	if obj and obj[posId] then
		return obj[posId][lvl]
	end

	return {}
end

function AceTeamConfig:getPetListByGroupId(groupId)
	return self.ace_team_system_petCfg[groupId] or {}
end

function AceTeamConfig:getPetCfgById(groupId, petId)
	return self:getPetListByGroupId(groupId)[petId] or {}
end

function AceTeamConfig:getMonsterCfg(creepsMasterId)
	return self._ace_team_boss_monster[creepsMasterId]
end

function AceTeamConfig:getCreepsCfg(creepsMasterId)
	return self._ace_team_boss_creeps[creepsMasterId]
end

function AceTeamConfig:getRankPrizeCfgs(seasonId)
	return self._ace_team_rank_prize[seasonId]
end

function AceTeamConfig:getCommonValue(key, isToNumber)
	if isToNumber then
		return checknumber(self._ace_team_common[key].value)
	else
		return self._ace_team_common[key].value
	end
end

function AceTeamConfig:getHolyStripeCfg(positionId, level)
	return self.ace_team_holy_stripeCfg[positionId][level]
end

function AceTeamConfig:getHolyStripeListCfg(positionId)
	return self.ace_team_holy_stripeCfg[positionId]
end

function AceTeamConfig:getHolyStripeSuitCfg(suitId)
	return self.ace_team_holy_stripe_suitCfg[suitId]
end

function AceTeamConfig:getHolyStripeAllSuitCfg()
	return self.ace_team_holy_stripe_suitCfg
end

function AceTeamConfig:getSourceTraceCfg(groupId, nodeId)
	if self._ace_team_source_trace[groupId] then
		return self._ace_team_source_trace[groupId][nodeId]
	end
end

function AceTeamConfig:getSourceTraceGroupCfg(groupId)
	return self._ace_team_source_trace[groupId]
end

AceTeamConfig.instance = AceTeamConfig.New()

return AceTeamConfig
