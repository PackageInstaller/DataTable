local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_TalkShow_Get = function(arg_1_0, arg_1_1, arg_1_2)
		g.core.model.User:updatePropChat(arg_1_2)
		g.core.model.User.chatData:updateChatFaceData()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TALK_SHOW_GET, false, arg_1_1, arg_1_2)
	end,
	on_S2C_TalkShow_Active = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User:updatePropChat(arg_2_2)
			g.core.model.User.chatData:updateChatFaceData()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TALK_SHOW_ACTIVE, false, arg_2_1, arg_2_2)
		end
	end
}
