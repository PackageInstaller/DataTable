-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/config/AutochessConfig.lua

module("logic.extensions.autochess.config.AutochessConfig", package.seeall)

local AutochessConfig = class("AutochessConfig", BaseConfig)

function AutochessConfig:onInit()
	return
end

function AutochessConfig:getNames()
	return {
		"auto_chess_activity",
		"auto_chess_round",
		"auto_chess_rate",
		"auto_chess_star_level",
		"auto_chess_card",
		"auto_chess_creeps",
		"auto_chess_fetters",
		"auto_chess_fetters_buff",
		"auto_chess_init_buff",
		"auto_chess_equip_buff",
		"auto_chess_rank_score",
		"auto_chess_rank_prize",
		"auto_chess_client_common"
	}
end

function AutochessConfig:handleConfig(name, content)
	if name == "auto_chess_activity" then
		self._auto_chess_activity = content
	elseif name == "auto_chess_round" then
		self._auto_chess_round = content
	elseif name == "auto_chess_rate" then
		self._auto_chess_rate = content
	elseif name == "auto_chess_star_level" then
		self._auto_chess_star_level = content
	elseif name == "auto_chess_card" then
		self._auto_chess_card = content
	elseif name == "auto_chess_creeps" then
		self._auto_chess_creeps = content

		self:_handleCreeps(content)
		self:_handleRaceIdMaxStar(content)
	elseif name == "auto_chess_fetters" then
		self._auto_chess_fetters = content
	elseif name == "auto_chess_fetters_buff" then
		self._auto_chess_fetters_buff = content
	elseif name == "auto_chess_init_buff" then
		self._auto_chess_init_buff = content
	elseif name == "auto_chess_equip_buff" then
		self._auto_chess_equip_buff = content
	elseif name == "auto_chess_rank_score" then
		self._auto_chess_rank_score = content
	elseif name == "auto_chess_rank_prize" then
		self._auto_chess_rank_prize = content
	elseif name == "auto_chess_client_common" then
		self._auto_chess_client_common = content
	end
end

function AutochessConfig:getActCfg(activityId)
	return self._auto_chess_activity[activityId]
end

function AutochessConfig:getMatchingWaitSec(activityId)
	return self._auto_chess_activity[activityId].matchingWaitSec
end

function AutochessConfig:getSelectEquipTimeSec(activityId)
	return self._auto_chess_activity[activityId].selectEquipTimeSec
end

function AutochessConfig:getSettleTimeSec(activityId)
	return self._auto_chess_activity[activityId].settleTimeSec
end

function AutochessConfig:getInitBuffTimeSec(activityId)
	return self._auto_chess_activity[activityId].initBuffTimeSec
end

function AutochessConfig:getBattleTimeSec(activityId)
	return self._auto_chess_activity[activityId].battleTimeSec
end

function AutochessConfig:getRefreshShopMoney(activityId)
	return self._auto_chess_activity[activityId].refreshShopMoney
end

function AutochessConfig:getPlayerNum(activityId)
	return self._auto_chess_activity[activityId].playerNum
end

function AutochessConfig:getInitBuffCfg(buffId)
	return self._auto_chess_init_buff[buffId]
end

function AutochessConfig:getEquipBuffCfg(buffId)
	return self._auto_chess_equip_buff[buffId]
end

function AutochessConfig:getCreepsCfg(creepsId)
	return self._auto_chess_creeps[creepsId]
end

function AutochessConfig:getBuyCost(raceId)
	local cfg = self:getRateCfg(self._auto_chess_card[raceId].rate)

	return cfg.money
end

function AutochessConfig:getRateCfg(rate)
	return self._auto_chess_rate[rate]
end

function AutochessConfig:_handleCreeps(content)
	self._star2Creeps = {}

	for i, v in ipairs(content.dataList) do
		self._star2Creeps[v.starLevel] = self._star2Creeps[v.starLevel] or {}
		self._star2Creeps[v.starLevel][v.raceId] = v
	end
end

function AutochessConfig:getCreepsCfgByStarLevel(raceId, starLevel)
	return self._star2Creeps[starLevel][raceId]
end

function AutochessConfig:getCreepsIdByStarLevel(raceId, starLevel)
	return self._star2Creeps[starLevel][raceId].creepsId
end

function AutochessConfig:getInitStarLevel(raceId)
	local cfg = self:getRateCfg(self._auto_chess_card[raceId].rate)

	return cfg.initStarLevel
end

function AutochessConfig:getRoundCfg(roundId)
	return self._auto_chess_round[roundId]
end

function AutochessConfig:getRoundFormationNum(roundId)
	return self._auto_chess_round[roundId].formationNum
end

function AutochessConfig:getSellMoney(starLevel)
	return self._auto_chess_star_level[starLevel].sellMoney
end

function AutochessConfig:getBattleTimeSec(activityId)
	return self._auto_chess_activity[activityId].battleTimeSec
end

function AutochessConfig:getPackageLimit(activityId)
	return self._auto_chess_activity[activityId].packageLimit
end

function AutochessConfig:getPetFettersId(raceId)
	return self._auto_chess_card[raceId].fettersId
end

function AutochessConfig:getFettersBuffCfg(fettersId, num)
	local cfgs = self._auto_chess_fetters_buff[fettersId]
	local newCfgs = table.values(cfgs)

	table.sort(newCfgs, function(a, b)
		return a.num < b.num
	end)

	local cfg

	for i, v in ipairs(newCfgs) do
		if num >= v.num then
			cfg = v
		end
	end

	return cfg
end

function AutochessConfig:getFettersBuffCfgs(fettersId)
	return self._auto_chess_fetters_buff[fettersId]
end

function AutochessConfig:getCardCfg(raceId)
	return self._auto_chess_card[raceId]
end

function AutochessConfig:getFettersCfg(fettersId)
	return self._auto_chess_fetters[fettersId]
end

function AutochessConfig:getCommonValue(key, neednumber)
	local value = self._auto_chess_client_common[key].value

	if neednumber then
		return checknumber(value)
	end

	return value
end

function AutochessConfig:_handleRaceIdMaxStar(content)
	self._raceId2maxStar = {}

	for i, v in ipairs(content.dataList) do
		self._raceId2maxStar[v.raceId] = self._raceId2maxStar[v.raceId] or 0

		if v.starLevel > self._raceId2maxStar[v.raceId] then
			self._raceId2maxStar[v.raceId] = v.starLevel
		end
	end
end

function AutochessConfig:getRaceIdMaxStar(raceId)
	return self._raceId2maxStar[raceId] or 0
end

function AutochessConfig:getRankPrizeCfg(rank)
	for i, v in ipairs(self._auto_chess_rank_prize.dataList) do
		if rank >= v.startRank and rank <= v.endRank then
			return v
		end
	end
end

AutochessConfig.instance = AutochessConfig.New()

return AutochessConfig
