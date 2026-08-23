local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_GoldEquip_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.troopData:updateTroop(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GOLD_EQUIP_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_GoldEquip_Draw = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GOLD_EQUIP_DRAW, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_GoldEquip_TaskAward = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.troopData:updateAward(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GOLD_EQUIP_TASKAWARD, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_GoldEquip_SyncTask = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.troopData:updateSyncTask(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GOLD_EQUIP_SYNCTASK, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_GoldEquip_BroadcastDrawInfo = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.troopData:addHistory(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GOLD_EQUIP_BROADCASTDRAWINFO, false, arg_5_1, arg_5_2)
		end
	end
}
