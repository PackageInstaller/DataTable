local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Guild_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			if not arg_1_2.guild_id or arg_1_2.guild_id == 0 then
				g.core.model.User:setGuildName(arg_1_2)
				g.core.model.User.guildData:updateGuildInfo(arg_1_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Guild_Create = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.guildData:updateGuildData(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_CREATE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Guild_ReqJoin = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.guildWarData:onS2CGuildNotifyJoin()
			g.core.model.User.guildData:updateGuildReqJoin(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_REQJOIN, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Guild_Confirm = function(arg_4_0, arg_4_1, arg_4_2)
		ProtoHandler:onMsgProcess(arg_4_1, arg_4_2)
		g.core.model.User.guildData:updateMemberByReview(arg_4_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_CONFIRM, false, arg_4_1, arg_4_2)
	end,
	on_S2C_Guild_KickOut = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.guildData:updateMemberByKickOut(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_KICKOUT, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Guild_Quit = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.guildData:updateGuildQuit()
			g.core.model.User.chatData:clearChatByChannel(g.core.const.ConstMgr.ChatConst.ARMY)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_QUIT, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Guild_Dismiss = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.guildData:updateGuildQuit()
			g.core.model.User.chatData:clearChatByChannel(g.core.const.ConstMgr.ChatConst.ARMY)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DISMISS, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Guild_Appoint = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.guildData:updateAppoint(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_APPOINT, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Guild_Impeach = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_IMPEACH, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Guild_GetHistory = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.model.User.guildData:updateGuildLog(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_GETHISTORY, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_Guild_ModifyInfo = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			g.core.model.User.guildData:updateGuildModify(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_MODIFYINFO, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_Guild_GetMessageBoard = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			g.core.model.User.guildData:updateGuildMessage(arg_12_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_GETMESSAGEBOARD, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_Guild_LeaveAMessage = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			g.core.model.User.guildData:updateMsg(arg_13_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_LEAVEAMESSAGE, false, arg_13_1, arg_13_2)
		end
	end,
	on_S2C_Guild_OperateMessage = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_OPERATEMESSAGE, false, arg_14_1, arg_14_2)
		end
	end,
	on_S2C_Guild_Recommend = function(arg_15_0, arg_15_1, arg_15_2)
		g.core.model.User.guildData:updateRecommendGuild(arg_15_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_RECOMMEND, false, arg_15_1, arg_15_2)
	end,
	on_S2C_Guild_Search = function(arg_16_0, arg_16_1, arg_16_2)
		if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
			g.core.model.User.guildData:updateSearchList(arg_16_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_SEARCH, false, arg_16_1, arg_16_2)
		end
	end,
	on_S2C_Guild_GetApplyList = function(arg_17_0, arg_17_1, arg_17_2)
		if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
			g.core.model.User.guildData:updateApplyData(arg_17_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_GETAPPLYLIST, false, arg_17_1, arg_17_2)
		end
	end,
	on_S2C_Guild_GetApplyHistory = function(arg_18_0, arg_18_1, arg_18_2)
		if ProtoHandler:onMsgProcess(arg_18_1, arg_18_2) then
			g.core.model.User.guildData:updateApplyHistory(arg_18_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_GETAPPLYHISTORY, false, arg_18_1, arg_18_2)
		end
	end,
	on_S2C_Guild_GetWorshipInfo = function(arg_19_0, arg_19_1, arg_19_2)
		if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
			g.core.model.User.guildData:updateWorshipData(arg_19_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_GETWORSHIPINFO, false, arg_19_1, arg_19_2)
		end
	end,
	on_S2C_Guild_DoWorship = function(arg_20_0, arg_20_1, arg_20_2)
		if ProtoHandler:onMsgProcess(arg_20_1, arg_20_2) then
			g.core.model.User.guildData:updateWorshipProg(arg_20_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DOWORSHIP, false, arg_20_1, arg_20_2)
		end
	end,
	on_S2C_Guild_GetWorshipAward = function(arg_21_0, arg_21_1, arg_21_2)
		if ProtoHandler:onMsgProcess(arg_21_1, arg_21_2) then
			g.core.model.User.guildData:updateWorshipAwardId(arg_21_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_GETWORSHIPAWARD, false, arg_21_1, arg_21_2)
		end
	end,
	on_S2C_Guild_DeleteApply = function(arg_22_0, arg_22_1, arg_22_2)
		if ProtoHandler:onMsgProcess(arg_22_1, arg_22_2) then
			g.core.model.User.guildData:updateDeleteApply(arg_22_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_DELETEAPPLY, false, arg_22_1, arg_22_2)
		end
	end,
	on_S2C_Guild_NotifyJoin = function(arg_23_0, arg_23_1, arg_23_2)
		g.core.platform.PlatformProxy:sendAdvFirstGuildJoin()
		g.core.model.User.guildData:onRcvNotifyJoin(nil, nil, arg_23_2)
		g.core.model.User.guildWarData:onS2CGuildNotifyJoin()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_NOTIFYJOIN, false, arg_23_1, arg_23_2)
	end,
	on_S2C_Guild_NotifyLeave = function(arg_24_0, arg_24_1, arg_24_2)
		if arg_24_2.type == 4 then
			g.core.model.User.guildData:setHasGuild(true)
			g.core.model.User.guildData:onRcvNotifyMerge()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_NOTIFYLEAVE, false, arg_24_1, arg_24_2)
		else
			g.core.model.User.guildData:setHasGuild(false)
			g.core.model.User.guildData:onRcvNotifyLeave()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_NOTIFYLEAVE, false, arg_24_1, arg_24_2)
			g.core.model.User.allianceData:onS2CNoticeState({
				state = 0
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_NOTICESTATE, false, arg_24_1, arg_24_2)
		end
	end,
	on_S2C_Guild_FastJoin = function(arg_25_0, arg_25_1, arg_25_2)
		if ProtoHandler:onMsgProcess(arg_25_1, arg_25_2) then
			g.core.model.User.guildData:updateGuildData(arg_25_2)
			g.core.model.User.guildWarData:onS2CGuildFastJoin()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_FASTJOIN, false, arg_25_1, arg_25_2)
		end
	end,
	on_S2C_Guild_RedPacket_Info = function(arg_26_0, arg_26_1, arg_26_2)
		if ProtoHandler:onMsgProcess(arg_26_1, arg_26_2) then
			g.core.model.User.redPacketData:updateInfo(arg_26_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_INFO, false, arg_26_1, arg_26_2)
		end
	end,
	on_S2C_Guild_RedPacket_Detail = function(arg_27_0, arg_27_1, arg_27_2)
		if ProtoHandler:onMsgProcess(arg_27_1, arg_27_2) then
			g.core.model.User.redPacketData:updatePacketDetail(arg_27_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_DETAIL, false, arg_27_1, arg_27_2)
		end
	end,
	on_S2C_Guild_RedPacket_Pick = function(arg_28_0, arg_28_1, arg_28_2)
		if ProtoHandler:onMsgProcess(arg_28_1, arg_28_2) then
			g.core.model.User.redPacketData:onPickSuc(arg_28_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_PICK, false, arg_28_1, arg_28_2)
		end
	end,
	on_S2C_Guild_RedPacket_Use = function(arg_29_0, arg_29_1, arg_29_2)
		if ProtoHandler:onMsgProcess(arg_29_1, arg_29_2) then
			g.core.model.User.redPacketData:onUseRedPacket(arg_29_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_USE, false, arg_29_1, arg_29_2)
		end
	end,
	on_S2C_Guild_RedPacket_Pick_OneKey = function(arg_30_0, arg_30_1, arg_30_2)
		if ProtoHandler:onMsgProcess(arg_30_1, arg_30_2) then
			g.core.model.User.redPacketData:onFlushRedPacket(arg_30_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_PICK_ONEKEY, false, arg_30_1, arg_30_2)
		end
	end,
	on_S2C_Guild_RedPacket_Flush = function(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_2.rp then
			g.core.model.User.redPacketData:onFlushRedPacket(arg_31_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_FLUSH, false, arg_31_1, arg_31_2)
		end
	end,
	on_S2C_Guild_SendGift = function(arg_32_0, arg_32_1, arg_32_2)
		if ProtoHandler:onMsgProcess(arg_32_1, arg_32_2) then
			g.core.model.User.guildData:updateSendCount(arg_32_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_SENDGIFT, false, arg_32_1, arg_32_2)
		end
	end,
	on_S2C_Guild_OneKeySendGift = function(arg_33_0, arg_33_1, arg_33_2)
		if ProtoHandler:onMsgProcess(arg_33_1, arg_33_2) then
			g.core.model.User.guildData:updateSendCount(arg_33_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_ONEKEYSENDGIFT, false, arg_33_1, arg_33_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.SPIRIT_HELP_NET_ERROR, false, arg_33_1, arg_33_2)
		end
	end,
	on_S2C_Guild_Merge_Request = function(arg_34_0, arg_34_1, arg_34_2)
		if ProtoHandler:onMsgProcess(arg_34_1, arg_34_2) then
			g.core.model.User.guildData:onS2CRequest(arg_34_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_MERGE_REQUEST, false, arg_34_1, arg_34_2)
		end
	end,
	on_S2C_Guild_Merge_Agree = function(arg_35_0, arg_35_1, arg_35_2)
		if ProtoHandler:onMsgProcess(arg_35_1, arg_35_2) then
			g.core.model.User.guildData:onS2CAgree(arg_35_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_MERGE_AGREE, false, arg_35_1, arg_35_2)
		end
	end,
	on_S2C_Guild_Merge_Notify = function(arg_36_0, arg_36_1, arg_36_2)
		if ProtoHandler:onMsgProcess(arg_36_1, arg_36_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_MERGE_NOTIFY, false, arg_36_1, arg_36_2)
		end
	end,
	on_S2C_Guild_Merge_Cancel = function(arg_37_0, arg_37_1, arg_37_2)
		if ProtoHandler:onMsgProcess(arg_37_1, arg_37_2) then
			g.core.model.User.guildData:onS2CCancel(arg_37_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GUILD_MERGE_CANCEL, false, arg_37_1, arg_37_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.GUILD_MERGE_REQUEST_ERROR, false, arg_37_1, arg_37_2)
		end
	end
}
