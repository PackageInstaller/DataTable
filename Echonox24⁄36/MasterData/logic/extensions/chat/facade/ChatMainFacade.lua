-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/facade/ChatMainFacade.lua

module("logic.extensions.chat.facade.ChatMainFacade", package.seeall)

local ChatMainFacade = class("ChatMainFacade", BaseFacade)

function ChatMainFacade:openChatMainView(channelType, targetId)
	local params = {}

	params.index = channelType
	params.targetId = targetId

	if ViewMgr.instance:isOpen(ViewName.ChatMain) then
		ViewMgr.instance:close(ViewName.ChatMain)
	end

	ViewMgr.instance:open(ViewName.ChatMain, params)
end

function ChatMainFacade:tryShowChatMsgTips(channelType, targetId)
	local topViewInfo = ViewMgr.instance._backStack:peek()

	if not topViewInfo then
		return
	end

	if topViewInfo.viewName == ViewName.MainUIView then
		local params = {}

		params.channelType = channelType
		params.targetId = targetId

		GlobalDispatcher:dispatchEvent(EventType.CHAT_NEW_MESSAGE_TIPS, params)
	end
end

ChatMainFacade.instance = ChatMainFacade.New()

return ChatMainFacade
