local RecallPageBase = class("RecallPageBase", ReduxView)

function RecallPageBase:Init()
	self:InitUI()
	self:AddUIListener()
end

function RecallPageBase:InitUI()
	return
end

function RecallPageBase:AddUIListener()
	return
end

function RecallPageBase:UpdateBar()
	return
end

function RecallPageBase:OnEnter()
	return
end

function RecallPageBase:OnExit()
	return
end

function RecallPageBase:Hide()
	SetActive(self.gameObject_, false)
end

function RecallPageBase:Show()
	SetActive(self.gameObject_, true)
end

function RecallPageBase:Dispose()
	RecallPageBase.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return RecallPageBase
