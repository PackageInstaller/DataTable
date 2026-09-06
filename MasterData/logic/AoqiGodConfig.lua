-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/config/AoqiGodConfig.lua

module("logic.extensions.aoqigod.config.AoqiGodConfig", package.seeall)

local AoqiGodConfig = class("AoqiGodConfig", BaseConfig)

function AoqiGodConfig:onInit()
	AoqiGodConfig.super.onInit(self)
end

function AoqiGodConfig:getNames()
	return {
		"aoqi_god_activity",
		"aoqi_god_challenge",
		"aoqi_god_rank_prize",
		"aoqi_god_race_buff"
	}
end

function AoqiGodConfig:handleConfig(name, content)
	if name == "aoqi_god_activity" then
		self._aoqi_god_activity = content
	elseif name == "aoqi_god_challenge" then
		self._aoqi_god_challenge = content

		self:_sortChallengeById()
	elseif name == "aoqi_god_rank_prize" then
		self._aoqi_god_rank_prize = content
	elseif name == "aoqi_god_race_buff" then
		self._aoqi_god_race_buff = content
	end
end

function AoqiGodConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function AoqiGodConfig:_sortChallengeById()
	self._challengeMap = {}

	for i, cfg in ipairs(self._aoqi_god_challenge.dataList) do
		local skinId = cfg.skinId
		local activityId = cfg.activityId

		self._challengeMap[activityId] = self._challengeMap[activityId] or {}
		self._challengeMap[activityId][skinId] = cfg
	end
end

function AoqiGodConfig:getActDataList()
	return self._aoqi_god_activity.dataList
end

function AoqiGodConfig:getActData(activityId)
	return self:_safeGet(self._aoqi_god_activity, activityId)
end

function AoqiGodConfig:getClgCfg(activityId)
	return self:_safeGet(self._aoqi_god_challenge, activityId)
end

function AoqiGodConfig:getClgData(activityId, challengeId)
	return self:_safeGet(self._aoqi_god_challenge, activityId, challengeId)
end

function AoqiGodConfig:getClgDataBySkinId(activityId, skinId)
	return self:_safeGet(self._challengeMap, activityId, skinId)
end

function AoqiGodConfig:getRankPrizeCfg(activityId)
	return self:_safeGet(self._aoqi_god_rank_prize, activityId)
end

function AoqiGodConfig:getRankPrizeData(activityId, rank)
	local cfg = self:getRankPrizeCfg(activityId)

	return MmUtil.binarySearchInArrayKey(cfg, "rankRange", rank)
end

function AoqiGodConfig:getRaceBuffCfg(activityId)
	return self:_safeGet(self._aoqi_god_race_buff, activityId)
end

function AoqiGodConfig:getRaceBuffData(activityId, raceNum)
	return self:_safeGet(self._aoqi_god_race_buff, activityId, raceNum)
end

function AoqiGodConfig:getRaceBuffDataList(activityId)
	local cfg = self:getRaceBuffCfg(activityId)
	local dataList = {}

	for _, data in pairs(cfg or {}) do
		table.insert(dataList, data)
	end

	table.sort(dataList, function(a, b)
		return checknumber(a.raceNum) < checknumber(b.raceNum)
	end)

	return dataList
end

AoqiGodConfig.instance = AoqiGodConfig.New()

return AoqiGodConfig
