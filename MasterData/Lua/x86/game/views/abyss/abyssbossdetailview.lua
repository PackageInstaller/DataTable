local AbyssBossDetailView = class("AbyssBossDetailView", ReduxView)

function AbyssBossDetailView:UIName()
	return "Widget/System/Challenge_Abyss/AbyssBoss"
end

function AbyssBossDetailView:UIParent()
	return manager.ui.uiPop.transform
end

function AbyssBossDetailView:OnCtor()
	return
end

function AbyssBossDetailView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AbyssBossDetailView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, AbyssBossDetailItemView)
end

function AbyssBossDetailView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.bossIdList_[arg_6_1])
end

function AbyssBossDetailView:AddUIListener()
	self.uiList_:SetPageChangeHandler(handler(self, self.OnPageChange))
	self:AddBtnListener(self.leftBtn_, nil, function()
		if self.pageIndex_ > 1 then
			self.pageIndex_ = self.pageIndex_ - 1

			self.uiList_:SwitchToPage(self.pageIndex_)
		end
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		if self.pageIndex_ < self.maxLv_ then
			self.pageIndex_ = self.pageIndex_ + 1

			self.uiList_:SwitchToPage(self.pageIndex_)
		end
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function AbyssBossDetailView:OnPageChange(arg_11_1)
	self.pageIndex_ = arg_11_1

	self:RefreshBtn()
end

function AbyssBossDetailView:RefreshBtn()
	SetActive(self.leftBtn_.gameObject, self.pageIndex_ > 1)
	SetActive(self.rightBtn_.gameObject, self.pageIndex_ < #self.bossIdList_)
end

function AbyssBossDetailView:AddEventListeners()
	return
end

function AbyssBossDetailView:OnTop()
	self:UpdateBar()
end

function AbyssBossDetailView:OnBehind()
	manager.windowBar:HideBar()
end

function AbyssBossDetailView:UpdateBar()
	self:ShowDefaultBar()
end

function AbyssBossDetailView:OnEnter()
	self:AddEventListeners()

	self.pageIndex_ = 1
	self.bossIdList_ = self.params_.bossIdList

	self.uiList_:StartScroll(#self.bossIdList_)
	self:RefreshBtn()
end

function AbyssBossDetailView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function AbyssBossDetailView:OnMainHomeViewTop()
	return
end

function AbyssBossDetailView:OnAbyssRefresh()
	JumpTools.OpenPageByJump("/abyssMain", {
		refresh = true
	})
end

function AbyssBossDetailView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	AbyssBossDetailView.super.Dispose(self)
end

return AbyssBossDetailView
