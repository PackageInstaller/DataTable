local AdminCatExploreFirstPopView = class("AdminCatExploreFirstPopView", ReduxView)

function AdminCatExploreFirstPopView:UIName()
	return "Widget/System/ExploreUI/ExploCalculusGoUI"
end

function AdminCatExploreFirstPopView:UIParent()
	return manager.ui.uiPop.transform
end

function AdminCatExploreFirstPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdminCatExploreFirstPopView:InitUI()
	self:BindCfgUI()
end

function AdminCatExploreFirstPopView:AddUIListener()
	self:AddBtnListener(self.maskBg_, nil, function()
		self:Back()
	end)
end

function AdminCatExploreFirstPopView:UpdateBar()
	return
end

function AdminCatExploreFirstPopView:UpdateView()
	return
end

function AdminCatExploreFirstPopView:OnEnter()
	self:UpdateView()
end

function AdminCatExploreFirstPopView:OnExit()
	return
end

function AdminCatExploreFirstPopView:Hide()
	SetActive(self.gameObject_, false)
end

function AdminCatExploreFirstPopView:Show()
	SetActive(self.gameObject_, true)
end

function AdminCatExploreFirstPopView:Dispose()
	AdminCatExploreFirstPopView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AdminCatExploreFirstPopView
