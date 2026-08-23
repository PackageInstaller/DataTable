local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_AllianceTrial_Enter = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.allianceTrialData:onS2CAllianceTrialEnter(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_ENTER, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_AllianceTrial_Move = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_MOVE, false, arg_2_1, arg_2_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_MOVE_ERROR, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_AllianceTrial_NotifyMove = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.allianceTrialData:onS2CAllianceNotifyMove(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_NOTIFYMOVE, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_AllianceTrial_Exit = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_EXIT, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_AllianceTrial_NotifyExit = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.allianceTrialData:onS2CAllianceNotifyExit(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_NOTIFYEXIT, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_AllianceTrial_ChallengeBegin = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_CHALLENGEBEGIN, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_AllianceTrial_ChallengeFinish = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.allianceTrialData:onS2CAllianceTrialChallenge(arg_7_2)

			if not arg_7_2.is_sweep then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_CHALLENGEFINISH, false, arg_7_1, arg_7_2)
			else
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_CHALLENGEFINISH_SWEEP, false, arg_7_1, arg_7_2)
			end
		elseif g.core.battle.BattleProxy:isInBattle() then
			g.core.battle.BattleProxy:exitBattle()
		end
	end,
	on_S2C_AllianceTrial_GiveInfo = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_GIVEINFO, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_AllianceTrial_Give = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.model.User.allianceTrialData:onS2CAllianceTrialGive(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_GIVE, false, arg_9_1, arg_9_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_GIVE_ERROR, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_AllianceTrial_BoxInfo = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.model.User.allianceTrialData:onS2CAllianceTrialBoxInfo(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_BOXINFO, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_AllianceTrial_BoxAward = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			g.core.model.User.allianceTrialData:onS2CAllianceTrialBoxAward(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_BOXAWARD, false, arg_11_1, arg_11_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_BOXAWARD_ERROR, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_AllianceTrial_RankList = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_RANKLIST, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_AllianceTrial_NotifyLevel = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			g.core.model.User.allianceTrialData:onS2CAllianceTrialNotifyLevel(arg_13_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_NOTIFYLEVEL, false, arg_13_1, arg_13_2)
		end
	end,
	on_S2C_AllianceTrial_UpdateUser = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			g.core.model.User.allianceTrialData:onS2CAllianceTrialUpdateUser(arg_14_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_UPDATEUSER, false, arg_14_1, arg_14_2)
		end
	end,
	on_S2C_AllianceTrial_UpdateMonster = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			g.core.model.User.allianceTrialData:onS2CAllianceTrialUpdateMonster(arg_15_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_UPDATEMONSTER, false, arg_15_1, arg_15_2)
		end
	end,
	on_S2C_AllianceTrial_NotifyChallenge = function(arg_16_0, arg_16_1, arg_16_2)
		if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_NOTIFYCHALLENGE, false, arg_16_1, arg_16_2)
		end
	end
}
