local MoonPartyVisitView = class("MoonPartyVisitView", ReduxView)

function MoonPartyVisitView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonPartyVisitUI"
end

function MoonPartyVisitView:UIParent()
	return manager.ui.uiPop.transform
end

function MoonPartyVisitView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MoonPartyVisitView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, MoonPartyVisitItem)
	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
end

function MoonPartyVisitView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.refreshBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_7_0 = GameSetting.activity_mid_autumn_party_list_refresh_interval.value[1]
		local var_7_1 = MoonCakeData:GetRefreshRecommendPartyTime(self.activityID_)

		if var_7_1 and var_7_0 > manager.time:GetServerTime() - var_7_1 then
			ShowTips("MID_AUTUMN_FESTIVAL_TASK_REFRESH_PROMPT")

			return
		end

		MoonCakeAction.RefreshRecommendParty(self.activityID_)
	end)
	self:AddBtnListener(self.allVisitBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if self.type_ == MoonCakeConst.VISIT_TYPE.ALL then
			return
		end

		self:RefreshList(MoonCakeConst.VISIT_TYPE.ALL)
	end)
	self:AddBtnListener(self.friendVisitBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if self.type_ == MoonCakeConst.VISIT_TYPE.FRIEND then
			return
		end

		self:RefreshList(MoonCakeConst.VISIT_TYPE.FRIEND)
	end)
end

function MoonPartyVisitView:Dispose()
	self.scrollHelper_:Dispose()

	self.scrollHelper_ = nil

	MoonPartyVisitView.super.Dispose(self)
end

function MoonPartyVisitView:OnEnter()
	self.activityID_ = self.params_.activityID

	if self.params_.isReturnFromOther then
		self.params_.isReturnFromOther = false
		self.tempScrollPos_ = MoonCakeTools.GetTempVisitViewScrollPos(self.activityID_) or 0
	elseif self.params_.isBack then
		self.params_.isBack = false
		self.type_ = MoonCakeTools.GetTempVisitViewType(self.activityID_) or MoonCakeConst.VISIT_TYPE.ALL
		self.tempScrollPos_ = MoonCakeTools.GetTempVisitViewScrollPos(self.activityID_) or 0
	else
		self.type_ = MoonCakeConst.VISIT_TYPE.ALL
	end

	self:RefreshList(self.type_)
	self:RefreshProgress()
end

function MoonPartyVisitView:OnExit()
	MoonCakeTools.SetTempVisitViewType(self.activityID_, self.type_)
	MoonCakeTools.SetTempVisitViewScrollPos(self.activityID_, self.scrollHelper_:GetScrolledPosition())
end

function MoonPartyVisitView:RefreshList(arg_13_1)
	self.type_ = arg_13_1
	self.visitorDataList_ = {}

	if self.type_ == MoonCakeConst.VISIT_TYPE.ALL then
		self.visitorDataList_ = MoonCakeData:GetSortedRecommendPartyList(self.activityID_)
	elseif self.type_ == MoonCakeConst.VISIT_TYPE.FRIEND then
		self.visitorDataList_ = MoonCakeData:GetSortedFriendPartyList(self.activityID_)
	end

	self.selectController_:SetSelectedIndex(self.type_)

	if not self.tempScrollPos_ then
		self.scrollHelper_:StartScroll(#self.visitorDataList_)
	else
		self.scrollHelper_:StartScrollByPosition(#self.visitorDataList_, self.tempScrollPos_)

		self.tempScrollPos_ = nil
	end
end

function MoonPartyVisitView:RefreshProgress()
	self.progressText_.text = string.format("%d/%d", MoonCakeData:GetTodayVisitRewardTimes(self.activityID_), GameSetting.activity_mid_autumn_present_limit.value[1])
end

function MoonPartyVisitView:IndexItem(arg_15_1, arg_15_2)
	arg_15_2:SetData(self.type_, arg_15_1, self.visitorDataList_[arg_15_1], self.activityID_)
end

function MoonPartyVisitView:OnVisitOtherParty()
	self:Back()
end

function MoonPartyVisitView:OnPartyRecommendUpdate()
	self:RefreshList(self.type_)
end

return MoonPartyVisitView
