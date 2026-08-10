local var_0_0 = {}

manager.net:Bind(19001, function(arg_1_0)
	local var_1_0 = arg_1_0.friend_list or {}

	if #var_1_0 > 0 then
		FriendsData:RefreshFriendsDataList(var_1_0, FriendsConst.FRIEND_TYPE.MY_FRIENDS)
	end

	local var_1_1 = arg_1_0.request_list or {}

	if #var_1_1 > 0 then
		FriendsData:RefreshFriendsDataList(var_1_1, FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS)
	end

	local var_1_2 = arg_1_0.black_list or {}

	if #var_1_2 > 0 then
		FriendsData:RefreshFriendsDataList(var_1_2, FriendsConst.FRIEND_TYPE.BLACKLIST)
	end

	FriendsAction:OnFriendsDataChange()
	FriendsAction:UpdateFriendsRedTip()
end)
manager.net:Bind(19019, function(arg_2_0)
	FriendsData:RefreshFriendsData(arg_2_0.request, FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS)
	FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS)
	FriendsAction:UpdateFriendsRequestRedTip()
end)
manager.net:Bind(19021, function(arg_3_0)
	FriendsData:RefreshFriendsData(arg_3_0.friend, FriendsConst.FRIEND_TYPE.MY_FRIENDS)
	FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.MY_FRIENDS)
	FriendsAction:UpdateFriendsRedTip()
end)
manager.net:Bind(19023, function(arg_4_0)
	FriendsData:DelectFriendsData(arg_4_0.friend_id)
	FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.MY_FRIENDS)
	FriendsAction:UpdateChatRedTip()
	ChatAction.DeleteFriendChat(arg_4_0.friend_id)
	FriendsAction:OnFriendsDelect(arg_4_0.friend_id)
end)
manager.net:Bind(19027, function(arg_5_0)
	FriendsData:DelectFriendsData(arg_5_0.friend_id)
	FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.MY_FRIENDS)
	FriendsAction:UpdateFriendsRedTip()
	ChatAction.DeleteFriendChat(arg_5_0.friend_id)
	ChatAction.RefreshWorldChatData()
	FriendsAction:OnFriendsDelect(arg_5_0.friend_id)
end)
manager.net:Bind(19029, function(arg_6_0)
	local var_6_0 = arg_6_0.brief_friend_list or {}
	local var_6_1 = arg_6_0.request_list or {}
	local var_6_2 = arg_6_0.black_list or {}

	FriendsData:FriendsDataInit(var_6_0, var_6_1, var_6_2)
	manager.redPoint:setTip(RedPointConst.FRIEND_FRIEND_REQUESTS, #var_6_1)
end)
manager.net:Bind(19033, function(arg_7_0)
	FriendsData:RefreshFriendsData(arg_7_0.recommend, FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
end)

var_0_0.RequestToFriendSrc = {
	MidAutumnActivity = 5,
	MultiPlayerGameRoom = 1,
	MultiPlayerGameResult = 2,
	AddFriend = 0,
	DormInfo = 4,
	PlayerInfo = 3,
	Activity = 6,
	IdolDanceGame = 7
}

function var_0_0.TryToRequestToFriend(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = {
		request_user_id = arg_8_1,
		source = arg_8_2,
		activity_id = arg_8_3 or 0
	}

	manager.net:SendWithLoadingNew(19002, var_8_0, 19003, handler(arg_8_0, arg_8_0.OnTryToRequestToFriend))
end

function var_0_0.OnTryToRequestToFriend(arg_9_0, arg_9_1, arg_9_2)
	if isSuccess(arg_9_1.result) then
		ShowTips("FRIEND_APPLY_SEND")
		FriendsData:RequestToFriend(arg_9_2.request_user_id)
		FriendsData:TryToAddRequest(arg_9_2.request_user_id)
		FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
	else
		ShowTips(arg_9_1.result)
	end
end

function var_0_0.TryToDealRequest(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 == 1 then
		if not FriendsData:IsCanBeFriend(arg_10_1) then
			return
		end
	else
		ShowTips("FRIEND_APPLY_REJECT")
	end

	local var_10_0 = {
		request_user_id = arg_10_1,
		deal = arg_10_2
	}

	manager.net:SendWithLoadingNew(19004, var_10_0, 19005, handler(arg_10_0, arg_10_0.OnTryToDealRequest))
end

function var_0_0.OnTryToDealRequest(arg_11_0, arg_11_1, arg_11_2)
	if isSuccess(arg_11_1.result) then
		FriendsData:DealRequest(arg_11_2.request_user_id, arg_11_2.deal, arg_11_1.friend)

		if arg_11_2.deal == 1 then
			SendMessageManagerToSDK("add_friend")
		end

		FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS)
		FriendsAction:UpdateFriendsRequestRedTip()
	else
		ShowTips(arg_11_1.result)
	end
end

function var_0_0.TryToDelectFromMyFriendsList(arg_12_0, arg_12_1)
	local var_12_0 = {
		friend_id = arg_12_1
	}

	manager.net:SendWithLoadingNew(19006, var_12_0, 19007, handler(arg_12_0, arg_12_0.OnTryToDelectFromMyFriendsList))
end

function var_0_0.OnTryToDelectFromMyFriendsList(arg_13_0, arg_13_1, arg_13_2)
	if isSuccess(arg_13_1.result) then
		FriendsData:DelectFriendsData(arg_13_2.friend_id)
		FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.MY_FRIENDS)
		FriendsAction:UpdateChatRedTip()
		ChatAction.DeleteFriendChat(arg_13_2.friend_id)
		FriendsAction:OnFriendsDelect(arg_13_2.friend_id)
	else
		ShowTips(arg_13_1.result)
	end
end

function var_0_0.TryToAddToBlacklist(arg_14_0, arg_14_1)
	if FriendsData:IsCanBeBlackList(arg_14_1) then
		local var_14_0 = {
			black_user_id = arg_14_1
		}

		manager.net:SendWithLoadingNew(19008, var_14_0, 19009, handler(arg_14_0, arg_14_0.OnTryToAddToBlacklist))
	end
end

function var_0_0.OnTryToAddToBlacklist(arg_15_0, arg_15_1, arg_15_2)
	if isSuccess(arg_15_1.result) then
		FriendsData:RefreshFriendsData(arg_15_1.black, FriendsConst.FRIEND_TYPE.BLACKLIST)
		FriendsData:TryToRemoveRequest(arg_15_2.friend_id)
		FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.MY_FRIENDS)
		FriendsAction:UpdateFriendsRedTip()
		ChatAction.DeleteFriendChat(arg_15_2.black_user_id)
		ChatAction.RefreshWorldChatData()
		FriendsAction:OnFriendsDelect(arg_15_2.black_user_id)
	else
		ShowTips(arg_15_1.result)
	end
end

function var_0_0.TryToDelectFromBlackList(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {
		black_user_id = arg_16_1,
		is_request = arg_16_2
	}

	manager.net:SendWithLoadingNew(19010, var_16_0, 19011, handler(arg_16_0, arg_16_0.OnTryToDelectFromBlackList))
end

function var_0_0.OnTryToDelectFromBlackList(arg_17_0, arg_17_1, arg_17_2)
	if isSuccess(arg_17_1.result) then
		FriendsData:DelectFromBlackList(arg_17_2.black_user_id, arg_17_2.is_request)

		if arg_17_2.isRequest == 1 then
			FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
		else
			FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.BLACKLIST)
		end

		ChatAction.RefreshWorldChatData()
	else
		ShowTips(arg_17_1.result)
	end
end

function var_0_0.TryToSearchFriend(arg_18_0, arg_18_1)
	local var_18_0 = {
		user_id = arg_18_1
	}

	manager.net:SendWithLoadingNew(19012, var_18_0, 19013, handler(arg_18_0, arg_18_0.OnTryToSearchFriend))
end

function var_0_0.OnTryToSearchFriend(arg_19_0, arg_19_1, arg_19_2)
	if isSuccess(arg_19_1.result) then
		FriendsData:SetSearchList(arg_19_1.user_info)
		FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.SEARCH)
	else
		FriendsData:SetSearchList()
		FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.SEARCH)
		ShowTips(arg_19_1.result)
	end
end

function var_0_0.TryToDealRequestList(arg_20_0, arg_20_1)
	if FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS) == 0 then
		return
	end

	local var_20_0 = {
		deal = arg_20_1
	}

	manager.net:SendWithLoadingNew(19014, var_20_0, 19015, handler(arg_20_0, arg_20_0.OnTryToDealRequestList))
end

function var_0_0.OnTryToDealRequestList(arg_21_0, arg_21_1, arg_21_2)
	if isSuccess(arg_21_1.result) then
		if arg_21_2.deal == 1 then
			local var_21_0 = arg_21_1.friend_list or {}

			FriendsData:AllAcceptRequestList(var_21_0, arg_21_2.deal)
			SendMessageManagerToSDK("add_friend")
		else
			FriendsData:AllRefuseRequestList(list, arg_21_2.deal)
			ShowTips("IGNORE_ALL_FRIEND_REQUEST")
		end

		FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS)
		FriendsAction:UpdateFriendsRequestRedTip()
	else
		ShowTips(arg_21_1.result)
	end
end

function var_0_0.TryToRefreshNewFriendsList(arg_22_0, arg_22_1)
	local var_22_0 = {
		cmd = arg_22_1
	}

	manager.net:SendWithLoadingNew(19016, var_22_0, 19017, handler(arg_22_0, arg_22_0.OnTryToRefreshNewFriendsList))
end

function var_0_0.OnTryToRefreshNewFriendsList(arg_23_0, arg_23_1, arg_23_2)
	if isSuccess(arg_23_1.result) then
		local var_23_0 = arg_23_1.recommend_list or {}

		FriendsData:RefreshNewFriendsList(var_23_0, arg_23_2.cmd)
		FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
	else
		ShowTips(arg_23_1.result)

		if arg_23_2.cmd == 1 then
			FriendsData:RefreshNewFriendsList({}, 2)
			FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
		end
	end
end

function var_0_0.TryToRefreshFriendsView(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = {
		type = arg_24_1
	}

	manager.net:SendWithLoadingNew(19030, var_24_0, 19031, function(arg_25_0, arg_25_1)
		if isSuccess(arg_25_0.result) then
			if arg_24_2 then
				arg_24_2()
			end
		else
			ShowTips(arg_25_0.result)
		end
	end)
end

function var_0_0.ChatInit(arg_26_0)
	FriendsData:ChatInit()
end

function var_0_0.RefreshChat(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	FriendsData:RefreshChat(arg_27_1, arg_27_2, arg_27_3)
	manager.notify:CallUpdateFunc(FRIENDS_CHAT_CHANGE, arg_27_1, arg_27_2, arg_27_3)
end

function var_0_0.RefreshUnread(arg_28_0, arg_28_1, arg_28_2)
	FriendsData:RefreshUnread(arg_28_1, arg_28_2)
	manager.notify:CallUpdateFunc(FRIENDS_UNREAD_CHANGE, arg_28_1, arg_28_2)

	if arg_28_2 == 0 then
		FriendsAction:UpdateChatRedTip()
	elseif manager.redPoint:getTipValue(RedPointConst.FRIEND_MY_FRIENDS) == 0 then
		manager.redPoint:setTip(RedPointConst.FRIEND_MY_FRIENDS, 1)
	end
end

function var_0_0.OnFriendsDataChange(arg_29_0, arg_29_1)
	manager.notify:CallUpdateFunc(FRIENDS_LIST_CHANGE, arg_29_1)
end

function var_0_0.OnFriendsDelect(arg_30_0, arg_30_1)
	manager.notify:CallUpdateFunc(FRIENDS_DELECT, arg_30_1)
end

function var_0_0.UpdateFriendsRedTip(arg_31_0)
	arg_31_0:UpdateChatRedTip()
	arg_31_0:UpdateFriendsRequestRedTip()
end

function var_0_0.UpdateChatRedTip(arg_32_0)
	local var_32_0 = false

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.FRIEND) then
		var_32_0 = false
	end

	local var_32_1 = FriendsData:GetChatList() or {}

	for iter_32_0, iter_32_1 in pairs(var_32_1) do
		if iter_32_1.unReadMsgCnt > 0 then
			var_32_0 = true

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.FRIEND_MY_FRIENDS, var_32_0 and 1 or 0)
end

function var_0_0.UpdateFriendsRequestRedTip(arg_33_0)
	local var_33_0 = false

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.FRIEND) then
		var_33_0 = false
	end

	if FriendsData:IsRequesting() then
		var_33_0 = true
	end

	manager.redPoint:setTip(RedPointConst.FRIEND_FRIEND_REQUESTS, var_33_0 and 1 or 0)
	manager.redPoint:setTip(RedPointConst.FRIEND, var_33_0 and 1 or 0)
end

return var_0_0
