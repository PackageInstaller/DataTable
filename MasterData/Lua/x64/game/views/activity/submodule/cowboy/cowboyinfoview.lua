local CowboyInfoView = class("CowboyInfoView", ReduxView)

function CowboyInfoView:UIName()
	return CowboyTools.GetInfoUIName(self.params_.activityID)
end

function CowboyInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function CowboyInfoView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CowboyInfoView:InitUI()
	self:BindCfgUI()
end

function CowboyInfoView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function CowboyInfoView:OnEnter()
	self.text_.text = GetTips(CowboyTools.GetGameHelpKey(self.params_.activityID))
end

function CowboyInfoView:OnExit()
	return
end

function CowboyInfoView:Dispose()
	self:RemoveAllListeners()
	CowboyInfoView.super.Dispose(self)
end

return CowboyInfoView
