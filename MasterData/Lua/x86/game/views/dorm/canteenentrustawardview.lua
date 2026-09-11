local CanteenEntrustAwardView = class("CanteenEntrustAwardView", ReduxView)

function CanteenEntrustAwardView:UIName()
	return "Widget/BackHouseUI/canteen/EmptyDreamTaskToCompletePop"
end

function CanteenEntrustAwardView:UIParent()
	return manager.ui.uiPop.transform
end

function CanteenEntrustAwardView:OnCtor()
	return
end

function CanteenEntrustAwardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CanteenEntrustAwardView:InitUI()
	self:BindCfgUI()

	self.awardListScroll_ = LuaList.New(handler(self, self.indexAwardItem), self.awardviewuilistUilist_, CanteenEntrustAwardItem)
end

function CanteenEntrustAwardView:AddUIListener()
	self.awardListScroll_:SetPageChangeHandler(handler(self, self.UpdataButton))
	self:AddBtnListener(self.leftbtnBtn_, nil, function()
		self.index = self.index - 1

		self:UpdataButton(self.index)
		self.awardListScroll_:ScrollToIndex(self.index, true, false)
	end)
	self:AddBtnListener(self.rightbtnBtn_, nil, function()
		self.index = self.index + 1

		self:UpdataButton(self.index)
		self.awardListScroll_:ScrollToIndex(self.index, true, false)
	end)
	self:AddBtnListener(self.okbtnBtn_, nil, function()
		JumpTools.Back()
	end)
end

function CanteenEntrustAwardView:OnEnter()
	self.flag = self.params_.flag
	self.index = 1

	self:UpdataView()
end

function CanteenEntrustAwardView:UpdataButton(arg_11_1)
	self.index = arg_11_1

	if arg_11_1 == 1 then
		SetActive(self.leftbtnGo_, false)
	else
		SetActive(self.leftbtnGo_, true)
	end

	if arg_11_1 == #self.awardList then
		SetActive(self.rightbtnGo_, false)
	else
		SetActive(self.rightbtnGo_, true)
	end
end

function CanteenEntrustAwardView:UpdataView()
	self.awardList = CanteenEntrustData:GetEntrustFinishAwardList()

	self.awardListScroll_:StartScroll(#self.awardList)
	self:UpdataButton(self.index)
end

function CanteenEntrustAwardView:indexAwardItem(arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(self.awardList[arg_13_1], self.flag)
end

function CanteenEntrustAwardView:Dispose()
	if self.awardListScroll_ then
		self.awardListScroll_:Dispose()
	end

	CanteenEntrustAwardView.super.Dispose(self)
end

return CanteenEntrustAwardView
