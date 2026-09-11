local FriendsRightContentView = class("FriendsRightContentView", ReduxView)

function FriendsRightContentView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function FriendsRightContentView:Init()
	self:InitUI()
	self:AddUIListener()
	self:InitDropdownData()
end

function FriendsRightContentView:InitDropdownData()
	self.dropDown_.options:Clear()

	for iter_3_0, iter_3_1 in ipairs({
		"DEFAULT_SORT",
		"LAST_CHAT",
		"LAST_LOGIN",
		"USER_NAME"
	}) do
		self.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips(iter_3_1), nil))
	end

	self.dropDown_:RefreshShownValue()
end

function FriendsRightContentView:InitUI()
	self:BindCfgUI()

	self.friendType_ = {
		myFriends = FriendsConst.FRIEND_TYPE.MY_FRIENDS,
		newFriends = FriendsConst.FRIEND_TYPE.NEW_FRIENDS,
		friendsRequest = FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS,
		blackList = FriendsConst.FRIEND_TYPE.BLACKLIST,
		search = FriendsConst.FRIEND_TYPE.SEARCH
	}
	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.itemScroll_, FriendsItem)
	self.nothingController_ = ControllerUtil.GetController(self.gameObject_.transform, "nothing")
	self.inputController_ = ControllerUtil.GetController(self.transform_, "input")
	self.orderController_ = self.sortBtn_.transform:GetComponent("ControllerExCollection"):GetController("sort")
	self.dropDown_ = self.dropGo_:GetComponent("Dropdown")
end

function FriendsRightContentView:AddUIListener()
	self:AddToggleListener(self.dropDown_, function(arg_6_0)
		self.sortType_ = self.dropDown_.value

		self:SortList()
		self.scrollHelper_:StartScroll(#self.curList_)
	end)
	self:AddBtnListener(self.sortBtn_, nil, function()
		self.order_ = 1 - self.order_

		self:SortList()
		self.scrollHelper_:StartScroll(#self.curList_)
	end)
	self:AddBtnListener(self.searchBtn_, nil, function()
		if self.inputField_.text == "" then
			return
		end

		local var_8_0, var_8_1 = textLimit(self.inputField_.text, 15)

		self.inputField_.text = var_8_0
		self.curPageIndex_ = self.friendType_.search

		FriendsAction:TryToSearchFriend(var_8_0)
	end)
	self:AddBtnListener(self.ignoreAllBtn_, nil, function()
		FriendsAction:TryToDealRequestList(2)
	end)
	self:AddBtnListener(self.acceptAllBtn_, nil, function()
		FriendsAction:TryToDealRequestList(1)
	end)
	self:AddBtnListener(self.refreshBtn_, nil, function()
		FriendsAction:TryToRefreshNewFriendsList(2)
	end)
	self:AddBtnListener(self.deleteBtn_, nil, function()
		self.inputField_.text = ""
	end)
	self:AddBtnListener(self.pasteBtn_, nil, function()
		self.inputField_.text = GetI18NText(UnityEngine.GUIUtility.systemCopyBuffer)
	end)
	self.inputField_.onValueChanged:AddListener(function()
		self.inputController_:SetSelectedState(self.inputField_.text ~= "" and "delete" or "add")
	end)
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDrag)))
end

function FriendsRightContentView:EndDrag(arg_15_1, arg_15_2)
	if self.curPageIndex_ ~= self.friendType_.newFriends then
		return
	end

	if self.template_.transform.sizeDelta.y < -1 * self.content_.transform.anchoredPosition.y then
		FriendsAction:TryToRefreshNewFriendsList(2)
	end
end

function FriendsRightContentView:OnEnter()
	self.order_ = 0
	self.dropDown_.value = 0
	self.sortType_ = self.dropDown_.value
	self.curList_ = {}
end

function FriendsRightContentView:indexItem(arg_17_1, arg_17_2)
	arg_17_2:RefreshUI(self.curList_[arg_17_1], self.curPageIndex_)
end

function FriendsRightContentView:RefreshUI(arg_18_1)
	local var_18_0 = self.curPageIndex_ and self.curPageIndex_ == arg_18_1

	self:clearText(self.curPageIndex_)

	self.curPageIndex_ = arg_18_1
	self.curList_ = {}

	for iter_18_0, iter_18_1 in ipairs((FriendsData:GetList(self.curPageIndex_))) do
		table.insert(self.curList_, (FriendsData:GetInfoByID(iter_18_1)))
	end

	if self.curPageIndex_ == self.friendType_.myFriends then
		self.myFriendsTxt_.text = FriendsData:GetFriendsOnLineCount() .. "/" .. FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.MY_FRIENDS)
	elseif self.curPageIndex_ == self.friendType_.newFriends then
		self.inputField_.text = ""
		self.defaultTxt_.text = GetTips("NOT_ENTER_NICK_UID")
		self.newFriendsTxt_.text = FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.MY_FRIENDS) .. "/" .. GameSetting.user_friend_num_max.value[1]
	elseif self.curPageIndex_ == self.friendType_.search then
		self.newFriendsTxt_.text = FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.MY_FRIENDS) .. "/" .. GameSetting.user_friend_num_max.value[1]
	elseif self.curPageIndex_ == self.friendType_.friendsRequest then
		self.friendsRequestTxt_.text = FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.MY_FRIENDS) .. "/" .. GameSetting.user_friend_num_max.value[1]

		SetActive(self.ignoreAllBtn_.gameObject, #self.curList_ > 0)
		SetActive(self.acceptAllBtn_.gameObject, #self.curList_ > 0)
	elseif self.curPageIndex_ == self.friendType_.blackList then
		self.blacklistTxt_.text = FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.BLACKLIST) .. "/" .. GameSetting.user_black_num_max.value[1]
	end

	SetActive(self.refreshBtn_.gameObject, self.curPageIndex_ == self.friendType_.newFriends)
	self:SortList(var_18_0)
end

function FriendsRightContentView:SortList(arg_19_1)
	if self.curPageIndex_ == self.friendType_.myFriends then
		self.orderController_:SetSelectedState(self.order_ == 0 and "down" or "up")

		if self.sortType_ == 0 then
			table.sort(self.curList_, function(arg_20_0, arg_20_1)
				if arg_20_0.online_state == 0 and arg_20_1.online_state ~= 0 then
					return true
				elseif arg_20_0.online_state ~= 0 and arg_20_1.online_state == 0 then
					return false
				end

				return (arg_20_1.lastChatTime or arg_20_1.timestamp) < (arg_20_0.lastChatTime or arg_20_0.timestamp)
			end)
		elseif self.sortType_ == 1 then
			table.sort(self.curList_, function(arg_21_0, arg_21_1)
				return (arg_21_1.lastChatTime or arg_21_1.timestamp) < (arg_21_0.lastChatTime or arg_21_0.timestamp)
			end)
		elseif self.sortType_ == 2 then
			table.sort(self.curList_, function(arg_22_0, arg_22_1)
				if arg_22_0.online_state == 0 and arg_22_1.online_state ~= 0 then
					return true
				elseif arg_22_0.online_state ~= 0 and arg_22_1.online_state == 0 then
					return false
				end

				if arg_22_0.online_state ~= 0 and arg_22_1.online_state ~= 0 then
					return arg_22_0.online_state > arg_22_1.online_state
				end

				return (arg_22_1.lastChatTime or arg_22_1.timestamp) < (arg_22_0.lastChatTime or arg_22_0.timestamp)
			end)
		elseif self.sortType_ == 3 then
			table.sort(self.curList_, function(arg_23_0, arg_23_1)
				return (Hanzi2Pinyin.Sort(arg_23_0.nick, arg_23_1.nick))
			end)
		end

		if self.order_ == 1 then
			local var_19_0 = {}

			for iter_19_0 = 1, #self.curList_ do
				var_19_0[iter_19_0] = table.remove(self.curList_)
			end

			self.curList_ = var_19_0
		end
	elseif self.curPageIndex_ == self.friendType_.newFriends then
		-- block empty
	elseif self.curPageIndex_ == self.friendType_.friendsRequest then
		table.sort(self.curList_, function(arg_24_0, arg_24_1)
			return arg_24_0.timestamp > arg_24_1.timestamp
		end)
	elseif self.curPageIndex_ == self.friendType_.blackList then
		table.sort(self.curList_, function(arg_25_0, arg_25_1)
			return arg_25_0.timestamp > arg_25_1.timestamp
		end)
	end

	if arg_19_1 and self.curPageIndex_ == self.friendType_.newFriends then
		self.scrollHelper_:SetScrolledPosition((self.scrollHelper_:GetScrolledPosition()))
	else
		self.scrollHelper_:StartScroll(#self.curList_)
	end

	if next(self.curList_) == nil then
		self.nothingController_:SetSelectedState(self.curPageIndex_)
	else
		self.nothingController_:SetSelectedState(0)
	end
end

function FriendsRightContentView:clearText(arg_26_1)
	if arg_26_1 == self.friendType_.myFriends then
		self.myFriendsTxt_.text = ""
	elseif self.curPageIndex_ == self.friendType_.newFriends then
		-- block empty
	elseif self.curPageIndex_ == self.friendType_.search then
		-- block empty
	elseif self.curPageIndex_ == self.friendType_.friendsRequest then
		self.friendsRequestTxt_.text = ""
	elseif self.curPageIndex_ == self.friendType_.blackList then
		self.blacklistTxt_.text = ""
	end
end

function FriendsRightContentView:OnFriendsChatChange(arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = self:ItemIndex(arg_27_1)

	if var_27_0 == 0 then
		return
	end

	self.curList_[var_27_0].lastChat = arg_27_2
	self.curList_[var_27_0].timestamp = arg_27_3
end

function FriendsRightContentView:OnFriendsUnreadChange(arg_28_1, arg_28_2)
	local var_28_0 = self:ItemIndex(arg_28_1)

	if var_28_0 == 0 then
		return
	end

	self.curList_[var_28_0].unReadMsgCnt = arg_28_2

	table.insert(self.curList_, 1, (table.remove(self.curList_, var_28_0)))
	self.scrollHelper_:Refresh()
end

function FriendsRightContentView:ItemIndex(arg_29_1)
	for iter_29_0 = 1, #self.curList_ do
		if self.curList_[iter_29_0].user_id == arg_29_1 then
			return iter_29_0
		end
	end

	return 0
end

function FriendsRightContentView:OnFriendsListChange(arg_30_1)
	self:RefreshUI(arg_30_1)
end

function FriendsRightContentView:OnExit()
	self.curList_ = {}
	self.myFriendsTxt_.text = ""
	self.friendsRequestTxt_.text = ""
	self.blacklistTxt_.text = ""
end

function FriendsRightContentView:Dispose()
	self:RemoveAllListeners()
	self.dropDown_.onValueChanged:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	FriendsRightContentView.super.Dispose(self)
end

return FriendsRightContentView
