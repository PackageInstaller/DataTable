local FriendsView = class("FriendsView", ReduxView)

function FriendsView:UIName()
	return "Widget/System/Friends/FriendsUI"
end

function FriendsView:UIParent()
	return manager.ui.uiMain.transform
end

function FriendsView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function FriendsView:InitUI()
	self:BindCfgUI()

	self.contentView_ = FriendsRightContentView.New(self.rightContentPanel_)
	self.toggle_ = {}
	self.toggleCon_ = {}

	for iter_4_0 = 1, 4 do
		self.toggle_[iter_4_0] = self["tgl_" .. iter_4_0]
		self.toggleCon_[iter_4_0] = ControllerUtil.GetController(self.toggle_[iter_4_0].transform, "name")
	end

	self.pageCon_ = ControllerUtil.GetController(self.gameObject_.transform, "pageCon")
end

function FriendsView:AddUIListeners()
	for iter_5_0, iter_5_1 in ipairs(self.toggle_) do
		self:AddBtnListener(iter_5_1, nil, function()
			if iter_5_0 ~= self.curPageIndex_ then
				self:RefreshUI(iter_5_0)
			end
		end)
	end
end

function FriendsView:OnEnter()
	self.contentView_:OnEnter()

	self.params_.friendPage = self.params_.friendPage or FriendsConst.FRIEND_TYPE.MY_FRIENDS

	if self.params_.friendPage == FriendsConst.FRIEND_TYPE.SEARCH then
		self.curPageIndex_ = FriendsConst.FRIEND_TYPE.NEW_FRIENDS or self.params_.friendPage
	end

	self:BindRedPoint()
	self:RefreshUI(self.curPageIndex_)
end

function FriendsView:RefreshUI(arg_8_1)
	self.isRefreshing_ = true
	self.curPageIndex_ = arg_8_1
	self.params_.friendPage = self.curPageIndex_

	if self.curPageIndex_ == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		FriendsAction:TryToRefreshFriendsView(1)
	elseif self.curPageIndex_ == FriendsConst.FRIEND_TYPE.NEW_FRIENDS then
		if not FriendsData:GetHadFreshNewFriend() then
			FriendsAction:TryToRefreshNewFriendsList(1)
		else
			self.isRefreshing_ = false

			self.contentView_:RefreshUI(self.curPageIndex_)
			self.pageCon_:SetSelectedState(self.curPageIndex_)
			self:RefreshTgl(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
		end
	elseif self.curPageIndex_ == FriendsConst.FRIEND_TYPE.SEARCH then
		self.isRefreshing_ = false

		self.contentView_:RefreshUI(self.curPageIndex_)
		self.pageCon_:SetSelectedState(self.curPageIndex_)
		self:RefreshTgl(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
	elseif self.curPageIndex_ == FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS then
		FriendsAction:TryToRefreshFriendsView(2)
	elseif self.curPageIndex_ == FriendsConst.FRIEND_TYPE.BLACKLIST then
		FriendsAction:TryToRefreshFriendsView(3)
	end
end

function FriendsView:RefreshTgl(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(self.toggleCon_) do
		iter_9_1:SetSelectedState(iter_9_0 == arg_9_1 and "false" or "true")
	end
end

function FriendsView:OnFriendsListChange(arg_10_1)
	if self.curPageIndex_ == FriendsConst.FRIEND_TYPE.NEW_FRIENDS and arg_10_1 == FriendsConst.FRIEND_TYPE.SEARCH then
		self.curPageIndex_ = FriendsConst.FRIEND_TYPE.SEARCH
		self.params_.friendPage = self.curPageIndex_
	elseif self.curPageIndex_ == FriendsConst.FRIEND_TYPE.SEARCH and arg_10_1 == FriendsConst.FRIEND_TYPE.NEW_FRIENDS then
		self.curPageIndex_ = FriendsConst.FRIEND_TYPE.NEW_FRIENDS
		self.params_.friendPage = arg_10_1
	end

	if self.curPageIndex_ == FriendsConst.FRIEND_TYPE.SEARCH then
		self:RefreshTgl(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
		self.pageCon_:SetSelectedState(self.curPageIndex_)
		self.contentView_:RefreshUI(self.curPageIndex_)
	else
		self:RefreshTgl(self.curPageIndex_)
		self.pageCon_:SetSelectedState(self.curPageIndex_)
		self.contentView_:RefreshUI(self.curPageIndex_)
	end
end

function FriendsView:OnFriendsChatChange(arg_11_1, arg_11_2, arg_11_3)
	if self.isRefreshing_ then
		return
	end

	if self.curPageIndex_ == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		self.contentView_:OnFriendsChatChange(arg_11_1, arg_11_2, arg_11_3)
	end
end

function FriendsView:OnFriendsUnreadChange(arg_12_1, arg_12_2)
	if self.isRefreshing_ then
		return
	end

	if self.curPageIndex_ == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		self.contentView_:OnFriendsUnreadChange(arg_12_1, arg_12_2)
	end
end

function FriendsView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.toggle_[3].transform, RedPointConst.FRIEND_FRIEND_REQUESTS)
end

function FriendsView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.toggle_[3].transform, RedPointConst.FRIEND_FRIEND_REQUESTS)
end

function FriendsView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function FriendsView:OnExit()
	self:UnbindRedPoint()
	self.contentView_:OnExit()
	manager.windowBar:HideBar()
end

function FriendsView:Dispose()
	self:RemoveAllListeners()
	self.contentView_:Dispose()
	FriendsView.super.Dispose(self)
end

return FriendsView
