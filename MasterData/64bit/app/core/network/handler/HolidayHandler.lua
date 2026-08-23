local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Holiday_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			if arg_1_2.tp == 0 then
				g.core.model.User.holidayData:updateHolidayInfo(arg_1_2)
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HOLIDAY_INFO, false, arg_1_1, arg_1_2)
			elseif arg_1_2.tp == 2 then
				if arg_1_2.activity_id and arg_1_2.activity_id > 0 then
					g.core.model.User.fortuneBagData:updateInfo(arg_1_2)
					g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HOLIDAY_INFO, false, arg_1_1, arg_1_2)
				else
					g.core.model.User.fortuneBagData:updateNoData()
				end
			end
		end
	end,
	on_S2C_Holiday_Award = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			if arg_2_2.tp == 0 then
				g.core.model.User.holidayData:updateTaskAward(arg_2_2)
			elseif arg_2_2.tp == 2 then
				g.core.model.User.fortuneBagData:updateAward(arg_2_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HOLIDAY_AWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Holiday_Buy = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			if arg_3_2.tp == 0 then
				g.core.model.User.holidayData:updateBuyGood(arg_3_2)
			elseif arg_3_2.tp == 2 then
				g.core.model.User.fortuneBagData:updateBuy(arg_3_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HOLIDAY_BUY, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Holiday_NotifyTask = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			if arg_4_2.tp == 0 then
				g.core.model.User.holidayData:updateTaskData(arg_4_2)
			elseif arg_4_2.tp == 2 then
				g.core.model.User.fortuneBagData:updateNotifyTask(arg_4_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HOLIDAY_NOTIFYTASK, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Holiday_Drop_Info = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			local var_5_0 = g.core.model.User.themeData:getThemeData(arg_5_2.sub_activity_id)

			if var_5_0 then
				var_5_0:getTaskData():onNetHandleTaskDropInfo(arg_5_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HOLIDAY_DROP_INFO, false, arg_5_1, arg_5_2)
		end
	end
}
