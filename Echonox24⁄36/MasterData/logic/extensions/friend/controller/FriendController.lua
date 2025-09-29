-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/controller/FriendController.lua

module("logic.extensions.friend.controller.FriendController", package.seeall)

local M = class("FriendController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	return
end

function M:onLateInit()
	return
end

function M:onReset()
	return
end

function M:handleApplyFriendReplyMsg(userId)
	FriendModel.instance:updateSearchResult(userId)
end

function M:handleAgreeApplyReplyMsg(resultList)
	for _, AgreeResultNO in ipairs(resultList) do
		if AgreeResultNO.result == 0 then
			local relationType = GameEnum.RelationTypeEnum.BeApply
			local friendMo = FriendModel.instance:getUser(relationType, AgreeResultNO.userId)

			if friendMo then
				friendMo:setApplyTime(0)
				FriendModel.instance:removeUser(relationType, friendMo)

				local newRelationType = GameEnum.RelationTypeEnum.Friend

				if not FriendModel.instance:getUser(newRelationType, AgreeResultNO.userId) then
					FriendModel.instance:addUser(newRelationType, friendMo)
				end
			end
		end
	end
end

function M:handleRefuseApplyReplyMsg(userIdList)
	for _, userId in ipairs(userIdList) do
		local relationType = GameEnum.RelationTypeEnum.BeApply
		local friendMo = FriendModel.instance:getUser(relationType, tonumber(userId))

		if friendMo then
			FriendModel.instance:removeUser(relationType, friendMo)
		end
	end
end

function M:handleRemoveFriendReplyMsg(userId)
	local relationType = GameEnum.RelationTypeEnum.Friend
	local friendMo = FriendModel.instance:getUser(relationType, userId)

	FriendModel.instance:removeUser(relationType, friendMo)
end

function M:handleBlockUserReplyMsg(userId)
	local relationType = GameEnum.RelationTypeEnum.Friend
	local friendMo = FriendModel.instance:getUser(relationType, userId)

	if not friendMo then
		relationType = GameEnum.RelationTypeEnum.BeApply
		friendMo = FriendModel.instance:getUser(relationType, userId)
	end

	if not friendMo then
		local searchResult = FriendModel.instance:getSearchResult()

		for _, mo in ipairs(searchResult) do
			if mo:getUserId() == userId then
				friendMo = mo

				FriendModel.instance:clearSearchResult()
				GlobalDispatcher:dispatchEvent(EventType.UPDATE_SEARCH_RESULT)

				break
			end
		end
	end

	if friendMo then
		FriendModel.instance:removeUser(relationType, friendMo)

		local newRelationType = GameEnum.RelationTypeEnum.Block

		FriendModel.instance:addUser(newRelationType, friendMo)
		FloatWordMgr.instance:show(string.format("已将%s加入黑名单", friendMo:getNickName()))
	end
end

function M:handleUnBlockUserReplyMsg(userId)
	local relationType = GameEnum.RelationTypeEnum.Block
	local friendMo = FriendModel.instance:getUser(relationType, userId)

	if friendMo then
		FriendModel.instance:removeUser(relationType, friendMo)
	end
end

function M:handleChangeAliasReplyMsg(userId, alias)
	local relationType = GameEnum.RelationTypeEnum.Friend
	local friendMo = FriendModel.instance:getUser(relationType, userId)

	if friendMo then
		friendMo:setAlias(alias or "")
	end
end

M.instance = M.New()

return M
