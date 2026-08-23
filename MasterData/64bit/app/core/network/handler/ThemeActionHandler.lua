local ProtoHandler = import(".ProtoHandler")
local var_0_2 = g.core.model.User.themeData

return {
	on_S2C_ThemeAction_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			local var_1_0 = var_0_2:getThemeData(arg_1_2.act_id)

			if var_1_0 then
				var_1_0:getTaskData():onNetHandleTaskGetInfo(arg_1_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_ACTION_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_ThemeAction_GetAwards = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			local var_2_0 = g.core.config.activity_theme_task_info.fetch(arg_2_2.act_id)

			if not var_2_0 then
				return
			end

			for iter_2_0, iter_2_1 in ipairs(var_2_0.activity_id ~= 0 and var_0_2:getThemeMergeConfigValueList(var_2_0.activity_id) or var_0_2:getThemeMergeConfigValuesByThreeActivity(var_2_0.three_activity or 0)) do
				local var_2_3 = var_0_2:getThemeData(iter_2_1)

				if var_2_3 then
					var_2_3:getTaskData():onNetHandleTaskAward(arg_2_2)
				end
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_THEME_ACTION_GETAWARDS, false, arg_2_1, arg_2_2)
		end
	end
}
