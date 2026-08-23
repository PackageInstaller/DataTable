local var_0_0 = g.core.model.User.outpostData
local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Outpost_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_0:onS2COutpostGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Outpost_Leave = function(arg_2_0, arg_2_1, arg_2_2)
		return
	end,
	on_S2C_Outpost_DonateKnight = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_0:onS2COutpostDonateKnight(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_DONATEKNIGHT, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Outpost_BattleFinish = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_0:onS2COutpostBattleFinish(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BATTLEFINISH, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Outpost_Build_LevelUp = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_0:onS2COutpostBuildLevelUp(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_LEVELUP, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Outpost_Build_Unlock = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_0:onS2COutpostBuildUnlock(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_UNLOCK, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Outpost_Build_Use = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			var_0_0:onS2COutpostBuildUse(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_USE, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Outpost_Build_Use_Leave = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			var_0_0:onS2COutpostBuildUseLeave(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_USE_LEAVE, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Outpost_Build_OrderProcess = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			var_0_0:onS2COutpostBuildOrderProcess(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_ORDERPROCESS, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Outpost_Build_ChangeOrder = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			var_0_0:onS2COutpostBuildChangeOrder(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_CHANGEORDER, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_Outpost_Build_CallBoss = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			var_0_0:onS2COutpostCallBoss(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_CALLBOSS, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_Outpost_Boss_Sweep = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			var_0_0:onS2COutpostBossSweep(arg_12_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BOSS_SWEEP, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_Outpost_DelBoss = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			var_0_0:onS2COutpostDelBoss(arg_13_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_DELBOSS, false, arg_13_1, arg_13_2)
		end
	end,
	on_S2C_Outpost_Map_ClickDrop = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			var_0_0:onS2COutpostClickDrop(arg_14_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_MAP_CLICKDROP, false, arg_14_1, arg_14_2)
		end
	end,
	on_S2C_Outpost_GetBossBox = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			var_0_0:onS2COutpostClickBossBox(arg_15_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETBOSSBOX, false, arg_15_1, arg_15_2)
		end
	end,
	on_S2C_Outpost_GetTaskAward = function(arg_16_0, arg_16_1, arg_16_2)
		if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
			var_0_0:onS2COutpostGetTaskAward(arg_16_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETTASKAWARD, false, arg_16_1, arg_16_2)
		end
	end,
	on_S2C_Outpost_SyncTask = function(arg_17_0, arg_17_1, arg_17_2)
		if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
			var_0_0:onS2COutpostSyncTask(arg_17_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_SYNCTASK, false, arg_17_1, arg_17_2)
		end
	end,
	on_S2C_Outpost_Knight_Entrance = function(arg_18_0, arg_18_1, arg_18_2)
		if ProtoHandler:onMsgProcess(arg_18_1, arg_18_2) then
			var_0_0:onS2COutPostKnightEntrance(arg_18_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_KNIGHT_ENTRANCE, false, arg_18_1, arg_18_2)
		end
	end,
	on_S2C_Outpost_Knight_Exit = function(arg_19_0, arg_19_1, arg_19_2)
		if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
			var_0_0:onS2COutPostKnightExit(arg_19_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_KNIGHT_EXIT, false, arg_19_1, arg_19_2)
		end
	end,
	on_S2C_Outpost_KnightChangeMap = function(arg_20_0, arg_20_1, arg_20_2)
		if ProtoHandler:onMsgProcess(arg_20_1, arg_20_2) then
			var_0_0:onS2COutPostKnightChangeMap(arg_20_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_KNIGHTCHANGEMAP, false, arg_20_1, arg_20_2)
		end
	end,
	on_S2C_Outpost_Map_Unlock = function(arg_21_0, arg_21_1, arg_21_2)
		if ProtoHandler:onMsgProcess(arg_21_1, arg_21_2) then
			var_0_0:onS2COutpostMapUnlock(arg_21_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_MAP_UNLOCK, false, arg_21_1, arg_21_2)
		end
	end,
	on_S2C_Outpost_OneKeyClickDrop = function(arg_22_0, arg_22_1, arg_22_2)
		if ProtoHandler:onMsgProcess(arg_22_1, arg_22_2) then
			var_0_0:onS2COneKeyClickDrop(arg_22_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OUTPOST_ONEKEYCLICKDROP, false, arg_22_1, arg_22_2)
		end
	end
}
