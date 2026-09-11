local ServantBreakView = class("ServantBreakView", (import("game.views.pop.PopLevelUpBaseView")))

function ServantBreakView:UIName()
	return "Widget/System/Hero_servant/HeroServantLvupPopUI"
end

function ServantBreakView:UIParent()
	return manager.ui.uiPop.transform
end

function ServantBreakView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ServantBreakView:InitUI()
	self:BindCfgUI()
end

function ServantBreakView:AddUIListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		self:Back()
	end)
end

function ServantBreakView:OnEnter()
	self:CheckBack()
	self:RefreshBreakSuccess(self.params_.stage)
end

function ServantBreakView:OnExit()
	return
end

function ServantBreakView:RefreshBreakSuccess(arg_9_1)
	self.nextLevelTxt_.text = arg_9_1 + 1
	self.afterText_.text = arg_9_1
end

function ServantBreakView:Cacheable()
	return false
end

return ServantBreakView
