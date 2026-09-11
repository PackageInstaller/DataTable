local EquipOneKeyCulturePopView = class("EquipOneKeyCulturePopView", ReduxView)

function EquipOneKeyCulturePopView:UIName()
	return "Widget/System/Hero_equip/Develop/HeroEquipLvupPopUI"
end

function EquipOneKeyCulturePopView:UIParent()
	return manager.ui.uiPop.transform
end

function EquipOneKeyCulturePopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EquipOneKeyCulturePopView:InitUI()
	self:BindCfgUI()

	self.descController_ = self.descCon_:GetController("desc")
	self.upgradeController_ = self.descCon_:GetController("showUpgrade")
	self.switchController_ = self.switchCon_:GetController("switch")
	self.btnController_ = self.btnCon_:GetController("btnState")
	self.itemScrollList_ = LuaList.New(handler(self, self.IndexItem), self.itemListGo_, CommonItemView)
end

function EquipOneKeyCulturePopView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.noBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.yesBtn_, nil, function()
		if not checkGold(self.costMoney_) then
			return
		end

		EquipAction.OneKeyStrength(tonumber(self.equipId_), self.useEquipList_, self.useMaterialList_, self.levelUpCost_, self.targetLevel_, self.upgradeTimes_)
		JumpTools.Back()
	end)
	self:AddBtnListener(self.subBtn_, nil, function()
		self.slider_.value = self.targetLevel_ - 1
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		self.slider_.value = self.targetLevel_ + 1
	end)
	self:AddBtnListener(self.upgradeBtn_, nil, function()
		self.upgradeState_ = not self.upgradeState_

		self.switchController_:SetSelectedState(self.upgradeState_ and "on" or "off")
		self:RefreshMaterialList(self.upgradeState_)
		self:RefrehStatus()
	end)
end

function EquipOneKeyCulturePopView:OnEnter()
	return
end

function EquipOneKeyCulturePopView:OnTop()
	manager.windowBar:SetAsLastSibling()
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)

	self.failReason_ = {}

	self:RefreshData()
	self:RefreshUI()
end

function EquipOneKeyCulturePopView:RefreshData()
	self.equipId_ = self.params_.equipId
	self.equip_ = EquipData:GetEquipData(self.equipId_)
	self.equipCfg_ = EquipCfg[self.equip_.prefab_id]
	self.nowLevel_ = self.equip_:GetLevel()
	self.isUpgrade_ = self.nowLevel_ >= self.equip_:GetMaxLv() and self.equip_.now_break_level < self.equipCfg_.break_times_max

	if self.equip_:GetLevel() >= self.equipCfg_.max_level[self.equipCfg_.break_times_max + 1] then
		JumpTools.Back()

		return
	end

	local var_14_0, var_14_1, var_14_2 = EquipTools.GetEquipLevelUpMaterial(0, 0, {
		self.equipId_
	}, 5)

	self.totalExp_, self.minExp_ = EquipTools.CountAddExp(var_14_1, var_14_2, true)
	self.cultureParams_ = EquipTools.CalculateCultueLevel(self.equip_, self.totalExp_, nil, self.isUpgrade_)
	self.failReason_.expMaxLevel = self.cultureParams_.expMaxLevel
	self.minLevel_ = math.max(self.nowLevel_ + 1, (math.min(self.equip_:GetMaxLv(), EquipTools.CountMinAddLevel(self.equip_, self.minExp_))))
	self.targetLevel_ = math.max(self.minLevel_, self.cultureParams_.maxLevel)
	self.failReason_.showUpgrade = self.cultureParams_.maxLevel % 10 == 0 and self.failReason_.expMaxLevel >= self.cultureParams_.maxLevel and self.targetLevel_ < EquipTools.CountEquipMaxLvWitnoutBreak(self.equip_)

	self:InitSlider()

	self.upgradeState_ = false

	self.switchController_:SetSelectedState("off")

	self.expSumIndex = "exp_sum_" .. self.equip_.star
end

function EquipOneKeyCulturePopView:InitSlider()
	self.maxLevel_ = EquipTools.CountEquipMaxLvWitnoutBreak(self.equip_)
	self.slider_.minValue = self.nowLevel_
	self.slider_.maxValue = self.maxLevel_
	self.slider_.value = self.targetLevel_

	if self.maxLevel_ - self.nowLevel_ <= 1 then
		self.subBtn_.interactable = false
		self.addBtn_.interactable = false
	else
		self.subBtn_.interactable = self.targetLevel_ > self.minLevel_
		self.addBtn_.interactable = self.targetLevel_ < self.maxLevel_
	end

	self.slider_.onValueChanged:AddListener(function(arg_16_0)
		self.subBtn_.interactable = arg_16_0 > self.minLevel_
		self.addBtn_.interactable = arg_16_0 < self.maxLevel_

		if arg_16_0 < self.minLevel_ then
			self.slider_.value = self.minLevel_
		else
			self:OnTargetLevelChange(arg_16_0)
		end
	end)
end

function EquipOneKeyCulturePopView:RefreshUI()
	self.leftLvTxt_.text = self.nowLevel_
	self.rightLvTxt_.text = self.targetLevel_

	self:RefreshMaterialList()
	self:RefrehStatus()
end

function EquipOneKeyCulturePopView:OnTargetLevelChange(arg_18_1)
	if self.targetLevel_ == arg_18_1 then
		return
	end

	self.targetLevel_ = arg_18_1
	self.rightLvTxt_.text = arg_18_1
	self.cultureParams_ = EquipTools.CalculateCultueLevel(self.equip_, self.totalExp_, self.targetLevel_)
	self.failReason_.expMaxLevel = self.cultureParams_.expMaxLevel
	self.failReason_.showUpgrade = self.cultureParams_.maxLevel % 10 == 0 and self.failReason_.expMaxLevel >= self.cultureParams_.maxLevel and self.targetLevel_ < EquipTools.CountEquipMaxLvWitnoutBreak(self.equip_)

	self:RefreshMaterialList()
	self:RefrehStatus()
end

function EquipOneKeyCulturePopView:RefreshMaterialList(arg_19_1)
	local var_19_0, var_19_1 = EquipTools.QuickSelectList(EquipExpCfg[self.targetLevel_][self.expSumIndex] - self.equip_.exp, {
		self.equipId_
	})

	self.itemList_ = {}
	self.useEquipList_ = var_19_1
	self.useMaterialList_ = var_19_0

	local var_19_2, var_19_3 = self:CaculateExpMaterial(var_19_0)

	for iter_19_0, iter_19_1 in ipairs(var_19_2) do
		table.insert(self.itemList_, iter_19_1)
	end

	self.maxExp_ = var_19_3

	local var_19_4, var_19_5 = self:CaculateUpgradeMaterial(arg_19_1)

	for iter_19_2, iter_19_3 in ipairs(var_19_4) do
		table.insert(self.itemList_, iter_19_3)
	end

	local var_19_6 = {}

	for iter_19_4, iter_19_5 in pairs(var_19_1) do
		table.insert(var_19_6, iter_19_5.equip_info)
	end

	for iter_19_6, iter_19_7 in pairs((EquipTools.EquipSort(var_19_6, 0, EquipConst.EQUIP_SORT.RARE))) do
		table.insert(self.itemList_, {
			isEquip = true,
			number = 1,
			id = iter_19_7.prefab_id
		})
	end

	self.itemScrollList_:StartScroll(#self.itemList_)

	self.levelUpCost_ = math.floor((EquipExpCfg[self.targetLevel_][self.expSumIndex] - self.equip_.exp) * GameSetting.equip_strengthen_gold_cost.value[1])
	self.costMoney_ = self.levelUpCost_ + var_19_5

	self:RefreshCostMoney()
end

function EquipOneKeyCulturePopView:RefrehStatus()
	local var_20_0 = true

	if self.failReason_.resetNotSatisfied then
		self.descController_:SetSelectedState("condition")

		self.conditionText_.text = GetTips("EQUIP_BREAK_LIMITED")
		var_20_0 = false
	elseif self.failReason_.upgradeMaterialLack then
		self.descController_:SetSelectedState("condition")

		self.conditionText_.text = GetTips("UPGRADE_MATERIAL_LACK")
		var_20_0 = false
	elseif self.failReason_.expMaterialLack and self.targetLevel_ > self.failReason_.expMaxLevel then
		self.descController_:SetSelectedState("condition")

		self.conditionText_.text = string.format(GetTips("LEVELUP_MATERIAL_LACK"), self.maxExp_.needExp, ItemTools.getItemName(self.maxExp_.id), (math.ceil(self.maxExp_.needExp / self.maxExp_.exp)))
		var_20_0 = false
	elseif self.failReason_.showUpgrade then
		self.descController_:SetSelectedState("upgrade")

		self.upgradeText_.text = string.format(GetTips("UPGRADE_TIP"), self.targetLevel_ + 10)
	elseif self.failReason_.moneyLack then
		self.descController_:SetSelectedState("level")

		self.levelUpText_.text = string.format(GetTips("LEVELUP_DIFF"), self.targetLevel_ - self.nowLevel_)
	else
		self.descController_:SetSelectedState("level")

		self.levelUpText_.text = string.format(GetTips("LEVELUP_DIFF"), self.targetLevel_ - self.nowLevel_)
	end

	self.btnController_:SetSelectedState(tostring(var_20_0))

	if self.failReason_.showUpgrade then
		self.upgradeController_:SetSelectedState(not (self.failReason_.resetNotSatisfied and self.targetLevel_ > 40 or self.failReason_.upgradeMaterialLack and self.targetLevel_ > self.failRank_ * 10) and "show" or "hide")
	else
		self.upgradeController_:SetSelectedState("hide")
		self.switchController_:SetSelectedState("off")

		self.upgradeState_ = false
	end
end

function EquipOneKeyCulturePopView:CaculateExpMaterial(arg_21_1)
	local var_21_0 = {}
	local var_21_1 = {
		exp = 0,
		needExp = EquipExpCfg[self.targetLevel_][self.expSumIndex] - (self.totalExp_ + self.equip_.exp)
	}

	if EquipExpCfg[self.targetLevel_][self.expSumIndex] - (self.totalExp_ + self.equip_.exp) and EquipExpCfg[self.targetLevel_][self.expSumIndex] - (self.totalExp_ + self.equip_.exp) > 0 then
		local var_21_2 = {}

		for iter_21_0 = 3, 1, -1 do
			if EquipExpCfg[self.targetLevel_][self.expSumIndex] - (self.totalExp_ + self.equip_.exp) >= EquipConst.EQUIP_LEVEL_UP_MATERIAL_EXP[iter_21_0].exp then
				if EquipConst.EQUIP_LEVEL_UP_MATERIAL_EXP[iter_21_0].exp > var_21_1.exp then
					var_21_1.exp = EquipConst.EQUIP_LEVEL_UP_MATERIAL_EXP[iter_21_0].exp
					var_21_1.id = EquipConst.EQUIP_LEVEL_UP_MATERIAL_EXP[iter_21_0].id
				end

				local var_21_3 = math.floor((EquipExpCfg[self.targetLevel_][self.expSumIndex] - (self.totalExp_ + self.equip_.exp)) / EquipConst.EQUIP_LEVEL_UP_MATERIAL_EXP[iter_21_0].exp)

				if var_21_3 > 0 then
					table.insert(var_21_2, {
						id = EquipConst.EQUIP_LEVEL_UP_MATERIAL_EXP[iter_21_0].id,
						num = var_21_3
					})
				end
			end
		end

		for iter_21_1, iter_21_2 in pairs(var_21_2) do
			arg_21_1[iter_21_2.id] = (arg_21_1[iter_21_2.id] or 0) + iter_21_2.num
		end
	end

	for iter_21_3, iter_21_4 in pairs(arg_21_1) do
		if iter_21_4 > 0 then
			table.insert(var_21_0, {
				isEquip = false,
				id = iter_21_3,
				number = iter_21_4
			})

			if iter_21_4 > ItemTools.getItemNum(iter_21_3) then
				self.failReason_.expMaterialLack = true
			end
		end
	end

	table.sort(var_21_0, function(arg_22_0, arg_22_1)
		return arg_22_0.id < arg_22_1.id
	end)

	return var_21_0, var_21_1
end

function EquipOneKeyCulturePopView:CaculateUpgradeMaterial(arg_23_1)
	local var_23_0 = math.floor(self.targetLevel_ / 10)
	local var_23_1 = self.equip_.now_break_level
	local var_23_2 = arg_23_1 or self.targetLevel_ >= var_23_0 * 10 + 1
	local var_23_3 = false
	local var_23_4 = {}
	local var_23_5 = 0

	self.upgradeTimes_ = 0

	for iter_23_0 = var_23_1, ((arg_23_1 or self.targetLevel_ >= var_23_0 * 10 + 1) and var_23_0 or var_23_0 - 1) - 1 do
		if self.equipCfg_.break_cost[iter_23_0 + 1] then
			self.upgradeTimes_ = self.upgradeTimes_ + 1
			var_23_5 = var_23_5 + EquipMaterialCfg[self.equipCfg_.break_cost[iter_23_0 + 1]].item_list[1][2]
			var_23_1 = var_23_1 + 1

			for iter_23_1 = 2, #EquipMaterialCfg[self.equipCfg_.break_cost[iter_23_0 + 1]].item_list do
				local var_23_6 = EquipMaterialCfg[self.equipCfg_.break_cost[iter_23_0 + 1]].item_list[iter_23_1][1]

				var_23_4[var_23_6] = ((var_23_4[EquipMaterialCfg[self.equipCfg_.break_cost[iter_23_0 + 1]].item_list[iter_23_1][1]] or nil) and (var_23_4[var_23_6] or 0)) + EquipMaterialCfg[self.equipCfg_.break_cost[iter_23_0 + 1]].item_list[iter_23_1][2]

				if not var_23_3 and var_23_4[var_23_6] > ItemTools.getItemNum(var_23_6) then
					var_23_3 = true
					self.failRank_ = iter_23_0 + 1
				end
			end
		end
	end

	local var_23_7 = {}

	for iter_23_2, iter_23_3 in pairs(var_23_4) do
		table.insert(var_23_7, {
			isEquip = false,
			id = iter_23_2,
			number = iter_23_3
		})
	end

	table.sort(var_23_7, function(arg_24_0, arg_24_1)
		return arg_24_0.id < arg_24_1.id
	end)

	self.failReason_.resetNotSatisfied = (var_23_2 or self.targetLevel_ > 40) and var_23_0 >= 4 and (self.equip_.race == 0 or table.keyof(RaceEffectCfg.all, self.equip_.race) ~= nil)
	self.failReason_.upgradeMaterialLack = var_23_3

	return var_23_7, var_23_5
end

function EquipOneKeyCulturePopView:RefreshCostMoney()
	if self.costMoney_ > ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) then
		self.failReason_.moneyLack = true
		self.costText_.text = "<color='#FF0000'>" .. self.costMoney_ .. "</color>"
	else
		self.failReason_.moneyLack = false
		self.costText_.text = self.costMoney_
	end
end

function EquipOneKeyCulturePopView:IndexItem(arg_26_1, arg_26_2)
	local var_26_0 = clone(ItemTemplateData)
	local var_26_1 = self.itemList_[arg_26_1]

	var_26_0.id = self.itemList_[arg_26_1].id
	var_26_0.number = self.itemList_[arg_26_1].number

	if self.itemList_[arg_26_1].isEquip == false then
		var_26_0.bottomText = {
			ItemTools.getItemNum(self.itemList_[arg_26_1].id),
			self.itemList_[arg_26_1].number
		}
		var_26_0.hideBottomRightTextFlag = true
	end

	function var_26_0.clickFun()
		ShowPopItem(POP_SOURCE_ITEM, {
			var_26_1.id,
			var_26_1.number
		})
	end

	arg_26_2:SetData(var_26_0)
end

function EquipOneKeyCulturePopView:OnExit()
	self.switchController_:SetSelectedState("off")

	self.upgradeState_ = false

	self.slider_.onValueChanged:RemoveAllListeners()
	manager.windowBar:HideBar()
end

function EquipOneKeyCulturePopView:Dispose()
	self.itemScrollList_:Dispose()
	EquipOneKeyCulturePopView.super.Dispose(self)
end

return EquipOneKeyCulturePopView
