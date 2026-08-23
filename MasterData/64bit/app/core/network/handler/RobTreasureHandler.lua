local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_ContendTreasure_GetList = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CONTEND_TREASURE_GETLIST, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_ContendTreasure_Fast = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CONTEND_TREASURE_FAST, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_ContendTreasure_RobBegin = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CONTEND_TREASURE_ROBBEGIN, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_ContendTreasure_RobFinish = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CONTEND_TREASURE_ROBFINISH, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_ContendTreasure_Info = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CONTEND_TREASURE_INFO, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_ContendTreasure_AvengeBegin = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CONTEND_TREASURE_AVENGEBEGIN, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_ContendTreasure_AvengeFinish = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CONTEND_TREASURE_AVENGEFINISH, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_ContendTreasure_OneKeyFast = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CONTEND_TREASURE_ONEKEYFAST, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_ExploreTreasure_Info = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORE_TREASURE_INFO, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_ExploreTreasure_Event = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORE_TREASURE_EVENT, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_ExploreTreasure_BattleEvent_Begin = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORE_TREASURE_BATTLEEVENT_BEGIN, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_ExploreTreasure_BattleEvent_Finish = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			g.core.model.User.robTreasureData:setBattleData(arg_12_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORE_TREASURE_BATTLEEVENT_FINISH, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_ExploreTreasure_Event_OneKey = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORE_TREASURE_EVENT_ONEKEY, false, arg_13_1, arg_13_2)
		end
	end
}
