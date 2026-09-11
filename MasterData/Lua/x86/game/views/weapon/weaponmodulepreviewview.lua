local WeaponModulePreviewView = class("WeaponModulePreviewView", ReduxView)

function WeaponModulePreviewView:UIName()
	return "Widget/System/Hero_module/HeroModulePreviewPopUI"
end

function WeaponModulePreviewView:UIParent()
	return manager.ui.uiPop.transform
end

function WeaponModulePreviewView:Init()
	self:InitUI()
	self:AddUIListener()
end

function WeaponModulePreviewView:InitUI()
	self:BindCfgUI()

	self.attributeItems_ = {}
end

function WeaponModulePreviewView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		JumpTools.Back()
	end)
end

function WeaponModulePreviewView:OnEnter()
	self.heroID_ = self.params_.heroID
	self.nameText_.text = GetI18NText(WeaponModuleCfg[self.params_.heroID].name)
	self.levelText_.text = HeroData:GetModuleMaxLevel(self.heroID_)

	self:RefreshDes()
end

function WeaponModulePreviewView:RefreshDes()
	local var_8_0, var_8_1, var_8_2, var_8_3 = HeroTools.GetModuleAllDes(HeroData:GetAllModulePowersByHeroID(self.heroID_), self.heroID_, true)

	if var_8_0 == nil then
		SetActive(self.attrGo_, false)
	else
		SetActive(self.attrGo_, true)
		self:RefreshAttriItems(var_8_0)
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.attrGo_.transform)
	end

	if var_8_1 == nil then
		SetActive(self.skillGo_, false)
	else
		SetActive(self.skillGo_, true)

		self.skillText_.text = var_8_1

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.skillGo_.transform)
	end

	if var_8_2 == nil then
		SetActive(self.astrolabeGo_, false)
	else
		SetActive(self.astrolabeGo_, true)

		self.astrolabeText_.text = var_8_2

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.astrolabeGo_.transform)
	end

	if var_8_3 == nil then
		SetActive(self.servantGo_, false)
	else
		SetActive(self.servantGo_, true)

		self.servantText_.text = var_8_3

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.servantGo_.transform)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)

	self.contentTrans_.localPosition = Vector3.New(0, 0, 0)
end

function WeaponModulePreviewView:RefreshAttriItems(arg_9_1)
	local var_9_0 = 1

	for iter_9_0, iter_9_1 in pairs((HeroTools.MergeModuleAttribute(arg_9_1))) do
		if self.attributeItems_[var_9_0] == nil then
			self.attributeItems_[var_9_0] = WeaponModuleAttributeItem.New((GameObject.Instantiate(self.attriItemGo_, self.attriItemTrans_)))
		end

		self.attributeItems_[var_9_0]:SetData(iter_9_0, iter_9_1)

		var_9_0 = var_9_0 + 1
	end

	for iter_9_2, iter_9_3 in pairs(self.attributeItems_) do
		if iter_9_2 < var_9_0 then
			self.attributeItems_[iter_9_2]:SetIsShow(true)
		else
			self.attributeItems_[iter_9_2]:SetIsShow(false)
		end
	end
end

function WeaponModulePreviewView:Dispose()
	for iter_10_0, iter_10_1 in pairs(self.attributeItems_) do
		iter_10_1:Dispose()
	end

	WeaponModulePreviewView.super.Dispose(self)
end

return WeaponModulePreviewView
