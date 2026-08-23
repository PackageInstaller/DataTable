local var_0_0 = g.core.model.User.pubgData
local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Pubg_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_0:onS2CGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Pubg_Match = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_MATCH, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Pubg_CancelMatch = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_CANCELMATCH, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Pubg_Enter = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_0:onS2CEnterMap(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_ENTER, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Pubg_Exit = function(arg_5_0, arg_5_1, arg_5_2)
		return
	end,
	on_S2C_Pubg_Move = function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_2.ret ~= g.core.network.proto.RET_OK then
			var_0_0:getMapData():moveError(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.PUBG_MOVE_ERROR, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Pubg_MoveNotice = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			var_0_0:getMapData():setUserMoveNotice(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_MOVENOTICE, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Pubg_Challenge = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			var_0_0:getMapData():onChallenge(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_CHALLENGE, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Pubg_UpdateUser = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			var_0_0:getMapData():onUpdateUser(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_UPDATEUSER, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Pubg_DeadNotice = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			var_0_0:getMapData():onDeadNotice(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_DEADNOTICE, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_Pubg_RecoverNotice = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			var_0_0:getMapData():onRecoverNotice(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_RECOVERNOTICE, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_Pubg_PickBuff = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			-- block empty
		end
	end,
	on_S2C_Pubg_PickBuffNotice = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			var_0_0:getMapData():onPickBuffNotice(arg_13_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_PICKBUFFNOTICE, false, arg_13_1, arg_13_2)
		end
	end,
	on_S2C_Pubg_RemoveBuffNotice = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			var_0_0:getMapData():onRemoveBuffNotice(arg_14_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_REMOVEBUFFNOTICE, false, arg_14_1, arg_14_2)
		end
	end,
	on_S2C_Pubg_ShrinkCircle = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			var_0_0:getMapData():onShrinkCircle(arg_15_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_SHRINKCIRCLE, false, arg_15_1, arg_15_2)
		end
	end,
	on_S2C_Pubg_Refresh = function(arg_16_0, arg_16_1, arg_16_2)
		if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
			var_0_0:getMapData():onRefresh(arg_16_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_REFRESH, false, arg_16_1, arg_16_2)
		end
	end,
	on_S2C_Pubg_TaskInfo = function(arg_17_0, arg_17_1, arg_17_2)
		if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
			var_0_0:onS2CPubgTaskInfo(arg_17_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_TASKINFO, false, arg_17_1, arg_17_2)
		end
	end,
	on_S2C_Pubg_TaskAward = function(arg_18_0, arg_18_1, arg_18_2)
		if ProtoHandler:onMsgProcess(arg_18_1, arg_18_2) then
			var_0_0:onS2CTaskAward(arg_18_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_TASKAWARD, false, arg_18_1, arg_18_2)
		end
	end,
	on_S2C_Pubg_GameBegin = function(arg_19_0, arg_19_1, arg_19_2)
		if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_GAMEBEGIN, false, arg_19_1, arg_19_2)
		end
	end,
	on_S2C_Pubg_GameEnd = function(arg_20_0, arg_20_1, arg_20_2)
		if ProtoHandler:onMsgProcess(arg_20_1, arg_20_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_GAMEEND, false, arg_20_1, arg_20_2)
		end
	end,
	on_S2C_Pubg_TextNotice = function(arg_21_0, arg_21_1, arg_21_2)
		if ProtoHandler:onMsgProcess(arg_21_1, arg_21_2) then
			var_0_0:getMapData():onAddTextNotice(arg_21_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_TEXTNOTICE, false, arg_21_1, arg_21_2)
		end
	end,
	on_S2C_Pubg_AddExpNotice = function(arg_22_0, arg_22_1, arg_22_2)
		if ProtoHandler:onMsgProcess(arg_22_1, arg_22_2) then
			var_0_0:getMapData():onExpNotice(arg_22_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_ADDEXPNOTICE, false, arg_22_1, arg_22_2)
		end
	end,
	on_S2C_Pubg_ServerInfos = function(arg_23_0, arg_23_1, arg_23_2)
		if ProtoHandler:onMsgProcess(arg_23_1, arg_23_2) then
			var_0_0:onS2CServerInfos(arg_23_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_SERVERINFOS, false, arg_23_1, arg_23_2)
		end
	end,
	on_S2C_Pubg_RefreshAirdrop = function(arg_24_0, arg_24_1, arg_24_2)
		if ProtoHandler:onMsgProcess(arg_24_1, arg_24_2) then
			var_0_0:getMapData():onS2CRefreshAirdrop(arg_24_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_REFRESHAIRDROP, false, arg_24_1, arg_24_2)
		end
	end,
	on_S2C_Pubg_PickAirdrop = function(arg_25_0, arg_25_1, arg_25_2)
		if ProtoHandler:onMsgProcess(arg_25_1, arg_25_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_PICKAIRDROP, false, arg_25_1, arg_25_2)
		end
	end,
	on_S2C_Pubg_PickAirdropNotice = function(arg_26_0, arg_26_1, arg_26_2)
		if ProtoHandler:onMsgProcess(arg_26_1, arg_26_2) then
			var_0_0:getMapData():onS2CPickAirdropNotice(arg_26_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_PICKAIRDROPNOTICE, false, arg_26_1, arg_26_2)
		end
	end,
	on_S2C_Pubg_GainAirdrop = function(arg_27_0, arg_27_1, arg_27_2)
		if ProtoHandler:onMsgProcess(arg_27_1, arg_27_2) then
			var_0_0:getMapData():onS2CGainAirdrop(arg_27_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_GAINAIRDROP, false, arg_27_1, arg_27_2)
		end
	end
}
