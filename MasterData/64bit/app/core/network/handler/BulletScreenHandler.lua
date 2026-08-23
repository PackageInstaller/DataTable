local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_BulletScreenSend = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.chatData:setCrossServerMessage(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BULLET_SCREEN_SEND, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_BulletScreenNotify = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			if arg_2_2.message.user.id == g.core.model.User:getId() then
				return
			end

			g.core.model.User.chatData:setCrossServerMessage(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BULLET_SCREEN_NOTIFY, false, arg_2_1, arg_2_2)
		end
	end
}
