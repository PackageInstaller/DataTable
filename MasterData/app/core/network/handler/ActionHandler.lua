local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Action_Finish = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ACTION_FINISH, false, arg_1_1, arg_1_2)
		end
	end
}
