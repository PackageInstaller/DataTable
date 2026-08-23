local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_VipLink_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			dump(arg_1_2, "on_S2C_VipLink_GetInfo")
			g.core.model.User.vipLinkData:onRecvGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_VIP_LINK_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_VipLink_NotifyBind = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			dump(arg_2_2, "on_S2C_VipLink_NotifyBind")
			g.core.model.User.vipLinkData:onRecvNotifyBind(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_VIP_LINK_NOTIFYBIND, false, arg_2_1, arg_2_2)
		end
	end
}
