local AbyssTipView = class("AbyssTipView", ReduxView)

function AbyssTipView:UIName()
	return "Widget/System/Challenge_Abyss/AbyssTips"
end

function AbyssTipView:UIParent()
	return manager.ui.uiPop.transform
end

function AbyssTipView:OnCtor()
	return
end

function AbyssTipView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AbyssTipView:InitUI()
	self:BindCfgUI()
end

function AbyssTipView:AddUIListener()
	return
end

function AbyssTipView:AddEventListeners()
	return
end

function AbyssTipView:OnTop()
	self:UpdateBar()
end

function AbyssTipView:OnBehind()
	manager.windowBar:HideBar()
end

function AbyssTipView:UpdateBar()
	self:ShowDefaultBar()
end

function AbyssTipView:OnEnter()
	self:AddEventListeners()
end

function AbyssTipView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function AbyssTipView:OnMainHomeViewTop()
	return
end

function AbyssTipView:OnAbyssRefresh()
	JumpTools.OpenPageByJump("/abyssMain", {
		refresh = true
	})
end

function AbyssTipView:Dispose()
	AbyssTipView.super.Dispose(self)
end

return AbyssTipView
