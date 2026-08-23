local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.peakArenaData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum

return {
	on_S2C_PeakArena_GetActivityInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onS2CGetInfo(arg_1_2)

			if var_0_1:isReqMulTeamDataAfterInfoRes() then
				g.core.network.GameNetProxy:send_C2S_Formation_Get({
					tp = g.core.const.ConstMgr.LineUpConst.MulTeamType.PEAK_ARENA
				})
			end

			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PEAK_ARENA_GETACTIVITYINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_PeakArena_GetUserInfo = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:onS2CGetUserInfo(arg_2_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PEAK_ARENA_GETUSERINFO, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_PeakArena_GetFinalInfo = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:onS2CGetFinalInfo(arg_3_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PEAK_ARENA_GETFINALINFO, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_PeakArena_Match = function(arg_4_0, arg_4_1, arg_4_2)
		dump(arg_4_2)

		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:onS2CMatch(arg_4_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PEAK_ARENA_MATCH, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_PeakArena_ChallengeBegin = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_1:onS2CChallengeBegin(arg_5_2)
		end
	end,
	on_S2C_PeakArena_GetHistorys = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_1:onS2CPeakArenaHistory(arg_6_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PEAK_ARENA_GETHISTORYS, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_PeakArena_ChallengeFinish = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			var_0_1:onS2CChallengeFinish(arg_7_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PEAK_ARENA_CHALLENGEFINISH, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_PeakArena_GetRecords = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			var_0_1:onS2CGetRecords(arg_8_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PEAK_ARENA_GETRECORDS, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_PeakArena_PlayBets = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			var_0_1:onS2CPlayBets(arg_9_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PEAK_ARENA_PLAYBETS, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_PeakArena_SetBattleTeam = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PEAK_ARENA_SETBATTLETEAM, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_PeakArena_Cheer = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			var_0_1:onS2CCheer(arg_11_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PEAK_ARENA_CHEER, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_PeakArena_AllianceRankAward = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			var_0_1:onS2CAllianceRankAward(arg_12_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PEAK_ARENA_ALLIANCERANKAWARD, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_PeakArena_GetServerInfos = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			var_0_1:onS2CGetServerInfo(arg_13_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_PEAK_ARENA_ALLIANCERANKAWARD, false, arg_13_1, arg_13_2)
		end
	end
}
