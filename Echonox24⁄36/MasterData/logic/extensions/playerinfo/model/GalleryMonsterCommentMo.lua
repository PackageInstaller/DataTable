-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/GalleryMonsterCommentMo.lua

module("logic.extensions.playerinfo.model.GalleryMonsterCommentMo", package.seeall)

local M = class("GalleryMonsterCommentMo")

function M:ctor(monsterId)
	self._monsterId = monsterId
end

function M:updateFromServer(msg)
	self._lastUpdateTime = ServerTime.now()
	self._star = msg.star or 0
	self._commentPlayerCount = msg.count or 0
	self._myStar = msg.myStar or 0
	self._myTags = {}

	if msg.myTag and #msg.myTag > 0 then
		for _, tagId in ipairs(msg.myTag) do
			table.insert(self._myTags, tagId)
		end
	end

	self._hotTags = {}

	if msg.tag and #msg.tag > 0 then
		for _, commentTagNO in ipairs(msg.tag) do
			table.insert(self._hotTags, commentTagNO)
		end
	end
end

function M:getMonsterId()
	return self._monsterId
end

function M:getLastUpdateTime()
	return self._lastUpdateTime or 0
end

function M:getStar()
	return self._star
end

function M:getCommentPlayerCount()
	return self._commentPlayerCount
end

function M:getMyStar()
	return self._myStar
end

function M:setMyStar(myStar)
	self._myStar = myStar
end

function M:getMyTags()
	return self._myTags or {}
end

function M:setMyTags(tableLst)
	self._myTags = tableLst
end

function M:getHotTags()
	return self._hotTags
end

return M
