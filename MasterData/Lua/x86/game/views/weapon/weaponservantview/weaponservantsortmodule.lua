local WeaponServantSortModule = class("WeaponServantSortModule", ReduxView)

function WeaponServantSortModule:UIName()
	return "Widget/System/Hero_servant/HeroServantSortUI"
end

function WeaponServantSortModule:UIParent()
	return manager.ui.uiPop.transform
end

function WeaponServantSortModule:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function WeaponServantSortModule:OnExit()
	return
end

function WeaponServantSortModule:OnEnter()
	return
end

function WeaponServantSortModule:OnDispose()
	self:RemoveAllListeners()
	WeaponServantSortModule.super.Dispose(self)
end

function WeaponServantSortModule:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:OnBackBtnClick()
	end)
end

function WeaponServantSortModule:OnBackBtnClick()
	self:Back()
end

return WeaponServantSortModule
