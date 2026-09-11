local AffixDetailView = class("AffixDetailView", ReduxView)

function AffixDetailView:UIName()
	return "UI/Affix/AffixDetailUI"
end

function AffixDetailView:UIParent()
	return manager.ui.uiPop.transform
end

function AffixDetailView:OnCtor()
	return
end

function AffixDetailView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AffixDetailView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, AffixDetailItemView)
end

function AffixDetailView:IndexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.affixList_[arg_6_1])
end

function AffixDetailView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function AffixDetailView:AddEventListeners()
	return
end

function AffixDetailView:OnTop()
	return
end

function AffixDetailView:OnBehind()
	return
end

function AffixDetailView:UpdateBar()
	return
end

function AffixDetailView:OnEnter()
	self:AddEventListeners()

	self.affixList_ = self.params_.affixList

	self.uiList_:StartScroll(#self.affixList_)
end

function AffixDetailView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function AffixDetailView:OnMainHomeViewTop()
	return
end

function AffixDetailView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	AffixDetailView.super.Dispose(self)
end

return AffixDetailView
