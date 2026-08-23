local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Chat = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			-- block empty
		end
	end,
	on_S2C_Chat_LeftTimes = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.chatData:addWorldLeftTimes(arg_2_2.times)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CHAT_LEFTTIMES, false, arg_2_1, arg_2_2)
		end
	end
}
