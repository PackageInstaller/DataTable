local WeaponModuleUnlockView = class("WeaponModuleUnlockView", ReduxView)
local var_0_1 = "F6302F"

function WeaponModuleUnlockView:UIName()
	return "Widget/System/Hero_module/HeroModuleUnlockUI"
end

function WeaponModuleUnlockView:UIParent()
	return manager.ui.uiMain.transform
end

function WeaponModuleUnlockView:Init()
	self:InitUI()
	self:AddUIListener()
end

function WeaponModuleUnlockView:InitUI()
	self:BindCfgUI()

	self.attributeItems_ = {}
	self.conditionItems_ = {}
	self.costItems_ = {}

	for iter_4_0 = 1, 3 do
		self.costItems_[iter_4_0] = CommonItemView.New(self["itemGo" .. iter_4_0 .. "_"])
	end

	self.taskController_ = ControllerUtil.GetController(self.taskTrans_, "mission")
end

function WeaponModuleUnlockView:AddUIListener()
	self:AddBtnListener(self.unlockBtn_, nil, function()
		if not HeroData:GetModuleAssignmentIsFinish(self.heroID_) then
			ShowTips("WEAPON_MODULE_UNLOCK_TASK_NOT_COMPLETED")

			return
		end

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

		for iter_6_2, iter_6_3 in pairs(WeaponModuleCfg[self.heroID_].cost[1]) do
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
		JumpTools.OpenPageByJump("weaponModuleGodInfoView", {
			effectList = HeroData:GetLockModuleEffectListByType(self.heroID_, 3),
			heroID = self.heroID_
		})
	end)
	self:AddBtnListener(self.servantinfoBtn_, nil, function()
		JumpTools.OpenPageByJump("weaponModuleServantInfoView", {
			effectList = HeroData:GetLockModuleEffectListByType(self.heroID_, 4),
			heroID = self.heroID_
		})
	end)
	self:AddBtnListener(self.taskGotoBtn_, nil, function()
		JumpTools.JumpToPage(WeaponModuleCfg[self.heroID_].source)
	end)
end

function WeaponModuleUnlockView:OnEnter()
	self:UpdateBar()

	self.lockController_ = self.controllerEx_:GetController("lock")
	self.heroID_ = self.params_.heroID

	self:RegistEventListener(CURRENCY_UPDATE, function(arg_11_0)
		if arg_11_0 == CurrencyConst.CURRENCY_TYPE_GOLD then
			HeroAction.UpdateModuleRedPointByHeroID(self.heroID_)
		end
	end)
	self:RefreshUI()
end

function WeaponModuleUnlockView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetGameHelpKey("WEAPON_MODULE_DESCRIPE")
end

function WeaponModuleUnlockView:OnTop()
	self.goldNum_.text = checkGold(self.cost_, false) and "<color=#D2D9E1>" .. self.cost_ .. "</color>" or "<color=#F6302F>" .. self.cost_ .. "</color>"

	self:RefreshBtn()
	self:UpdateBar()
end

function WeaponModuleUnlockView:RefreshUI()
	local var_14_0 = WeaponModuleCfg[self.params_.heroID]

	self.nameText_.text = GetI18NText(WeaponModuleCfg[self.params_.heroID].name)

	self:RefreshDes()

	self.taskText_.text = GetI18NText(var_14_0.task_desc)

	if HeroData:GetModuleAssignmentIsFinish(self.heroID_) then
		self.taskController_:SetSelectedState("clear")
	else
		self.taskController_:SetSelectedState("notClear")
	end

	self.conditionList_ = var_14_0.condition[1]
	self.conditionSourceList_ = var_14_0.condition_source[1]

	self:RefreshCondition()
	self:RefreshCost()
	self:RefreshBtn()
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.taskTrans_)
end

function WeaponModuleUnlockView:RefreshBtn()
	self.lockController_:SetSelectedIndex(1)

	if not HeroData:GetModuleAssignmentIsFinish(self.heroID_) then
		return
	end

	local var_15_0

	if self.conditionList_ and self.conditionList_[1] then
		for iter_15_0, iter_15_1 in pairs(self.conditionList_) do
			if not IsConditionAchieved(iter_15_1, {
				heroId = self.heroID_
			}) then
				return
			end
		end

		var_15_0 = {}
	end

	for iter_15_2, iter_15_3 in pairs(WeaponModuleCfg[self.heroID_].cost[1]) do
		if iter_15_3[1] ~= 2 then
			table.insert(var_15_0, iter_15_3)
		end
	end

	for iter_15_4, iter_15_5 in pairs(var_15_0) do
		if iter_15_5[2] > ItemTools.getItemNum(iter_15_5[1]) then
			return
		end
	end

	self.lockController_:SetSelectedIndex(0)
end

function WeaponModuleUnlockView:RefreshDes()
	self.effects_ = WeaponModuleCfg[self.params_.heroID].skill[1]

	local var_16_0, var_16_1, var_16_2, var_16_3 = HeroTools.GetModuleAllDes(self.effects_, self.heroID_)

	if var_16_0 == nil then
		SetActive(self.attrGo_, false)
	else
		SetActive(self.attrGo_, true)
		self:RefreshAttriItems(var_16_0)
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.attrGo_.transform)
	end

	if var_16_1 == nil then
		SetActive(self.skillGo_, false)
	else
		SetActive(self.skillGo_, true)

		self.skillText_.text = var_16_1

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.skillGo_.transform)
	end

	if var_16_2 == nil then
		SetActive(self.astrolabeGo_, false)
	else
		SetActive(self.astrolabeGo_, true)

		self.astrolabeText_.text = var_16_2

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.astrolabeGo_.transform)
	end

	if var_16_3 == nil then
		SetActive(self.servantGo_, false)
	else
		SetActive(self.servantGo_, true)

		self.servantText_.text = var_16_3

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.servantGo_.transform)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)

	self.contentTrans_.localPosition = Vector3.New(0, 0, 0)
end

function WeaponModuleUnlockView:RefreshAttriItems(arg_17_1)
	local var_17_0 = 1

	for iter_17_0, iter_17_1 in pairs((HeroTools.MergeModuleAttribute(arg_17_1))) do
		if self.attributeItems_[var_17_0] == nil then
			self.attributeItems_[var_17_0] = WeaponModuleAttributeItem.New((GameObject.Instantiate(self.attriItemGo_, self.attriItemTrans_)))
		end

		self.attributeItems_[var_17_0]:SetData(iter_17_0, iter_17_1)

		var_17_0 = var_17_0 + 1
	end

	for iter_17_2, iter_17_3 in pairs(self.attributeItems_) do
		if iter_17_2 < var_17_0 then
			self.attributeItems_[iter_17_2]:SetIsShow(true)
		else
			self.attributeItems_[iter_17_2]:SetIsShow(false)
		end
	end
end

function WeaponModuleUnlockView:RefreshCondition()
	if self.conditionList_ and self.conditionList_[1] then
		SetActive(self.conditonParent_.gameObject, true)

		for iter_18_0, iter_18_1 in pairs(self.conditionList_) do
			if self.conditionItems_[iter_18_0] then
				self.conditionItems_[iter_18_0]:SetData(iter_18_1, self.heroID_, self.conditionSourceList_[iter_18_0])
			else
				self.conditionItems_[iter_18_0] = WeaponModuleConditionItem.New((GameObject.Instantiate(self.conditonGo_, self.conditonParent_)))

				self.conditionItems_[iter_18_0]:SetData(iter_18_1, self.heroID_, self.conditionSourceList_[iter_18_0])
			end
		end

		for iter_18_2, iter_18_3 in pairs(self.conditionItems_) do
			if #self.conditionList_ < iter_18_2 then
				iter_18_3:SetIsShow(false)
			else
				iter_18_3:SetIsShow(true)
			end
		end
	else
		SetActive(self.conditonParent_.gameObject, false)
	end
end

function WeaponModuleUnlockView:RefreshCost()
	local var_19_0 = {}

	self.cost_ = 0

	for iter_19_0, iter_19_1 in pairs(WeaponModuleCfg[self.heroID_].cost[1]) do
		if iter_19_1[1] == 2 then
			self.cost_ = iter_19_1[2]
			self.goldNum_.text = checkGold(self.cost_, false) and "<color=#D2D9E1>" .. iter_19_1[2] .. "</color>" or "<color=#F6302F>" .. iter_19_1[2] .. "</color>"
		else
			table.insert(var_19_0, iter_19_1)
		end
	end

	for iter_19_2, iter_19_3 in pairs(var_19_0) do
		local var_19_2 = ItemTools.getItemNum(iter_19_3[1])
		local var_19_3 = clone(ItemTemplateData)

		var_19_3.id = iter_19_3[1]

		local var_19_4 = {
			var_19_2,
			iter_19_3[2]
		}

		if var_19_2 < iter_19_3[2] then
			var_19_4[3] = var_0_1 or nil
		end

		var_19_3.bottomText = var_19_4
		var_19_3.hideBottomRightTextFlag = true

		function var_19_3.clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
				iter_19_3[1],
				iter_19_3[2]
			})
		end

		self.costItems_[iter_19_2]:SetData(var_19_3)
	end

	for iter_19_4 = 1, 3 do
		if iter_19_4 > #var_19_0 then
			self.costItems_[iter_19_4]:Show(false)
		else
			self.costItems_[iter_19_4]:Show(true)
		end
	end
end

function WeaponModuleUnlockView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function WeaponModuleUnlockView:Dispose()
	for iter_22_0, iter_22_1 in pairs(self.attributeItems_) do
		iter_22_1:Dispose()
	end

	for iter_22_2, iter_22_3 in pairs(self.conditionItems_) do
		iter_22_3:Dispose()
	end

	for iter_22_4, iter_22_5 in pairs(self.costItems_) do
		iter_22_5:Dispose()
	end

	WeaponModuleUnlockView.super.Dispose(self)
end

return WeaponModuleUnlockView
