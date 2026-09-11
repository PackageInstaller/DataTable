local WeaponModuleServantInfoView = class("WeaponModuleServantInfoView", ReduxView)

function WeaponModuleServantInfoView:UIName()
	return "Widget/System/Hero_module/HeroModuleKeyPopUI"
end

function WeaponModuleServantInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function WeaponModuleServantInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function WeaponModuleServantInfoView:InitUI()
	self:BindCfgUI()
end

function WeaponModuleServantInfoView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		JumpTools.Back()
	end)
end

function WeaponModuleServantInfoView:OnEnter()
	self.heroID_ = self.params_.heroID

	local var_7_0 = HeroTools.GetHeroSpecServant(self.heroID_)

	self.nameText1_.text = ItemTools.getItemName(var_7_0)
	self.nameText2_.text = ItemTools.getItemName(var_7_0)
	self.frontDesText_.text = GetCfgDescription(WeaponEffectCfg[WeaponServantCfg[var_7_0].effect[1]].description[1], 1, nil, nil, true)
	self.nextDesText_.text = GetCfgDescription(WeaponEffectCfg[WeaponServantCfg[var_7_0].effect[1]].strengthen_description[2], 1, nil, nil, true)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.frontcontentTrans_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.nextcontentTrans_)
end

function WeaponModuleServantInfoView:Dispose()
	WeaponModuleServantInfoView.super.Dispose(self)
end

return WeaponModuleServantInfoView
