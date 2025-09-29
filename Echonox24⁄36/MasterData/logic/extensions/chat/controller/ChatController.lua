-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/controller/ChatController.lua

module("logic.extensions.chat.controller.ChatController", package.seeall)

local M = class("ChatController", BaseController)

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

function M:handleMsgFromServer(messageList)
	local msgLen = #messageList

	if msgLen > 1 then
		table.sort(messageList, function(msg1, msg2)
			if msg1.time ~= msg2.time then
				return msg1.time < msg2.time
			else
				return tonumber(msg1.senderId) < tonumber(msg2.senderId)
			end
		end)
	end

	local _frameLoadMsg
	local index = 0

	function _frameLoadMsg()
		index = index + 1

		if index > #messageList then
			removetimer(_frameLoadMsg, self)

			return
		end

		local msgMo = ChatMsgMO.New(messageList[index])

		ChatModel.instance:addMsg(msgMo, true)
		GlobalDispatcher:dispatchEvent(EventType.CHAT_MESSAGE_UPDATE)
	end

	settimer(0, _frameLoadMsg, self, true)
end

local function _createContent(length)
	local ret = lang("t_content")

	for i = 1, length do
		ret = ret .. i
	end

	return ret
end

local function _createTextMsgReplyNO(args)
	local isMe = args % 2 == 1

	return {
		senderId = isMe and tonumber(PlayerModel.instance:getId()) or 13171,
		targetId = isMe and 13171 or tonumber(PlayerModel.instance:getId()),
		channelType = GameEnum.ChannelTypeEnum.Friend,
		messageType = GameEnum.MessageTypeEnum.Text,
		content = _createContent(math.random(40, 50)),
		time = ServerTime.now() * 1000
	}
end

local function _createEmojiMsgReplyNO(args)
	local isMe = args % 2 == 1
	local allEmojiCfgs = ChatConfig.instance:getAllEmojiCfgs()

	return {
		senderId = isMe and tonumber(PlayerModel.instance:getId()) or 13171,
		targetId = isMe and 13171 or tonumber(PlayerModel.instance:getId()),
		channelType = GameEnum.ChannelTypeEnum.Friend,
		messageType = GameEnum.MessageTypeEnum.Emoji,
		content = tostring(allEmojiCfgs[math.random(1, #allEmojiCfgs)].id),
		time = ServerTime.now() * 1000
	}
end

function M:testMultipleMsg(count)
	local messageList = {}

	for i = 1, count do
		table.insert(messageList, _createTextMsgReplyNO(math.random(1, 10)))
	end

	self:handleMsgFromServer(messageList)
end

function M:testEmojiMsg(count)
	local messageList = {}

	for i = 1, count do
		table.insert(messageList, _createEmojiMsgReplyNO(math.random(1, 10)))
	end

	self:handleMsgFromServer(messageList)
end

M.instance = M.New()

return M
