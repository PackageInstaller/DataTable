local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.commanderWorldData

return {
	on_S2C_OrderWorld_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:updateInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_OrderWorld_Donate = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:updateDonate(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_DONATE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_OrderWorld_OpTabUser = function(arg_3_0, arg_3_1, arg_3_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_OPTABUSER, false, arg_3_1, arg_3_2)
	end,
	on_S2C_OrderWorld_GuildLevelAward = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:updateGuildLevelAward(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_GUILDLEVELAWARD, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_OrderWorld_Record_Broadcast = function(arg_5_0, arg_5_1, arg_5_2)
		var_0_1:broadcastDonateRecord(arg_5_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_RECORD_BROADCAST, false, arg_5_1, arg_5_2)
	end,
	on_S2C_OrderWorld_MarsAward = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.commanderWorldData:updateGetMarsRewardInfo(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_MARSAWARD, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_OrderWorld_GuildAllAward = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.commanderWorldData:updateGetALlGuildLevelAward()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_GUILDALLAWARD, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_OrderWorld_GuildNotify = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			var_0_1:updateDonateNotify(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_GUILDNOTIFY, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_OrderWorld_ShopBuy = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.model.User.commanderWorldData:updateBuyShopData(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_SHOPBUY, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_OrderWorld_NotifyRank = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.model.User.commanderWorldData:updateRankDataByNotify(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_NOTIFYRANK, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_OrderWorld_TaskAward = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			g.core.model.User.commanderWorldData:updateTaskAward(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_TASKAWARD, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_OrderWorld_GetServerInfos = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			var_0_1:onS2COrderWorldGetServerInfos(arg_12_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_GETSERVERINFOS, false, arg_12_1, arg_12_2)
		end
	end
}
