-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/model/RankBaseMO.lua

module("logic.extensions.rank.model.RankBaseMO", package.seeall)

local M = class("RankBaseMO")

function M:ctor()
	self._rankId = nil
	self._userId = nil
	self._rank = nil
	self._nickname = nil
	self._playerLv = nil
	self._portrait = nil
	self._cardBgId = nil
end

function M:_setBaseInfo(userId, rank, nickname, playerLv, portrait, displayCard)
	self._userId = userId
	self._rank = rank
	self._nickname = nickname
	self._playerLv = playerLv
	self._portrait = portrait
	self._cardBgId = displayCard and displayCard[1]
end

function M:updateData(rankId, data)
	if not rankId or not data then
		return
	end

	self:_setRankId(rankId)
	self:_setBaseInfo(data.userId, data.rank, data.nickname, data.playerLv, data.portrait, data.displayCard)
end

function M:_setRankId(rankId)
	self._rankId = rankId
end

function M:getRankId()
	return self._rankId
end

function M:getUserId()
	return self._userId
end

function M:getRank()
	return self._rank
end

function M:getNickname()
	return self._nickname
end

function M:getPlayerLv()
	return self._playerLv
end

function M:getPortrait()
	return self._portrait
end

function M:getdisplayCardBgIcon()
	local cfg = BackpackConfig.instance:getItemInfoByItemId(self._cardBgId)

	return cfg and cfg.icon3
end

function M:clear()
	self._rankId = nil
	self._userId = nil
	self._rank = nil
	self._nickname = nil
	self._playerLv = nil
	self._portrait = nil
end

return M
