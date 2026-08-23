local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Retrieve_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.resouceBackData:onS2CRetrieveGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RETRIEVE_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Retrieve_Res = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RETRIEVE_RES, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Retrieve_OpRetrieveRes = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.resouceBackData:onS2CRetrieveOpRetrieveRes(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RETRIEVE_OPRETRIEVERES, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Retrieve_Res_OneKey = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.resouceBackData:onS2CRetrieveResOneKey(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RETRIEVE_RES_ONEKEY, false, arg_4_1, arg_4_2)
		end
	end
}
