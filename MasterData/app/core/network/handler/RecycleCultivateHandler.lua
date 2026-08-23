local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.recycleCultivateData

return {
	on_S2C_RecycleCultivate_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onS2CGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECYCLE_CULTIVATE_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_RecycleCultivate_Recycle = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:onS2CRecycle(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECYCLE_CULTIVATE_RECYCLE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_RecycleCultivate_Notify = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:onS2CRecycleNotify(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECYCLE_CULTIVATE_RECYCLE, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_RecycleCultivate_Upgrade = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:onS2CUpgrade(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RECYCLE_CULTIVATE_UPGRADE, false, arg_4_1, arg_4_2)
		end
	end
}
