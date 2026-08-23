local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.const.ConstMgr.BaseShowTypeConst

return {
	on_S2C_Treasure_Upgrade = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.formationData:generateNewTreasMasterData()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
				baseShowPop = {
					type = var_0_1.ET_STRENGTH_SUCCESS
				}
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TREASURE_UPGRADE, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Treasure_Upgrade_OneLevel = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.formationData:generateNewTreasMasterData()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
				baseShowPop = {
					type = var_0_1.ET_STRENGTH_SUCCESS
				}
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TREASURE_UPGRADE_ONELEVEL, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Treasure_Refining = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.formationData:generateNewTreasMasterData()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
				baseShowPop = {
					type = var_0_1.ET_REFINE_SUCCESS
				}
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TREASURE_REFINING, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Treasure_Glyph = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TREASURE_GLYPH, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Treasure_Golden = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TREASURE_GOLDEN, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Treasure_Luck = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TREASURE_LUCK, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Treasure_InheritFormation = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.treasureData:onS2CTreasureInheritFormation(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TREASURE_INHERITFORMATION, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Treasure_Purify = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.treasureData:onTreasurePurify(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TREASURE_PURIFY, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Treasure_Purify_Replace = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.model.User.treasureData:onTreasurePurifyReplace(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TREASURE_PURIFY_REPLACE, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Treasure_Purify_Lock = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.model.User.treasureData:onTreasurePurifyLock(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TREASURE_PURIFY_LOCK, false, arg_10_1, arg_10_2)
		end
	end
}
