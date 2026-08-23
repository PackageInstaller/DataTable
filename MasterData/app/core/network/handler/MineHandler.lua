local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.mineData

return {
	on_S2C_Mine_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if arg_1_2.ret == g.core.network.proto.RET_MINE_ACTIVITY_STATUS_NOT_SAME then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_GETINFO, false, arg_1_1, arg_1_2)
		elseif ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:updateMineData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Mine_GetGold = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:updateGetGold(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_GETGOLD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Mine_GetCityInfo = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:updateCityData(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_GETCITYINFO, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Mine_MoveCity = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:updateByMoveCity(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_MOVECITY, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Mine_AttackUserBegin = function(arg_5_0, arg_5_1, arg_5_2)
		ProtoHandler:onMsgProcess(arg_5_1, arg_5_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_ATTACKUSERBEGIN, false, arg_5_1, arg_5_2)
	end,
	on_S2C_Mine_AttackUserFinish = function(arg_6_0, arg_6_1, arg_6_2)
		ProtoHandler:onMsgProcess(arg_6_1, arg_6_2)
		var_0_1:updateAttackFinish(arg_6_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_ATTACKUSERFINISH, false, arg_6_1, arg_6_2)

		if var_0_1:getCurPower() == 0 and var_0_1:getCurPower() ~= 0 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MINE_PLAYER_DEAD, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Mine_CaptureNotify = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			var_0_1:updateCaptureNotify(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_CAPTURENOTIFY, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Mine_BuyPower = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			var_0_1:updatePower(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_BUYPOWER, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Mine_GetLeagueStatus = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_GETLEAGUESTATUS, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Mine_Leave = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_LEAVE, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_Mine_EventNotify = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			var_0_1:updateEventNotify(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_EVENTNOTIFY, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_Mine_GetRecord = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			var_0_1:updateGetRecord(arg_12_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_GETRECORD, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_Mine_PlayerDieNotify = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			var_0_1:updateDeadNotify(arg_13_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_PLAYERDIENOTIFY, false, arg_13_1, arg_13_2)
		end
	end,
	on_S2C_Mine_PlayerPowerNotify = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			var_0_1:updatePowerNotify(arg_14_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_PLAYERPOWERNOTIFY, false, arg_14_1, arg_14_2)

			if arg_14_2.power == 0 then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MINE_PLAYER_DEAD, false, arg_14_1, arg_14_2)
			end
		end
	end,
	on_S2C_Mine_GetMission = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			var_0_1:updateMissionState(arg_15_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_GETMISSION, false, arg_15_1, arg_15_2)
		end
	end,
	on_S2C_Mine_GetMissionReward = function(arg_16_0, arg_16_1, arg_16_2)
		if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
			var_0_1:updateGetMissionReward(arg_16_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_GETMISSIONREWARD, false, arg_16_1, arg_16_2)
		end
	end,
	on_S2C_Mine_GetAchieveReward = function(arg_17_0, arg_17_1, arg_17_2)
		if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
			var_0_1:updateGetAchieveReward(arg_17_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_GETACHIEVEREWARD, false, arg_17_1, arg_17_2)
		end
	end,
	on_S2C_Mine_GetMassInfo = function(arg_18_0, arg_18_1, arg_18_2)
		if ProtoHandler:onMsgProcess(arg_18_1, arg_18_2) then
			var_0_1:updateMassInfo(arg_18_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_GETMASSINFO, false, arg_18_1, arg_18_2)
		end
	end,
	on_S2C_Mine_Mass = function(arg_19_0, arg_19_1, arg_19_2)
		if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
			var_0_1:updateMass(arg_19_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_MASS, false, arg_19_1, arg_19_2)
		end
	end,
	on_S2C_Mine_GetEnemyUser = function(arg_20_0, arg_20_1, arg_20_2)
		var_0_1:updateEnemyUsers(arg_20_2.mineEnemyUser)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_GETENEMYUSER, false, arg_20_1, arg_20_2)
	end,
	on_S2C_Mine_GetEnemyGuild = function(arg_21_0, arg_21_1, arg_21_2)
		var_0_1:updateEnemyGuilds(arg_21_2.mineEnemyGuild)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_GETENEMYGUILD, false, arg_21_1, arg_21_2)
	end,
	on_S2C_Mine_MassNotify = function(arg_22_0, arg_22_1, arg_22_2)
		g.core.model.User.mineData:updateMassNotify(arg_22_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_MASSNOTIFY, false, arg_22_1, arg_22_2)
	end,
	on_S2C_Mine_GetShield = function(arg_23_0, arg_23_1, arg_23_2)
		if ProtoHandler:onMsgProcess(arg_23_1, arg_23_2) then
			var_0_1:onMineGetShield(arg_23_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_GETSHIELD, false, arg_23_1, arg_23_2)
		end
	end,
	on_S2C_Mine_UserShieldNotify = function(arg_24_0, arg_24_1, arg_24_2)
		if ProtoHandler:onMsgProcess(arg_24_1, arg_24_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MINE_USERSHIELDNOTIFY, false, arg_24_1, arg_24_2)
		end
	end
}
