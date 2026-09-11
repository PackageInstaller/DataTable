local SpringWelfareLetterBoxView = class("SpringWelfareLetterBoxView", ReduxView)
local var_0_1 = {
	PLAYER = 1,
	SYSTEM = 0
}

function SpringWelfareLetterBoxView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeMailUI"
end

function SpringWelfareLetterBoxView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringWelfareLetterBoxView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.page_ = var_0_1.SYSTEM
	self.pageController_ = ControllerUtil.GetController(self.transform_, "tap")
	self.letterUiList_ = LuaList.New(handler(self, self.IndexItem), self.letterListGo_, SpringWelfareLetterBoxItem)

	self:UpdateLetterList()
end

function SpringWelfareLetterBoxView:OnEnter()
	self:RefreshUI()
end

function SpringWelfareLetterBoxView:OnExit()
	return
end

function SpringWelfareLetterBoxView:OnTop()
	SetActive(self.gameObject_, true)
end

function SpringWelfareLetterBoxView:OnBehind()
	SetActive(self.gameObject_, false)
end

function SpringWelfareLetterBoxView:Dispose()
	self.letterUiList_:Dispose()
	SpringWelfareLetterBoxView.super.Dispose(self)
end

function SpringWelfareLetterBoxView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.systemBtn_, nil, function()
		self:SwitchPage(var_0_1.SYSTEM)
	end)
	self:AddBtnListener(self.playerBtn_, nil, function()
		self:SwitchPage(var_0_1.PLAYER)
	end)
end

function SpringWelfareLetterBoxView:RefreshUI()
	if self.page_ == var_0_1.SYSTEM then
		self:RefreshSystemLetterUI()
	elseif self.page_ == var_0_1.PLAYER then
		self:RefreshPlayerLetterUI()
	end

	self.letterUiList_:Refresh()
end

function SpringWelfareLetterBoxView:RefreshSystemLetterUI()
	self.letterUiList_:StartScroll(#self.systemLetterIdList_)
	self.pageController_:SetSelectedState("system")
end

function SpringWelfareLetterBoxView:RefreshPlayerLetterUI()
	if SpringWelfareData:IsFetched() then
		self.letterUiList_:StartScroll(#self.playerLetterIdList_)
	else
		self.letterUiList_:StartScroll(0)
	end

	self.pageController_:SetSelectedState("player")
end

function SpringWelfareLetterBoxView:OnLetterPlayerInfoFetched()
	self:RefreshPlayerLetterUI()
end

function SpringWelfareLetterBoxView:SwitchPage(arg_17_1)
	if self.page_ == arg_17_1 then
		return
	end

	self.page_ = arg_17_1

	self:RefreshUI()
end

function SpringWelfareLetterBoxView:UpdateLetterList()
	self.systemLetterIdList_ = SpringWelfareData:GetSystemLetterIdList()
	self.playerLetterIdList_ = SpringWelfareData:GetPlayerLetterIdList()
end

function SpringWelfareLetterBoxView:IndexSystemLetter(arg_19_1, arg_19_2)
	arg_19_2:SetLetterServerId(self.systemLetterIdList_[arg_19_1])
	arg_19_2:RefreshUI()
end

function SpringWelfareLetterBoxView:IndexPlayerLetter(arg_20_1, arg_20_2)
	arg_20_2:SetLetterServerId(self.playerLetterIdList_[arg_20_1])
	arg_20_2:RefreshUI()
end

function SpringWelfareLetterBoxView:IndexItem(arg_21_1, arg_21_2)
	if self.page_ == var_0_1.SYSTEM then
		self:IndexSystemLetter(arg_21_1, arg_21_2)
	elseif self.page_ == var_0_1.PLAYER then
		self:IndexPlayerLetter(arg_21_1, arg_21_2)
	end
end

function SpringWelfareLetterBoxView:OnNewDay()
	self:UpdateLetterList()
	self:RefreshUI()
end

function SpringWelfareLetterBoxView:OnActivitySpringWelfareInit()
	self:OnNewDay()
end

function SpringWelfareLetterBoxView:OnFriendsListChange()
	for iter_24_0, iter_24_1 in ipairs(self.letterUiList_:GetItemList()) do
		iter_24_1:OnFriendsListChange()
	end
end

function SpringWelfareLetterBoxView:GetActivityID()
	return self.params_.activityId
end

return SpringWelfareLetterBoxView
