local WeaponModuleLevelUpView = class("WeaponModuleLevelUpView", ReduxView)
local var_0_1 = "F6302F"

function WeaponModuleLevelUpView:UIName()
	return "Widget/System/Hero_module/HeroModuleUpgradeUI"
end

function WeaponModuleLevelUpView:UIParent()
	return manager.ui.uiMain.transform
end

function WeaponModuleLevelUpView:Init()
	self:InitUI()
	self:AddUIListener()
end

function WeaponModuleLevelUpView:InitUI()
	self:BindCfgUI()

	self.attributeItems_ = {}
	self.conditionItems_ = {}
	self.costItems_ = {}

	for iter_4_0 = 1, 3 do
		self.costItems_[iter_4_0] = CommonItemView.New(self["itemGo" .. iter_4_0 .. "_"])
	end
end

function WeaponModuleLevelUpView:AddUIListener()
	self:AddBtnListener(self.unlockBtn_, nil, function()
		local var_6_0

		if self.conditionList_ and self.conditionList_[1] then
			for iter_6_0, iter_6_1 in pairs(self.conditionList_) do
				if not IsConditionAchieved(iter_6_1, {
					heroId = self.heroID_
				}) then
					ShowTips("WEAPON_MODULE_UNLOCK_CONDITION_NOT_FINISH")

					return
				end
			end

			var_6_0 = {}
		end

		for iter_6_2, iter_6_3 in pairs(WeaponModuleCfg[self.heroID_].cost[HeroData:GetCurModuleLevel(self.heroID_) + 1]) do
			if iter_6_3[1] ~= 2 then
				table.insert(var_6_0, iter_6_3)
			end
		end

		for iter_6_4, iter_6_5 in pairs(var_6_0) do
			if iter_6_5[2] > ItemTools.getItemNum(iter_6_5[1]) then
				ShowTips("WEAPON_MODULE_UNLOCK_NOT_ENOUGH")

				return
			end
		end

		if not checkGold(self.cost_, true) then
			return
		end

		HeroAction.TryToLevelUpModule(self.heroID_)
	end)
	self:AddBtnListener(self.astrolabeinfoBtn_, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs(self.effects_) do
			if WeaponModuleEffectCfg[iter_7_1].type == 3 then
				table.insert(var_7_0, iter_7_1)
			end
		end

		JumpTools.OpenPageByJump("weaponModuleGodInfoView", {
			effectList = var_7_0,
			heroID = self.heroID_
		})
	end)
	self:AddBtnListener(self.servantinfoBtn_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(self.effects_) do
			if WeaponModuleEffectCfg[iter_8_1].type == 3 then
				table.insert(var_8_0, iter_8_1)
			end
		end

		JumpTools.OpenPageByJump("weaponModuleServantInfoView", {
			effectList = var_8_0,
			heroID = self.heroID_
		})
	end)
end

function WeaponModuleLevelUpView:OnEnter()
	self:UpdateBar()

	self.lockController_ = self.controllerEx_:GetController("lock")
	self.heroID_ = self.params_.heroID

	self:RefreshUI()
end

function WeaponModuleLevelUpView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetGameHelpKey("WEAPON_MODULE_DESCRIPE")
end

function WeaponModuleLevelUpView:OnTop()
	self.goldNum_.text = checkGold(self.cost_, false) and "<color=#D2D9E1>" .. self.cost_ .. "</color>" or "<color=#F6302F>" .. self.cost_ .. "</color>"

	self:UpdateBar()
end

function WeaponModuleLevelUpView:RefreshUI()
	self.nameText_.text = GetI18NText(WeaponModuleCfg[self.params_.heroID].name)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.titleTrans_)

	self.moduleImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponModule/" .. self.heroID_)

	local var_12_0 = HeroData:GetCurModuleLevel(self.heroID_)

	self.curLevelText_.text = var_12_0
	self.nextLevelText_.text = var_12_0 + 1

	self:RefreshDes()

	self.conditionList_ = WeaponModuleCfg[self.params_.heroID].condition[HeroData:GetCurModuleLevel(self.heroID_) + 1]
	self.conditionSourceList_ = WeaponModuleCfg[self.params_.heroID].condition_source[HeroData:GetCurModuleLevel(self.heroID_) + 1]

	self:RefreshCondition()
	self:RefreshCost()
	self:RefreshBtn()
end

function WeaponModuleLevelUpView:RefreshDes()
	self.effects_ = WeaponModuleCfg[self.params_.heroID].skill[HeroData:GetCurModuleLevel(self.heroID_) + 1]

	local var_13_0, var_13_1, var_13_2, var_13_3 = HeroTools.GetModuleAllDes(self.effects_, self.heroID_, true)

	if var_13_0 == nil then
		SetActive(self.attrGo_, false)
	else
		SetActive(self.attrGo_, true)
		self:RefreshAttriItems(var_13_0)
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.attrGo_.transform)
	end

	if var_13_1 == nil then
		SetActive(self.skillGo_, false)
	else
		SetActive(self.skillGo_, true)

		self.skillText_.text = var_13_1

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.skillGo_.transform)
	end

	if var_13_2 == nil then
		SetActive(self.astrolabeGo_, false)
	else
		SetActive(self.astrolabeGo_, true)

		self.astrolabeText_.text = var_13_2

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.astrolabeGo_.transform)
	end

	if var_13_3 == nil then
		SetActive(self.servantGo_, false)
	else
		SetActive(self.servantGo_, true)

		self.servantText_.text = var_13_3

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.servantGo_.transform)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)

	self.contentTrans_.localPosition = Vector3.New(0, 0, 0)
end

function WeaponModuleLevelUpView:RefreshAttriItems(arg_14_1)
	local var_14_0 = 1

	for iter_14_0, iter_14_1 in pairs((HeroTools.MergeModuleAttribute(arg_14_1))) do
		if self.attributeItems_[var_14_0] == nil then
			self.attributeItems_[var_14_0] = WeaponModuleAttributeItem.New((GameObject.Instantiate(self.attriItemGo_, self.attriItemTrans_)))
		end

		self.attributeItems_[var_14_0]:SetData(iter_14_0, iter_14_1)

		var_14_0 = var_14_0 + 1
	end

	for iter_14_2, iter_14_3 in pairs(self.attributeItems_) do
		if iter_14_2 < var_14_0 then
			self.attributeItems_[iter_14_2]:SetIsShow(true)
		else
			self.attributeItems_[iter_14_2]:SetIsShow(false)
		end
	end
end

function WeaponModuleLevelUpView:RefreshCondition()
	if self.conditionList_ and self.conditionList_[1] then
		SetActive(self.conditonParent_.gameObject, true)

		for iter_15_0, iter_15_1 in pairs(self.conditionList_) do
			if self.conditionItems_[iter_15_0] then
				self.conditionItems_[iter_15_0]:SetData(iter_15_1, self.heroID_, self.conditionSourceList_[iter_15_0])
			else
				self.conditionItems_[iter_15_0] = WeaponModuleConditionItem.New((GameObject.Instantiate(self.conditonGo_, self.conditonParent_)))

				self.conditionItems_[iter_15_0]:SetData(iter_15_1, self.heroID_, self.conditionSourceList_[iter_15_0])
			end
		end

		for iter_15_2, iter_15_3 in pairs(self.conditionItems_) do
			if #self.conditionList_ < iter_15_2 then
				iter_15_3:SetIsShow(false)
			else
				iter_15_3:SetIsShow(true)
			end
		end
	else
		SetActive(self.conditonParent_.gameObject, false)
	end
end

function WeaponModuleLevelUpView:RefreshCost()
	local var_16_0 = {}

	self.cost_ = 0

	for iter_16_0, iter_16_1 in pairs(WeaponModuleCfg[self.heroID_].cost[HeroData:GetCurModuleLevel(self.heroID_) + 1]) do
		if iter_16_1[1] == 2 then
			self.cost_ = iter_16_1[2]
			self.goldNum_.text = checkGold(self.cost_, false) and "<color=#D2D9E1>" .. iter_16_1[2] .. "</color>" or "<color=#F6302F>" .. iter_16_1[2] .. "</color>"
		else
			table.insert(var_16_0, iter_16_1)
		end
	end

	for iter_16_2, iter_16_3 in pairs(var_16_0) do
		local var_16_2 = ItemTools.getItemNum(iter_16_3[1])
		local var_16_3 = clone(ItemTemplateData)

		var_16_3.id = iter_16_3[1]

		local var_16_4 = {
			var_16_2,
			iter_16_3[2]
		}

		if var_16_2 < iter_16_3[2] then
			var_16_4[3] = var_0_1 or nil
		end

		var_16_3.bottomText = var_16_4
		var_16_3.hideBottomRightTextFlag = true

		function var_16_3.clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
				iter_16_3[1],
				iter_16_3[2]
			})
		end

		self.costItems_[iter_16_2]:SetData(var_16_3)
	end

	for iter_16_4 = 1, 3 do
		if iter_16_4 > #var_16_0 then
			self.costItems_[iter_16_4]:Show(false)
		else
			self.costItems_[iter_16_4]:Show(true)
		end
	end
end

function WeaponModuleLevelUpView:RefreshBtn()
	self.lockController_:SetSelectedIndex(1)

	if not HeroData:GetModuleAssignmentIsFinish(self.heroID_) then
		return
	end

	local var_18_0

	if self.conditionList_ and self.conditionList_[1] then
		for iter_18_0, iter_18_1 in pairs(self.conditionList_) do
			if not IsConditionAchieved(iter_18_1, {
				heroId = self.heroID_
			}) then
				return
			end
		end

		var_18_0 = {}
	end

	for iter_18_2, iter_18_3 in pairs(WeaponModuleCfg[self.heroID_].cost[HeroData:GetCurModuleLevel(self.heroID_) + 1]) do
		if iter_18_3[1] ~= 2 then
			table.insert(var_18_0, iter_18_3)
		end
	end

	for iter_18_4, iter_18_5 in pairs(var_18_0) do
		if iter_18_5[2] > ItemTools.getItemNum(iter_18_5[1]) then
			return
		end
	end

	self.lockController_:SetSelectedIndex(0)
end

function WeaponModuleLevelUpView:OnExit()
	manager.windowBar:HideBar()
end

function WeaponModuleLevelUpView:Dispose()
	for iter_20_0, iter_20_1 in pairs(self.attributeItems_) do
		iter_20_1:Dispose()
	end

	for iter_20_2, iter_20_3 in pairs(self.conditionItems_) do
		iter_20_3:Dispose()
	end

	for iter_20_4, iter_20_5 in pairs(self.costItems_) do
		iter_20_5:Dispose()
	end

	WeaponModuleLevelUpView.super.Dispose(self)
end

return WeaponModuleLevelUpView
