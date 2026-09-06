-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/config/ArenaConfig.lua

module("logic.extensions.arena.config.ArenaConfig", package.seeall)

local ArenaConfig = class("ArenaConfig", BaseConfig)

function ArenaConfig:onInit()
	ArenaConfig.super.onInit(self)

	self._cofigArenaTopGroupCfg = nil
	self._configArenaDailyTaskCfg = nil
	self._scoreCfg = nil
	self._kvCfg = nil
	self._buyChallengeCfg = nil
	self._arenaZoneCfg = nil
	self._seasonCfg = nil
end

function ArenaConfig:getNames()
	return {
		"arena_top_group",
		"arena_daily_task",
		"arena_score_range",
		"arena_common",
		"arena_buy_challenge",
		"arena_zone",
		"arena_season"
	}
end

function ArenaConfig:handleConfig(name, content)
	if name == "arena_top_group" then
		self._cofigArenaTopGroupCfg = content
	elseif name == "arena_daily_task" then
		self._configArenaDailyTaskCfg = content
	elseif name == "arena_score_range" then
		self._scoreCfg = content
	elseif name == "arena_common" then
		self._kvCfg = content
	elseif name == "arena_buy_challenge" then
		self._buyChallengeCfg = content
	elseif name == "arena_zone" then
		self._arenaZoneCfg = content
	elseif name == "arena_season" then
		self._seasonCfg = content
	end
end

function ArenaConfig:getArenaTopGroupCfgById(id)
	return self._cofigArenaTopGroupCfg[id]
end

function ArenaConfig:getArenaTopGroupCfgByArenaId(topGroupId)
	for i, v in ipairs(self._cofigArenaTopGroupCfg) do
		if v.topGroupId == topGroupId then
			return v
		end
	end
end

function ArenaConfig:getArenaTopGroupCfgs()
	return self._cofigArenaTopGroupCfg
end

function ArenaConfig:getArenaTopGroupCfgJYNum()
	for i, v in ipairs(self._cofigArenaTopGroupCfg) do
		if v.arenaId > 1 then
			return i - 1
		end
	end

	return 0
end

function ArenaConfig:getArenaDailyTaskCfgById(id)
	return self._configArenaDailyTaskCfg[id]
end

function ArenaConfig:getScoreCfg(id)
	return self._scoreCfg[id].beginZdl
end

function ArenaConfig:getValue(key)
	return self._kvCfg[key].value
end

function ArenaConfig:getBuyTimeCost(time)
	if checkint(time) > #self._buyChallengeCfg then
		time = #self._buyChallengeCfg
	end

	return (self._buyChallengeCfg and self._buyChallengeCfg[time] or nil) and (self._buyChallengeCfg[time].cost or "")
end

function ArenaConfig:getMaxDailyRefreshTime()
	return self:getValue("MAX_DAILY_REFRESH_TIME")
end

function ArenaConfig:getRefreshCd()
	return self:getValue("REFRESH_CD_SEC")
end

function ArenaConfig:getZoneName(zoneId)
	return (self._arenaZoneCfg[zoneId] or nil) and (self._arenaZoneCfg[zoneId].zoneName or "-未知-")
end

function ArenaConfig:getSeasonCfg(seasonId)
	return self._seasonCfg[seasonId]
end

ArenaConfig.instance = ArenaConfig.New()

return ArenaConfig
