local var_0_0 = class("EquipOneKeyCulturePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_equip/Develop/HeroEquipLvupPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.descController_ = arg_4_0.descCon_:GetController("desc")
	arg_4_0.upgradeController_ = arg_4_0.descCon_:GetController("showUpgrade")
	arg_4_0.switchController_ = arg_4_0.switchCon_:GetController("switch")
	arg_4_0.btnController_ = arg_4_0.btnCon_:GetController("btnState")
	arg_4_0.itemScrollList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.itemListGo_, CommonItemView)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.noBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.yesBtn_, nil, function()
		if not checkGold(arg_5_0.costMoney_) then
			return
		end

		EquipAction.OneKeyStrength(tonumber(arg_5_0.equipId_), arg_5_0.useEquipList_, arg_5_0.useMaterialList_, arg_5_0.levelUpCost_, arg_5_0.targetLevel_, arg_5_0.upgradeTimes_)
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.subBtn_, nil, function()
		arg_5_0.slider_.value = arg_5_0.targetLevel_ - 1
	end)
	arg_5_0:AddBtnListener(arg_5_0.addBtn_, nil, function()
		arg_5_0.slider_.value = arg_5_0.targetLevel_ + 1
	end)
	arg_5_0:AddBtnListener(arg_5_0.upgradeBtn_, nil, function()
		arg_5_0.upgradeState_ = not arg_5_0.upgradeState_

		arg_5_0.switchController_:SetSelectedState(arg_5_0.upgradeState_ and "on" or "off")
		arg_5_0:RefreshMaterialList(arg_5_0.upgradeState_)
		arg_5_0:RefrehStatus()
	end)
end

function var_0_0.OnEnter(arg_12_0)
	return
end

function var_0_0.OnTop(arg_13_0)
	manager.windowBar:SetAsLastSibling()
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)

	arg_13_0.failReason_ = {}

	arg_13_0:RefreshData()
	arg_13_0:RefreshUI()
end

function var_0_0.RefreshData(arg_14_0)
	arg_14_0.equipId_ = arg_14_0.params_.equipId
	arg_14_0.equip_ = EquipData:GetEquipData(arg_14_0.equipId_)
	arg_14_0.equipCfg_ = EquipCfg[arg_14_0.equip_.prefab_id]
	arg_14_0.nowLevel_ = arg_14_0.equip_:GetLevel()
	arg_14_0.isUpgrade_ = arg_14_0.nowLevel_ >= arg_14_0.equip_:GetMaxLv() and arg_14_0.equip_.now_break_level < arg_14_0.equipCfg_.break_times_max

	if arg_14_0.equip_:GetLevel() >= arg_14_0.equipCfg_.max_level[arg_14_0.equipCfg_.break_times_max + 1] then
		JumpTools.Back()

		return
	end

	local var_14_0, var_14_1, var_14_2 = EquipTools.GetEquipLevelUpMaterial(0, 0, {
		arg_14_0.equipId_
	}, 5)

	arg_14_0.totalExp_, arg_14_0.minExp_ = EquipTools.CountAddExp(var_14_1, var_14_2, true)
	arg_14_0.cultureParams_ = EquipTools.CalculateCultueLevel(arg_14_0.equip_, arg_14_0.totalExp_, nil, arg_14_0.isUpgrade_)
	arg_14_0.failReason_.expMaxLevel = arg_14_0.cultureParams_.expMaxLevel

	local var_14_3 = math.min(arg_14_0.equip_:GetMaxLv(), EquipTools.CountMinAddLevel(arg_14_0.equip_, arg_14_0.minExp_))

	arg_14_0.minLevel_ = math.max(arg_14_0.nowLevel_ + 1, var_14_3)
	arg_14_0.targetLevel_ = math.max(arg_14_0.minLevel_, arg_14_0.cultureParams_.maxLevel)
	arg_14_0.failReason_.showUpgrade = arg_14_0.cultureParams_.maxLevel % 10 == 0 and arg_14_0.failReason_.expMaxLevel >= arg_14_0.cultureParams_.maxLevel and arg_14_0.targetLevel_ < EquipTools.CountEquipMaxLvWitnoutBreak(arg_14_0.equip_)

	arg_14_0:InitSlider()

	arg_14_0.upgradeState_ = false

	arg_14_0.switchController_:SetSelectedState("off")

	arg_14_0.expSumIndex = "exp_sum_" .. arg_14_0.equip_.star
end

function var_0_0.InitSlider(arg_15_0)
	arg_15_0.maxLevel_ = EquipTools.CountEquipMaxLvWitnoutBreak(arg_15_0.equip_)
	arg_15_0.slider_.minValue = arg_15_0.nowLevel_
	arg_15_0.slider_.maxValue = arg_15_0.maxLevel_
	arg_15_0.slider_.value = arg_15_0.targetLevel_

	if arg_15_0.maxLevel_ - arg_15_0.nowLevel_ <= 1 then
		arg_15_0.subBtn_.interactable = false
		arg_15_0.addBtn_.interactable = false
	else
		arg_15_0.subBtn_.interactable = arg_15_0.targetLevel_ > arg_15_0.minLevel_
		arg_15_0.addBtn_.interactable = arg_15_0.targetLevel_ < arg_15_0.maxLevel_
	end

	arg_15_0.slider_.onValueChanged:AddListener(function(arg_16_0)
		arg_15_0.subBtn_.interactable = arg_16_0 > arg_15_0.minLevel_
		arg_15_0.addBtn_.interactable = arg_16_0 < arg_15_0.maxLevel_

		if arg_16_0 < arg_15_0.minLevel_ then
			arg_15_0.slider_.value = arg_15_0.minLevel_
		else
			arg_15_0:OnTargetLevelChange(arg_16_0)
		end
	end)
end

function var_0_0.RefreshUI(arg_17_0)
	arg_17_0.leftLvTxt_.text = arg_17_0.nowLevel_
	arg_17_0.rightLvTxt_.text = arg_17_0.targetLevel_

	arg_17_0:RefreshMaterialList()
	arg_17_0:RefrehStatus()
end

function var_0_0.OnTargetLevelChange(arg_18_0, arg_18_1)
	if arg_18_0.targetLevel_ == arg_18_1 then
		return
	end

	arg_18_0.targetLevel_ = arg_18_1
	arg_18_0.rightLvTxt_.text = arg_18_1
	arg_18_0.cultureParams_ = EquipTools.CalculateCultueLevel(arg_18_0.equip_, arg_18_0.totalExp_, arg_18_0.targetLevel_)
	arg_18_0.failReason_.expMaxLevel = arg_18_0.cultureParams_.expMaxLevel
	arg_18_0.failReason_.showUpgrade = arg_18_0.cultureParams_.maxLevel % 10 == 0 and arg_18_0.failReason_.expMaxLevel >= arg_18_0.cultureParams_.maxLevel and arg_18_0.targetLevel_ < EquipTools.CountEquipMaxLvWitnoutBreak(arg_18_0.equip_)

	arg_18_0:RefreshMaterialList()
	arg_18_0:RefrehStatus()
end

function var_0_0.RefreshMaterialList(arg_19_0, arg_19_1)
	local var_19_0 = EquipExpCfg[arg_19_0.targetLevel_][arg_19_0.expSumIndex] - arg_19_0.equip_.exp
	local var_19_1, var_19_2 = EquipTools.QuickSelectList(var_19_0, {
		arg_19_0.equipId_
	})

	arg_19_0.itemList_ = {}
	arg_19_0.useEquipList_ = var_19_2
	arg_19_0.useMaterialList_ = var_19_1

	local var_19_3, var_19_4 = arg_19_0:CaculateExpMaterial(var_19_1)

	for iter_19_0, iter_19_1 in ipairs(var_19_3) do
		table.insert(arg_19_0.itemList_, iter_19_1)
	end

	arg_19_0.maxExp_ = var_19_4

	local var_19_5, var_19_6 = arg_19_0:CaculateUpgradeMaterial(arg_19_1)

	for iter_19_2, iter_19_3 in ipairs(var_19_5) do
		table.insert(arg_19_0.itemList_, iter_19_3)
	end

	local var_19_7 = {}

	for iter_19_4, iter_19_5 in pairs(var_19_2) do
		table.insert(var_19_7, iter_19_5.equip_info)
	end

	local var_19_8 = EquipTools.EquipSort(var_19_7, 0, EquipConst.EQUIP_SORT.RARE)

	for iter_19_6, iter_19_7 in pairs(var_19_8) do
		table.insert(arg_19_0.itemList_, {
			isEquip = true,
			number = 1,
			id = iter_19_7.prefab_id
		})
	end

	arg_19_0.itemScrollList_:StartScroll(#arg_19_0.itemList_)

	arg_19_0.levelUpCost_ = math.floor(var_19_0 * GameSetting.equip_strengthen_gold_cost.value[1])
	arg_19_0.costMoney_ = arg_19_0.levelUpCost_ + var_19_6

	arg_19_0:RefreshCostMoney()
end

function var_0_0.RefrehStatus(arg_20_0)
	local var_20_0 = true

	if arg_20_0.failReason_.resetNotSatisfied then
		arg_20_0.descController_:SetSelectedState("condition")

		arg_20_0.conditionText_.text = GetTips("EQUIP_BREAK_LIMITED")
		var_20_0 = false
	elseif arg_20_0.failReason_.upgradeMaterialLack then
		arg_20_0.descController_:SetSelectedState("condition")

		arg_20_0.conditionText_.text = GetTips("UPGRADE_MATERIAL_LACK")
		var_20_0 = false
	elseif arg_20_0.failReason_.expMaterialLack and arg_20_0.targetLevel_ > arg_20_0.failReason_.expMaxLevel then
		arg_20_0.descController_:SetSelectedState("condition")

		local var_20_1 = ItemTools.getItemName(arg_20_0.maxExp_.id)
		local var_20_2 = math.ceil(arg_20_0.maxExp_.needExp / arg_20_0.maxExp_.exp)

		arg_20_0.conditionText_.text = string.format(GetTips("LEVELUP_MATERIAL_LACK"), arg_20_0.maxExp_.needExp, var_20_1, var_20_2)
		var_20_0 = false
	elseif arg_20_0.failReason_.showUpgrade then
		arg_20_0.descController_:SetSelectedState("upgrade")

		arg_20_0.upgradeText_.text = string.format(GetTips("UPGRADE_TIP"), arg_20_0.targetLevel_ + 10)
	elseif arg_20_0.failReason_.moneyLack then
		arg_20_0.descController_:SetSelectedState("level")

		arg_20_0.levelUpText_.text = string.format(GetTips("LEVELUP_DIFF"), arg_20_0.targetLevel_ - arg_20_0.nowLevel_)
	else
		arg_20_0.descController_:SetSelectedState("level")

		arg_20_0.levelUpText_.text = string.format(GetTips("LEVELUP_DIFF"), arg_20_0.targetLevel_ - arg_20_0.nowLevel_)
	end

	arg_20_0.btnController_:SetSelectedState(tostring(var_20_0))

	if arg_20_0.failReason_.showUpgrade then
		local var_20_3 = true

		if arg_20_0.failReason_.resetNotSatisfied and arg_20_0.targetLevel_ > 40 or arg_20_0.failReason_.upgradeMaterialLack and arg_20_0.targetLevel_ > arg_20_0.failRank_ * 10 then
			var_20_3 = false
		end

		arg_20_0.upgradeController_:SetSelectedState(var_20_3 and "show" or "hide")
	else
		arg_20_0.upgradeController_:SetSelectedState("hide")
		arg_20_0.switchController_:SetSelectedState("off")

		arg_20_0.upgradeState_ = false
	end
end

function var_0_0.CaculateExpMaterial(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.totalExp_ + arg_21_0.equip_.exp
	local var_21_1 = EquipExpCfg[arg_21_0.targetLevel_][arg_21_0.expSumIndex] - var_21_0
	local var_21_2 = {}
	local var_21_3 = {
		exp = 0,
		needExp = var_21_1
	}

	if var_21_1 and var_21_1 > 0 then
		local var_21_4 = {}

		for iter_21_0 = 3, 1, -1 do
			local var_21_5 = EquipConst.EQUIP_LEVEL_UP_MATERIAL_EXP[iter_21_0]

			if var_21_1 >= var_21_5.exp then
				if var_21_5.exp > var_21_3.exp then
					var_21_3.exp = var_21_5.exp
					var_21_3.id = var_21_5.id
				end

				local var_21_6 = math.floor(var_21_1 / var_21_5.exp)

				if var_21_6 > 0 then
					table.insert(var_21_4, {
						id = var_21_5.id,
						num = var_21_6
					})

					var_21_1 = var_21_1 - var_21_5.exp * var_21_6
				end
			end
		end

		for iter_21_1, iter_21_2 in pairs(var_21_4) do
			local var_21_7 = arg_21_1[iter_21_2.id] or 0

			arg_21_1[iter_21_2.id] = var_21_7 + iter_21_2.num
		end
	end

	for iter_21_3, iter_21_4 in pairs(arg_21_1) do
		if iter_21_4 > 0 then
			table.insert(var_21_2, {
				isEquip = false,
				id = iter_21_3,
				number = iter_21_4
			})

			if iter_21_4 > ItemTools.getItemNum(iter_21_3) then
				arg_21_0.failReason_.expMaterialLack = true
			end
		end
	end

	table.sort(var_21_2, function(arg_22_0, arg_22_1)
		return arg_22_0.id < arg_22_1.id
	end)

	return var_21_2, var_21_3
end

function var_0_0.CaculateUpgradeMaterial(arg_23_0, arg_23_1)
	local var_23_0 = math.floor(arg_23_0.targetLevel_ / 10)
	local var_23_1 = arg_23_0.equip_.now_break_level
	local var_23_2 = arg_23_1 or arg_23_0.targetLevel_ >= var_23_0 * 10 + 1
	local var_23_3 = var_23_2 and var_23_0 or var_23_0 - 1
	local var_23_4 = false
	local var_23_5 = {}
	local var_23_6 = 0

	arg_23_0.upgradeTimes_ = 0

	for iter_23_0 = var_23_1, var_23_3 - 1 do
		local var_23_7 = arg_23_0.equipCfg_.break_cost[iter_23_0 + 1]

		if var_23_7 then
			arg_23_0.upgradeTimes_ = arg_23_0.upgradeTimes_ + 1

			local var_23_8 = EquipMaterialCfg[var_23_7]

			var_23_6 = var_23_6 + var_23_8.item_list[1][2]
			var_23_1 = var_23_1 + 1

			for iter_23_1 = 2, #var_23_8.item_list do
				local var_23_9 = var_23_8.item_list[iter_23_1]
				local var_23_10 = var_23_9[1]
				local var_23_11 = var_23_9[2]

				var_23_5[var_23_10] = (var_23_5[var_23_10] and var_23_5[var_23_10] or 0) + var_23_11

				if not var_23_4 and var_23_5[var_23_10] > ItemTools.getItemNum(var_23_10) then
					var_23_4 = true
					arg_23_0.failRank_ = iter_23_0 + 1
				end
			end
		end
	end

	local var_23_12 = {}

	for iter_23_2, iter_23_3 in pairs(var_23_5) do
		table.insert(var_23_12, {
			isEquip = false,
			id = iter_23_2,
			number = iter_23_3
		})
	end

	table.sort(var_23_12, function(arg_24_0, arg_24_1)
		return arg_24_0.id < arg_24_1.id
	end)

	arg_23_0.failReason_.resetNotSatisfied = (var_23_2 or arg_23_0.targetLevel_ > 40) and var_23_0 >= 4 and (arg_23_0.equip_.race == 0 or table.keyof(RaceEffectCfg.all, arg_23_0.equip_.race) ~= nil)
	arg_23_0.failReason_.upgradeMaterialLack = var_23_4

	return var_23_12, var_23_6
end

function var_0_0.RefreshCostMoney(arg_25_0)
	if arg_25_0.costMoney_ > ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) then
		arg_25_0.failReason_.moneyLack = true
		arg_25_0.costText_.text = "<color='#FF0000'>" .. arg_25_0.costMoney_ .. "</color>"
	else
		arg_25_0.failReason_.moneyLack = false
		arg_25_0.costText_.text = arg_25_0.costMoney_
	end
end

function var_0_0.IndexItem(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = clone(ItemTemplateData)
	local var_26_1 = arg_26_0.itemList_[arg_26_1]

	var_26_0.id = var_26_1.id
	var_26_0.number = var_26_1.number

	if var_26_1.isEquip == false then
		var_26_0.bottomText = {
			ItemTools.getItemNum(var_26_1.id),
			var_26_1.number
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

function var_0_0.OnExit(arg_28_0)
	arg_28_0.switchController_:SetSelectedState("off")

	arg_28_0.upgradeState_ = false

	arg_28_0.slider_.onValueChanged:RemoveAllListeners()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_29_0)
	arg_29_0.itemScrollList_:Dispose()
	var_0_0.super.Dispose(arg_29_0)
end

return var_0_0
