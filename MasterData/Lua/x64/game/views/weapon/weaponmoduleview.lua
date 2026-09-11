local WeaponModuleView = class("WeaponModuleView", ReduxView)

function WeaponModuleView:UIName()
	return "Widget/System/Hero_module/HeroModuleMainUI"
end

function WeaponModuleView:UIParent()
	return manager.ui.uiMain.transform
end

function WeaponModuleView:Init()
	self:InitUI()
	self:AddUIListener()
end

function WeaponModuleView:InitUI()
	self:BindCfgUI()

	self.moduleImage_.immediate = true
	self.statusController_ = ControllerUtil.GetController(self.viewTrans_, "status")
	self.attributeItems_ = {}
end

function WeaponModuleView:AddUIListener()
	self:AddBtnListener(self.storyBtn_, nil, function()
		JumpTools.OpenPageByJump("/weaponModuleStoryView", {
			heroID = self.heroID_
		})
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("weaponModulePreviewView", {
			heroID = self.heroID_
		})
	end)
	self:AddBtnListener(self.levelupBtn_, nil, function()
		JumpTools.OpenPageByJump("/weaponModuleLevelUpView", {
			heroID = self.heroID_
		})
	end)
	self:AddBtnListener(self.getBtn_, nil, function()
		JumpTools.OpenPageByJump("/weaponModuleUnlockView", {
			heroID = self.heroID_
		})
	end)
	self:AddBtnListener(self.astrolabeinfoBtn_, nil, function()
		local var_10_0
		local var_10_1 = self:GetModuleLevel()

		var_10_0 = var_10_1 > 0 and HeroData:GetCurModuleEffectListByType(self.heroID_, 3, var_10_1) or HeroData:GetLockModuleEffectListByType(self.heroID_, 3)

		JumpTools.OpenPageByJump("weaponModuleGodInfoView", {
			effectList = var_10_0,
			heroID = self.heroID_
		})
	end)
	self:AddBtnListener(self.servantinfoBtn_, nil, function()
		local var_11_0
		local var_11_1 = self:GetModuleLevel()

		var_11_0 = var_11_1 > 0 and HeroData:GetCurModuleEffectListByType(self.heroID_, 4, var_11_1) or HeroData:GetLockModuleEffectListByType(self.heroID_, 4)

		JumpTools.OpenPageByJump("weaponModuleServantInfoView", {
			effectList = var_11_0,
			heroID = self.heroID_
		})
	end)
end

function WeaponModuleView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("WEAPON_MODULE_DESCRIPE")

	self.heroID_ = self.params_.heroID

	self:RefreshUI()
	self:AddRedPoint()
end

function WeaponModuleView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("WEAPON_MODULE_DESCRIPE")
end

function WeaponModuleView:AddRedPoint()
	manager.redPoint:bindUIandKey(self.levelupBtn_.transform, RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. self.heroID_)
	manager.redPoint:bindUIandKey(self.getBtn_.transform, RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. self.heroID_)
end

function WeaponModuleView:GetModuleLevel()
	return HeroData:GetCurModuleLevel(self.heroID_)
end

function WeaponModuleView:GetModuleMaxLevel()
	return HeroData:GetModuleMaxLevel(self.heroID_)
end

function WeaponModuleView:GetEffectList()
	return HeroTools:GetModulePowersByHeroIDAndLevel(self.heroID_, self:GetModuleLevel())
end

function WeaponModuleView:RefreshUI()
	self.nameText_.text = GetI18NText(WeaponModuleCfg[self.heroID_].name)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.titleTrans_)

	self.moduleImage_.spriteSync = "TextureConfig/WeaponModule/" .. self.heroID_

	local var_18_0 = self:GetModuleLevel()

	if var_18_0 == 0 then
		self.statusController_:SetSelectedState("lock")

		self.stateTips_.text = GetTips("WEAPON_MODULE_LOCK")
	else
		self.stateTips_.text = GetTips("WEAPON_MODULE_UNLOCK")
		self.levelText_.text = var_18_0

		if var_18_0 >= self:GetModuleMaxLevel() then
			self.statusController_:SetSelectedState("max")
		else
			self.statusController_:SetSelectedState("unlock")
		end
	end

	self:RefreshDes()
end

function WeaponModuleView:RefreshDes()
	local var_19_1, var_19_2, var_19_3, var_19_4 = HeroTools.GetModuleAllDes(self:GetModuleLevel() == 0 and WeaponModuleCfg[self.heroID_].skill[1] or self:GetEffectList(), self.heroID_, true)

	if var_19_1 == nil then
		SetActive(self.attrGo_, false)
	else
		SetActive(self.attrGo_, true)
		self:RefreshAttriItems(var_19_1)
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.attrGo_.transform)
	end

	if var_19_2 == nil then
		SetActive(self.skillGo_, false)
	else
		SetActive(self.skillGo_, true)

		self.skillText_.text = var_19_2

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.skillGo_.transform)
	end

	if var_19_3 == nil then
		SetActive(self.astrolabeGo_, false)
	else
		SetActive(self.astrolabeGo_, true)

		self.astrolabeText_.text = var_19_3

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.astrolabeGo_.transform)
	end

	if var_19_4 == nil then
		SetActive(self.servantGo_, false)
	else
		SetActive(self.servantGo_, true)

		self.servantText_.text = var_19_4

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.servantGo_.transform)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)

	self.contentTrans_.localPosition = Vector3.New(0, 0, 0)
end

function WeaponModuleView:RefreshAttriItems(arg_20_1)
	local var_20_0 = 1

	for iter_20_0, iter_20_1 in pairs((HeroTools.MergeModuleAttribute(arg_20_1))) do
		if self.attributeItems_[var_20_0] == nil then
			self.attributeItems_[var_20_0] = WeaponModuleAttributeItem.New((GameObject.Instantiate(self.attriItemGo_, self.attriItemTrans_)))
		end

		self.attributeItems_[var_20_0]:SetData(iter_20_0, iter_20_1)

		var_20_0 = var_20_0 + 1
	end

	for iter_20_2, iter_20_3 in pairs(self.attributeItems_) do
		if iter_20_2 < var_20_0 then
			self.attributeItems_[iter_20_2]:SetIsShow(true)
		else
			self.attributeItems_[iter_20_2]:SetIsShow(false)
		end
	end
end

function WeaponModuleView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveRedPoint()
end

function WeaponModuleView:RemoveRedPoint()
	manager.redPoint:unbindUIandKey(self.levelupBtn_.transform, RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. self.heroID_)
	manager.redPoint:unbindUIandKey(self.getBtn_.transform, RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. self.heroID_)
end

function WeaponModuleView:Dispose()
	for iter_23_0, iter_23_1 in pairs(self.attributeItems_) do
		iter_23_1:Dispose()
	end

	WeaponModuleView.super.Dispose(self)
end

return WeaponModuleView
