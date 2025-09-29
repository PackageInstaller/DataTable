-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/model/FriendMO.lua

module("logic.extensions.friend.model.FriendMO", package.seeall)

local FriendMO = class("FriendMO")

function FriendMO:ctor(PlayerMetaNO)
	self._userId = 0
	self._nickname = ""
	self._lv = 0
	self._portrait = 0
	self._card = 0
	self._lastLoginTime = -1
	self._alias = ""
	self._signature = ""
	self._applyTime = 0
	self._relation = 0

	self:update(PlayerMetaNO)
end

function FriendMO:getUserId()
	return self._userId
end

function FriendMO:getNickName()
	return self._nickname
end

function FriendMO:getSignature()
	return self._signature
end

function FriendMO:getLv()
	return self._lv
end

function FriendMO:getPortrait()
	return self._portrait
end

function FriendMO:getCard()
	return self._card
end

function FriendMO:getLastLoginTime()
	return self._lastLoginTime
end

function FriendMO:getAlias()
	return self._alias
end

function FriendMO:setAlias(alias)
	self._alias = alias
end

function FriendMO:setApplyTime(time)
	self._applyTime = time
end

function FriendMO:getApplyTime()
	return self._applyTime
end

function FriendMO:setRelationShip(relation)
	self._relation = relation
end

function FriendMO:getRelationShip()
	return self._relation
end

function FriendMO:getOnLineStatus()
	if self._lastLoginTime == 0 then
		return FriendEnum.OnLineStatus.OnLine
	else
		return FriendEnum.OnLineStatus.OffLine
	end
end

function FriendMO:getLastContent()
	local channelType = GameEnum.ChannelTypeEnum.Friend
	local msgMo = ChatModel.instance:getLastMsg(channelType, self:getUserId())

	if msgMo then
		if msgMo:getMessageType() == GameEnum.MessageTypeEnum.Emoji then
			local emojiId = tonumber(msgMo:getContent())
			local emojiCfg = ChatConfig.instance:getEmojiCfg(emojiId)

			return string.format("[%s]", emojiCfg.name)
		elseif msgMo:getMessageType() == GameEnum.MessageTypeEnum.Text then
			return msgMo:getContent()
		end
	else
		return ""
	end
end

function FriendMO:update(PlayerMetaNO)
	if not PlayerMetaNO then
		return
	end

	self._userId = tonumber(PlayerMetaNO.userId)
	self._nickname = PlayerMetaNO.nickname
	self._lv = PlayerMetaNO.lv
	self._portrait = PlayerMetaNO.portrait
	self._card = PlayerMetaNO.card
	self._lastLoginTime = tonumber(PlayerMetaNO.lastLoginTime)
	self._alias = PlayerMetaNO.alias
	self._applyTime = PlayerMetaNO.beApplyTime
	self._signature = PlayerMetaNO.sign
end

return FriendMO
