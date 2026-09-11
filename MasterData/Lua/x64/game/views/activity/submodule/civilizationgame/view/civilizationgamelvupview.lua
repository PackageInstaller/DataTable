local CivilizationGameLvUpView = class("CivilizationGameLvUpView", ReduxView)

function CivilizationGameLvUpView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Culture/V4_2_GodEaterUI_Culture_lvlPopUI"
end

function CivilizationGameLvUpView:UIParent()
	return manager.ui.uiPop.transform
end

function CivilizationGameLvUpView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CivilizationGameLvUpView:InitUI()
	self:BindCfgUI()
end

function CivilizationGameLvUpView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		JumpTools.Back()
		civilization.CivilizationLuaBridge.OnCloseLuaPage()
	end)
end

function CivilizationGameLvUpView:OnEnter()
	self:UpdateView()
end

function CivilizationGameLvUpView:UpdateView()
	self.tipsText_.text = ActivityCivilizationSettingCfg[self.params_.lastAge].desc
end

function CivilizationGameLvUpView:OnExit()
	manager.windowBar:HideBar()
end

function CivilizationGameLvUpView:OnTop()
	self.mainAni_:Play("UI_V4_2_GodEaterUI_Culture_lvlPopUI")
	manager.windowBar:HideBar()
end

function CivilizationGameLvUpView:Dispose()
	CivilizationGameLvUpView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CivilizationGameLvUpView
