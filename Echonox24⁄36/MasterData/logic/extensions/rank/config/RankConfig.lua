-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/config/RankConfig.lua

module("logic.extensions.rank.config.RankConfig", package.seeall)

local M = class("RankConfig", BaseConfig)

M.rankShowMinLimit = 10
M.refreshDot = 30
M.refreshInterval = 30
M.noDataShow = "-"

function M:getNames()
	return {
		ConfigName.Rank
	}
end

function M:getRankList()
	return self._dict[ConfigName.Rank] and self._dict[ConfigName.Rank].dataList
end

function M:getRankCfg(id)
	return self._dict[ConfigName.Rank] and self._dict[ConfigName.Rank][id]
end

function M:getRankType(id)
	local cfg = self:getRankCfg(id)

	return cfg and cfg.logicType
end

function M:isRankOnline(id)
	local cfg = self:getRankCfg(id)

	if not cfg then
		return false
	end

	return cfg.online > 0
end

function M:getRefreshInterval(id)
	local cfg = self:getRankCfg(id)

	return cfg and cfg.interval
end

function M:getRankName(id)
	local cfg = self:getRankCfg(id)

	return cfg and cfg.name
end

function M:getshowCount(id)
	local cfg = self:getRankCfg(id)
	local count = cfg and cfg.showCount or 0

	if count < M.rankShowMinLimit then
		printError(string.format("最低显示数量不能小于%s个，请核查配置，排行榜id:%s", M.rankShowMinLimit, id))
	end

	return count
end

function M:getTabName(rankType)
	local rankList = self:getRankList()

	for _, rankCfg in ipairs(rankList) do
		if rankCfg.logicType == rankType then
			return rankCfg.tabName
		end
	end
end

function M:isLastRank(id)
	local cfg = self:getRankCfg(id)

	if not cfg then
		return false
	end

	return cfg.lastRank > 0
end

function M:getRefreshRankInterval(rankId, intervalDot)
	local leftValue = intervalDot - M.refreshInterval

	leftValue = math.max(leftValue, 0) + 1

	local rightValue = intervalDot + M.refreshInterval

	rightValue = math.min(rightValue, self:getshowCount(rankId))

	return leftValue, rightValue
end

M.instance = M.New()

return M
