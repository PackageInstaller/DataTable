local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Dungeon_GetChapterList = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.dungeonData:initChapterList(arg_1_2)

			if not g.core.model.User.bioData:isInited() and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BIO_MAIN) then
				g.core.network.GameNetProxy:send_C2S_Biography_GetMainInfo({})
			end

			g.core.model.User.recruitData:updateAllPrimaryRoundData()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DUNGEON_GETCHAPTERLIST, false, arg_1_1, arg_1_2)

			if g.core.model.User:getLevel() > 40 and g.core.model.User.dungeonData:getLastPassedChapter() < 3 then
				local var_1_0 = string.format("Error! level: %s,  lastChapter: %s, serverId: %s, userId: %s, msg: %s", tostring(g.core.model.User:getLevel()), tostring(g.core.model.User.dungeonData:getLastPassedChapter()), tostring(g.core.platform.ServerListProxy:getSelectedServer().sid), tostring((g.core.model.User:getId())), (json.encode(arg_1_2)))
			end
		end
	end,
	on_S2C_Dungeon_ChallengeStageBegin = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DUNGEON_CHALLENGESTAGEBEGIN, false, arg_2_1, arg_2_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_DUNGEON_STAGE_TO_BATTLE_FAILED, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Dungeon_ChallengeStageFinish = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.dungeonData:updateStageExecuteResult(arg_3_2)
			g.core.model.User.recruitData:updateAllPrimaryRoundData()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DUNGEON_CHALLENGESTAGEFINISH, false, arg_3_1, arg_3_2)
		else
			g.core.platform.BuglyProxy:error(string.format("Error! S2C_Dungeon_ChallengeStageFinish ret: %s ", tostring(arg_3_2.ret)))
		end
	end,
	on_S2C_Dungeon_ResetChallengeCount = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.dungeonData:updateStageResetResult(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DUNGEON_RESETCHALLENGECOUNT, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Dungeon_GetChapterChestAward = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.dungeonData:updateStarChestResult(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DUNGEON_GETCHAPTERCHESTAWARD, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Dungeon_GetStageRecord = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DUNGEON_GETSTAGERECORD, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Dungeon_FastChallengeStage = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.dungeonData:updateStageCountByBlitz(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DUNGEON_FASTCHALLENGESTAGE, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Dungeon_FinishAchievement = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.dungeonData:updateDungeonAchievement(arg_8_2.flags)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DUNGEON_FINISHACHIEVEMENT, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Dungeon_OneKey_GetChapterChestAward = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.model.User.dungeonData:updateChaptersData(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DUNGEON_ONEKEY_GETCHAPTERCHESTAWARD, false, arg_9_1, arg_9_2)
		end
	end
}
