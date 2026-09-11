local FishingGivePageView = class("FishingGivePageView", ReduxView)

function FishingGivePageView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function FishingGivePageView:Init()
	self.friendInfoOfFriendId_ = {}

	self:InitUI()
	self:AddUIListener()
end

function FishingGivePageView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, FishingGiveItemView)
end

function FishingGivePageView:indexItem(arg_4_1, arg_4_2)
	self.friendInfoOfFriendId_[self.friendRequestDataList_[arg_4_1].friendId] = self.friendInfoOfFriendId_[self.friendRequestDataList_[arg_4_1].friendId] or FriendsData:GetInfoByID(self.friendRequestDataList_[arg_4_1].friendId)

	arg_4_2:SetData(self.friendRequestDataList_[arg_4_1], self.friendInfoOfFriendId_[self.friendRequestDataList_[arg_4_1].friendId])
end

function FishingGivePageView:AddUIListener()
	return
end

function FishingGivePageView:AddEventListeners()
	self:RegistEventListener(FRIENDS_REQUEST_FISH_INFO_CHANGE, function()
		self.friendRequestDataList_ = FishingData:GetFriendRequestFishInfo()

		self:UpdateView()
	end)
end

function FishingGivePageView:OnTop()
	self:UpdateBar()
end

function FishingGivePageView:UpdateBar()
	return
end

function FishingGivePageView:OnEnter()
	self.uiList_:StartScroll(0)
	self:AddEventListeners()
	FishingAction.GetFriendNeedFish(ActivityConst.SUMMER_FISHING)
end

function FishingGivePageView:OnExit()
	self:RemoveAllEventListener()
end

function FishingGivePageView:UpdateView()
	self.uiList_:StartScroll(#self.friendRequestDataList_)
end

function FishingGivePageView:OnMainHomeViewTop()
	return
end

function FishingGivePageView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	FishingGivePageView.super.Dispose(self)
end

return FishingGivePageView
