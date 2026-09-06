-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/config/AnheimmConfig.lua

module("logic.extensions.timelimitedchallenge.config.AnheimmConfig", package.seeall)

local AnheimmConfig = class("AnheimmConfig", BaseConfig)

function AnheimmConfig:onInit()
	AnheimmConfig.super.onInit(self)

	self._modeCfgs = nil
	self._ruleCfgs = nil
	self._ruleCfgsMode = nil
	self._challengeCfgs = nil
	self._creepCfgs = nil
	self._buyTimeCostCfgs = nil
	self._baseParamCfgs = nil
end

function AnheimmConfig:getNames()
	return {
		"an_hei_mm_challenge_mode",
		"an_hei_mm_challenge_rule_plan",
		"an_hei_mm_challenge_monster_plan",
		"an_hei_mm_challenge_creeps",
		"an_hei_mm_challenge_buy_times",
		"an_hei_mm_challenge_common",
		"an_hei_mm_challenge_perfect_win_op"
	}
end

function AnheimmConfig:handleConfig(name, content)
	if name == "an_hei_mm_challenge_mode" then
		self._modeCfgs = content
	elseif name == "an_hei_mm_challenge_rule_plan" then
		self._ruleCfgs = content
		self._ruleCfgsMode = {}

		for _, v in ipairs(content.dataList) do
			self._ruleCfgsMode[v.modeId] = self._ruleCfgsMode[v.modeId] or {}

			table.insert(self._ruleCfgsMode[v.modeId], v)
		end
	elseif name == "an_hei_mm_challenge_monster_plan" then
		self._challengeCfgs = content
	elseif name == "an_hei_mm_challenge_creeps" then
		self._creepCfgs = content
	elseif name == "an_hei_mm_challenge_buy_times" then
		self._buyTimeCostCfgs = content
	elseif name == "an_hei_mm_challenge_common" then
		self._baseParamCfgs = content
	elseif name == "an_hei_mm_challenge_perfect_win_op" then
		self._perfectWinOps = content
	end
end

function AnheimmConfig:getPerfectWinOpCfg(id)
	return self._perfectWinOps[id]
end

function AnheimmConfig:getCreepCfgsById(creepsMasterId)
	if self._creepCfgs then
		return self._creepCfgs[creepsMasterId]
	end
end

function AnheimmConfig:getModeCfgs()
	return self._modeCfgs
end

function AnheimmConfig:getModeCfgById(Id)
	if Id and self._modeCfgs and self._modeCfgs[Id] then
		return self._modeCfgs[Id]
	else
		printError("Anheimm Mode get NIL Config")
	end
end

function AnheimmConfig:getRuleCfgsByModeId(modeId)
	if modeId and self._ruleCfgsMode and self._ruleCfgsMode[modeId] then
		return self._ruleCfgsMode[modeId]
	else
		printError("Anheimm Rule Mode get NIL Config")
	end
end

function AnheimmConfig:getRuleCfgById(Id)
	if Id and self._ruleCfgs and self._ruleCfgs[Id] then
		return self._ruleCfgs[Id]
	else
		printError("Anheimm Rule get NIL Config")
	end
end

function AnheimmConfig:getChallengeCfgById(Id)
	if Id and self._challengeCfgs and self._challengeCfgs[Id] then
		return self._challengeCfgs[Id]
	else
		printError("Anheimm Challenge get NIL Config")
	end
end

function AnheimmConfig:getCreepCfgById(challengeId, creepId)
	if not creepsId then
		return self._creepsCfgs[challengeId]
	end

	return self._creepsCfgs[challengeId][creepId]
end

function AnheimmConfig:getCostByAddTimes(times)
	local time = checkint(times)

	return self._buyTimeCostCfgs[time].cost
end

function AnheimmConfig:getMaxAddTimes()
	return #self._buyTimeCostCfgs
end

function AnheimmConfig:getParamValueByKey(key)
	return self._baseParamCfgs[key].value
end

function AnheimmConfig:getChallengeId()
	return checkint(self:getParamValueByKey("CHALLENGE_ID"))
end

function AnheimmConfig:getChallengeDailyTimes()
	return checkint(self:getParamValueByKey("DAILY_FREE_TIMES"))
end

function AnheimmConfig:getEvolvePetRaceId()
	return checkint(self:getParamValueByKey("EVOLVE_PET_RACE_ID"))
end

AnheimmConfig.instance = AnheimmConfig.New()

return AnheimmConfig
