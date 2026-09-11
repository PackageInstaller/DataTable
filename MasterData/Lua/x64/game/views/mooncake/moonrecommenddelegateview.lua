local MoonRecommendDelegateView = class("MoonRecommendDelegateView", ReduxView)

function MoonRecommendDelegateView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function MoonRecommendDelegateView:InitUI()
	self:BindCfgUI()

	self.delegateList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, MoonCakeDelegateItem)
end

function MoonRecommendDelegateView:Dispose()
	self.delegateList_:Dispose()

	self.delegateList_ = nil

	MoonRecommendDelegateView.super.Dispose(self)
end

function MoonRecommendDelegateView:Show(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function MoonRecommendDelegateView:SetData(arg_5_1, arg_5_2)
	self.activityID_ = arg_5_1

	self:RefreshList(arg_5_2)
	self:RefreshProgress()
end

function MoonRecommendDelegateView:RefreshList(arg_6_1)
	self.delegateDataList_ = MoonCakeData:GetSortRecommendDelegateList(self.activityID_)

	if not arg_6_1 then
		self.delegateList_:StartScroll(#self.delegateDataList_)
	else
		self.delegateList_:StartScrollByPosition(#self.delegateDataList_, arg_6_1)
	end
end

function MoonRecommendDelegateView:RefreshProgress()
	local var_7_0 = GameSetting.activity_mid_autumn_entrust_finish_limit.value[1]
	local var_7_1 = MoonCakeData:GetTodaySubmitTimes(self.activityID_)

	var_7_1 = var_7_1 <= GameSetting.activity_mid_autumn_entrust_finish_limit.value[1] and var_7_1 or var_7_0
	self.progressText_.text = string.format("%s/%s", var_7_0 - var_7_1, var_7_0)
end

function MoonRecommendDelegateView:GetScrollPos()
	return self.delegateList_:GetScrolledPosition()
end

function MoonRecommendDelegateView:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.delegateDataList_[arg_9_1], self.activityID_)
end

function MoonRecommendDelegateView:PageRegisterEvent()
	self:RegistEventListener(MOON_DELEGATE_SUBMIT, handler(self, self.OnSubmitDelegate))
	self:RegistEventListener(MOON_RECOMMEND_DELEGATE_UPDATE, handler(self, self.OnRefreshRecommendDelegate))
end

function MoonRecommendDelegateView:PageRemoveEvent()
	self:RemoveAllEventListener()
end

function MoonRecommendDelegateView:OnSubmitDelegate()
	for iter_12_0, iter_12_1 in pairs((self.delegateList_:GetItemList())) do
		iter_12_1:RefreshUI()
	end

	self:RefreshProgress()
end

function MoonRecommendDelegateView:OnRefreshRecommendDelegate()
	self:RefreshList()
end

function MoonRecommendDelegateView:OnFriendsListChange()
	for iter_14_0, iter_14_1 in pairs((self.delegateList_:GetItemList())) do
		iter_14_1:RefreshFriend()
	end
end

return MoonRecommendDelegateView
