local var_0_0 = class("EquipUpgradeView", EquipBaseView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.params_ = arg_1_3

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0.super.Init(arg_2_0)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.attrs = {}

	for iter_3_0 = 1, 2 do
		local var_3_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_3_0, arg_3_0["property_" .. iter_3_0])
		table.insert(arg_3_0.attrs, var_3_0)
	end

	arg_3_0.costScroller_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.costListGo_, CommonItemView)
	arg_3_0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	arg_3_0.conditionController_ = arg_3_0.transCon_:GetController("condition")
	arg_3_0.clearController_ = arg_3_0.conditionCon_:GetController("clear")
	arg_3_0.btnStateController_ = arg_3_0.transCon_:GetController("btnState")
	arg_3_0.equipStrengthHandler_ = handler(arg_3_0, arg_3_0.OnEquipStrengthSuccess)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.upgradeBtn_, nil, function()
		EquipAction.ApplyUpgradeEquip(tonumber(arg_4_0.equipId))
	end)
	arg_4_0:AddBtnListener(arg_4_0.noBtn_, nil, function()
		if arg_4_0.showTips_ then
			ShowTips(GetTips("EQUIP_BREAK_LIMITED"))
		else
			EquipAction.ApplyUpgradeEquip(tonumber(arg_4_0.equipId))
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnOneKeyCulture_, nil, function()
		JumpTools.OpenPageByJump("equipOneKeyCulturePopView", {
			equipId = arg_4_0.equipId
		})
	end)
end

function var_0_0.OnEquipStrengthSuccess(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_3.equipId == arg_8_0.equipId then
		if arg_8_0.handler_:RefreshSideBar(arg_8_0.equipId) ~= 2 then
			arg_8_0:RefreshEquipUpgrade()
		end
	else
		arg_8_0:RefreshEquipUpgrade()
	end

	if arg_8_2 then
		JumpTools.OpenPageByJump("equipCulturePopView", arg_8_3)
	end
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:OnEquipChange(arg_9_0.params_.equipId)
	arg_9_0:RegistEventListener(EQUIP_STRENGTH_SUCCESS, arg_9_0.equipStrengthHandler_)
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0:ChangeBar()
	arg_10_0:RefreshEquipUpCost()
	arg_10_0:RefreshEquipUpLimit()

	local var_10_0 = arg_10_0.isLack_ or arg_10_0.showTips_

	arg_10_0.btnStateController_:SetSelectedIndex(var_10_0 and 1 or 0)
end

function var_0_0.ChangeBar(arg_11_0)
	local var_11_0 = {
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	}

	manager.windowBar:SwitchBar(var_11_0)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
end

function var_0_0.OnEquipChange(arg_12_0, arg_12_1)
	arg_12_0.equipId = arg_12_1
	arg_12_0.equip = EquipData:GetEquipData(arg_12_0.equipId)

	local var_12_0 = EquipCfg[arg_12_0.equip.prefab_id]

	if arg_12_0.equip:GetLevel() >= var_12_0.max_level[var_12_0.break_times_max + 1] then
		arg_12_0.handler_:RefreshSideBar(arg_12_0.equipId)

		return
	end

	arg_12_0:RefreshEquipUpgrade()
	arg_12_0:ChangeBar()
end

function var_0_0.RefreshEquipUpgrade(arg_13_0)
	arg_13_0:RefreshEquipUpInfo()
	arg_13_0:RefreshEquipUpCost()
	arg_13_0:RefreshEquipUpLimit()

	local var_13_0 = arg_13_0.isLack_ or arg_13_0.showTips_

	arg_13_0.btnStateController_:SetSelectedIndex(var_13_0 and 1 or 0)
end

function var_0_0.RefreshEquipUpInfo(arg_14_0)
	local var_14_0 = EquipCfg[arg_14_0.equip.prefab_id]
	local var_14_1 = arg_14_0.equip.now_break_level

	arg_14_0.oldLv_.text = var_14_0.max_level[var_14_1 + 1]
	arg_14_0.newLv_.text = var_14_0.max_level[var_14_1 + 2]

	for iter_14_0 = 1, 2 do
		local var_14_2 = var_14_0.fixed_attributes[var_14_1 + 1]
		local var_14_3 = PublicAttrCfg[var_14_2[iter_14_0][1]]
		local var_14_4 = arg_14_0.attrs[iter_14_0]

		var_14_4.icon_.sprite = getSprite("Atlas/SystemCommonAtlas", var_14_3.icon)
		var_14_4.name_.text = string.format(GetTips("EQUIP_UPGRADE_ATTR_DES"), GetI18NText(var_14_3.name))
		var_14_4.oldVal_.text = var_14_2[iter_14_0][3]
		var_14_4.newVal_.text = var_14_0.fixed_attributes[var_14_1 + 2][iter_14_0][3]
	end
end

function var_0_0.RefreshEquipUpCost(arg_15_0)
	local var_15_0 = arg_15_0.equip:GetUpgradeCost()

	if not var_15_0 then
		return
	end

	arg_15_0.isLack_ = false
	arg_15_0.moneyCost_ = var_15_0.money

	local var_15_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
	local var_15_2 = tostring(arg_15_0.moneyCost_)

	if var_15_1 < var_15_0.money then
		arg_15_0.isLack_ = true
		var_15_2 = "<color='#EB0000'>" .. var_15_2 .. "</color>"
	end

	arg_15_0.costNum_.text = var_15_2

	for iter_15_0, iter_15_1 in ipairs(var_15_0.item_list) do
		if ItemTools.getItemNum(iter_15_1[1]) < iter_15_1[2] then
			arg_15_0.isLack_ = true

			break
		end
	end

	arg_15_0.costMaterialList_ = var_15_0.item_list

	local var_15_3 = #arg_15_0.costMaterialList_

	arg_15_0.costScroller_:StartScroll(var_15_3)
end

function var_0_0.indexItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = clone(ItemTemplateData)
	local var_16_1 = arg_16_0.costMaterialList_[arg_16_1]

	var_16_0.id = var_16_1[1]

	local var_16_2 = ItemTools.getItemNum(var_16_1[1])

	function var_16_0.clickFun(arg_17_0)
		ShowPopItem(POP_SOURCE_ITEM, {
			arg_17_0.id,
			arg_17_0.number
		})
	end

	var_16_0.bottomText = {
		var_16_2,
		var_16_1[2]
	}
	var_16_0.hideBottomRightTextFlag = true

	arg_16_2:SetData(var_16_0)
end

function var_0_0.RefreshEquipUpLimit(arg_18_0)
	local var_18_0 = EquipCfg[arg_18_0.equip.prefab_id]
	local var_18_1 = arg_18_0.equip.now_break_level
	local var_18_2 = var_18_0.max_level[var_18_1 + 2]
	local var_18_3 = var_18_0.hero_slot_open_level[1]

	if var_18_3 and var_18_2 == var_18_3 then
		arg_18_0.conditionController_:SetSelectedState("show")

		arg_18_0.conditionDesc_.text = GetTips("EQUIP_BREAK_LIMITED")

		if arg_18_0.equip.race ~= 0 and table.keyof(RaceEffectCfg.all, arg_18_0.equip.race) == nil then
			arg_18_0.showTips_ = false

			arg_18_0.clearController_:SetSelectedState("clear")
		else
			arg_18_0.showTips_ = true

			arg_18_0.clearController_:SetSelectedState("notclear")
		end
	else
		arg_18_0.showTips_ = false

		arg_18_0.conditionController_:SetSelectedState("hide")
	end
end

function var_0_0.OnExit(arg_19_0)
	arg_19_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0:RemoveAllListeners()

	if arg_20_0.costScroller_ then
		arg_20_0.costScroller_:Dispose()

		arg_20_0.costScroller_ = nil
	end

	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
