local ProtoHandler = import(".ProtoHandler")
local var_0_1 = {}
local var_0_2 = g.core.model.User.teamPvpData

function var_0_1.on_S2C_GroupBattle_Enter(arg_1_0, arg_1_1, arg_1_2)
	if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
		var_0_2:onS2CGroupBattleEnter(arg_1_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_ENTER, false, arg_1_1, arg_1_2)
	end
end

function var_0_1.on_S2C_GroupBattle_CreateRoom(arg_2_0, arg_2_1, arg_2_2)
	if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
		var_0_2:onS2CGroupBattleCreateRoom(arg_2_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_CREATEROOM, false, arg_2_1, arg_2_2)
	end
end

function var_0_1.on_S2C_GroupBattle_QuickJoin(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2.ret == 1 then
		var_0_2:onS2CGroupBattleQuickJoin(arg_3_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_QUICKJOIN, false, arg_3_1, arg_3_2)
	end
end

function var_0_1.on_S2C_GroupBattle_Invite(arg_4_0, arg_4_1, arg_4_2)
	if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
		var_0_2:onS2CGroupBattleInvite(arg_4_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_INVITE, false, arg_4_1, arg_4_2)
	end
end

function var_0_1.on_S2C_GroupBattle_ConfirmInvite(arg_5_0, arg_5_1, arg_5_2)
	ProtoHandler:onMsgProcess(arg_5_1, arg_5_2)
	var_0_2:confirmInvited(arg_5_2.room_id)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_CONFIRMINVITE, false, arg_5_1, arg_5_2)
end

function var_0_1.on_S2C_GroupBattle_QuitRoom(arg_6_0, arg_6_1, arg_6_2)
	ProtoHandler:onMsgProcess(arg_6_1, arg_6_2)
	var_0_2:onS2CGroupBattleQuitRoom(arg_6_2)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_QUITROOM, false, arg_6_1, arg_6_2)
end

function var_0_1.on_S2C_GroupBattle_Kick(arg_7_0, arg_7_1, arg_7_2)
	if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_KICK, false, arg_7_1, arg_7_2)
	end
end

function var_0_1.on_S2C_GroupBattle_Ready(arg_8_0, arg_8_1, arg_8_2)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_READY, false, arg_8_1, arg_8_2)
end

function var_0_1.on_S2C_GroupBattle_Setting(arg_9_0, arg_9_1, arg_9_2)
	if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_SETTING, false, arg_9_1, arg_9_2)
	end
end

function var_0_1.on_S2C_GroupBattle_LineUp(arg_10_0, arg_10_1, arg_10_2)
	if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_LINEUP, false, arg_10_1, arg_10_2)
	end
end

function var_0_1.on_S2C_GroupBattle_Match(arg_11_0, arg_11_1, arg_11_2)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_MATCH, false, arg_11_1, arg_11_2)
end

function var_0_1.on_S2C_GroupBattle_NotifyRoomChange(arg_12_0, arg_12_1, arg_12_2)
	if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
		var_0_2:onS2CGroupBattleNotifyRoomChange(arg_12_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYROOMCHANGE, false, arg_12_1, arg_12_2)
	end
end

function var_0_1.on_S2C_GroupBattle_NotifyMatch(arg_13_0, arg_13_1, arg_13_2)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYMATCH, false, arg_13_1, arg_13_2)
end

function var_0_1.on_S2C_GroupBattle_NotifyMatchFinish(arg_14_0, arg_14_1, arg_14_2)
	if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
		var_0_2:setEnemyTeamInfo(arg_14_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYMATCHFINISH, false, arg_14_1, arg_14_2)
	end
end

function var_0_1.on_S2C_GroupBattle_NotifyBeKick(arg_15_0, arg_15_1, arg_15_2)
	var_0_2:leaveTeam()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYBEKICK, false, arg_15_1, arg_15_2)
end

function var_0_1.on_S2C_GroupBattle_NotifyLineUp(arg_16_0, arg_16_1, arg_16_2)
	return
end

function var_0_1.on_S2C_GroupBattle_NotifyInvite(arg_17_0, arg_17_1, arg_17_2)
	var_0_2:addReceivedInvited(arg_17_2.invitaion)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYINVITE, false, arg_17_1, arg_17_2)
end

function var_0_1.on_S2C_GroupBattle_InviteRobot(arg_18_0, arg_18_1, arg_18_2)
	if ProtoHandler:onMsgProcess(arg_18_1, arg_18_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_INVITEROBOT, false, arg_18_1, arg_18_2)
	end
end

function var_0_1.on_S2C_GroupBattle_InviteeList(arg_19_0, arg_19_1, arg_19_2)
	if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
		var_0_2:onS2CGroupBattleInviteeList(arg_19_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_INVITEELIST, false, arg_19_1, arg_19_2)
	end
end

function var_0_1.on_S2C_GroupBattle_GetInvitation(arg_20_0, arg_20_1, arg_20_2)
	if ProtoHandler:onMsgProcess(arg_20_1, arg_20_2) then
		var_0_2:onS2CGetInvited(arg_20_2.invitation)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_GETINVITATION, false, arg_20_1, arg_20_2)
	end
end

function var_0_1.on_S2C_GroupBattle_JoinRoom(arg_21_0, arg_21_1, arg_21_2)
	if ProtoHandler:onMsgProcess(arg_21_1, arg_21_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_JOINROOM, false, arg_21_1, arg_21_2)
	end
end

function var_0_1.on_S2C_GroupBattle_NotifyFightReport(arg_22_0, arg_22_1, arg_22_2)
	if ProtoHandler:onMsgProcess(arg_22_1, arg_22_2) then
		var_0_2:receiveBattleReport(arg_22_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYFIGHTREPORT, false, arg_22_1, arg_22_2)
	end
end

function var_0_1.on_S2C_GroupBattle_QueryRoom(arg_23_0, arg_23_1, arg_23_2)
	if ProtoHandler:onMsgProcess(arg_23_1, arg_23_2) then
		if arg_23_2 and arg_23_2.room then
			var_0_2:updateTeamInfo(arg_23_2)
		else
			var_0_2:leaveTeam()
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_QUERYROOM, false, arg_23_1, arg_23_2)
	end
end

function var_0_1.on_S2C_GroupBattle_NotifyDisbandRoom(arg_24_0, arg_24_1, arg_24_2)
	if ProtoHandler:onMsgProcess(arg_24_1, arg_24_2) then
		var_0_2:leaveTeam()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYDISBANDROOM, false, arg_24_1, arg_24_2)
	end
end

function var_0_1.on_S2C_GroupBattle_NotifyMapChange(arg_25_0, arg_25_1, arg_25_2)
	if ProtoHandler:onMsgProcess(arg_25_1, arg_25_2) then
		var_0_2:onS2CNotifyMapChange(arg_25_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYMAPCHANGE, false, arg_25_1, arg_25_2)
	end
end

function var_0_1.on_S2C_GroupBattle_RefreshBattleUser(arg_26_0, arg_26_1, arg_26_2)
	if ProtoHandler:onMsgProcess(arg_26_1, arg_26_2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_REFRESHBATTLEUSER, false, arg_26_1, arg_26_2)
	end
end

function var_0_1.on_S2C_GroupBattle_NoticeActivity(arg_27_0, arg_27_1, arg_27_2)
	if ProtoHandler:onMsgProcess(arg_27_1, arg_27_2) then
		var_0_2:onS2CActivityInfo(arg_27_2)
	end
end

function var_0_1.on_S2C_GroupBattle_TaskAward(arg_28_0, arg_28_1, arg_28_2)
	if ProtoHandler:onMsgProcess(arg_28_1, arg_28_2) then
		var_0_2:onS2CGroupBattleTaskAward(arg_28_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_TASKAWARD, false, arg_28_1, arg_28_2)
	end
end

return var_0_1
