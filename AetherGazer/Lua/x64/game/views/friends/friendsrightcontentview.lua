local var_0_0 = class("FriendsRightContentView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:InitDropdownData()
end

function var_0_0.InitDropdownData(arg_3_0)
	arg_3_0.dropDown_.options:Clear()

	local var_3_0 = {
		"DEFAULT_SORT",
		"LAST_CHAT",
		"LAST_LOGIN",
		"USER_NAME"
	}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		arg_3_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips(iter_3_1), nil))
	end

	arg_3_0.dropDown_:RefreshShownValue()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.friendType_ = {
		myFriends = FriendsConst.FRIEND_TYPE.MY_FRIENDS,
		newFriends = FriendsConst.FRIEND_TYPE.NEW_FRIENDS,
		friendsRequest = FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS,
		blackList = FriendsConst.FRIEND_TYPE.BLACKLIST,
		search = FriendsConst.FRIEND_TYPE.SEARCH
	}
	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.itemScroll_, FriendsItem)
	arg_4_0.nothingController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "nothing")
	arg_4_0.inputController_ = ControllerUtil.GetController(arg_4_0.transform_, "input")
	arg_4_0.orderController_ = arg_4_0.sortBtn_.transform:GetComponent("ControllerExCollection"):GetController("sort")
	arg_4_0.dropDown_ = arg_4_0.dropGo_:GetComponent("Dropdown")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddToggleListener(arg_5_0.dropDown_, function(arg_6_0)
		arg_5_0.sortType_ = arg_5_0.dropDown_.value

		arg_5_0:SortList()
		arg_5_0.scrollHelper_:StartScroll(#arg_5_0.curList_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.sortBtn_, nil, function()
		arg_5_0.order_ = 1 - arg_5_0.order_

		arg_5_0:SortList()
		arg_5_0.scrollHelper_:StartScroll(#arg_5_0.curList_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.searchBtn_, nil, function()
		local var_8_0 = arg_5_0.inputField_.text

		if var_8_0 == "" then
			return
		end

		local var_8_1, var_8_2 = textLimit(var_8_0, 15)

		arg_5_0.inputField_.text = var_8_1

		local var_8_3 = var_8_1

		arg_5_0.curPageIndex_ = arg_5_0.friendType_.search

		FriendsAction:TryToSearchFriend(var_8_3)
	end)
	arg_5_0:AddBtnListener(arg_5_0.ignoreAllBtn_, nil, function()
		FriendsAction:TryToDealRequestList(2)
	end)
	arg_5_0:AddBtnListener(arg_5_0.acceptAllBtn_, nil, function()
		FriendsAction:TryToDealRequestList(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.refreshBtn_, nil, function()
		FriendsAction:TryToRefreshNewFriendsList(2)
	end)
	arg_5_0:AddBtnListener(arg_5_0.deleteBtn_, nil, function()
		arg_5_0.inputField_.text = ""
	end)
	arg_5_0:AddBtnListener(arg_5_0.pasteBtn_, nil, function()
		local var_13_0 = UnityEngine.GUIUtility.systemCopyBuffer

		arg_5_0.inputField_.text = GetI18NText(var_13_0)
	end)
	arg_5_0.inputField_.onValueChanged:AddListener(function()
		local var_14_0 = arg_5_0.inputField_.text

		arg_5_0.inputController_:SetSelectedState(var_14_0 ~= "" and "delete" or "add")
	end)
	arg_5_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_5_0, arg_5_0.EndDrag)))
end

function var_0_0.EndDrag(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.curPageIndex_ ~= arg_15_0.friendType_.newFriends then
		return
	end

	local var_15_0 = arg_15_0.content_.transform.anchoredPosition.y

	if arg_15_0.template_.transform.sizeDelta.y < -1 * var_15_0 then
		FriendsAction:TryToRefreshNewFriendsList(2)
	end
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0.order_ = 0
	arg_16_0.dropDown_.value = 0
	arg_16_0.sortType_ = arg_16_0.dropDown_.value
	arg_16_0.curList_ = {}
end

function var_0_0.indexItem(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2:RefreshUI(arg_17_0.curList_[arg_17_1], arg_17_0.curPageIndex_)
end

function var_0_0.RefreshUI(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.curPageIndex_ and arg_18_0.curPageIndex_ == arg_18_1

	arg_18_0:clearText(arg_18_0.curPageIndex_)

	arg_18_0.curPageIndex_ = arg_18_1
	arg_18_0.curList_ = {}

	local var_18_1 = FriendsData:GetList(arg_18_0.curPageIndex_)

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		local var_18_2 = FriendsData:GetInfoByID(iter_18_1)

		table.insert(arg_18_0.curList_, var_18_2)
	end

	if arg_18_0.curPageIndex_ == arg_18_0.friendType_.myFriends then
		arg_18_0.myFriendsTxt_.text = FriendsData:GetFriendsOnLineCount() .. "/" .. FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.MY_FRIENDS)
	elseif arg_18_0.curPageIndex_ == arg_18_0.friendType_.newFriends then
		arg_18_0.inputField_.text = ""
		arg_18_0.defaultTxt_.text = GetTips("NOT_ENTER_NICK_UID")
		arg_18_0.newFriendsTxt_.text = FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.MY_FRIENDS) .. "/" .. GameSetting.user_friend_num_max.value[1]
	elseif arg_18_0.curPageIndex_ == arg_18_0.friendType_.search then
		arg_18_0.newFriendsTxt_.text = FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.MY_FRIENDS) .. "/" .. GameSetting.user_friend_num_max.value[1]
	elseif arg_18_0.curPageIndex_ == arg_18_0.friendType_.friendsRequest then
		arg_18_0.friendsRequestTxt_.text = FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.MY_FRIENDS) .. "/" .. GameSetting.user_friend_num_max.value[1]

		SetActive(arg_18_0.ignoreAllBtn_.gameObject, #arg_18_0.curList_ > 0)
		SetActive(arg_18_0.acceptAllBtn_.gameObject, #arg_18_0.curList_ > 0)
	elseif arg_18_0.curPageIndex_ == arg_18_0.friendType_.blackList then
		arg_18_0.blacklistTxt_.text = FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.BLACKLIST) .. "/" .. GameSetting.user_black_num_max.value[1]
	end

	SetActive(arg_18_0.refreshBtn_.gameObject, arg_18_0.curPageIndex_ == arg_18_0.friendType_.newFriends)
	arg_18_0:SortList(var_18_0)
end

function var_0_0.SortList(arg_19_0, arg_19_1)
	if arg_19_0.curPageIndex_ == arg_19_0.friendType_.myFriends then
		arg_19_0.orderController_:SetSelectedState(arg_19_0.order_ == 0 and "down" or "up")

		if arg_19_0.sortType_ == 0 then
			table.sort(arg_19_0.curList_, function(arg_20_0, arg_20_1)
				if arg_20_0.online_state == 0 and arg_20_1.online_state ~= 0 then
					return true
				elseif arg_20_0.online_state ~= 0 and arg_20_1.online_state == 0 then
					return false
				end

				return (arg_20_0.lastChatTime or arg_20_0.timestamp) > (arg_20_1.lastChatTime or arg_20_1.timestamp)
			end)
		elseif arg_19_0.sortType_ == 1 then
			table.sort(arg_19_0.curList_, function(arg_21_0, arg_21_1)
				return (arg_21_0.lastChatTime or arg_21_0.timestamp) > (arg_21_1.lastChatTime or arg_21_1.timestamp)
			end)
		elseif arg_19_0.sortType_ == 2 then
			table.sort(arg_19_0.curList_, function(arg_22_0, arg_22_1)
				if arg_22_0.online_state == 0 and arg_22_1.online_state ~= 0 then
					return true
				elseif arg_22_0.online_state ~= 0 and arg_22_1.online_state == 0 then
					return false
				end

				if arg_22_0.online_state ~= 0 and arg_22_1.online_state ~= 0 then
					return arg_22_0.online_state > arg_22_1.online_state
				end

				return (arg_22_0.lastChatTime or arg_22_0.timestamp) > (arg_22_1.lastChatTime or arg_22_1.timestamp)
			end)
		elseif arg_19_0.sortType_ == 3 then
			table.sort(arg_19_0.curList_, function(arg_23_0, arg_23_1)
				return (Hanzi2Pinyin.Sort(arg_23_0.nick, arg_23_1.nick))
			end)
		end

		if arg_19_0.order_ == 1 then
			local var_19_0 = {}

			for iter_19_0 = 1, #arg_19_0.curList_ do
				var_19_0[iter_19_0] = table.remove(arg_19_0.curList_)
			end

			arg_19_0.curList_ = var_19_0
		end
	elseif arg_19_0.curPageIndex_ == arg_19_0.friendType_.newFriends then
		-- block empty
	elseif arg_19_0.curPageIndex_ == arg_19_0.friendType_.friendsRequest then
		table.sort(arg_19_0.curList_, function(arg_24_0, arg_24_1)
			return arg_24_0.timestamp > arg_24_1.timestamp
		end)
	elseif arg_19_0.curPageIndex_ == arg_19_0.friendType_.blackList then
		table.sort(arg_19_0.curList_, function(arg_25_0, arg_25_1)
			return arg_25_0.timestamp > arg_25_1.timestamp
		end)
	end

	if arg_19_1 and arg_19_0.curPageIndex_ == arg_19_0.friendType_.newFriends then
		local var_19_1 = arg_19_0.scrollHelper_:GetScrolledPosition()

		arg_19_0.scrollHelper_:SetScrolledPosition(var_19_1)
	else
		arg_19_0.scrollHelper_:StartScroll(#arg_19_0.curList_)
	end

	if next(arg_19_0.curList_) == nil then
		arg_19_0.nothingController_:SetSelectedState(arg_19_0.curPageIndex_)
	else
		arg_19_0.nothingController_:SetSelectedState(0)
	end
end

function var_0_0.clearText(arg_26_0, arg_26_1)
	if arg_26_1 == arg_26_0.friendType_.myFriends then
		arg_26_0.myFriendsTxt_.text = ""
	elseif arg_26_0.curPageIndex_ == arg_26_0.friendType_.newFriends then
		-- block empty
	elseif arg_26_0.curPageIndex_ == arg_26_0.friendType_.search then
		-- block empty
	elseif arg_26_0.curPageIndex_ == arg_26_0.friendType_.friendsRequest then
		arg_26_0.friendsRequestTxt_.text = ""
	elseif arg_26_0.curPageIndex_ == arg_26_0.friendType_.blackList then
		arg_26_0.blacklistTxt_.text = ""
	end
end

function var_0_0.OnFriendsChatChange(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_0:ItemIndex(arg_27_1)

	if var_27_0 == 0 then
		return
	end

	arg_27_0.curList_[var_27_0].lastChat = arg_27_2
	arg_27_0.curList_[var_27_0].timestamp = arg_27_3
end

function var_0_0.OnFriendsUnreadChange(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:ItemIndex(arg_28_1)

	if var_28_0 == 0 then
		return
	end

	arg_28_0.curList_[var_28_0].unReadMsgCnt = arg_28_2

	local var_28_1 = table.remove(arg_28_0.curList_, var_28_0)

	table.insert(arg_28_0.curList_, 1, var_28_1)
	arg_28_0.scrollHelper_:Refresh()
end

function var_0_0.ItemIndex(arg_29_0, arg_29_1)
	for iter_29_0 = 1, #arg_29_0.curList_ do
		if arg_29_0.curList_[iter_29_0].user_id == arg_29_1 then
			return iter_29_0
		end
	end

	return 0
end

function var_0_0.OnFriendsListChange(arg_30_0, arg_30_1)
	arg_30_0:RefreshUI(arg_30_1)
end

function var_0_0.OnExit(arg_31_0)
	arg_31_0.curList_ = {}
	arg_31_0.myFriendsTxt_.text = ""
	arg_31_0.friendsRequestTxt_.text = ""
	arg_31_0.blacklistTxt_.text = ""
end

function var_0_0.Dispose(arg_32_0)
	arg_32_0:RemoveAllListeners()
	arg_32_0.dropDown_.onValueChanged:RemoveAllListeners()
	arg_32_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_32_0)
end

return var_0_0
