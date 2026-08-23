local var_0_0 = g.core.model.User.themeData
local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Eliminate_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			local var_1_0 = var_0_0:getThemeData(arg_1_2.id)

			if var_1_0 then
				var_1_0:getGemEliminateData():onS2CGemEliminateGetInfo(arg_1_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ELIMINATE_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Eliminate_Result = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			local var_2_0 = var_0_0:getThemeData(arg_2_2.id)

			if var_2_0 then
				var_2_0:getGemEliminateData():onS2CEliminateResult(arg_2_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ELIMINATE_RESULT, false, arg_2_1, arg_2_2)
		end
	end
}
