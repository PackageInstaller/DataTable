-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/agent/ChatAgent.lua

module("logic.extensions.chat.agent.ChatAgent", package.seeall)

local M = class("ChatAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendSendMessageRequest(channelType, messageType, content, targetId)
	local msg = ChatExtension_pb.SendMessageRequest()

	msg.message.channelType = channelType
	msg.message.messageType = messageType
	msg.message.content = content

	if targetId then
		msg.message.targetId = targetId
	end

	self:sendMsg(msg)
end

function M:handleSendMessageReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.CHAT_MESSAGE_SEND_SUCCESS)
	end
end

function M:handleNewMessagePush(status, msg)
	if status == 0 then
		if msg.result and msg.result > 0 then
			MsgBoardController.instance:_handleResultCodeMsg(nil, nil, msg.result)
		else
			ChatController.instance:handleMsgFromServer(msg.message)
		end
	end
end

function M:handleBroadcastPush(status, msg)
	if status == 0 then
		for _, v in pairs(msg.displayMode) do
			if v == GameEnum.DisplayModeEnum.BANNER then
				ChatModel.instance:addBroadcastData(msg.content)
			elseif v == GameEnum.DisplayModeEnum.CHAT then
				-- block empty
			end
		end
	end
end

M.instance = M.New()

return M
