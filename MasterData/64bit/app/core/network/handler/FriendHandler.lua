local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Friend_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.friendData:updateFriendsInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Friend_FriendList = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.friendData:updateFriendsList(1, arg_2_2)
			g.core.model.User.playerData:updateRandomList(2, arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_FRIENDLIST, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Friend_BlackList = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.friendData:updateFriendsList(2, arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_BLACKLIST, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Friend_RequestList = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.friendData:updateFriendsList(3, arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_REQUESTLIST, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Friend_AddFriend = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_ADDFRIEND, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Friend_DelFriend = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.friendData:onDelFriendSuc(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_DELFRIEND, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Friend_AddBlackList = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.friendData:onAddBlackSuc(arg_7_2)
			g.core.model.User.chatData:clearChatById(arg_7_2.id, g.core.const.ConstMgr.ChatConst.ALL)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CLEAR_SOMEONE_CHAT)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_ADDBLACKLIST, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Friend_DelBlackList = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.friendData:onDelBlackSuc(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_DELBLACKLIST, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Friend_ConfirmFriend = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) or arg_9_2.ret == g.core.network.proto.RET_TARGET_FRIEND_FULL then
			g.core.model.User.friendData:updateConfirmList(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_CONFIRMFRIEND, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Friend_SendGift = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.model.User.friendData:onSendGiftSuc(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_SENDGIFT, false, arg_10_1, arg_10_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.SPIRIT_HELP_NET_ERROR, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_Friend_ReceiveGift = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			g.core.model.User.friendData:onReceiveGiftSuc(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_RECEIVEGIFT, false, arg_11_1, arg_11_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.SPIRIT_HELP_NET_ERROR, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_Friend_GetRecommendList = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			g.core.model.User.friendData:updateFriendsList(5, arg_12_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_GETRECOMMENDLIST, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_Friend_NotifyAddFriendRequest = function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_2.id then
			g.core.model.User.friendData:onNotifyAddFriendRequest(arg_13_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYADDFRIENDREQUEST, false, arg_13_1, arg_13_2)
		end
	end,
	on_S2C_Friend_NotifyAddFriend = function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_2.id then
			g.core.model.User.friendData:onNotifyAddFriend(arg_14_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYADDFRIEND, false, arg_14_1, arg_14_2)
		end
	end,
	on_S2C_Friend_NotifyDelFriend = function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_2.id then
			g.core.model.User.friendData:onNotifyDelFriend(arg_15_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYDELFRIEND, false, arg_15_1, arg_15_2)
		end
	end,
	on_S2C_Friend_NotifyTask = function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_2.id then
			g.core.model.User.friendData:onNotifyTask(arg_16_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYTASK, false, arg_16_1, arg_16_2)
		end
	end,
	on_S2C_Friend_NotifyTask_All = function(arg_17_0, arg_17_1, arg_17_2)
		g.core.model.User.friendData:onNotifyTaskAll(arg_17_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYTASK, false, arg_17_1, arg_17_2)
	end,
	on_S2C_Friend_NotifyGift = function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_2.id then
			g.core.model.User.friendData:onNotifyGift(arg_18_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYGIFT, false, arg_18_1, arg_18_2)
		end
	end,
	on_S2C_Friend_GetSnapshot = function(arg_19_0, arg_19_1, arg_19_2)
		if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_GETSNAPSHOT, false, arg_19_1, (g.core.model.User.friendData:processingDatasToStructs(arg_19_2.users)))
		end
	end,
	on_S2C_Friend_Duel = function(arg_20_0, arg_20_1, arg_20_2)
		if ProtoHandler:onMsgProcess(arg_20_1, arg_20_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_DUEL, false, arg_20_1, arg_20_2)
		end
	end,
	on_S2C_Friend_RequestCondList = function(arg_21_0, arg_21_1, arg_21_2)
		if ProtoHandler:onMsgProcess(arg_21_1, arg_21_2) then
			g.core.model.User.friendData:updateApplyCondList(arg_21_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_REQUESTCONDLIST, false, arg_21_1, arg_21_2)
		end
	end,
	on_S2C_Friend_SetRequestCond = function(arg_22_0, arg_22_1, arg_22_2)
		if ProtoHandler:onMsgProcess(arg_22_1, arg_22_2) then
			g.core.model.User.friendData:updateApplyCondList(arg_22_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRIEND_SETREQUESTCOND, false, arg_22_1, arg_22_2)
		end
	end
}
