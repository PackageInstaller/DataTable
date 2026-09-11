local SpringFestivalZumaTipsView = class("SpringFestivalZumaTipsView", ReduxView)

function SpringFestivalZumaTipsView:UIName()
	return "Widget/System/Activity_Skuld/Activity_Skuld_TipsPopUI"
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
	self:AddBtnListener(self.sureBtn_, nil, function()
		if self.params_.sureCallback then
			self.params_.sureCallback()
		end
	end)
end

function SpringFestivalZumaTipsView:OnEnter()
	self.contentText_.text = self.params_.textContent

	if self.params_.textContent then
		self.titleText_.text = self.params_.titleContent
	end
end

function SpringFestivalZumaTipsView:OnExit()
	return
end

function SpringFestivalZumaTipsView:Dispose()
	SpringFestivalZumaTipsView.super.Dispose(self)
end

return SpringFestivalZumaTipsView
