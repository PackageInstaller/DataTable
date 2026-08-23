local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_GuildAlliance_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.allianceData:onS2CGetInfo(arg_1_2)
			g.core.model.User.allianceTrialData:onS2CAllianceGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_GuildAlliance_ApplyList = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.allianceData:onS2CApplyList(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_APPLYLIST, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_GuildAlliance_InviteList = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.allianceData:onS2CInviteList(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_INVITELIST, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_GuildAlliance_SearchList = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			local var_4_0 = arg_4_2.alliances or {}
			local var_4_1 = {}

			for iter_4_0, iter_4_1 in ipairs(var_4_0) do
				table.insert(var_4_1, iter_4_1.id)
			end

			g.core.model.User.snapShotCacheData:updateSnapShotCache(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, var_4_0, var_4_1)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_SEARCHLIST, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_GuildAlliance_Create = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.allianceData:onS2CCreate(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_CREATE, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_GuildAlliance_Apply = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.allianceData:onS2CApply(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_APPLY, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_GuildAlliance_CancelApply = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.allianceData:onS2CCancelApply(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_CANCELAPPLY, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_GuildAlliance_ApproveApply = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.allianceData:onS2CApproveApply(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_APPROVEAPPLY, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_GuildAlliance_Invite = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.model.User.allianceData:onS2CInvite(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_INVITE, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_GuildAlliance_CancelInvite = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.model.User.allianceData:onS2CCancelInvite(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_CANCELINVITE, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_GuildAlliance_ApproveInvite = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			g.core.model.User.allianceData:onS2CApproveInvite(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_APPROVEINVITE, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_GuildAlliance_Suggest = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			g.core.model.User.allianceData:onS2CSuggest(arg_12_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_SUGGEST, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_GuildAlliance_Quit = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			g.core.model.User.allianceData:onS2CQuit(arg_13_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_QUIT, false, arg_13_1, arg_13_2)
		end
	end,
	on_S2C_GuildAlliance_Kick = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			g.core.model.User.allianceData:onS2CKick(arg_14_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_KICK, false, arg_14_1, arg_14_2)
		end
	end,
	on_S2C_GuildAlliance_KickNotice = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			g.core.model.User.allianceData:onS2CKickNotice(arg_15_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_KICKNOTICE, false, arg_15_1, arg_15_2)
		end
	end,
	on_S2C_GuildAlliance_Dismiss = function(arg_16_0, arg_16_1, arg_16_2)
		if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
			g.core.model.User.allianceData:onS2CDismiss(arg_16_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_DISMISS, false, arg_16_1, arg_16_2)
		end
	end,
	on_S2C_GuildAlliance_Appoint = function(arg_17_0, arg_17_1, arg_17_2)
		if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
			g.core.model.User.allianceData:onS2CAppoint(arg_17_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_APPOINT, false, arg_17_1, arg_17_2)
		end
	end,
	on_S2C_GuildAlliance_Impeach = function(arg_18_0, arg_18_1, arg_18_2)
		if ProtoHandler:onMsgProcess(arg_18_1, arg_18_2) then
			g.core.model.User.allianceData:onS2CImpeach(arg_18_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_IMPEACH, false, arg_18_1, arg_18_2)
		end
	end,
	on_S2C_GuildAlliance_ModifyContent = function(arg_19_0, arg_19_1, arg_19_2)
		if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
			g.core.model.User.allianceData:onS2CModifyContent(arg_19_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_MODIFYCONTENT, false, arg_19_1, arg_19_2)
		end
	end,
	on_S2C_GuildAlliance_ModifySetting = function(arg_20_0, arg_20_1, arg_20_2)
		if ProtoHandler:onMsgProcess(arg_20_1, arg_20_2) then
			g.core.model.User.allianceData:onS2CModifySetting(arg_20_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_MODIFYSETTING, false, arg_20_1, arg_20_2)
		end
	end,
	on_S2C_GuildAlliance_TaskAward = function(arg_21_0, arg_21_1, arg_21_2)
		if ProtoHandler:onMsgProcess(arg_21_1, arg_21_2) then
			g.core.model.User.allianceData:onS2CTaskAward(arg_21_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_TASKAWARD, false, arg_21_1, arg_21_2)
		end
	end,
	on_S2C_GuildAlliance_DismissNotice = function(arg_22_0, arg_22_1, arg_22_2)
		if ProtoHandler:onMsgProcess(arg_22_1, arg_22_2) then
			g.core.model.User.allianceData:onS2CDismissNotice(arg_22_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_DISMISSNOTICE, false, arg_22_1, arg_22_2)
		end
	end,
	on_S2C_GuildAlliance_GetSnapshot = function(arg_23_0, arg_23_1, arg_23_2)
		if ProtoHandler:onMsgProcess(arg_23_1, arg_23_2) then
			g.core.model.User.snapShotCacheData:updateSnapShotCache(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, arg_23_2.snapshots, arg_23_2.alliance_ids)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, false, arg_23_1, arg_23_2)
		end
	end,
	on_S2C_GuildAlliance_NoticeState = function(arg_24_0, arg_24_1, arg_24_2)
		if ProtoHandler:onMsgProcess(arg_24_1, arg_24_2) then
			g.core.model.User.allianceData:onS2CNoticeState(arg_24_2)
			g.core.model.User.newSlgData:checkSendCrossPointMsg()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_NOTICESTATE, false, arg_24_1, arg_24_2)
		end
	end,
	on_S2C_GuildAlliance_GuildList = function(arg_25_0, arg_25_1, arg_25_2)
		if ProtoHandler:onMsgProcess(arg_25_1, arg_25_2) then
			g.core.model.User.allianceData:onS2CGuildList(arg_25_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GUILDLIST, false, arg_25_1, arg_25_2)
		end
	end,
	on_S2C_GuildAlliance_DisplayList = function(arg_26_0, arg_26_1, arg_26_2)
		if ProtoHandler:onMsgProcess(arg_26_1, arg_26_2) then
			g.core.model.User.allianceData:onS2CDisplayUserList(arg_26_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_DISPLAYLIST, false, arg_26_1, arg_26_2)
		end
	end,
	on_S2C_GuildAlliance_BoxInfo = function(arg_27_0, arg_27_1, arg_27_2)
		if ProtoHandler:onMsgProcess(arg_27_1, arg_27_2) then
			g.core.model.User.allianceData:onS2CGetBoxInfo(arg_27_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_BOXINFO, false, arg_27_1, arg_27_2)
		end
	end,
	on_S2C_GuildAlliance_BoxGet = function(arg_28_0, arg_28_1, arg_28_2)
		if ProtoHandler:onMsgProcess(arg_28_1, arg_28_2) then
			g.core.model.User.allianceData:onS2CBoxGet(arg_28_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_BOXGET, false, arg_28_1, arg_28_2)
		end
	end,
	on_S2C_GuildAlliance_BoxOpen = function(arg_29_0, arg_29_1, arg_29_2)
		if ProtoHandler:onMsgProcess(arg_29_1, arg_29_2) then
			g.core.model.User.allianceData:onS2CBoxOpen(arg_29_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_BOXOPEN, false, arg_29_1, arg_29_2)
		end
	end,
	on_S2C_GuildAlliance_BoxNotify = function(arg_30_0, arg_30_1, arg_30_2)
		if ProtoHandler:onMsgProcess(arg_30_1, arg_30_2) then
			g.core.model.User.allianceData:onS2CBoxNotify(arg_30_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_BOXNOTIFY, false, arg_30_1, arg_30_2)
		end
	end,
	on_S2C_GuildAlliance_BoxGrandNotify = function(arg_31_0, arg_31_1, arg_31_2)
		if ProtoHandler:onMsgProcess(arg_31_1, arg_31_2) then
			g.core.model.User.allianceData:onS2CBoxGrandNotify(arg_31_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_BOXGRANDNOTIFY, false, arg_31_1, arg_31_2)
		end
	end,
	on_S2C_GuildAlliance_SendBox = function(arg_32_0, arg_32_1, arg_32_2)
		if ProtoHandler:onMsgProcess(arg_32_1, arg_32_2) then
			g.core.model.User.allianceData:onS2CBoxSendBox(arg_32_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_SENDBOX, false, arg_32_1, arg_32_2)
		end
	end,
	on_S2C_GuildAlliance_ExchangeBoxAward = function(arg_33_0, arg_33_1, arg_33_2)
		if ProtoHandler:onMsgProcess(arg_33_1, arg_33_2) then
			g.core.model.User.allianceData:onS2CBoxExchangeBoxAward(arg_33_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_EXCHANGEBOXAWARD, false, arg_33_1, arg_33_2)
		end
	end,
	on_S2C_GuildAlliance_ServerInfos = function(arg_34_0, arg_34_1, arg_34_2)
		if ProtoHandler:onMsgProcess(arg_34_1, arg_34_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_SERVERINFOS, false, arg_34_1, arg_34_2)
		end
	end,
	on_S2C_GuildAlliance_GetLog = function(arg_35_0, arg_35_1, arg_35_2)
		if ProtoHandler:onMsgProcess(arg_35_1, arg_35_2) then
			g.core.model.User.allianceData:onS2CGuildAllianceGetLog(arg_35_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETLOG, false, arg_35_1, arg_35_2)
		end
	end,
	on_S2C_GuildAlliance_TaskList = function(arg_36_0, arg_36_1, arg_36_2)
		if ProtoHandler:onMsgProcess(arg_36_1, arg_36_2) then
			g.core.model.User.allianceData:onS2CGuildAllianceTaskList(arg_36_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_TASKLIST, false, arg_36_1, arg_36_2)
		end
	end,
	on_S2C_GuildAlliance_UserList = function(arg_37_0, arg_37_1, arg_37_2)
		if ProtoHandler:onMsgProcess(arg_37_1, arg_37_2) then
			g.core.model.User.allianceData:onS2CGuildAllianceUserList(arg_37_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_USERLIST, false, arg_37_1, arg_37_2)
		end
	end,
	on_S2C_GuildAlliance_HonourGetInfo = function(arg_38_0, arg_38_1, arg_38_2)
		if ProtoHandler:onMsgProcess(arg_38_1, arg_38_2) then
			g.core.model.User.allianceData:onS2CHonorGetInfo(arg_38_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_HONOURGETINFO, false, arg_38_1, arg_38_2)
		end
	end,
	on_S2C_GuildAlliance_HonourSendLike = function(arg_39_0, arg_39_1, arg_39_2)
		if ProtoHandler:onMsgProcess(arg_39_1, arg_39_2) then
			g.core.model.User.allianceData:onS2CHonorSendLike(arg_39_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_HONOURSENDLIKE, false, arg_39_1, arg_39_2)
		end
	end
}
