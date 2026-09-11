local AdminCatExploreLevelView = class("AdminCatExploreLevelView", ReduxView)

function AdminCatExploreLevelView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdminCatExploreLevelView:InitUI()
	return
end

function AdminCatExploreLevelView:AddUIListener()
	return
end

function AdminCatExploreLevelView:UpdateBar()
	return
end

function AdminCatExploreLevelView:OnEnter()
	return
end

function AdminCatExploreLevelView:OnExit()
	return
end

function AdminCatExploreLevelView:Hide()
	SetActive(self.gameObject_, false)
end

function AdminCatExploreLevelView:Show()
	SetActive(self.gameObject_, true)
end

function AdminCatExploreLevelView:Dispose()
	AdminCatExploreLevelView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AdminCatExploreLevelView
