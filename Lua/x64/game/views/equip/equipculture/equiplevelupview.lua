local var_0_0 = class("EquipLevelUpView", EquipBaseView)

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
	var_0_0.super.Init(arg_2_0)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.scrollHelper = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.listGo_, CommonItemView)
	arg_3_0.attrs = {}

	for iter_3_0 = 1, 2 do
		local var_3_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_3_0, arg_3_0["property_" .. iter_3_0])
		table.insert(arg_3_0.attrs, var_3_0)
	end

	arg_3_0.maxAttrs = {}

	for iter_3_1 = 1, 2 do
		local var_3_1 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_3_1, arg_3_0["maxAttr_" .. iter_3_1])
		table.insert(arg_3_0.maxAttrs, var_3_1)
	end

	arg_3_0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	arg_3_0.maxLvController_ = arg_3_0.transCon_:GetController("levelMax")
	arg_3_0.equipStrengthHandler_ = handler(arg_3_0, arg_3_0.OnEquipStrengthSuccess)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btnAutoSelect_, nil, function()
		if arg_4_0.nextLv_ >= arg_4_0.equipMaxLv_ then
			return
		end

		local var_5_0 = EquipCfg[arg_4_0.equip_.prefab_id]
		local var_5_1 = EquipTools.CountNeedExp(arg_4_0.equip_, arg_4_0.equipMaxLv_, arg_4_0.equip_.now_break_level) - arg_4_0.equip_.exp
		local var_5_2 = {}

		table.insert(var_5_2, arg_4_0.equipId_)

		local var_5_3, var_5_4 = EquipTools.QuickSelectList(var_5_1, var_5_2)

		arg_4_0.usedMaterialList_ = var_5_3
		arg_4_0.usedEquipList_ = var_5_4

		arg_4_0:RefreshListSelect()
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnLevelup_, nil, function()
		local var_6_0 = false

		for iter_6_0, iter_6_1 in pairs(arg_4_0.usedMaterialList_) do
			if iter_6_1 > 0 then
				var_6_0 = true
			end
		end

		if not var_6_0 and next(arg_4_0.usedEquipList_) == nil then
			ShowTips(GetTips("PLEASE_SELECT_ITEM"))

			return
		end

		if not checkGold(arg_4_0.cost_) then
			return
		end

		local var_6_1 = false

		for iter_6_2, iter_6_3 in pairs(arg_4_0.usedEquipList_) do
			if iter_6_3.equip_star >= 5 then
				var_6_1 = true

				break
			end
		end

		local var_6_2 = false
		local var_6_3 = EquipTools.CountNeedExp(arg_4_0.equip_, arg_4_0.equipMaxLv_, arg_4_0.equip_.now_break_level)
		local var_6_4 = EquipTools.CountAddExp(arg_4_0.usedMaterialList_, arg_4_0.usedEquipList_)
		local var_6_5 = arg_4_0.equip_.exp + var_6_4 - var_6_3
		local var_6_6 = MaterialTools.materialGiveBack(var_6_5, ItemConst.STR_ITEM.EQUIP)

		local function var_6_7(arg_7_0, arg_7_1)
			for iter_7_0, iter_7_1 in pairs(arg_7_1) do
				arg_7_0[#arg_7_0 + 1] = iter_7_1
			end
		end

		for iter_6_4, iter_6_5 in pairs(arg_4_0.usedEquipList_) do
			local var_6_8 = EquipData:GetEquipData(iter_6_4):GetBreakCostReturn()

			var_6_7(var_6_6, var_6_8)
		end

		local var_6_9 = formatRewardCfgList(var_6_6)
		local var_6_10 = mergeReward(var_6_9)
		local var_6_11 = sortReward(var_6_10)
		local var_6_12 = unformatRewardCfgList(var_6_11)

		if #var_6_12 > 0 then
			var_6_2 = true
		end

		local var_6_13 = ""

		if var_6_1 and var_6_2 then
			var_6_13 = string.format(GetTips("EQUIP_STRENGTH_EXP_OVERFLOW_AND_RARE"))
		elseif var_6_1 and not var_6_2 then
			var_6_13 = GetTips("EQUIP_STRENGTH_COST_RARE")
		elseif not var_6_1 and var_6_2 then
			var_6_13 = string.format(GetTips("EQUIP_STRENGTH_EXP_OVERFLOW"))
		else
			EquipAction.ApplyStrengthEquip(tonumber(arg_4_0.equipId_), arg_4_0.usedEquipList_, arg_4_0.usedMaterialList_, arg_4_0.cost_, var_6_5)

			return
		end

		if var_6_1 and not var_6_2 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = var_6_13,
				OkCallback = function()
					EquipAction.ApplyStrengthEquip(tonumber(arg_4_0.equipId_), arg_4_0.usedEquipList_, arg_4_0.usedMaterialList_, arg_4_0.cost_)
				end
			})

			return
		end

		JumpTools.OpenPageByJump("materialPreview", {
			content = var_6_13,
			OkCallback = function()
				EquipAction.ApplyStrengthEquip(tonumber(arg_4_0.equipId_), arg_4_0.usedEquipList_, arg_4_0.usedMaterialList_, arg_4_0.cost_, var_6_5)
			end,
			itemList = var_6_12
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnFilter_, nil, function()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.Equip_Filter_List
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnOneKeyCulture_, nil, function()
		JumpTools.OpenPageByJump("equipOneKeyCulturePopView", {
			equipId = arg_4_0.equipId_
		})
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:OnEquipChange(arg_12_0.params_.equipId)
	arg_12_0:RegistEventListener(COMMON_FILTER_OK, handler(arg_12_0, arg_12_0.OnFilterChange))
	arg_12_0:RegistEventListener(CURRENCY_UPDATE, handler(arg_12_0, arg_12_0.OnGoldChange))
	arg_12_0:RegistEventListener(EQUIP_STRENGTH_SUCCESS, arg_12_0.equipStrengthHandler_)
end

function var_0_0.OnEquipChange(arg_13_0, arg_13_1)
	arg_13_0.usedMaterialList_ = {}
	arg_13_0.usedEquipList_ = {}
	arg_13_0.equipId_ = arg_13_1
	arg_13_0.equip_ = EquipData:GetEquipData(arg_13_0.equipId_)
	arg_13_0.equipMaxLv_ = EquipTools.CountEquipMaxLv(arg_13_0.equip_)
	arg_13_0.equipLv_ = arg_13_0.equip_:GetLevel()

	if arg_13_0.equipLv_ == arg_13_0.equipMaxLv_ then
		arg_13_0.maxLvController_:SetSelectedState("max")
		arg_13_0:RefreshMax()
	else
		arg_13_0.maxLvController_:SetSelectedState("normal")
		arg_13_0:RefreshEquipStrength()
		arg_13_0:ChangeEquipSelectView(EquipConst.EQUIP_SORT.LEVEL, ItemConst.SORT_TYPE.UP)
	end

	arg_13_0:ChangeBar()
end

function var_0_0.OnTop(arg_14_0)
	arg_14_0:ChangeBar()
end

function var_0_0.ChangeBar(arg_15_0)
	local var_15_0 = {
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	}

	if arg_15_0.equipLv_ == arg_15_0.equipMaxLv_ then
		manager.windowBar:SwitchBar(var_15_0)
	else
		table.insert(var_15_0, CurrencyConst.CURRENCY_TYPE_GOLD)
		manager.windowBar:SwitchBar(var_15_0)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	end
end

function var_0_0.RefreshMax(arg_16_0)
	arg_16_0.maxLv_.text = arg_16_0.equipMaxLv_

	local var_16_0 = EquipTools.CountEquipAttribute(arg_16_0.equip_)
	local var_16_1 = 1

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		local var_16_2 = PublicAttrCfg[iter_16_0]
		local var_16_3 = arg_16_0.maxAttrs[var_16_1]
		local var_16_4 = math.floor(iter_16_1)

		if var_16_2.percent and var_16_2.percent == 1 then
			var_16_4 = iter_16_1 / 10 .. "%"
		end

		var_16_3.name_.text = GetI18NText(var_16_2.name)
		var_16_3.icon_.sprite = getSprite("Atlas/SystemCommonAtlas", var_16_2.icon)
		var_16_3.num_.text = var_16_4
		var_16_1 = var_16_1 + 1
	end
end

function var_0_0.RefreshEquipStrength(arg_17_0)
	local var_17_0 = EquipTools.CountAddExp(arg_17_0.usedMaterialList_, arg_17_0.usedEquipList_)
	local var_17_1 = arg_17_0.equip_
	local var_17_2 = var_17_1.exp + var_17_0
	local var_17_3 = deepClone(var_17_1)

	var_17_3.exp = var_17_2

	arg_17_0:RefreshExp(var_17_0, var_17_2, var_17_1, var_17_3)
	arg_17_0:RefreshAttr(var_17_1, var_17_3)
	arg_17_0:RefreshCost()
end

function var_0_0.RefreshExp(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = EquipTools.CountEquipLevel(arg_18_3)
	local var_18_1 = EquipTools.CountEquipLevel(arg_18_4)

	arg_18_0.nextLv_ = var_18_1
	arg_18_0.oldLv_.text = "" .. var_18_0
	arg_18_0.newLv_.text = "" .. var_18_1

	local var_18_2 = arg_18_0.equipMaxLv_

	SetActive(arg_18_0.btnAutoSelectGo_, var_18_0 < var_18_2)
	SetActive(arg_18_0.btnStrengthGo_, var_18_0 < var_18_2)
	SetActive(arg_18_0.btnAutoSelectNullGo_, var_18_0 == var_18_2)
	SetActive(arg_18_0.newLevelContent_, arg_18_1 ~= 0)

	arg_18_0.addExpText_.text = "+" .. arg_18_1

	local var_18_3 = EquipTools.CountNeedExp(arg_18_3, var_18_1, arg_18_3.now_break_level)
	local var_18_4 = arg_18_2 - var_18_3

	arg_18_0.cost_ = 0

	if var_18_2 <= var_18_1 then
		local var_18_5 = var_18_3 - arg_18_3.exp

		arg_18_0.cost_ = math.floor((var_18_5 < 0 and 0 or var_18_5) * GameSetting.equip_strengthen_gold_cost.value[1])
		arg_18_0.expNum_.text = "-/-"
		arg_18_0.expProg_.fillAmount = 0
		arg_18_0.newExpProg_.fillAmount = 1

		SetActive(arg_18_0.maxGo_, true)
	else
		arg_18_0.cost_ = math.floor(arg_18_1 * GameSetting.equip_strengthen_gold_cost.value[1])

		local var_18_6 = EquipExpCfg[var_18_1]["exp" .. arg_18_3.equipConfig.starlevel]

		arg_18_0.expNum_.text = var_18_4 .. "/" .. var_18_6

		if var_18_1 == var_18_0 then
			arg_18_0.expProg_.fillAmount = (var_18_4 - arg_18_1) / var_18_6
		else
			arg_18_0.expProg_.fillAmount = 0
		end

		arg_18_0.newExpProg_.fillAmount = var_18_4 / var_18_6

		SetActive(arg_18_0.maxGo_, false)
	end
end

function var_0_0.RefreshAttr(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = EquipTools.CountEquipAttribute(arg_19_1)
	local var_19_1 = EquipTools.CountEquipAttribute(arg_19_2)
	local var_19_2 = 1

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		local var_19_3 = PublicAttrCfg[iter_19_0]
		local var_19_4 = arg_19_0.attrs[var_19_2]

		if not var_19_4 then
			break
		end

		local var_19_5 = math.floor(iter_19_1)
		local var_19_6 = math.floor(var_19_1[iter_19_0])

		if var_19_3.percent and var_19_3.percent == 1 then
			var_19_5 = iter_19_1 / 10 .. "%"
			var_19_6 = var_19_1[iter_19_0] / 10 .. "%"
		end

		var_19_4.name_.text = GetI18NText(var_19_3.name)
		var_19_4.icon_.sprite = getSprite("Atlas/SystemCommonAtlas", var_19_3.icon)
		var_19_4.oldVal_.text = var_19_5

		if iter_19_1 ~= var_19_1[iter_19_0] then
			var_19_4.newVal_.text = string.format("<color='#E28000'>%s</color>", var_19_6)
			var_19_4.arrow_.color = Color.New(0.8941176, 0.5058823, 0, 1)
		else
			var_19_4.newVal_.text = string.format("<color='#3D4045'>%s</color>", var_19_6)
			var_19_4.arrow_.color = Color.New(0.2392156, 0.2509803, 0.2705882, 1)
		end

		var_19_2 = var_19_2 + 1
	end
end

function var_0_0.RefreshCost(arg_20_0)
	local var_20_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
	local var_20_1 = tostring(arg_20_0.cost_)

	if var_20_0 < arg_20_0.cost_ then
		var_20_1 = "<color='#FF0000'>" .. var_20_1 .. "</color>"
	end

	arg_20_0.costNum_.text = var_20_1
end

function var_0_0.ChangeEquipSelectView(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.priority_ = arg_21_1
	arg_21_0.order_ = arg_21_2
	arg_21_0.itemList = arg_21_0:GetItemList()

	arg_21_0:RefreshList()
end

function var_0_0.RefreshList(arg_22_0)
	local var_22_0 = #arg_22_0.itemList

	arg_22_0.scrollHelper:StartScroll(var_22_0)
end

function var_0_0.RefreshListSelect(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.scrollHelper:GetItemList()) do
		local var_23_0 = iter_23_1:GetData()

		if var_23_0.type == ItemConst.ITEM_TYPE.MATERIAL then
			local var_23_1 = arg_23_0.usedMaterialList_[var_23_0.id] or 0

			iter_23_1:RefreshTopAmount(var_23_1)
		elseif var_23_0.type == ItemConst.ITEM_TYPE.EQUIP then
			iter_23_1:RefreshSelectState(arg_23_0.usedEquipList_[var_23_0.equip_id] and true or false)
		end
	end

	arg_23_0:RefreshEquipStrength()
end

function var_0_0.indexItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.itemList[arg_24_1]
	local var_24_1 = clone(ItemTemplateData)

	if var_24_0.type == ItemConst.ITEM_TYPE.EQUIP then
		var_24_1.equip_info = var_24_0
		var_24_1.id = var_24_0.prefab_id
		var_24_1.equip_id = var_24_0.equip_id
		var_24_1.equip_star = getItemStar(var_24_0.prefab_id)
		var_24_1.equipLevel = EquipTools.CountEquipLevel(var_24_0)
		var_24_1.isEquiped = false
		var_24_1.equipedLocked = var_24_0.is_lock
		var_24_1.type = var_24_0.type

		function var_24_1.clickFun(arg_25_0)
			arg_24_0:EquipClickFunc(arg_24_2, arg_25_0)
		end

		var_24_1.selectStyle = arg_24_0.usedEquipList_[var_24_0.equip_id] ~= nil
	elseif var_24_0.type == ItemConst.ITEM_TYPE.MATERIAL then
		var_24_1.id = var_24_0.id
		var_24_1.number = var_24_0.number
		var_24_1.type = var_24_0.type

		function var_24_1.longClickFun(arg_26_0)
			return arg_24_0:MaterialLongClickFunc(arg_24_2, arg_26_0)
		end

		function var_24_1.clickAmountFun(arg_27_0)
			return arg_24_0:MaterialAmountClickFunc(arg_24_2, arg_27_0)
		end

		if arg_24_0.usedMaterialList_[var_24_0.id] and arg_24_0.usedMaterialList_[var_24_0.id] ~= 0 then
			var_24_1.topAmountValue = arg_24_0.usedMaterialList_[var_24_0.id]
		end
	end

	arg_24_2:SetData(var_24_1)
end

function var_0_0.EquipClickFunc(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_2.equip_id

	if arg_28_0.usedEquipList_[var_28_0] then
		arg_28_0.usedEquipList_[var_28_0] = nil
		arg_28_0.handler_.equipCommonItem_ = arg_28_1

		arg_28_0.handler_:HidePop()
	else
		local var_28_1 = arg_28_2.equip_id

		if arg_28_0.nextLv_ >= arg_28_0.equipMaxLv_ then
			ShowTips("ERROR_USER_MAX_LV")

			return
		end

		if arg_28_2.equipedLocked then
			ShowTips("REMOVE_LOCK")
			arg_28_0:ShowEquipInfo(var_28_1, arg_28_1)

			return
		end

		arg_28_0:ShowEquipInfo(var_28_1, arg_28_1)
		arg_28_1:RefreshSelectState(true)

		arg_28_0.usedEquipList_[var_28_1] = arg_28_2
	end

	arg_28_0:RefreshEquipStrength()
end

function var_0_0.MaterialLongClickFunc(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0.nextLv_ >= arg_29_0.equipMaxLv_ then
		ShowTips("ERROR_USER_MAX_LV")

		return false
	end

	arg_29_0.usedMaterialList_[arg_29_2.id] = arg_29_0.usedMaterialList_[arg_29_2.id] or 0

	if arg_29_0.usedMaterialList_[arg_29_2.id] >= arg_29_2.number then
		return false
	end

	arg_29_0.usedMaterialList_[arg_29_2.id] = arg_29_0.usedMaterialList_[arg_29_2.id] + 1

	arg_29_1:RefreshTopAmount(arg_29_0.usedMaterialList_[arg_29_2.id])
	arg_29_0:RefreshEquipStrength()
	manager.audio:PlayUIAudio(2)

	return true
end

function var_0_0.MaterialAmountClickFunc(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0.usedMaterialList_[arg_30_2.id] = arg_30_0.usedMaterialList_[arg_30_2.id] or 0

	if arg_30_0.usedMaterialList_[arg_30_2.id] <= 0 then
		return false
	end

	arg_30_0.usedMaterialList_[arg_30_2.id] = arg_30_0.usedMaterialList_[arg_30_2.id] - 1

	arg_30_1:RefreshTopAmount(arg_30_0.usedMaterialList_[arg_30_2.id])
	arg_30_0:RefreshEquipStrength()
	manager.audio:PlayUIAudio(2)

	return true
end

function var_0_0.GetEquip(arg_31_0)
	return EquipData:GetEquipData(arg_31_0.equipId_)
end

function var_0_0.GetItemList(arg_32_0)
	return EquipTools.GetEquipLevelUpMaterial(arg_32_0.order_, arg_32_0.priority_, {
		arg_32_0.equipId_
	})
end

function var_0_0.ShowEquipInfo(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = EquipData:GetEquipData(arg_33_1)

	local function var_33_1(arg_34_0)
		if arg_34_0 then
			arg_33_2:RefreshSelectState(false)

			arg_33_0.usedEquipList_[arg_33_1] = nil

			arg_33_0:RefreshEquipStrength()
		end

		arg_33_2:RefreshLock(arg_34_0)
	end

	arg_33_0.handler_:RefreshEquipInfo(var_33_0, arg_33_2, var_33_1)
end

function var_0_0.OnEquipStrengthSuccess(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if arg_35_3.equipId == arg_35_0.equipId_ then
		arg_35_0.handler_:RefreshSideBar(arg_35_0.equipId_)
	end

	if arg_35_2 then
		JumpTools.OpenPageByJump("equipCulturePopView", arg_35_3)
	end

	arg_35_0.handler_:HidePop()

	arg_35_0.usedMaterialList_ = {}
	arg_35_0.usedEquipList_ = {}
	arg_35_0.itemList = arg_35_0:GetItemList()

	arg_35_0:RefreshListSelect()
	arg_35_0:RefreshList()
end

function var_0_0.OnGoldChange(arg_36_0, arg_36_1)
	if arg_36_1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		arg_36_0:RefreshEquipStrength()
	end
end

function var_0_0.OnExit(arg_37_0)
	CommonFilterData:ClearFilter(Filter_Root_Define.Equip_Filter_List.filter_id)
	arg_37_0:RemoveAllEventListener()
end

function var_0_0.OnFilterChange(arg_38_0)
	local var_38_0 = CommonFilterData:HasIndexFlag(2, 4, 13)
	local var_38_1 = CommonFilterData:HasIndexFlag(2, 4, 14)
	local var_38_2 = CommonFilterData:HasIndexFlag(2, 5, 15)
	local var_38_3 = CommonFilterData:HasIndexFlag(2, 5, 16)
	local var_38_4 = var_38_1 and EquipConst.EQUIP_SORT.RARE or EquipConst.EQUIP_SORT.LEVEL
	local var_38_5 = var_38_3 and 0 or 1

	arg_38_0:ChangeEquipSelectView(var_38_4, var_38_5)
end

function var_0_0.Dispose(arg_39_0)
	arg_39_0:RemoveAllListeners()

	if arg_39_0.scrollHelper then
		arg_39_0.scrollHelper:Dispose()

		arg_39_0.scrollHelper = nil
	end

	var_0_0.super.Dispose(arg_39_0)
end

return var_0_0
