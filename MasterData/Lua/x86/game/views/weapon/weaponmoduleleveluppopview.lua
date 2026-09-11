local WeaponModuleLevelUpPopView = class("WeaponModuleLevelUpPopView", ReduxView)

function WeaponModuleLevelUpPopView:UIName()
	return "Widget/System/Hero_module/HeroModuleUpgradePopUI"
end

function WeaponModuleLevelUpPopView:UIParent()
	return manager.ui.uiPop.transform
end

function WeaponModuleLevelUpPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function WeaponModuleLevelUpPopView:InitUI()
	self:BindCfgUI()
end

function WeaponModuleLevelUpPopView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		gameContext:Go("/weaponModuleView", {
			heroID = self.heroID_
		})
	end)
end

function WeaponModuleLevelUpPopView:OnEnter()
	self.heroID_ = self.params_.heroID
	self.nameText_.text = GetI18NText(WeaponModuleCfg[self.heroID_].name)
	self.levelText_.text = HeroData:GetCurModuleLevel(self.heroID_)
	self.moduleImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponModule/" .. self.heroID_)
end

function WeaponModuleLevelUpPopView:Dispose()
	WeaponModuleLevelUpPopView.super.Dispose(self)
end

return WeaponModuleLevelUpPopView
