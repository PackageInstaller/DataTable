local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.playerInfoData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum

return {
	on_S2C_PlayerInfo_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onS2CGetInfo(arg_1_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PLAYER_INFO_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_PlayerInfo_Praise_GetInfo = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PLAYER_INFO_PRAISE_GETINFO, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_PlayerInfo_Praise_Execute = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PLAYER_INFO_PRAISE_EXECUTE, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_PlayerInfo_Praise_Award = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PLAYER_INFO_PRAISE_AWARD, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_PlayerInfo_Sign = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PLAYER_INFO_SIGN, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_PlayerInfo_SetShow = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PLAYER_INFO_SETSHOW, false, arg_6_1, arg_6_2)
		end
	end
}
