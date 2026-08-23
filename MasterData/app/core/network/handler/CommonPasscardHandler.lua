local var_0_0 = g.core.model.User.commonPassCardDataMgr
local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_CommonPasscard_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			if arg_1_2.passcard then
				var_0_0:getPassCardData(arg_1_2.passcard.id):updatePassCardData(arg_1_2.passcard)
				g.core.model.User.newSlgData:updatePassCardData(arg_1_2.passcard.id)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_COMMON_PASSCARD_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_CommonPasscard_LevelAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_0:getPassCardData(arg_2_2.id):onGetActivityLevelAward(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_COMMON_PASSCARD_LEVELAWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_CommonPasscard_TaskAward = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_0:getPassCardData(arg_3_2.id):passCardTaskAward(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_COMMON_PASSCARD_TASKAWARD, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_CommonPasscard_BuyLevel = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_0:getPassCardData(arg_4_2.id):updateBuyLevel(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_COMMON_PASSCARD_BUYLEVEL, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_CommonPasscard_UpdateLevel = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_0:getPassCardData(arg_5_2.id):updateLvExp(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_COMMON_PASSCARD_UPDATELEVEL, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_CommonPasscard_UpdateTask = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_0:getPassCardData(arg_6_2.id):onS2CActionStatusFlush(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_COMMON_PASSCARD_UPDATETASK, false, arg_6_1, arg_6_2)
		end
	end
}
