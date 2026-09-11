local MoonCakeDispatchDelegateView = class("MoonCakeDispatchDelegateView", ReduxView)

function MoonCakeDispatchDelegateView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonDelegateDispatchUI"
end

function MoonCakeDispatchDelegateView:UIParent()
	return manager.ui.uiPop.transform
end

function MoonCakeDispatchDelegateView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MoonCakeDispatchDelegateView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.clickCakeHandler_ = handler(self, self.OnClickCake)
	self.cakeItemList_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, MoonCakeItem)
end

function MoonCakeDispatchDelegateView:AddUIListener()
	self:AddBtnListener(self.dispatchBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if not self.targetCakeID_ then
			return
		end

		MoonCakeAction.DispatchDelegate(self.activityID_, self.targetCakeID_, function()
			self:Back()
		end)
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function MoonCakeDispatchDelegateView:Dispose()
	self.cakeItemList_:Dispose()

	self.cakeItemList_ = nil

	MoonCakeDispatchDelegateView.super.Dispose(self)
end

function MoonCakeDispatchDelegateView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.targetCakeID_ = nil

	self:RefreshUI()
	self:RefreshStatus()
end

function MoonCakeDispatchDelegateView:RefreshUI()
	self.cakeIdList_ = MoonCakeCfg.get_id_list_by_activity[self.activityID_]

	self.cakeItemList_:StartScroll(#self.cakeIdList_)
end

function MoonCakeDispatchDelegateView:IndexItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(MoonCakeCfg[self.cakeIdList_[arg_12_1]].moon_cakes, self.cakeIdList_[arg_12_1])
	arg_12_2:SetClickHandler(self.clickCakeHandler_)
	arg_12_2:SetSelect(self.targetCakeID_)
end

function MoonCakeDispatchDelegateView:RefreshStatus()
	if not self.targetCakeID_ then
		self.statusController_:SetSelectedState("off")
	else
		self.statusController_:SetSelectedState("on")

		self.dispatchCakeName_.text = ItemTools.getItemName(MoonCakeCfg[self.targetCakeID_].moon_cakes)
		self.dispatchCakeIcon_.sprite = ItemTools.getItemSprite(MoonCakeCfg[self.targetCakeID_].moon_cakes)
	end
end

function MoonCakeDispatchDelegateView:OnClickCake(arg_14_1)
	self.targetCakeID_ = arg_14_1

	for iter_14_0, iter_14_1 in pairs((self.cakeItemList_:GetItemList())) do
		iter_14_1:SetSelect(arg_14_1)
	end

	self:RefreshStatus()
end

return MoonCakeDispatchDelegateView
