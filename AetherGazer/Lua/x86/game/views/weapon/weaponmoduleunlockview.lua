local var_0_0 = class("WeaponModuleUnlockView", ReduxView)
local var_0_1 = "F6302F"

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_module/HeroModuleUnlockUI"
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

	arg_4_0.taskController_ = ControllerUtil.GetController(arg_4_0.taskTrans_, "mission")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.unlockBtn_, nil, function()
		if not HeroData:GetModuleAssignmentIsFinish(arg_5_0.heroID_) then
			ShowTips("WEAPON_MODULE_UNLOCK_TASK_NOT_COMPLETED")

			return
		end

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

		local var_6_0 = WeaponModuleCfg[arg_5_0.heroID_].cost[1]
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
		local var_7_0 = HeroData:GetLockModuleEffectListByType(arg_5_0.heroID_, 3)

		JumpTools.OpenPageByJump("weaponModuleGodInfoView", {
			effectList = var_7_0,
			heroID = arg_5_0.heroID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.servantinfoBtn_, nil, function()
		local var_8_0 = HeroData:GetLockModuleEffectListByType(arg_5_0.heroID_, 4)

		JumpTools.OpenPageByJump("weaponModuleServantInfoView", {
			effectList = var_8_0,
			heroID = arg_5_0.heroID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.taskGotoBtn_, nil, function()
		local var_9_0 = WeaponModuleCfg[arg_5_0.heroID_].source

		JumpTools.JumpToPage(var_9_0)
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:UpdateBar()

	arg_10_0.lockController_ = arg_10_0.controllerEx_:GetController("lock")
	arg_10_0.heroID_ = arg_10_0.params_.heroID

	arg_10_0:RegistEventListener(CURRENCY_UPDATE, function(arg_11_0)
		if arg_11_0 == CurrencyConst.CURRENCY_TYPE_GOLD then
			HeroAction.UpdateModuleRedPointByHeroID(arg_10_0.heroID_)
		end
	end)
	arg_10_0:RefreshUI()
end

function var_0_0.UpdateBar(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetGameHelpKey("WEAPON_MODULE_DESCRIPE")
end

function var_0_0.OnTop(arg_13_0)
	local var_13_0

	if checkGold(arg_13_0.cost_, false) then
		var_13_0 = "<color=#D2D9E1>" .. arg_13_0.cost_ .. "</color>"
	else
		var_13_0 = "<color=#F6302F>" .. arg_13_0.cost_ .. "</color>"
	end

	arg_13_0.goldNum_.text = var_13_0

	arg_13_0:RefreshBtn()
	arg_13_0:UpdateBar()
end

function var_0_0.RefreshUI(arg_14_0)
	local var_14_0 = WeaponModuleCfg[arg_14_0.params_.heroID]

	arg_14_0.nameText_.text = GetI18NText(var_14_0.name)

	arg_14_0:RefreshDes()

	arg_14_0.taskText_.text = GetI18NText(var_14_0.task_desc)

	if HeroData:GetModuleAssignmentIsFinish(arg_14_0.heroID_) then
		arg_14_0.taskController_:SetSelectedState("clear")
	else
		arg_14_0.taskController_:SetSelectedState("notClear")
	end

	arg_14_0.conditionList_ = var_14_0.condition[1]
	arg_14_0.conditionSourceList_ = var_14_0.condition_source[1]

	arg_14_0:RefreshCondition()
	arg_14_0:RefreshCost()
	arg_14_0:RefreshBtn()
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_0.taskTrans_)
end

function var_0_0.RefreshBtn(arg_15_0)
	arg_15_0.lockController_:SetSelectedIndex(1)

	if not HeroData:GetModuleAssignmentIsFinish(arg_15_0.heroID_) then
		return
	end

	if arg_15_0.conditionList_ and arg_15_0.conditionList_[1] then
		for iter_15_0, iter_15_1 in pairs(arg_15_0.conditionList_) do
			if not IsConditionAchieved(iter_15_1, {
				heroId = arg_15_0.heroID_
			}) then
				return
			end
		end
	end

	local var_15_0 = WeaponModuleCfg[arg_15_0.heroID_].cost[1]
	local var_15_1 = {}

	for iter_15_2, iter_15_3 in pairs(var_15_0) do
		if iter_15_3[1] ~= 2 then
			table.insert(var_15_1, iter_15_3)
		end
	end

	for iter_15_4, iter_15_5 in pairs(var_15_1) do
		if iter_15_5[2] > ItemTools.getItemNum(iter_15_5[1]) then
			return
		end
	end

	arg_15_0.lockController_:SetSelectedIndex(0)
end

function var_0_0.RefreshDes(arg_16_0)
	arg_16_0.effects_ = WeaponModuleCfg[arg_16_0.params_.heroID].skill[1]

	local var_16_0, var_16_1, var_16_2, var_16_3 = HeroTools.GetModuleAllDes(arg_16_0.effects_, arg_16_0.heroID_)

	if var_16_0 == nil then
		SetActive(arg_16_0.attrGo_, false)
	else
		SetActive(arg_16_0.attrGo_, true)
		arg_16_0:RefreshAttriItems(var_16_0)
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_0.attrGo_.transform)
	end

	if var_16_1 == nil then
		SetActive(arg_16_0.skillGo_, false)
	else
		SetActive(arg_16_0.skillGo_, true)

		arg_16_0.skillText_.text = var_16_1

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_0.skillGo_.transform)
	end

	if var_16_2 == nil then
		SetActive(arg_16_0.astrolabeGo_, false)
	else
		SetActive(arg_16_0.astrolabeGo_, true)

		arg_16_0.astrolabeText_.text = var_16_2

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_0.astrolabeGo_.transform)
	end

	if var_16_3 == nil then
		SetActive(arg_16_0.servantGo_, false)
	else
		SetActive(arg_16_0.servantGo_, true)

		arg_16_0.servantText_.text = var_16_3

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_0.servantGo_.transform)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_0.contentTrans_)

	arg_16_0.contentTrans_.localPosition = Vector3.New(0, 0, 0)
end

function var_0_0.RefreshAttriItems(arg_17_0, arg_17_1)
	local var_17_0 = HeroTools.MergeModuleAttribute(arg_17_1)
	local var_17_1 = 1

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		if arg_17_0.attributeItems_[var_17_1] == nil then
			local var_17_2 = GameObject.Instantiate(arg_17_0.attriItemGo_, arg_17_0.attriItemTrans_)

			arg_17_0.attributeItems_[var_17_1] = WeaponModuleAttributeItem.New(var_17_2)
		end

		arg_17_0.attributeItems_[var_17_1]:SetData(iter_17_0, iter_17_1)

		var_17_1 = var_17_1 + 1
	end

	for iter_17_2, iter_17_3 in pairs(arg_17_0.attributeItems_) do
		if iter_17_2 < var_17_1 then
			arg_17_0.attributeItems_[iter_17_2]:SetIsShow(true)
		else
			arg_17_0.attributeItems_[iter_17_2]:SetIsShow(false)
		end
	end
end

function var_0_0.RefreshCondition(arg_18_0)
	if arg_18_0.conditionList_ and arg_18_0.conditionList_[1] then
		SetActive(arg_18_0.conditonParent_.gameObject, true)

		for iter_18_0, iter_18_1 in pairs(arg_18_0.conditionList_) do
			if arg_18_0.conditionItems_[iter_18_0] then
				arg_18_0.conditionItems_[iter_18_0]:SetData(iter_18_1, arg_18_0.heroID_, arg_18_0.conditionSourceList_[iter_18_0])
			else
				local var_18_0 = GameObject.Instantiate(arg_18_0.conditonGo_, arg_18_0.conditonParent_)

				arg_18_0.conditionItems_[iter_18_0] = WeaponModuleConditionItem.New(var_18_0)

				arg_18_0.conditionItems_[iter_18_0]:SetData(iter_18_1, arg_18_0.heroID_, arg_18_0.conditionSourceList_[iter_18_0])
			end
		end

		local var_18_1 = #arg_18_0.conditionList_

		for iter_18_2, iter_18_3 in pairs(arg_18_0.conditionItems_) do
			if var_18_1 < iter_18_2 then
				iter_18_3:SetIsShow(false)
			else
				iter_18_3:SetIsShow(true)
			end
		end
	else
		SetActive(arg_18_0.conditonParent_.gameObject, false)
	end
end

function var_0_0.RefreshCost(arg_19_0)
	local var_19_0 = WeaponModuleCfg[arg_19_0.heroID_].cost[1]
	local var_19_1 = {}

	arg_19_0.cost_ = 0

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		if iter_19_1[1] == 2 then
			arg_19_0.cost_ = iter_19_1[2]

			local var_19_2

			if checkGold(arg_19_0.cost_, false) then
				var_19_2 = "<color=#D2D9E1>" .. iter_19_1[2] .. "</color>"
			else
				var_19_2 = "<color=#F6302F>" .. iter_19_1[2] .. "</color>"
			end

			arg_19_0.goldNum_.text = var_19_2
		else
			table.insert(var_19_1, iter_19_1)
		end
	end

	for iter_19_2, iter_19_3 in pairs(var_19_1) do
		local var_19_3 = iter_19_3[2]
		local var_19_4 = ItemTools.getItemNum(iter_19_3[1])
		local var_19_5 = clone(ItemTemplateData)

		var_19_5.id = iter_19_3[1]
		var_19_5.bottomText = {
			var_19_4,
			var_19_3,
			var_19_4 < var_19_3 and var_0_1 or nil
		}
		var_19_5.hideBottomRightTextFlag = true

		function var_19_5.clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
				iter_19_3[1],
				iter_19_3[2]
			})
		end

		arg_19_0.costItems_[iter_19_2]:SetData(var_19_5)
	end

	for iter_19_4 = 1, 3 do
		if iter_19_4 > #var_19_1 then
			arg_19_0.costItems_[iter_19_4]:Show(false)
		else
			arg_19_0.costItems_[iter_19_4]:Show(true)
		end
	end
end

function var_0_0.OnExit(arg_21_0)
	manager.windowBar:HideBar()
	arg_21_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.attributeItems_) do
		iter_22_1:Dispose()
	end

	for iter_22_2, iter_22_3 in pairs(arg_22_0.conditionItems_) do
		iter_22_3:Dispose()
	end

	for iter_22_4, iter_22_5 in pairs(arg_22_0.costItems_) do
		iter_22_5:Dispose()
	end

	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
