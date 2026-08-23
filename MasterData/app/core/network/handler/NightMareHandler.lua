local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_SpaceTimeDungeon_Enter = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.nightMareData:setDungeonProgress(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPACE_TIME_DUNGEON_ENTER, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_SpaceTimeDungeon_EnterChapter = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.nightMareData:updateEnterChapterData(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPACE_TIME_DUNGEON_ENTERCHAPTER, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_SpaceTimeDungeon_ResetChapter = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.nightMareData:reset()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPACE_TIME_DUNGEON_RESETCHAPTER, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_SpaceTimeDungeon_Move = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPACE_TIME_DUNGEON_MOVE, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_SpaceTimeDungeon_BattleStart = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPACE_TIME_DUNGEON_BATTLESTART, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_SpaceTimeDungeon_BoxAward = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPACE_TIME_DUNGEON_BOXAWARD, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_SpaceTimeDungeon_RestoreHp = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.nightMareData:updateHpList(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPACE_TIME_DUNGEON_RESTOREHP, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_SpaceTimeDungeon_Revive = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.nightMareData:updateHpList(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPACE_TIME_DUNGEON_REVIVE, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_SpaceTimeDungeon_ItemList = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.model.User.nightMareData:setSpaceTimeId(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPACE_TIME_DUNGEON_ITEMLIST, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_SpaceTimeDungeon_SelectItem = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPACE_TIME_DUNGEON_SELECTITEM, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_SpaceTimeDungeon_BattleFinish = function(arg_11_0, arg_11_1, arg_11_2)
		g.core.model.User.nightMareData:addNeedDealBattleData(arg_11_2)
		g.core.model.User.nightMareData:updateMonsterHp(arg_11_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPACE_TIME_DUNGEON_BATTLEFINISH, false, arg_11_1, arg_11_2)
	end,
	on_S2C_SpaceTimeDungeon_TriggerGear = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPACE_TIME_DUNGEON_TRIGGERGEAR, false, arg_12_1, arg_12_2)
		end
	end
}
