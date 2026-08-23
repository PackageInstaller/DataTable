local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.themeData

return {
	on_S2C_ThemePasscard_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			local var_1_0 = var_0_1:getThemeData(arg_1_2.passcard.activity_id)

			if var_1_0 then
				var_1_0:getPassCardData():updateAllInfo(arg_1_2.passcard)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_PASSCARD_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_ThemePasscard_GetAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			local var_2_0 = var_0_1:getThemeData(arg_2_2.activity_id)

			if var_2_0 then
				var_2_0:getPassCardData():updateAllFreeAward(arg_2_2.passcard_ids)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_PASSCARD_GETAWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_ThemePasscard_UpdateAction = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:updatePassCardTaskData(arg_3_2.actions)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_PASSCARD_UPDATEACTION, false, arg_3_1, arg_3_2)
		end
	end
}
