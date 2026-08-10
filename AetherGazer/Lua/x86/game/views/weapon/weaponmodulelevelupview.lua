local var_0_0 = class("WeaponModuleLevelUpView", ReduxView)
local var_0_1 = "F6302F"

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_module/HeroModuleUpgradeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.attributeItems_ = {}
	arg_4_0.conditionItems_ = {}
	arg_4_0.costItems_ = {}

	for iter_4_0 = 1, 3 do
		arg_4_0.costItems_[iter_4_0] = CommonItemView.New(arg_4_0["itemGo" .. iter_4_0 .. "_"])
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.unlockBtn_, nil, function()
		if arg_5_0.conditionList_ and arg_5_0.conditionList_[1] then
			for iter_6_0, iter_6_1 in pairs(arg_5_0.conditionList_) do
				if not IsConditionAchieved(iter_6_1, {
					heroId = arg_5_0.heroID_
				}) then
					ShowTips("WEAPON_MODULE_UNLOCK_CONDITION_NOT_FINISH")

					return
				end
			end
		end

		local var_6_0 = WeaponModuleCfg[arg_5_0.heroID_].cost[HeroData:GetCurModuleLevel(arg_5_0.heroID_) + 1]
		local var_6_1 = {}

		for iter_6_2, iter_6_3 in pairs(var_6_0) do
			if iter_6_3[1] ~= 2 then
				table.insert(var_6_1, iter_6_3)
			end
		end

		for iter_6_4, iter_6_5 in pairs(var_6_1) do
			if iter_6_5[2] > ItemTools.getItemNum(iter_6_5[1]) then
				ShowTips("WEAPON_MODULE_UNLOCK_NOT_ENOUGH")

				return
			end
		end

		if not checkGold(arg_5_0.cost_, true) then
			return
		end

		HeroAction.TryToLevelUpModule(arg_5_0.heroID_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.astrolabeinfoBtn_, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs(arg_5_0.effects_) do
			if WeaponModuleEffectCfg[iter_7_1].type == 3 then
				table.insert(var_7_0, iter_7_1)
			end
		end

		JumpTools.OpenPageByJump("weaponModuleGodInfoView", {
			effectList = var_7_0,
			heroID = arg_5_0.heroID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.servantinfoBtn_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(arg_5_0.effects_) do
			if WeaponModuleEffectCfg[iter_8_1].type == 3 then
				table.insert(var_8_0, iter_8_1)
			end
		end

		JumpTools.OpenPageByJump("weaponModuleServantInfoView", {
			effectList = var_8_0,
			heroID = arg_5_0.heroID_
		})
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:UpdateBar()

	arg_9_0.lockController_ = arg_9_0.controllerEx_:GetController("lock")
	arg_9_0.heroID_ = arg_9_0.params_.heroID

	arg_9_0:RefreshUI()
end

function var_0_0.UpdateBar(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetGameHelpKey("WEAPON_MODULE_DESCRIPE")
end

function var_0_0.OnTop(arg_11_0)
	local var_11_0

	if checkGold(arg_11_0.cost_, false) then
		var_11_0 = "<color=#D2D9E1>" .. arg_11_0.cost_ .. "</color>"
	else
		var_11_0 = "<color=#F6302F>" .. arg_11_0.cost_ .. "</color>"
	end

	arg_11_0.goldNum_.text = var_11_0

	arg_11_0:UpdateBar()
end

function var_0_0.RefreshUI(arg_12_0)
	local var_12_0 = WeaponModuleCfg[arg_12_0.params_.heroID]

	arg_12_0.nameText_.text = GetI18NText(var_12_0.name)

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.titleTrans_)

	arg_12_0.moduleImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponModule/" .. arg_12_0.heroID_)

	local var_12_1 = HeroData:GetCurModuleLevel(arg_12_0.heroID_)

	arg_12_0.curLevelText_.text = var_12_1
	arg_12_0.nextLevelText_.text = var_12_1 + 1

	arg_12_0:RefreshDes()

	arg_12_0.conditionList_ = var_12_0.condition[HeroData:GetCurModuleLevel(arg_12_0.heroID_) + 1]
	arg_12_0.conditionSourceList_ = var_12_0.condition_source[HeroData:GetCurModuleLevel(arg_12_0.heroID_) + 1]

	arg_12_0:RefreshCondition()
	arg_12_0:RefreshCost()
	arg_12_0:RefreshBtn()
end

function var_0_0.RefreshDes(arg_13_0)
	arg_13_0.effects_ = WeaponModuleCfg[arg_13_0.params_.heroID].skill[HeroData:GetCurModuleLevel(arg_13_0.heroID_) + 1]

	local var_13_0, var_13_1, var_13_2, var_13_3 = HeroTools.GetModuleAllDes(arg_13_0.effects_, arg_13_0.heroID_, true)

	if var_13_0 == nil then
		SetActive(arg_13_0.attrGo_, false)
	else
		SetActive(arg_13_0.attrGo_, true)
		arg_13_0:RefreshAttriItems(var_13_0)
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.attrGo_.transform)
	end

	if var_13_1 == nil then
		SetActive(arg_13_0.skillGo_, false)
	else
		SetActive(arg_13_0.skillGo_, true)

		arg_13_0.skillText_.text = var_13_1

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.skillGo_.transform)
	end

	if var_13_2 == nil then
		SetActive(arg_13_0.astrolabeGo_, false)
	else
		SetActive(arg_13_0.astrolabeGo_, true)

		arg_13_0.astrolabeText_.text = var_13_2

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.astrolabeGo_.transform)
	end

	if var_13_3 == nil then
		SetActive(arg_13_0.servantGo_, false)
	else
		SetActive(arg_13_0.servantGo_, true)

		arg_13_0.servantText_.text = var_13_3

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.servantGo_.transform)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.contentTrans_)

	arg_13_0.contentTrans_.localPosition = Vector3.New(0, 0, 0)
end

function var_0_0.RefreshAttriItems(arg_14_0, arg_14_1)
	local var_14_0 = HeroTools.MergeModuleAttribute(arg_14_1)
	local var_14_1 = 1

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if arg_14_0.attributeItems_[var_14_1] == nil then
			local var_14_2 = GameObject.Instantiate(arg_14_0.attriItemGo_, arg_14_0.attriItemTrans_)

			arg_14_0.attributeItems_[var_14_1] = WeaponModuleAttributeItem.New(var_14_2)
		end

		arg_14_0.attributeItems_[var_14_1]:SetData(iter_14_0, iter_14_1)

		var_14_1 = var_14_1 + 1
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_0.attributeItems_) do
		if iter_14_2 < var_14_1 then
			arg_14_0.attributeItems_[iter_14_2]:SetIsShow(true)
		else
			arg_14_0.attributeItems_[iter_14_2]:SetIsShow(false)
		end
	end
end

function var_0_0.RefreshCondition(arg_15_0)
	if arg_15_0.conditionList_ and arg_15_0.conditionList_[1] then
		SetActive(arg_15_0.conditonParent_.gameObject, true)

		for iter_15_0, iter_15_1 in pairs(arg_15_0.conditionList_) do
			if arg_15_0.conditionItems_[iter_15_0] then
				arg_15_0.conditionItems_[iter_15_0]:SetData(iter_15_1, arg_15_0.heroID_, arg_15_0.conditionSourceList_[iter_15_0])
			else
				local var_15_0 = GameObject.Instantiate(arg_15_0.conditonGo_, arg_15_0.conditonParent_)

				arg_15_0.conditionItems_[iter_15_0] = WeaponModuleConditionItem.New(var_15_0)

				arg_15_0.conditionItems_[iter_15_0]:SetData(iter_15_1, arg_15_0.heroID_, arg_15_0.conditionSourceList_[iter_15_0])
			end
		end

		local var_15_1 = #arg_15_0.conditionList_

		for iter_15_2, iter_15_3 in pairs(arg_15_0.conditionItems_) do
			if var_15_1 < iter_15_2 then
				iter_15_3:SetIsShow(false)
			else
				iter_15_3:SetIsShow(true)
			end
		end
	else
		SetActive(arg_15_0.conditonParent_.gameObject, false)
	end
end

function var_0_0.RefreshCost(arg_16_0)
	local var_16_0 = WeaponModuleCfg[arg_16_0.heroID_].cost[HeroData:GetCurModuleLevel(arg_16_0.heroID_) + 1]
	local var_16_1 = {}

	arg_16_0.cost_ = 0

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		if iter_16_1[1] == 2 then
			arg_16_0.cost_ = iter_16_1[2]

			local var_16_2

			if checkGold(arg_16_0.cost_, false) then
				var_16_2 = "<color=#D2D9E1>" .. iter_16_1[2] .. "</color>"
			else
				var_16_2 = "<color=#F6302F>" .. iter_16_1[2] .. "</color>"
			end

			arg_16_0.goldNum_.text = var_16_2
		else
			table.insert(var_16_1, iter_16_1)
		end
	end

	for iter_16_2, iter_16_3 in pairs(var_16_1) do
		local var_16_3 = iter_16_3[2]
		local var_16_4 = ItemTools.getItemNum(iter_16_3[1])
		local var_16_5 = clone(ItemTemplateData)

		var_16_5.id = iter_16_3[1]
		var_16_5.bottomText = {
			var_16_4,
			var_16_3,
			var_16_4 < var_16_3 and var_0_1 or nil
		}
		var_16_5.hideBottomRightTextFlag = true

		function var_16_5.clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
				iter_16_3[1],
				iter_16_3[2]
			})
		end

		arg_16_0.costItems_[iter_16_2]:SetData(var_16_5)
	end

	for iter_16_4 = 1, 3 do
		if iter_16_4 > #var_16_1 then
			arg_16_0.costItems_[iter_16_4]:Show(false)
		else
			arg_16_0.costItems_[iter_16_4]:Show(true)
		end
	end
end

function var_0_0.RefreshBtn(arg_18_0)
	arg_18_0.lockController_:SetSelectedIndex(1)

	if not HeroData:GetModuleAssignmentIsFinish(arg_18_0.heroID_) then
		return
	end

	if arg_18_0.conditionList_ and arg_18_0.conditionList_[1] then
		for iter_18_0, iter_18_1 in pairs(arg_18_0.conditionList_) do
			if not IsConditionAchieved(iter_18_1, {
				heroId = arg_18_0.heroID_
			}) then
				return
			end
		end
	end

	local var_18_0 = WeaponModuleCfg[arg_18_0.heroID_].cost[HeroData:GetCurModuleLevel(arg_18_0.heroID_) + 1]
	local var_18_1 = {}

	for iter_18_2, iter_18_3 in pairs(var_18_0) do
		if iter_18_3[1] ~= 2 then
			table.insert(var_18_1, iter_18_3)
		end
	end

	for iter_18_4, iter_18_5 in pairs(var_18_1) do
		if iter_18_5[2] > ItemTools.getItemNum(iter_18_5[1]) then
			return
		end
	end

	arg_18_0.lockController_:SetSelectedIndex(0)
end

function var_0_0.OnExit(arg_19_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.attributeItems_) do
		iter_20_1:Dispose()
	end

	for iter_20_2, iter_20_3 in pairs(arg_20_0.conditionItems_) do
		iter_20_3:Dispose()
	end

	for iter_20_4, iter_20_5 in pairs(arg_20_0.costItems_) do
		iter_20_5:Dispose()
	end

	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
