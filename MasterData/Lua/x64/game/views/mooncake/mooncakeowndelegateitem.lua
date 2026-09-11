local MoonCakeOwnDelegateItem = class("MoonCakeOwnDelegateItem", ReduxView)

function MoonCakeOwnDelegateItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddUIListener()
end

function MoonCakeOwnDelegateItem:InitUI()
	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.friendController_ = ControllerUtil.GetController(self.transform_, "friend")
end

function MoonCakeOwnDelegateItem:AddUIListener()
	self:AddBtnListener(self.addFriendBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if FriendsData:IsCanBeFriend(self.delegateData_.submiter_uid) then
			FriendsAction:TryToRequestToFriend(self.delegateData_.submiter_uid, FriendConst.ADD_FRIEND_SOURCE.MOON_CAKE_DELEGATE)
		end
	end)
	self:AddBtnListener(self.headBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(self.delegateData_.submiter_uid)
	end)
end

function MoonCakeOwnDelegateItem:SetData(arg_6_1, arg_6_2)
	self.activityID_ = arg_6_2
	self.delegateData_ = arg_6_1

	self:RefreshUI()
end

function MoonCakeOwnDelegateItem:RefreshUI()
	self:RefreshDelegate()
	self:RefreshGiver()
	self:RefreshFriend()
end

function MoonCakeOwnDelegateItem:RefreshGiver()
	self.userName_.text = self.delegateData_.nick

	self.commonPortrait_:RenderHead(self.delegateData_.portrait)
	self.commonPortrait_:RenderFrame(self.delegateData_.frame)
end

function MoonCakeOwnDelegateItem:RefreshFriend()
	if FriendsData:IsFriend(self.delegateData_.submiter_uid) == true then
		self.friendController_:SetSelectedState("myFriend")
	elseif FriendsData:IsInRequest(self.delegateData_.submiter_uid) == true then
		self.friendController_:SetSelectedState("requested")
	else
		self.friendController_:SetSelectedState("add")
	end
end

function MoonCakeOwnDelegateItem:RefreshDelegate()
	self.moonCakeName_.text = ItemTools.getItemName(MoonCakeCfg[self.delegateData_.targetID].moon_cakes) .. "X1"
	self.moonCakeIcon_.sprite = ItemTools.getItemSprite(MoonCakeCfg[self.delegateData_.targetID].moon_cakes)
end

function MoonCakeOwnDelegateItem:Dispose()
	self.commonPortrait_:Dispose()
	MoonCakeOwnDelegateItem.super.Dispose(self)
end

return MoonCakeOwnDelegateItem
