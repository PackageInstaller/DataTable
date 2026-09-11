local ZumaTipsView = class("ZumaTipsView", ReduxView)

function ZumaTipsView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaTipsPopup"
end

function ZumaTipsView:UIParent()
	return manager.ui.uiPop.transform
end

function ZumaTipsView:Init()
	self.selectTalentID = 0

	self:InitUI()
end

function ZumaTipsView:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		if self.cancelCallback then
			self.cancelCallback()
		end
	end)
	self:AddBtnListener(self.btn_noBtn_, nil, function()
		if self.cancelCallback then
			self.cancelCallback()
		end
	end)
	self:AddBtnListener(self.btn_yesBtn_, nil, function()
		if self.sureCallback then
			self.sureCallback()
		end
	end)
end

function ZumaTipsView:OnEnter()
	self.sureCallback = self.params_.sureCallback
	self.cancelCallback = self.params_.cancelCallback
	self.descText_.text = self.params_.textContent
	self.tittleText_.text = self.params_.titleContent
end

function ZumaTipsView:OnExit()
	return
end

function ZumaTipsView:Dispose()
	ZumaTipsView.super.Dispose(self)
end

return ZumaTipsView
