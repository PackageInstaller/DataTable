local CowboyAttributeView = class("CowboyAttributeView", ReduxView)

function CowboyAttributeView:UIName()
	return "Widget/System/Cowboy/CowboyAttributeUI"
end

function CowboyAttributeView:GetCustomScene()
	return HeroRaiseTrackConst.CustomScene.Cowboy
end

function CowboyAttributeView:UIParent()
	return manager.ui.uiMain.transform
end

function CowboyAttributeView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CowboyAttributeView:InitUI()
	self:BindCfgUI()
end

function CowboyAttributeView:AddUIListeners()
	return
end

function CowboyAttributeView:OnEnter()
	manager.windowBar:ShowDefaultBar()

	local var_7_0 = self:GetCustomSceneController()

	var_7_0:SwitchToShow()
	var_7_0:PlayHeroAnim("1083ui_dynamic", "Skill_Details_2", 0.2)
end

function CowboyAttributeView:OnTop()
	return
end

function CowboyAttributeView:OnBehind()
	return
end

function CowboyAttributeView:OnExit()
	return
end

function CowboyAttributeView:Dispose()
	CowboyAttributeView.super.Dispose(self)
end

return CowboyAttributeView
