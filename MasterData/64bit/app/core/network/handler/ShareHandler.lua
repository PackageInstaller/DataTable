local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_WeChat_Share_Get = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.ShareData:updateShareData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WE_CHAT_SHARE_GET, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_WeChat_Share = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.ShareData:setResetTime(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WE_CHAT_SHARE, false, arg_2_1, arg_2_2)
		end
	end
}
