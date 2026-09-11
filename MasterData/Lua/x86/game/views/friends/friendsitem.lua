local FriendsItem = class("FriendsItem", ReduxView)

function FriendsItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.friendType_ = {
		myFriends = FriendsConst.FRIEND_TYPE.MY_FRIENDS,
		newFriends = FriendsConst.FRIEND_TYPE.NEW_FRIENDS,
		friendsRequest = FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS,
		blackList = FriendsConst.FRIEND_TYPE.BLACKLIST,
		search = FriendsConst.FRIEND_TYPE.SEARCH
	}
	self.typeCon_ = ControllerUtil.GetController(self.transform_, "friendType")
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "online")
	self.newFriendCon_ = ControllerUtil.GetController(self.transform_, "newFriend")
	self.showLevelCon_ = ControllerUtil.GetController(self.transform_, "showLevel")
	self.cardBgCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("bgType")

	self:InitUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddUIListeners()
end

function FriendsItem:InitUI()
	self:BindCfgUI()

	self.textLimit_ = self.chatText_.gameObject:GetComponent("TextExtension")
end

function FriendsItem:AddUIListeners()
	self.commonPortrait_:RegisteClickCallback(function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(self.userID)
	end)
	self:AddBtnListener(self.chatBtn_, nil, function()
		ChatFriendData:AddCacheFriend(self.userID)
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_FRIEND,
			friendID = self.userID
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	self:AddBtnListener(self.addFriendBtn_, nil, function()
		if FriendsData:IsCanBeFriend(self.userID) then
			FriendsAction:TryToRequestToFriend(self.userID, FriendConst.ADD_FRIEND_SOURCE.FIREND_VIEW)
		end
	end)
	self:AddBtnListener(self.requestAcceptBtn_, nil, function()
		FriendsAction:TryToDealRequest(self.userID, 1)
	end)
	self:AddBtnListener(self.requestIgnoreBtn_, nil, function()
		FriendsAction:TryToDealRequest(self.userID, 2)
	end)
	self:AddBtnListener(self.shiftoutBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("BLACKLIST_REMOVE_QUEST"), self.data_.nick),
			OkCallback = function()
				FriendsAction:TryToDelectFromBlackList(self.userID, 2)
			end
		})
	end)
	self:AddBtnListener(self.reportBtn_, nil, function()
		JumpTools.OpenPageByJump("chatReport", {
			reportType = ChatConst.CHAT_REPORT_TYPE.USER,
			reportData = {
				nick = self.data_.nick,
				userID = self.data_.user_id
			}
		}, ViewConst.SYSTEM_ID.CHAT_REPORT)
	end)
	self:AddBtnListener(self.copyBtn_, nil, function()
		UnityEngine.GUIUtility.systemCopyBuffer = self.userID

		ShowTips("COPY_SUCCESS")
	end)
end

function FriendsItem:OnEnter()
	self.data_ = {}
end

function FriendsItem:RefreshUI(arg_14_1, arg_14_2)
	if arg_14_1 == nil then
		return
	end

	self.data_ = arg_14_1
	self.curType_ = arg_14_2

	self.typeCon_:SetSelectedState(self.curType_)

	self.userID = arg_14_1.user_id
	self.idTxt_.text = arg_14_1.user_id
	self.nameText_.text = GetI18NText(arg_14_1.nick)

	if self.curType_ ~= self.friendType_.blackList and arg_14_1.level then
		self.showLevelCon_:SetSelectedState("show")

		self.levelText_.text = string.format("%s%s", GetTips("LEVEL"), arg_14_1.level)
	else
		self.showLevelCon_:SetSelectedState("hide")
	end

	if self.data_.icon_frame ~= 0 then
		self.data_.icon_frame = self.data_.icon_frame or 2001
	end

	self.commonPortrait_:RenderHead(arg_14_1.icon)
	self.commonPortrait_:RenderFrame(self.data_.icon_frame)

	if ProfileDecorateItemCfg[self.data_.bg] then
		self.cardBgCon_:SetSelectedState("image")
		self.cardBgCon_:SetSelectedState("image")

		if ProfileDecorateItemCfg[self.data_.bg].type == 1 then
			self.bg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Friends/" .. ProfileDecorateItemCfg[self.data_.bg].resource .. "_s")
		elseif ProfileDecorateItemCfg[self.data_.bg].type == 2 then
			self.cardBgCon_:SetSelectedState("prefab")

			local var_14_0 = Asset.Load("Widget/System/PlayerProfileBg/profileBg_s/PPBCode_s_" .. ProfileDecorateItemCfg[self.data_.bg].resource)

			if var_14_0 then
				local var_14_1 = Object.Instantiate(var_14_0, self.cardBgPrefabRoot_)

				if var_14_1 then
					var_14_1.transform:SetParent(self.cardBgPrefabRoot_)

					var_14_1.transform.localScale = Vector3.New(1, 1, 1)
					var_14_1.transform.localPosition = Vector3.New(0, 0, 0)

					var_14_1:SetActive(true)
				end
			end
		elseif cfg.type == 3 then
			-- block empty
		end
	end

	if self.curType_ ~= self.friendType_.friendsRequest and self.curType_ ~= self.friendType_.blackList then
		local var_14_2 = arg_14_1.online_state or -1

		if var_14_2 == 0 then
			self.stateCon_:SetSelectedState("on")

			self.offlineText_.text = GetTips("ONLINE")
		else
			local var_14_3 = manager.time:GetServerTime() - var_14_2

			self.offlineText_.text = var_14_3 < 3600 and GetTips("FRIEND_ONLINE_TIME_WITHIN_AN_HOUR") or var_14_3 < 86400 and GetTips("FRIEND_ONLINE_TIME_IN_ONE_DAY") or var_14_3 < 2592000 and string.format(GetTips("FRIEND_ONLINE_TIME_ONE_DAY_AGO"), math.floor(var_14_3 / 86400)) or string.format(GetTips("FRIEND_ONLINE_TIME_ONE_DAY_AGO"), 30)

			self.stateCon_:SetSelectedState("off")
		end
	end

	if self.curType_ == self.friendType_.myFriends then
		self.textLimit_:SetText(arg_14_1.sign)
	elseif self.curType_ == self.friendType_.newFriends or self.curType_ == self.friendType_.search then
		self.newFriendsSign_.text = ""

		self.newFriendCon_:SetSelectedState(arg_14_1.isDeal and 1 or 0)
	elseif self.curType_ == self.friendType_.friendsRequest then
		self.friendsRequestSign_.text = ""
	elseif self.curType_ == self.friendType_.blackList then
		-- block empty
	else
		print("未确认类型")
	end
end

function FriendsItem:OnExit()
	return
end

function FriendsItem:Dispose()
	self.commonPortrait_:Dispose()

	self.commonPortrait_ = nil

	self:RemoveAllListeners()
	FriendsItem.super.Dispose(self)
end

return FriendsItem
