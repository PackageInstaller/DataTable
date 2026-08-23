local var_0_0 = g.core.model.User.themeData
local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_NewDemonBoss_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			local var_1_0 = var_0_0:getThemeData(arg_1_2.act_id)

			if var_1_0 then
				var_1_0:getBossData():onNetHandleBossGetInfo(arg_1_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_DEMON_BOSS_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_NewDemonBoss_BeginChallenge = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_DEMON_BOSS_BEGINCHALLENGE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_NewDemonBoss_ChallengeFinish = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			local var_3_0 = var_0_0:getThemeData(arg_3_2.act_id)

			if var_3_0 then
				var_3_0:getBossData():onNetHandleChallengeFinishInfo(arg_3_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_DEMON_BOSS_CHALLENGEFINISH, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_NewDemonBoss_ActiveTalent = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			local var_4_0 = var_0_0:getThemeData(arg_4_2.act_id)

			if var_4_0 then
				var_4_0:getBossData():onNetHandleActiveTalentInfo(arg_4_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_DEMON_BOSS_ACTIVETALENT, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_NewDemonBoss_ResetTalent = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			local var_5_0 = var_0_0:getThemeData(arg_5_2.act_id)

			if var_5_0 then
				var_5_0:getBossData():onNetHandleResetTalentInfo(arg_5_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_DEMON_BOSS_RESETTALENT, false, arg_5_1, arg_5_2)
		end
	end
}
