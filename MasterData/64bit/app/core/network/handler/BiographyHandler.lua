local ProtoHandler = import(".ProtoHandler")
local var_0_1 = {
	on_S2C_Biography_GetMainInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.bioData:updateMainInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_GETMAININFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Biography_ExecuteMission = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.bioData:updateMissionInfo(arg_2_2.mission, true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_EXECUTEMISSION, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Biography_ExecuteMissionBattle = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.bioData:updateMissionInfo(arg_3_2.mission, true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_EXECUTEMISSIONBATTLE, false, arg_3_1, arg_3_2)
		elseif g.core.battle.BattleProxy:isInBattle() then
			g.core.battle.BattleProxy:exitBattle()
		end
	end,
	on_S2C_Biography_FastExecuteMission = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.bioData:updateMissionInfo(arg_4_2.mission)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_FASTEXECUTEMISSION, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Biography_GetMissionAward = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.bioData:gotProgressAward(arg_5_2.id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_GETMISSIONAWARD, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Biography_ResetMissionCount = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.bioData:updateMissionInfo(arg_6_2.mission)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_RESETMISSIONCOUNT, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Biography_GetChapterAward = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.bioData:gotChapterAward(arg_7_2.id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_GETCHAPTERAWARD, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Biography_GetTeamList = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.bioData:updateJoinTeamData(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_GETTEAMLIST, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Biography_CreateTeam = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_CREATETEAM, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Biography_JoinTeam = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_JOINTEAM, false, arg_10_1, arg_10_2)
		end
	end
}

function var_0_1.on_S2C_Biography_KickOutTeam(arg_11_0, arg_11_1, arg_11_2)
	if var_0_1:_onBioMsgProcess(arg_11_1, arg_11_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_KICKOUTTEAM, false, arg_11_1, arg_11_2)
	end
end

function var_0_1.on_S2C_Biography_LeaveTeam(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2.ret == g.core.network.proto.RET_OK then
		g.core.model.User.bioData:updateTeamInfo({
			id = 0
		})
	end

	if var_0_1:_onBioMsgProcess(arg_12_1, arg_12_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_LEAVETEAM, false, arg_12_1, arg_12_2)
	end
end

function var_0_1.on_S2C_Biography_PrepareBattle(arg_13_0, arg_13_1, arg_13_2)
	if var_0_1:_onBioMsgProcess(arg_13_1, arg_13_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_PREPAREBATTLE, false, arg_13_1, arg_13_2)
	end
end

function var_0_1.on_S2C_Biography_SyncTeamStatus(arg_14_0, arg_14_1, arg_14_2)
	if var_0_1:_onBioMsgProcess(arg_14_1, arg_14_2) then
		g.core.model.User.bioData:updateTeamInfo(arg_14_2.team)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_SYNCTEAMSTATUS, false, arg_14_1, arg_14_2)
	end
end

function var_0_1.on_S2C_Biography_AttackCampaignBegin(arg_15_0, arg_15_1, arg_15_2)
	if var_0_1:_onBioMsgProcess(arg_15_1, arg_15_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_ATTACKCAMPAIGNBEGIN, false, arg_15_1, arg_15_2)
	end
end

function var_0_1.on_S2C_Biography_AttackCampaignFinish(arg_16_0, arg_16_1, arg_16_2)
	if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
		g.core.model.User.bioData:updateCampainFinish(arg_16_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_ATTACKCAMPAIGNFINISH, false, arg_16_1, arg_16_2)
	end
end

function var_0_1.on_S2C_Biography_GetCampaignFirstAward(arg_17_0, arg_17_1, arg_17_2)
	if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
		g.core.model.User.bioData:updateCampainInfos(arg_17_2.campaigns)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_GETCAMPAIGNFIRSTAWARD, false, arg_17_1, arg_17_2)
	end
end

function var_0_1.on_S2C_Biography_MoveMember(arg_18_0, arg_18_1, arg_18_2)
	if var_0_1:_onBioMsgProcess(arg_18_1, arg_18_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_MOVEMEMBER, false, arg_18_1, arg_18_2)
	end
end

function var_0_1.on_S2C_Biography_GetInviteeList(arg_19_0, arg_19_1, arg_19_2)
	if var_0_1:_onBioMsgProcess(arg_19_1, arg_19_2) then
		g.core.model.User.bioData:setInviteTeamData(arg_19_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_GETINVITEELIST, false, arg_19_1, arg_19_2)
	end
end

function var_0_1.on_S2C_Biography_InviteRobot(arg_20_0, arg_20_1, arg_20_2)
	if var_0_1:_onBioMsgProcess(arg_20_1, arg_20_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_INVITEROBOT, false, arg_20_1, arg_20_2)
	end
end

function var_0_1.on_S2C_Biography_InvitePlayer(arg_21_0, arg_21_1, arg_21_2)
	if var_0_1:_onBioMsgProcess(arg_21_1, arg_21_2) then
		g.core.model.User.bioData:onInviteFriend(arg_21_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_INVITEPLAYER, false, arg_21_1, arg_21_2)
	end
end

function var_0_1.on_S2C_Biography_GetInvitation(arg_22_0, arg_22_1, arg_22_2)
	if ProtoHandler:onMsgProcess(arg_22_1, arg_22_2) then
		g.core.model.User.bioData:updateInvited(arg_22_2.invitations)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_GETINVITATION, false, arg_22_1, arg_22_2)
	end
end

function var_0_1.on_S2C_Biography_ConfirmInvite(arg_23_0, arg_23_1, arg_23_2)
	if ProtoHandler:onMsgProcess(arg_23_1, arg_23_2) then
		g.core.model.User.bioData:confirmInvited(arg_23_2.team_id)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_CONFIRMINVITE, false, arg_23_1, arg_23_2)
	end
end

function var_0_1.on_S2C_Biography_ShieldInvite(arg_24_0, arg_24_1, arg_24_2)
	if ProtoHandler:onMsgProcess(arg_24_1, arg_24_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_SHIELDINVITE, false, arg_24_1, arg_24_2)
	end
end

function var_0_1.on_S2C_Biography_SetTeamLock(arg_25_0, arg_25_1, arg_25_2)
	if ProtoHandler:onMsgProcess(arg_25_1, arg_25_2) then
		-- block empty
	end
end

function var_0_1.on_S2C_Biography_NotifyInvitee(arg_26_0, arg_26_1, arg_26_2)
	g.core.model.User.bioData:addInvited(arg_26_2.invitation)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_NOTIFYINVITEE, false, arg_26_1, arg_26_2.invitation)
end

function var_0_1.on_S2C_Biography_NotifyDismiss(arg_27_0, arg_27_1, arg_27_2)
	g.core.model.User.bioData:delInvited(arg_27_2.team_id)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_NOTIFYDISMISS, false, arg_27_1, arg_27_2)
end

function var_0_1.on_S2C_Biography_Boss_Info(arg_28_0, arg_28_1, arg_28_2)
	if ProtoHandler:onMsgProcess(arg_28_1, arg_28_2) then
		g.core.model.User.bioData:updateBossInfo(arg_28_2.boss, arg_28_2.damage, false)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_BOSS_INFO, false, arg_28_1, arg_28_2)
	end
end

function var_0_1.on_S2C_Biography_Boss_ChallengeBegin(arg_29_0, arg_29_1, arg_29_2)
	if ProtoHandler:onMsgProcess(arg_29_1, arg_29_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_BOSS_CHALLENGEBEGIN, false, arg_29_1, arg_29_2)
	end
end

function var_0_1.on_S2C_Biography_Boss_ChallengeFinish(arg_30_0, arg_30_1, arg_30_2)
	if ProtoHandler:onMsgProcess(arg_30_1, arg_30_2) then
		g.core.model.User.bioData:updateBossAwards(arg_30_2.awards, arg_30_2.rare)
		g.core.model.User.bioData:updateBossInfo(arg_30_2.boss, arg_30_2.damage, arg_30_2.is_kill)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_BOSS_CHALLENGEFINISH, false, arg_30_1, arg_30_2)
	end
end

function var_0_1._onBioMsgProcess(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_2.ret == g.core.network.proto.RET_USER_NOT_IN_TEAM then
		g.core.model.User.bioData:updateTeamInfo({
			id = 0
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NOT_EXIST_TEAM, false, arg_31_1, arg_31_2)

		return false
	end

	return ProtoHandler:onMsgProcess(arg_31_1, arg_31_2)
end

function var_0_1.on_S2C_Biography_GetChapterAward_OneKey(arg_32_0, arg_32_1, arg_32_2)
	if ProtoHandler:onMsgProcess(arg_32_1, arg_32_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_GETCHAPTERAWARD_ONEKEY, false, arg_32_1, arg_32_2)
	end
end

return var_0_1
