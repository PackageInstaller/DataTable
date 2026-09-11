local AbyssResetConfirmView = class("AbyssResetConfirmView", ReduxView)

function AbyssResetConfirmView:UIName()
	return "Widget/System/Challenge_Abyss/AbyssPupUI"
end

function AbyssResetConfirmView:UIParent()
	return manager.ui.uiPop.transform
end

function AbyssResetConfirmView:OnCtor()
	return
end

function AbyssResetConfirmView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AbyssResetConfirmView:InitUI()
	self:BindCfgUI()
end

function AbyssResetConfirmView:AddUIListener()
	return
end

function AbyssResetConfirmView:AddEventListeners()
	return
end

function AbyssResetConfirmView:OnTop()
	self:UpdateBar()
end

function AbyssResetConfirmView:OnBehind()
	manager.windowBar:HideBar()
end

function AbyssResetConfirmView:UpdateBar()
	return
end

function AbyssResetConfirmView:OnEnter()
	self:AddEventListeners()
end

function AbyssResetConfirmView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function AbyssResetConfirmView:OnMainHomeViewTop()
	return
end

function AbyssResetConfirmView:OnAbyssRefresh()
	JumpTools.OpenPageByJump("/abyssMain", {
		refresh = true
	})
end

function AbyssResetConfirmView:Dispose()
	AbyssResetConfirmView.super.Dispose(self)
end

return AbyssResetConfirmView
