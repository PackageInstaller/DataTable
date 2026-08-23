local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.themeData

return {
	on_S2C_Turntable_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			local var_1_0 = var_0_1:getThemeData(arg_1_2.act_id)

			if var_1_0 then
				var_1_0:getTurnTableData():onS2CTurnTableGetInfo(arg_1_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TURNTABLE_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Turntable_Once = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			local var_2_0 = var_0_1:getThemeData(arg_2_2.act_id)

			if var_2_0 then
				var_2_0:getTurnTableData():onS2CTurnTableOnce(arg_2_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TURNTABLE_ONCE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Turntable_Five = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			local var_3_0 = var_0_1:getThemeData(arg_3_2.act_id)

			if var_3_0 then
				var_3_0:getTurnTableData():onS2CTurnTableFive(arg_3_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TURNTABLE_FIVE, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Turntable_Reward = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			local var_4_0 = var_0_1:getThemeData(arg_4_2.act_id)

			if var_4_0 then
				var_4_0:getTurnTableData():onS2CTurnTableReward(arg_4_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TURNTABLE_REWARD, false, arg_4_1, arg_4_2)
		end
	end
}
