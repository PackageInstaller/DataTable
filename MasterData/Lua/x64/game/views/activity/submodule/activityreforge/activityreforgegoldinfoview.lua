local ActivityReforgeGoldInfoView = class("ActivityReforgeGoldInfoView", ReduxView)

function ActivityReforgeGoldInfoView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeGoldInfoUI"
end

function ActivityReforgeGoldInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityReforgeGoldInfoView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityReforgeGoldInfoView:InitUI()
	self:BindCfgUI()
end

function ActivityReforgeGoldInfoView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityReforgeGoldInfoView:OnExit()
	manager.windowBar:HideBar()
end

function ActivityReforgeGoldInfoView:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.Back()
	end)
end

function ActivityReforgeGoldInfoView:Dispose()
	self.super.Dispose(self)
end

return ActivityReforgeGoldInfoView
