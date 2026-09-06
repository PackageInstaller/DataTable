-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/config/BuryGameConfig.lua

module("logic.extensions.burygame.config.BuryGameConfig", package.seeall)

local BuryGameConfig = class("BuryGameConfig", BaseConfig)

function BuryGameConfig:getNames()
	return {
		"bury_pit_game",
		"bury_pit_game_buy_times",
		"bury_pit_game_score_prize",
		"bury_pit_game_common",
		"bury_pit_game_special_prize",
		"bury_pit_egg_plan",
		"bury_pit_game_plan",
		"bury_pit_game_special_prize",
		"bury_pit_bubble"
	}
end

function BuryGameConfig:handleConfig(name, content)
	self._cfgDict = self._cfgDict or {}
	self._cfgDict[name] = content
end

function BuryGameConfig:getBubbleCfgs()
	local cfg = self._cfgDict.bury_pit_bubble

	return cfg.dataList
end

function BuryGameConfig:getConstantValue(key)
	if not self._cfgDict.bury_pit_game_common then
		if self._cfgDict.bury_pit_game_common[key] then
			return self._cfgDict.bury_pit_game_common[key].value
		end
	end
end

function BuryGameConfig:getPrizeCfgs(planId)
	if not self._cfgDict.bury_pit_game_score_prize then
		return self._cfgDict.bury_pit_game_score_prize[planId]
	end
end

function BuryGameConfig:getCfgById(activityId)
	if not self._cfgDict.bury_pit_game then
		return self._cfgDict.bury_pit_game[activityId]
	end
end

function BuryGameConfig:getBuyPlanCfg(planId, buyTimes)
	if not self._cfgDict.bury_pit_game_buy_times then
		return self._cfgDict.bury_pit_game_buy_times[planId]
	end
end

function BuryGameConfig:getGamePlan(id)
	if not self._cfgDict.bury_pit_game_plan then
		local cfg = {}
		local dict = cfg[id]
		local list = self:dictToList(dict)

		table.sort(list, function(a, b)
			return a.time < b.time
		end)

		return list
	end
end

function BuryGameConfig:dictToList(dict)
	local list = {}

	for k, v in pairs(dict) do
		if checknumber(k) > 0 then
			table.insert(list, v)
		end
	end

	return list
end

function BuryGameConfig:getGamePlanCfg(id, time)
	local dataList = self:getGamePlan(id)
	local id

	for k, v in ipairs(dataList) do
		if time < v.time then
			id = k

			break
		end
	end

	if id == nil then
		return dataList[#dataList]
	else
		return dataList[id]
	end
end

function BuryGameConfig:getEggPlanCfgs(planId)
	if not self._cfgDict.bury_pit_egg_plan then
		local cfg = {}
		local dict = cfg[planId]
		local list = self:dictToList(dict)

		table.sort(list, function(a, b)
			return a.score < b.score
		end)

		return list
	end
end

function BuryGameConfig:getSpecialPrizeCfg(planId, prizeId)
	local cfg = self._cfgDict.bury_pit_game_special_prize

	if not cfg[planId] then
		return cfg[planId][prizeId]
	end
end

BuryGameConfig.instance = BuryGameConfig.New()

return BuryGameConfig
