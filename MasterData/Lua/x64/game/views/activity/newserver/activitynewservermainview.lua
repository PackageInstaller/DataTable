local ActivityNewServerMainView = class("ActivityNewServerMainView", ReduxView)

function ActivityNewServerMainView:UIName()
	return "Widget/System/NewServer/NewServerMenuUI"
end

function ActivityNewServerMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityNewServerMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityNewServerMainView:InitUI()
	self:BindCfgUI()

	self.pageClass = {
		NewServerSignPage,
		NewServerTaskPage,
		NewServerCapsuleToysPage,
		NewServerBPTaskPage,
		NewServerSupplyPage
	}
	self.pages_ = {}
	self.selectIndex_ = -1
	self.clickItemHandler_ = handler(self, self.SwitchPage)
	self.switchItemList_ = {}

	for iter_4_0 = 1, self.switchPanelTrans_.childCount do
		self.switchItemList_[iter_4_0] = ActivityNewServerSwitchItem.New(self.switchPanelTrans_:GetChild(iter_4_0 - 1).gameObject, iter_4_0)

		self.switchItemList_[iter_4_0]:SetClickCallBack(self.clickItemHandler_)
	end
end

function ActivityNewServerMainView:AddUIListener()
	self:RegistEventListener(SHOP_LIST_UPDATE, function(arg_6_0)
		self:ShopRefresh()
	end)
	self:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function(arg_7_0)
		if self.curPage_ then
			self.curPage_:SetData(self.activityID_)
		end
	end)
	self:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_8_0, arg_8_1)
		self:ShopRefresh()
	end)
end

function ActivityNewServerMainView:OnTop()
	self.curPage_:UpdateBar()
end

function ActivityNewServerMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.activityID_ = ActivityConst.ACTIVITY_NEW_SERVER

	if self.params_.selectIndex then
		self.params_.selectIndex = nil
		self.params_.Inited = true
	elseif self.params_.isBack == true then
		self.selectIndex_ = -1

		self:SwitchPage(self.params_.lastIndex)
	elseif not self.params_.Inited then
		self.params_.Inited = true
		self.selectIndex_ = -1

		self:SwitchPage(1)
	end

	self:BindRedPoint()
	self:RefreshTime()

	self.timer_ = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.timer_:Start()
end

function ActivityNewServerMainView:OnExit()
	manager.windowBar:HideBar()

	self.params_.lastIndex = self.selectIndex_

	self:RemoveAllEventListener()
	self:UnbindRedPoint()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	if self.curPage_ and self.curPage_.OnExit then
		self.curPage_:OnExit()
		self.curPage_:SetActive(false)
	end
end

function ActivityNewServerMainView:Dispose()
	self.params_.Inited = nil

	if self.curPage_ then
		self.curPage_:SetActive(false)

		self.curPage_ = nil
	end

	for iter_13_0, iter_13_1 in pairs(self.pages_) do
		iter_13_1:Dispose()
	end

	self.pages_ = nil

	for iter_13_2, iter_13_3 in ipairs(self.switchItemList_) do
		iter_13_3:Dispose()
	end

	self.switchItemList_ = nil

	ActivityNewServerMainView.super.Dispose(self)
end

function ActivityNewServerMainView:SwitchPage(arg_14_1)
	if arg_14_1 == self.selectIndex_ then
		return
	end

	self.selectIndex_ = arg_14_1

	self:RefreshSelect()

	if self.curPage_ then
		self.curPage_:OnExit()
		self.curPage_:SetActive(false)
	end

	self.pages_[arg_14_1] = self.pages_[arg_14_1] or self.pageClass[arg_14_1].New(self.contentTrans_)
	self.curPage_ = self.pages_[arg_14_1]

	self.curPage_:SetActive(true)
	self.curPage_:OnEnter()

	if self.params_.isBack == true then
		if self.curPage_.SetIsBack then
			self.curPage_:SetIsBack(self.params_.isBack)
		end

		self.params_.isBack = false
	end

	self.curPage_:SetData(self.activityID_)
	self.curPage_:UpdateBar()
end

function ActivityNewServerMainView:RefreshSelect()
	for iter_15_0, iter_15_1 in ipairs(self.switchItemList_) do
		iter_15_1:RefreshSelect(self.selectIndex_)
	end
end

function ActivityNewServerMainView:RefreshTime()
	self.remainTimeText_.text = string.format(GetTips("LEFT_TIME"), ActivityTools.GetActivityLostTimeStrWith2Unit(self.activityID_))

	if self.curPage_ and self.curPage_.RefreshTime then
		self.curPage_:RefreshTime()
	end
end

function ActivityNewServerMainView:OnTaskListChange()
	if self.curPage_ and self.curPage_.OnTaskListChange then
		self.curPage_:OnTaskListChange()
	end
end

function ActivityNewServerMainView:ShopRefresh()
	if self.curPage_ and self.curPage_.RefreshList then
		self.curPage_:RefreshList(true)
	end
end

function ActivityNewServerMainView:OnNewServerSign(arg_19_1)
	if self.curPage_ and self.curPage_.OnNewServerSign then
		self.curPage_:OnNewServerSign(arg_19_1)
	end
end

function ActivityNewServerMainView:OnShopBuyResult()
	self:ShopRefresh()
end

function ActivityNewServerMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.switchItemList_[1].transform_, RedPointConst.ACTIVITY_NEW_SERVER_SIGN)
	manager.redPoint:bindUIandKey(self.switchItemList_[2].transform_, RedPointConst.ACTIVITY_NEW_SERVER_TASK)
	manager.redPoint:bindUIandKey(self.switchItemList_[4].transform_, RedPointConst.ACTIVITY_NEW_SERVER_BP)
	manager.redPoint:bindUIandKey(self.switchItemList_[5].transform_, RedPointConst.ACTIVITY_NEW_SERVER_SUPPLY_FREE)
end

function ActivityNewServerMainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.switchItemList_[1].transform_, RedPointConst.ACTIVITY_NEW_SERVER_SIGN)
	manager.redPoint:unbindUIandKey(self.switchItemList_[2].transform_, RedPointConst.ACTIVITY_NEW_SERVER_TASK)
	manager.redPoint:unbindUIandKey(self.switchItemList_[4].transform_, RedPointConst.ACTIVITY_NEW_SERVER_BP)
	manager.redPoint:unbindUIandKey(self.switchItemList_[5].transform_, RedPointConst.ACTIVITY_NEW_SERVER_SUPPLY_FREE)
end

return ActivityNewServerMainView
