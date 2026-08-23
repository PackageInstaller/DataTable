local var_0_0 = g.core.const.ConstMgr.GuideConst
local var_0_1 = g.core.model.User.guideData
local ProtoHandler = import(".ProtoHandler")
local var_0_3 = g.core.model.User.furnitureData

return {
	on_S2C_FurnitureRoom_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_3:onS2CFurnitureRoomGetInfo(arg_1_2)
			var_0_3:resetExpired()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_FurnitureRoom_Place = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_3:onS2CFurnitureRoomPlace(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_PLACE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_FurnitureRoom_PlaceKnight = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_3:onS2CFurnitureRoomPlaceKnight(arg_3_2)
			g.core.model.User.hlTrainData:onS2CFurnitureRoomPlaceKnight(arg_3_2)
			var_0_1:setSaveServerData(var_0_0.SAVE_SERVER_DATA_IDS.HOME_LAND_HOME_LIVED)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_PLACEKNIGHT, false, arg_3_2)
		end
	end,
	on_S2C_FurnitureRoom_Upgrade = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_3:onS2CFurnitureRoomUpgrade(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_UPGRADE, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_FurnitureRoom_Bath = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_3:onS2CFurnitureRoomBath(arg_5_2)
			var_0_1:setSaveServerData(var_0_0.SAVE_SERVER_DATA_IDS.HOME_LAND_HOME_SHOWER)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_BATH, false, arg_5_2)
		end
	end,
	on_S2C_FurnitureRoom_FriendGetInfo = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_3:onS2CFurnitureGetFriendInfo(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_FRIENDGETINFO, false, arg_6_2)
		end
	end,
	on_S2C_FurnitureRoom_Sweep = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			var_0_3:onS2CFurnitureRoomSweep(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_SWEEP, false, arg_7_2)
		end
	end,
	on_S2C_FurnitureRoom_Praise = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			var_0_3:onS2CFurnitureRoomPraise(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_PRAISE, false, arg_8_2)
		end
	end,
	on_S2C_FurnitureRoom_GetPraiseUser = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			var_0_3:onS2CFurnitureRoomGetPraiseUser(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_GETPRAISEUSER, false, arg_9_2)
		end
	end,
	on_S2C_FurnitureRoom_FurnishingNumRank = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.model.User.furnitureHandBookData:onS2CFurnishingNumRank(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_FURNISHINGNUMRANK, false, arg_10_2)
		end
	end,
	on_S2C_FurnitureRoom_OneKeySweep = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			var_0_3:onS2CFurnitureRoomSweepOneKey(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_ONEKEYSWEEP, false, arg_11_1, arg_11_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.SPIRIT_HELP_NET_ERROR, false, arg_11_1, arg_11_2)
		end
	end
}
