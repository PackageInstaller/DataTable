local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Mystery_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.mysteryData:onS2CMysteryInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Mystery_Enter = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.mysteryData:onS2CMysteryEnter(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_ENTER, false, arg_2_1, arg_2_2)
		elseif arg_2_2.room_id then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MYSTERY_ENTER_ROOM_FAILED)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MYSTERY_NOT_ENTER)
		end
	end,
	on_S2C_Mystery_GetRoomList = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.mysteryData:onS2CMysteryGetRoomList(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_GETROOMLIST, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Mystery_Exit = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.mysteryData:onS2CMysteryExit()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_EXIT, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Mystery_Move = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_MOVE, false, arg_5_1, arg_5_2)
		elseif arg_5_2 then
			if (arg_5_2.ret or 0) == g.core.network.proto.RET_MYSTERY_NOT_ENTER then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MYSTERY_NOT_ENTER)
			end
		end
	end,
	on_S2C_Mystery_NotifyMove = function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_2 and arg_6_2.user and arg_6_2.user.user_id ~= g.core.model.User:getId() then
			g.core.model.User.mysteryData:onS2CMySteryNotifyMove(arg_6_2.user, true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_NOTIFYMOVE, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Mystery_NotifyAttack = function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_2 and arg_7_2.user then
			if arg_7_2.user.user_id ~= g.core.model.User:getId() or g.core.model.User.mysteryData:isCanFastChallangeFinishChapter(arg_7_2.monster.base_id) then
				g.core.model.User.mysteryData:onS2CMysteryNotifyAttack(arg_7_2)
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_NOTIFYATTACK, false, arg_7_1, arg_7_2)
			end
		end
	end,
	on_S2C_Mystery_NotifyExit = function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_2.uid ~= g.core.model.User:getId() then
			g.core.model.User.mysteryData:removeRoomUser(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_NOTIFYEXIT, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Mystery_Monster_ChallengeBegin = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_MONSTER_CHALLENGEBEGIN, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Mystery_Monster_ChallengeFinish = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.model.User.mysteryData:onS2CMysteryMonsterChallengeFinish(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_MONSTER_CHALLENGEFINISH, false, arg_10_1, arg_10_2)
		elseif arg_10_2 then
			if (arg_10_2.ret or 0) == g.core.network.proto.RET_MYSTERY_NOT_ENTER then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MYSTERY_NOT_ENTER)
			end
		end
	end,
	on_S2C_Mystery_Monster_FastChallenge = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			g.core.model.User.mysteryData:onS2CMysteryMonsterFastChallenge(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_MONSTER_FASTCHALLENGE, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_Mystery_Elite_ChallengeBegin = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			g.core.model.User.mysteryData:s2CMysteryEliteChallengeBegin(arg_12_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_ELITE_CHALLENGEBEGIN, false, arg_12_1, arg_12_2)
		elseif arg_12_2 then
			if (arg_12_2.ret or 0) == g.core.network.proto.RET_MYSTERY_NOT_ENTER then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MYSTERY_NOT_ENTER)
			end
		end
	end,
	on_S2C_Mystery_Elite_ChallengeFinish = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			g.core.model.User.mysteryData:onS2CMysteryEliteChallengeFinish(arg_13_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_ELITE_CHALLENGEFINISH, false, arg_13_1, arg_13_2)
		end
	end,
	on_S2C_Mystery_Story_Finish = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			g.core.model.User.mysteryData:onS2CMysteryStoryFinish(arg_14_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_STORY_FINISH, false, arg_14_1, arg_14_2)
		end
	end,
	on_S2C_Mystery_AcceptTask = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			g.core.model.User.mysteryData:onS2CMysteryAcceptTask(arg_15_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_ACCEPTTASK, false, arg_15_1, arg_15_2)
		end
	end,
	on_S2C_Mystery_GiveUpTask = function(arg_16_0, arg_16_1, arg_16_2)
		if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
			g.core.model.User.mysteryData:onS2CMysteryGiveUpTask()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_GIVEUPTASK, false, arg_16_1, arg_16_2)
		end
	end,
	on_S2C_Mystery_Award = function(arg_17_0, arg_17_1, arg_17_2)
		if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_AWARD, false, arg_17_1, arg_17_2)
		end
	end,
	on_S2C_Mystery_NotifyTask = function(arg_18_0, arg_18_1, arg_18_2)
		if ProtoHandler:onMsgProcess(arg_18_1, arg_18_2) then
			g.core.model.User.mysteryData:onS2CMysteryNotifyTask(arg_18_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_NOTIFYTASK, false, arg_18_1, arg_18_2)
		end
	end,
	on_S2C_Mystery_SendLook = function(arg_19_0, arg_19_1, arg_19_2)
		if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
			g.core.model.User.mysteryData:setLastMysteryChatTime()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_SENDLOOK, false, arg_19_1, arg_19_2)
		end
	end,
	on_S2C_Mystery_NotifyLook = function(arg_20_0, arg_20_1, arg_20_2)
		if ProtoHandler:onMsgProcess(arg_20_1, arg_20_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_NOTIFYLOOK, false, arg_20_1, arg_20_2)
		end
	end
}
