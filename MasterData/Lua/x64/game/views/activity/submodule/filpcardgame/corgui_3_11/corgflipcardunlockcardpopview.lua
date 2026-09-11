local CORGflipCardUnlockCardPopView = class("CORGflipCardUnlockCardPopView", ReduxView)

function CORGflipCardUnlockCardPopView:UIName()
	return XH3rdFlipCardTool:GetUnlockPopUI()
end

function CORGflipCardUnlockCardPopView:UIParent()
	return manager.ui.uiPop.transform
end

function CORGflipCardUnlockCardPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CORGflipCardUnlockCardPopView:InitUI()
	self:BindCfgUI()

	self.cardItemList_ = {}
end

function CORGflipCardUnlockCardPopView:OnEnter()
	self.activityID_ = XH3rdFlipCardData:GetActivityID()
	self.cardList_ = XH3rdFlipCardData:GetNewCardList()

	self:RefreshUI()
end

function CORGflipCardUnlockCardPopView:RefreshUI()
	for iter_6_0, iter_6_1 in ipairs(self.cardItemList_) do
		SetActive(iter_6_1.gameObject_, false)
	end

	for iter_6_2, iter_6_3 in ipairs(self.cardList_) do
		self.cardItemList_[iter_6_2] = self.cardItemList_[iter_6_2] or CORGFlipCardItem.New((Object.Instantiate(self.cardItem_, self.cardContent_)))

		self.cardItemList_[iter_6_2]:SetData(iter_6_2, iter_6_3)
		SetActive(self.cardItemList_[iter_6_2].gameObject_, true)
	end

	self.fromNumText_.text = #XH3rdFlipCardData:GetUnlockCardList()
	self.toNumText_.text = #XH3rdFlipCardData:GetUnlockCardList() + #XH3rdFlipCardData:GetNewCardList()
end

function CORGflipCardUnlockCardPopView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		XH3rdFlipCardAction:sendViewCardRequest(self.activityID_, self.cardList_)
		self:Back()
	end)
end

function CORGflipCardUnlockCardPopView:Dispose()
	if self.cardItemList_ then
		for iter_9_0, iter_9_1 in ipairs(self.cardItemList_) do
			iter_9_1:Dispose()
		end

		self.cardItemList_ = nil
	end

	CORGflipCardUnlockCardPopView.super.Dispose(self)
end

function CORGflipCardUnlockCardPopView:OnExit()
	return
end

return CORGflipCardUnlockCardPopView
