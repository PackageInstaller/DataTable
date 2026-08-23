local ProtoHandler = import(".ProtoHandler")
local var_0_1 = {}
local var_0_2 = g.core.model.User.richmanData

function var_0_1.on_S2C_RichMan_GetInfo(arg_1_0, arg_1_1, arg_1_2)
	if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
		var_0_2:onGetRichManInfo(arg_1_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_GETINFO, false, arg_1_1, arg_1_2)
	end
end

function var_0_1.on_S2C_RichMan_RollDice(arg_2_0, arg_2_1, arg_2_2)
	if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
		var_0_2:onRichManDice(arg_2_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_ROLLDICE, false, arg_2_1, arg_2_2)
	end
end

function var_0_1.on_S2C_RichMan_EventProcess(arg_3_0, arg_3_1, arg_3_2)
	if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
		var_0_2:onRichManEventProcess(arg_3_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_EVENTPROCESS, false, arg_3_1, arg_3_2)
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RICHMAN_EVENTPROCESS_FAILED, false, arg_3_1, arg_3_2)
	end
end

function var_0_1.on_S2C_RichMan_ChallengeMonsterFinish(arg_4_0, arg_4_1, arg_4_2)
	if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
		if arg_4_2.is_win then
			var_0_2:delEvent(arg_4_2.event.unique_id)
			var_0_2:addMapExp(arg_4_2.exp)
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_CHALLENGEMONSTERFINISH, false, arg_4_1, arg_4_2)
	end
end

function var_0_1.on_S2C_RichMan_MapUpLevel(arg_5_0, arg_5_1, arg_5_2)
	if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
		var_0_2:onRichManMapUpLevel(arg_5_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_MAPUPLEVEL, false, arg_5_1, arg_5_2)
	end
end

function var_0_1.on_S2C_RichMan_MatchPasser(arg_6_0, arg_6_1, arg_6_2)
	if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
		var_0_2:cacheMatchPasser(arg_6_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_MATCHPASSER, false, arg_6_1, arg_6_2)
	end
end

function var_0_1.on_S2C_RichMan_EnemyList(arg_7_0, arg_7_1, arg_7_2)
	if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
		var_0_2:cacheEnemyList(arg_7_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_ENEMYLIST, false, arg_7_1, arg_7_2)
	end
end

function var_0_1.on_S2C_RichMan_RobData(arg_8_0, arg_8_1, arg_8_2)
	if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
		var_0_2:onRichManRobData(arg_8_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_ROBDATA, false, arg_8_1, arg_8_2)
	end
end

function var_0_1.on_S2C_RichMan_RobBegin(arg_9_0, arg_9_1, arg_9_2)
	if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_ROBBEGIN, false, arg_9_1, arg_9_2)
	end
end

function var_0_1.on_S2C_RichMan_RobFinish(arg_10_0, arg_10_1, arg_10_2)
	if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_ROBFINISH, false, arg_10_1, arg_10_2)
	end
end

function var_0_1.on_S2C_RichMan_RobAward(arg_11_0, arg_11_1, arg_11_2)
	if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
		var_0_2:onRichManAwardRob(arg_11_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_ROBAWARD, false, arg_11_1, arg_11_2)
	end
end

function var_0_1.on_S2C_RichMan_ConstructAward(arg_12_0, arg_12_1, arg_12_2)
	if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
		var_0_2:onRichManAwardBuild(arg_12_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_CONSTRUCTAWARD, false, arg_12_1, arg_12_2)
	end
end

function var_0_1.on_S2C_RichMan_TaskAward(arg_13_0, arg_13_1, arg_13_2)
	if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
		var_0_2:onRichManAwardTask(arg_13_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_TASKAWARD, false, arg_13_1, arg_13_2)
	end
end

function var_0_1.on_S2C_RichMan_GetLog(arg_14_0, arg_14_1, arg_14_2)
	if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
		var_0_2:onCacheLogContent(arg_14_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_GETLOG, false, arg_14_1, arg_14_2)
	end
end

function var_0_1.on_S2C_RichMan_GetConstruct(arg_15_0, arg_15_1, arg_15_2)
	if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
		var_0_2:updateConstruct(arg_15_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_GETCONSTRUCT, false, arg_15_1, arg_15_2)
	end
end

return var_0_1
