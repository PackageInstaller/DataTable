local FollowPopView = class("FollowPopView", ReduxView)

function FollowPopView:UIName()
	return "Widget/System/Medium/SubscribeUI"
end

function FollowPopView:UIParent()
	return manager.ui.uiPop.transform
end

function FollowPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FollowPopView:InitUI()
	self:BindCfgUI()
end

function FollowPopView:AddUIListener()
	self:AddBtnListener(self.okbtnBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
end

function FollowPopView:OnEnter()
	return
end

function FollowPopView:OnExit()
	return
end

function FollowPopView:Dispose()
	FollowPopView.super.Dispose(self)
end

return FollowPopView
