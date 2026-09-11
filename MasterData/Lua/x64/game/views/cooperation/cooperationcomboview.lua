local CooperationComboView = class("CooperationComboView", ReduxView)

function CooperationComboView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdbuffUI"
end

function CooperationComboView:UIParent()
	return manager.ui.uiMain.transform
end

function CooperationComboView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CooperationComboView:InitUI()
	self:BindCfgUI()
end

function CooperationComboView:OnTop()
	manager.windowBar:SwitchBar({})
end

function CooperationComboView:AddUIListener()
	self:AddBtnListener(nil, self.m_mask, function()
		self:Back()
	end)
end

function CooperationComboView:OnExit()
	manager.windowBar:HideBar()
end

return CooperationComboView
