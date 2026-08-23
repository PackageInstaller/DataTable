local var_0_0 = g.core.model.User.spireData
local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Spire_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_0:onS2CGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPIRE_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Spire_StageBegin = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_0:onS2CStageBegin(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPIRE_STAGEBEGIN, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Spire_StageFinish = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_0:onS2CStageFinish(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPIRE_STAGEFINISH, false, arg_3_1, arg_3_2)
		elseif not var_0_0:isActivityOpen() then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPIRE_STAGEFINISH, false, arg_3_1, {
				needExit = true
			})
		end
	end,
	on_S2C_Spire_BossBuff = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_0:onS2CBossBuff(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPIRE_BOSSBUFF, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Spire_BossBegin = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_0:onS2CBossBegin(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPIRE_BOSSBEGIN, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Spire_BossFinish = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_0:onS2CBossFinish(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPIRE_BOSSFINISH, false, arg_6_1, arg_6_2)
		elseif not var_0_0:isActivityOpen() then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPIRE_BOSSFINISH, false, arg_6_1, {
				needExit = true
			})
		end
	end,
	on_S2C_Spire_BossInfo = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			var_0_0:onS2CBossInfo(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPIRE_BOSSINFO, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Spire_IdleInfo = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			var_0_0:onS2CIdleInfo(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPIRE_IDLEINFO, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Spire_IdleAward = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			var_0_0:onS2CIdleAward(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPIRE_IDLEAWARD, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Spire_FastIdle = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			var_0_0:onS2CFastIdle(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPIRE_FASTIDLE, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_Spire_ServerInfos = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			var_0_0:onS2CServerInfos(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPIRE_SERVERINFOS, false, arg_11_1, arg_11_2)
		end
	end
}
