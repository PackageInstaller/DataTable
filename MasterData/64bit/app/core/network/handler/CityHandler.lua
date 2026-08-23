local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_City_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.cityData:updateCityData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CITY_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_City_StartPatrol = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.cityData:updateCityServerData(arg_2_2.city)
			g.core.model.User.cityData:addPatrolKnight(arg_2_2.city.knight_id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CITY_STARTPATROL, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_City_FinishPatrol = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.cityData:updateCityFinish(arg_3_2.id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CITY_FINISHPATROL, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_City_GetFriendInfo = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.cityData:updateFriendData(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CITY_GETFRIENDINFO, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_City_GetFriendCity = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.cityData:updateFriendCityData(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CITY_GETFRIENDCITY, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_City_HandleTrouble = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.cityData:updateEventAndAwardData(arg_6_2, true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CITY_HANDLETROUBLE, false, arg_6_1, arg_6_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CITY_REPEAT_HANDLE_TROUBLE)
		end
	end,
	on_S2C_City_GetTroubleFriend = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.cityData:updateFriendTrouble(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CITY_GETTROUBLEFRIEND, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_City_OneKeyHandleTrouble = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CITY_ONEKEYHANDLETROUBLE, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_City_OneKeyPatrol = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.model.User.cityData:startOneKeyPatrol(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CITY_ONEKEYPATROL, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_City_OneKeyGetAward = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.model.User.cityData:updateCityOneKeyFinish(arg_10_2.city_ids)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CITY_ONEKEYGETAWARD, false, arg_10_1, arg_10_2)
		end
	end
}
