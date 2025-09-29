-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/model/FriendModel.lua

module("logic.extensions.friend.model.FriendModel", package.seeall)

local M = class("FriendModel", BaseModel)

local function _sortFriendFunc(friendMo1, friendMo2)
	if friendMo1:getApplyTime() ~= friendMo2:getApplyTime() then
		return friendMo1:getApplyTime() < friendMo2:getApplyTime()
	elseif friendMo1:getOnLineStatus() ~= friendMo2:getOnLineStatus() then
		return friendMo1:getOnLineStatus() < friendMo2:getOnLineStatus()
	elseif friendMo1:getLv() ~= friendMo2:getLv() then
		return friendMo1:getLv() > friendMo2:getLv()
	elseif friendMo1:getLastLoginTime() ~= friendMo2:getLastLoginTime() then
		return friendMo1:getLastLoginTime() > friendMo2:getLastLoginTime()
	else
		return friendMo1:getUserId() > friendMo2:getUserId()
	end
end

function M:ctor()
	self._moLists = {}
	self._searchResult = {}
end

function M:onInit()
	return
end

function M:onReset()
	table.clear(self._moLists)
	table.clear(self._searchResult)
end

function M:getMoList(relationType)
	local ret = self._moLists[relationType]

	if not ret then
		ret = {}
		self._moLists[relationType] = ret
	end

	return ret
end

function M:getSearchResult()
	return self._searchResult
end

function M:getSearchResultById(userId)
	for i = 1, #self._searchResult do
		if self._searchResult[i]:getUserId() == userId then
			return self._searchResult[i]
		end
	end

	return nil
end

function M:addSearchResult(userList)
	self:clearSearchResult()

	for _, PlayerMetaNO in ipairs(userList) do
		local mo = FriendMO.New(PlayerMetaNO)

		table.insert(self._searchResult, mo)

		if PlayerMetaNO:HasField("applied") and PlayerMetaNO.applied then
			mo:setRelationShip(GameEnum.RelationTypeEnum.Apply)
		elseif self:getUser(GameEnum.RelationTypeEnum.Block, PlayerMetaNO.userId) then
			mo:setRelationShip(GameEnum.RelationTypeEnum.Block)
		elseif self:getUser(GameEnum.RelationTypeEnum.Friend, PlayerMetaNO.userId) then
			mo:setRelationShip(GameEnum.RelationTypeEnum.Friend)
		else
			mo:setRelationShip(0)
		end
	end
end

function M:clearSearchResult()
	table.clear(self._searchResult)
end

function M:updateSearchResult(userId)
	for i = 1, #self._searchResult do
		local mo = self._searchResult[i]

		if userId == mo:getUserId() then
			mo:setRelationShip(GameEnum.RelationTypeEnum.Apply)
		end
	end
end

function M:getUser(relationType, userId)
	for _, mo in ipairs(self:getMoList(relationType)) do
		if mo:getUserId() == tonumber(userId) then
			return mo
		end
	end
end

function M:addUser(relationType, mo)
	mo:setRelationShip(relationType)

	local moList = self:getMoList(relationType)

	table.insert(moList, mo)
end

function M:removeUser(relationType, mo)
	local moList = self:getMoList(relationType)

	table.removebyvalue(moList, mo)
end

function M:refreshUserListByAgent(relationType, list)
	table.clear(self:getMoList(relationType))

	for _, PlayerMetaNO in ipairs(list or {}) do
		local mo = self:getUser(relationType, PlayerMetaNO.userId)

		if not mo then
			mo = FriendMO.New(PlayerMetaNO)

			self:addUser(relationType, mo)
		end

		mo:update(PlayerMetaNO)
	end

	table.sort(self:getMoList(relationType), _sortFriendFunc)
end

function M:getUserCountByType(relationType)
	return #self:getMoList(relationType)
end

function M:isInRelationType(relationType, userId)
	local moList = self:getMoList(relationType)

	for _, _mo in ipairs(moList) do
		if _mo:getUserId() == userId then
			return true
		end
	end

	return false
end

M.instance = M.New()

return M
