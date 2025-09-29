-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/record/AirWorkShopRecordMo.lua

module("logic.extensions.airworkshop.model.record.AirWorkShopRecordMo", package.seeall)

local M = class("AirWorkShopRecordMo")

function M:ctor(PlayRecordNO)
	if PlayRecordNO then
		self:updateFromServer(PlayRecordNO)
	end
end

function M:updateFromServer(info)
	self._mapId = info.mapId
	self._type = info.type
	self._point = info.point
	self._passRate = info.passRate
	self._playCount = info.playCount
	self._likeCount = info.likeCount
	self._commentCount = info.commentCount
	self._winCondition = info.condition
	self._isWin = info.isWin
	self._time = info.time
	self._score = info.score
	self._liked = info.liked
	self._cover = info.cover
	self._tags = {}

	for _, tag in ipairs(info.tagId or {}) do
		table.insert(self._tags, tag)
	end

	self._playerInfo = {
		userId = info.player.userId,
		createLv = info.player.createLv,
		portrait = info.player.portrait,
		nickname = info.player.nickname,
		playerLv = info.player.playerLv
	}
end

function M:getCreatorInfo()
	return self._playerInfo
end

function M:getMapId()
	return self._mapId
end

function M:getCover()
	return self._cover
end

function M:getType()
	return self._type
end

function M:getPoint()
	return self._point or 0
end

function M:getPassRate()
	return self._passRate or 0
end

function M:getPlayCount()
	return self._playCount
end

function M:getLikeCount()
	return self._likeCount
end

function M:getCommentCount()
	return self._commentCount
end

function M:getIsWin()
	return self._isWin
end

function M:getTimeStamp()
	return self._time
end

function M:getExtraWinCondition()
	return self._winCondition
end

function M:getScore()
	return self._score
end

function M:getLiked()
	return self._liked
end

function M:setLiked(liked)
	self._liked = liked
end

function M:getTagIds()
	return self._tags
end

return M
