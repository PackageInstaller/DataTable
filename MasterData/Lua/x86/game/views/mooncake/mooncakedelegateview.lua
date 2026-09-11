local MoonCakeDelegateView = class("MoonCakeDelegateView", ReduxView)

function MoonCakeDelegateView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeDelegateUI"
end

function MoonCakeDelegateView:UIParent()
	return manager.ui.uiPop.transform
end

function MoonCakeDelegateView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MoonCakeDelegateView:InitUI()
	self:BindCfgUI()

	self.ownDetailView_ = MoonOwnDelegateDetailView.New(self.ownDelegateViewGo_)
	self.recommendView_ = MoonRecommendDelegateView.New(self.recommendDelegateViewGo_)
	self.refreshController_ = ControllerUtil.GetController(self.transform_, "refresh")
	self.pageController_ = ControllerUtil.GetController(self.transform_, "page")
	self.pageConst_ = {
		recommend = 2,
		own = 1
	}
	self.pageBtnList_ = {
		self.ownDelegateBtn_,
		self.recommendBtn_
	}
	self.pageViewList_ = {
		self.ownDetailView_,
		self.recommendView_
	}
end

function MoonCakeDelegateView:AddUIListener()
	for iter_5_0, iter_5_1 in ipairs(self.pageBtnList_) do
		self:AddBtnListener(iter_5_1, nil, function()
			if self.curPageIndex_ and self.curPageIndex_ == iter_5_0 then
				return
			end

			self:SwitchPage(iter_5_0)
		end)
	end

	self:AddBtnListener(self.refreshBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if self.curPageIndex_ == self.pageConst_.recommend then
			if self.leftTime_ and self.leftTime_ > 0 then
				ShowTips("MID_AUTUMN_FESTIVAL_TASK_REFRESH_PROMPT")

				return
			end

			MoonCakeAction.QueryRecommendDelegate(self.activityID_, function()
				self:AddCdTimer()
			end)
		end
	end)
	self:AddBtnListener(self.recordBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("moonCakeDelegateRecord", {
			activityID = self.activityID_,
			recoverType = self.curPageIndex_
		})
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function MoonCakeDelegateView:Dispose()
	for iter_11_0, iter_11_1 in pairs(self.pageViewList_) do
		iter_11_1:Dispose()
	end

	self.pageViewList_ = nil

	MoonCakeDelegateView.super.Dispose(self)
end

function MoonCakeDelegateView:OnEnter()
	self.activityID_ = self.params_.activityID

	if self.params_.isBack then
		self.params_.isBack = false
		self.curPageIndex_ = MoonCakeTools.GetTempDelegateViewPageIndex(self.activityID_) or self.pageConst_.own

		if self.curPageIndex_ == self.pageConst_.recommend then
			self.tempScrollPos_ = MoonCakeTools.GetTempDelegateViewScrollPos(self.activityID_)
		end
	else
		self.curPageIndex_ = self.pageConst_.own
	end

	self:SwitchPage(self.curPageIndex_)
	self:PageRegisterEvent()
	self:BindRedPoint()
	self:AddCdTimer()
end

function MoonCakeDelegateView:OnExit()
	MoonCakeTools.SetTempDelegateViewPageIndex(self.activityID_, self.curPageIndex_)

	if self.curPageIndex_ == self.pageConst_.recommend then
		MoonCakeTools.SetTempDelegateViewScrollPos(self.activityID_, self.pageViewList_[self.curPageIndex_]:GetScrollPos())
	end

	self.pageViewList_[self.curPageIndex_]:Show(false)
	self:StopCdTimer()
	self:PageRemoveEvent()
	self:UnBindRedPoint()
end

function MoonCakeDelegateView:SwitchPage(arg_14_1)
	self.pageViewList_[self.curPageIndex_]:Show(false)

	self.curPageIndex_ = arg_14_1

	self.pageViewList_[self.curPageIndex_]:Show(true)
	self.pageViewList_[self.curPageIndex_]:SetData(self.activityID_, self.tempScrollPos_)

	if self.tempScrollPos_ then
		self.tempScrollPos_ = nil
	end

	self.pageController_:SetSelectedIndex(self.curPageIndex_ - 1)
end

function MoonCakeDelegateView:PageRegisterEvent()
	for iter_15_0, iter_15_1 in pairs(self.pageViewList_) do
		iter_15_1:PageRegisterEvent()
	end
end

function MoonCakeDelegateView:PageRemoveEvent()
	for iter_16_0, iter_16_1 in pairs(self.pageViewList_) do
		iter_16_1:PageRemoveEvent()
	end
end

function MoonCakeDelegateView:OnFriendsListChange()
	if self.pageViewList_[self.curPageIndex_].OnFriendsListChange then
		self.pageViewList_[self.curPageIndex_]:OnFriendsListChange()
	end
end

function MoonCakeDelegateView:AddCdTimer()
	self:StopCdTimer()

	self.leftTime_ = MoonCakeData:GetLastRefreshDelegateTime(self.activityID_) + GameSetting.activity_mid_autumn_entrust_list_refresh_interval.value[1] + 1 - manager.time:GetServerTime()

	if self.leftTime_ <= 0 then
		return
	end

	if GameSetting.activity_mid_autumn_entrust_list_refresh_interval.value[1] >= self.leftTime_ then
		self.cdTimeText_.text = self.leftTime_ or GameSetting.activity_mid_autumn_entrust_list_refresh_interval.value[1]
	end

	self.cdTimer_ = Timer.New(function()
		self.leftTime_ = self.leftTime_ - 1
		self.cdTimeText_.text = self.leftTime_

		if self.leftTime_ <= 0 then
			self:StopCdTimer()

			return
		end
	end, 1, -1)

	self.cdTimer_:Start()
	self.refreshController_:SetSelectedState("off")
end

function MoonCakeDelegateView:StopCdTimer()
	if self.cdTimer_ then
		self.cdTimer_:Stop()

		self.cdTimer_ = nil
	end

	self.refreshController_:SetSelectedState("on")

	self.leftTime_ = 0
end

function MoonCakeDelegateView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.ownDelegateBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_DELEGATE, self.activityID_)))
end

function MoonCakeDelegateView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.ownDelegateBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_DELEGATE, self.activityID_)))
end

return MoonCakeDelegateView
