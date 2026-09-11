local SpringFestivalZumaTipsView = class("SpringFestivalZumaTipsView", ReduxView)

function SpringFestivalZumaTipsView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com/SandPlay_Com_PopUI"
end

function SpringFestivalZumaTipsView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringFestivalZumaTipsView:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function SpringFestivalZumaTipsView:AddUIListener()
	self:AddBtnListener(self.cancelBtn_, nil, function()
		if self.params_.cancelCallback then
			self.params_.cancelCallback()
		end
	end)
	self:AddBtnListener(self.reBattleBtn_, nil, function()
		if self.params_.battleAction then
			self.params_.battleAction()
		end
	end)
	self:AddBtnListener(self.confirmBtn_, nil, function()
		if self.params_.sureCallback then
			self.params_.sureCallback()
		end
	end)
end

function SpringFestivalZumaTipsView:OnEnter()
	self.contentText_.text = self.params_.textContent
	self.titleText_.text = self.params_.titleContent

	if self.params_.battleAction then
		SetActive(self.reBattleBtn_, true)
	else
		SetActive(self.reBattleBtn_, false)
	end
end

function SpringFestivalZumaTipsView:OnExit()
	return
end

function SpringFestivalZumaTipsView:Dispose()
	SpringFestivalZumaTipsView.super.Dispose(self)
end

return SpringFestivalZumaTipsView
