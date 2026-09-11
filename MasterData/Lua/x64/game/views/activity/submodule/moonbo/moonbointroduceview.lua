local MoonBoIntroduceView = class("MoonBoIntroduceView", ReduxView)

function MoonBoIntroduceView:UIName()
	return "UI/VolumeIIIUI/VolumeBocakeRuleUI"
end

function MoonBoIntroduceView:UIParent()
	return manager.ui.uiPop.transform
end

function MoonBoIntroduceView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function MoonBoIntroduceView:InitUI()
	self:BindCfgUI()
end

function MoonBoIntroduceView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function MoonBoIntroduceView:Dispose()
	MoonBoIntroduceView.super.Dispose(self)
end

return MoonBoIntroduceView
