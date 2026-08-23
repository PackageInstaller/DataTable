local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_DemonBoss_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			local var_1_0 = g.core.model.User.themeData:getThemeData(arg_1_2.id)

			if var_1_0 then
				var_1_0:getBossData():onNetHandleBossGetInfo(arg_1_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEMON_BOSS_GETINFO, false)
		end
	end,
	on_S2C_DemonBoss_BeginChallenge = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEMON_BOSS_BEGINCHALLENGE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_DemonBoss_ChallengeFinish = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEMON_BOSS_CHALLENGEFINISH, false, arg_3_1, arg_3_2)
		elseif g.core.battle.BattleProxy:isInBattle() then
			g.core.battle.BattleProxy:exitBattle()
		end
	end,
	on_S2C_DemonAutoBoss_GetInfo = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			local var_4_0 = g.core.model.User.themeData:getThemeData(arg_4_2.id)

			if var_4_0 then
				var_4_0:getBossData():onNetHandleAutoBossGetInfo(arg_4_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEMON_AUTO_BOSS_GETINFO, false)
		end
	end,
	on_S2C_DemonAutoBoss_BeginChallenge = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEMON_AUTO_BOSS_BEGINCHALLENGE, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_DemonAutoBoss_ChallengeFinish = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEMON_AUTO_BOSS_CHALLENGEFINISH, false, arg_6_1, arg_6_2)
		elseif g.core.battle.BattleProxy:isInBattle() then
			g.core.battle.BattleProxy:exitBattle()
		end
	end,
	on_S2C_DemonAutoBoss_GetAward = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			local var_7_0 = g.core.model.User.themeData:getThemeData(arg_7_2.id)

			if var_7_0 then
				var_7_0:getBossData():onNetHandleAutoBossGetAward(arg_7_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEMON_AUTO_BOSS_GETAWARD, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_DemonBoss_GetRankList = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DEMON_BOSS_GETRANKLIST, false, arg_8_1, arg_8_2)
		end
	end
}
