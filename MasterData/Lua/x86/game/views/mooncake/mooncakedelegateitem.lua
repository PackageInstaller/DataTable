local MoonCakeDelegateItem = class("MoonCakeDelegateItem", ReduxView)

function MoonCakeDelegateItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddUIListener()
end

function MoonCakeDelegateItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.friendController_ = ControllerUtil.GetController(self.transform_, "friend")
end

function MoonCakeDelegateItem:AddUIListener()
	if self.submitBtn_ then
		self:AddBtnListener(self.submitBtn_, nil, function()
			if not ActivityData:GetActivityIsOpen(self.activityID_) then
				ShowTips("TIME_OVER")

				return
			end

			if GameSetting.activity_mid_autumn_entrust_finish_limit.value[1] <= MoonCakeData:GetTodaySubmitTimes(self.activityID_) then
				ShowTips("MID_AUTUMN_FESTIVAL_TASK_FINISH_LIMIT")

				return
			end

			MoonCakeAction.SubmitDelegate(self.activityID_, self.delegateData_.uid, self.delegateData_.delegateID)
		end)
	end

	self:AddBtnListener(self.headBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(self.delegateData_.uid)
	end)

	if self.addFriendBtn_ then
		self:AddBtnListener(self.addFriendBtn_, nil, function()
			if not ActivityData:GetActivityIsOpen(self.activityID_) then
				ShowTips("TIME_OVER")

				return
			end

			if FriendsData:IsCanBeFriend(self.delegateData_.uid) then
				FriendsAction:TryToRequestToFriend(self.delegateData_.uid, FriendConst.ADD_FRIEND_SOURCE.MOON_CAKE_DELEGATE)
			end
		end)
	end
end

function MoonCakeDelegateItem:SetData(arg_7_1, arg_7_2)
	self.activityID_ = arg_7_2
	self.delegateData_ = arg_7_1

	self:RefreshUI()
end

function MoonCakeDelegateItem:RefreshUI()
	self:RefreshPrincipal()
	self:RefreshFriend()
	self:RefreshDelegate()
	self:RefreshStatus()
end

function MoonCakeDelegateItem:RefreshPrincipal()
	self.userName_.text = self.delegateData_.nick
	self.userLevel_.text = "LV." .. self.delegateData_.level
	self.userUid_.text = self.delegateData_.uid

	self.commonPortrait_:RenderHead(self.delegateData_.portrait)
	self.commonPortrait_:RenderFrame(self.delegateData_.frame)
end

function MoonCakeDelegateItem:RefreshFriend()
	if FriendsData:IsFriend(self.delegateData_.uid) == true then
		self.friendController_:SetSelectedState("myFriend")
	elseif FriendsData:IsInRequest(self.delegateData_.uid) == true then
		self.friendController_:SetSelectedState("requested")
	else
		self.friendController_:SetSelectedState("add")
	end
end

function MoonCakeDelegateItem:RefreshDelegate()
	local var_11_0 = MoonCakeCfg[self.delegateData_.targetID].moon_cakes

	self.curNum_ = ItemTools.getItemNum(MoonCakeCfg[self.delegateData_.targetID].moon_cakes) or 0
	self.moonCakeCurNum_.text = self.curNum_ > 0 and string.format(GetTips("MID_AUTUMN_FESTIVAL_MOONCAKE_QUANTITY"), self.curNum_) or GetTips("MID_AUTUMN_FESTIVAL_TASK_MOONCAKE_NOT_ENOUGH")
	self.moonCakeName_.text = ItemTools.getItemName(var_11_0)
	self.moonCakeIcon_.sprite = ItemTools.getItemSprite(var_11_0)
	self.moonCakeNeedNum_.text = "x1"
end

function MoonCakeDelegateItem:RefreshStatus()
	if self.delegateData_.isCompleted == true then
		self.statusController_:SetSelectedState("complete")
	elseif self.curNum_ <= 0 then
		self.statusController_:SetSelectedState("notEnough")

		self.submitBtn_.interactable = false
	else
		self.statusController_:SetSelectedState("enough")

		self.submitBtn_.interactable = true
	end
end

function MoonCakeDelegateItem:SetStatus(arg_13_1)
	self.statusController_:SetSelectedState(arg_13_1)
end

function MoonCakeDelegateItem:SetClickHandler(arg_14_1)
	self.clickHandler_ = arg_14_1
end

function MoonCakeDelegateItem:OnSubmitDelegate()
	self.delegateData_ = MoonCakeData:GetDelegateData(self.activityID_, self.delegateID_)

	self:RefreshStatus()
end

function MoonCakeDelegateItem:Dispose()
	self.commonPortrait_:Dispose()
	MoonCakeDelegateItem.super.Dispose(self)
end

return MoonCakeDelegateItem
