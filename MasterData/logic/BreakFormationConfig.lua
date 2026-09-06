-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/config/BreakFormationConfig.lua

module("logic.extensions.breakformation.config.BreakFormationConfig", package.seeall)

local BreakFormationConfig = class("BreakFormationConfig", BaseConfig)

function BreakFormationConfig:onInit()
	BreakFormationConfig.super.onInit(self)

	self._creepsCfg = nil
	self._monsterCfg = nil
	self._teamCfg = nil
	self._difficultyCfg = nil
	self._rankPrizeCfg = nil
	self.pozhenRankCfg = nil
	self.pozhenProgressCfg = nil
end

function BreakFormationConfig:getNames()
	return {
		"breach_formation_team",
		"breach_formation_monster",
		"breach_formation_creeps",
		"breach_formation_score",
		"breach_formation_difficulty",
		"breach_formation_rank_prize",
		"breach_formation_progress_prize",
		"breach_formation_buff",
		"breach_formation_buy_times_cost",
		"breach_formation_param",
		"breach_formation_hell_monster",
		"breach_formation_hell_creeps"
	}
end

function BreakFormationConfig:handleConfig(name, content)
	if name == "breach_formation_team" then
		self._teamCfg = content
	elseif name == "breach_formation_monster" then
		self._monsterCfg = content
	elseif name == "breach_formation_creeps" then
		self._creepsCfg = content
	elseif name == "breach_formation_hell_monster" then
		self._monsterHellCfg = content
	elseif name == "breach_formation_hell_creeps" then
		self._creepsHellCfg = content
	elseif name == "breach_formation_difficulty" then
		self._difficultyCfg = content
	elseif name == "breach_formation_score" then
		self.formation_score = content
	elseif name == "breach_formation_buff" then
		self.formation_buff = content
	elseif name == "breach_formation_param" then
		self.breach_formation_param = content
	elseif name == "breach_formation_buy_times_cost" then
		self.breach_formation_buy_times_cost = content
	elseif name == "breach_formation_rank_prize" then
		self._rankPrizeCfg = {}
		self.pozhenRankCfg = {}

		for _, item in ipairs(content.dataList) do
			if item and item.prize ~= "" then
				if self.pozhenRankCfg[item.teamId] == nil then
					self.pozhenRankCfg[item.teamId] = {}
				end

				table.insert(self.pozhenRankCfg[item.teamId], item)
			end
		end

		for _, list in ipairs(self.pozhenRankCfg) do
			if list and #list >= 2 then
				table.sort(list, function(a, b)
					return a.begin < b.begin
				end)
			end
		end
	elseif name == "breach_formation_progress_prize" then
		self.pozhenProgressCfg = {}

		for _, item in ipairs(content.dataList) do
			if self.pozhenProgressCfg[item.teamId] == nil then
				self.pozhenProgressCfg[item.teamId] = {}
			end

			table.insert(self.pozhenProgressCfg[item.teamId], item)

			item.__index = #self.pozhenProgressCfg[item.teamId]
			item.__state = 0
		end
	end
end

function BreakFormationConfig:getMonsterCfg(id, monsterId)
	return self._monsterCfg[id][monsterId]
end

function BreakFormationConfig:getHellMonsterCfg(id, monsterId)
	return self._monsterHellCfg[id][monsterId]
end

function BreakFormationConfig:getBuffCfg(id)
	return self.formation_buff[id]
end

function BreakFormationConfig:getBreakParmCfg(id)
	return self.breach_formation_param[id]
end

function BreakFormationConfig:getHellScoreLimit()
	local cfg = self:getBreakParmCfg("hellNeedScore")

	if cfg then
		return checknumber(cfg.paramVal)
	end

	return 0
end

function BreakFormationConfig:getScoreCfg(key)
	return self.formation_score[key]
end

function BreakFormationConfig:getScoreName(key, score)
	local cfg = self.formation_score[key]

	if cfg then
		for k, v in pairs(cfg) do
			if v.point == score then
				return v.evaluate
			end
		end
	end

	return ""
end

function BreakFormationConfig:getMonsterCfgs(id)
	if not self._monsterCfg[id] then
		local cfgs = {}

		for _, v in pairs(self._monsterCfg[id]) do
			table.insert(cfgs, v)
		end

		table.sort(cfgs, function(a, b)
			return a.creepsMasterId < b.creepsMasterId
		end)

		return cfgs
	end
end

function BreakFormationConfig:getCreepCfg(teamId, monsterId)
	return self._creepsCfg[teamId][monsterId]
end

function BreakFormationConfig:getHellMonsterCfgs(id)
	if not self._monsterHellCfg[id] then
		local cfgs = {}

		for _, v in pairs(self._monsterHellCfg[id]) do
			table.insert(cfgs, v)
		end

		table.sort(cfgs, function(a, b)
			return a.creepsMasterId < b.creepsMasterId
		end)

		return cfgs
	end
end

function BreakFormationConfig:getHellCreepCfg(teamId, monsterId)
	return self._creepsHellCfg[teamId][monsterId]
end

function BreakFormationConfig:getTeamCfg(periodId)
	return self._teamCfg[periodId]
end

function BreakFormationConfig:getDifficultyCfg(difficulty)
	return self._difficultyCfg[difficulty]
end

function BreakFormationConfig:getRankPrizeCfg(difficulty)
	return self._rankPrizeCfg[difficulty] or {}
end

function BreakFormationConfig:getBuyCfgByTimes(num)
	return self.breach_formation_buy_times_cost[num]
end

function BreakFormationConfig:getBuyCfgLength()
	if self.breach_formation_buy_times_cost and self.breach_formation_buy_times_cost.dataList then
		return #self.breach_formation_buy_times_cost.dataList
	end

	return 0
end

function BreakFormationConfig:GetPozhenMonsterCfg(teamId, monsterId)
	teamId = teamId or BreakFormationModel.instance:getFightId()

	if self._monsterCfg == nil then
		return nil
	end

	if monsterId == nil or monsterId == 0 then
		return self._monsterCfg[teamId]
	end

	return self._monsterCfg[teamId][monsterId]
end

function BreakFormationConfig:GetPozhenTeamCfg(teamId)
	teamId = teamId or BreakFormationModel.instance:getFightId()

	if self._teamCfg == nil or self._teamCfg[teamId] == nil then
		return nil
	end

	return self._teamCfg[teamId]
end

function BreakFormationConfig:GetPozhenRankByWeek(teamId)
	teamId = teamId or BreakFormationModel.instance:getFightId()

	if self.pozhenRankCfg == nil or self.pozhenRankCfg[teamId] == nil then
		return nil
	end

	return self.pozhenRankCfg[teamId]
end

function BreakFormationConfig:GetPozhenRankByWeekRank(teamId, rankId)
	local tempList = self:GetPozhenRankByWeek(teamId)

	if tempList == nil or #tempList == 0 then
		return nil
	end

	local count = #tempList

	for i = 1, count do
		if tempList[i] and rankId >= tempList[i].both and rankId <= tempList[i].tail then
			return tempList[i]
		end
	end

	return tempList[count]
end

function BreakFormationConfig:GetPozhenProgByWeek(teamId)
	teamId = teamId or BreakFormationModel.instance:getFightId()

	if self.pozhenProgressCfg == nil or self.pozhenProgressCfg[teamId] == nil then
		return nil
	end

	return self.pozhenProgressCfg[teamId]
end

BreakFormationConfig.instance = BreakFormationConfig.New()

return BreakFormationConfig
