local var_0_0 = class("StoreEquipFilterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Bag/BagEquipFilterUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.suitUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexSuitItem), arg_3_0.suitListGo_, EquipFilterSuitItem)
	arg_3_0.skillUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexSkillItem), arg_3_0.skillListGo_, EquipFilterSkillItem)
	arg_3_0.tabController_ = arg_3_0.filterController_:GetController("tab")
	arg_3_0.selectController_ = arg_3_0.filterController_:GetController("select")
	arg_3_0.suitList_ = {}
	arg_3_0.skillList_ = {}
	arg_3_0.selectList_ = {}
	arg_3_0.selectItemList_ = {}
	arg_3_0.selectPanelType_ = StoreConst.EQUIP_FILTER_TYPE.SUIT
	arg_3_0.OnEquipFilterSelectChangeHandler = handler(arg_3_0, arg_3_0.OnEquipFilterSelectChange)
end

function var_0_0.OnEnter(arg_4_0)
	manager.notify:RegistListener(EQUIP_FILTER_SELECT_CHANGE, arg_4_0.OnEquipFilterSelectChangeHandler)

	arg_4_0.filterParams_ = clone(arg_4_0.params_.filterParams)

	arg_4_0:InitSuitDataList()
	arg_4_0:InitSkillDataList()
	arg_4_0:InitSelectList()
	arg_4_0.suitUIList_:StartScroll(#arg_4_0.suitList_)
	arg_4_0.skillUIList_:StartScroll(#arg_4_0.skillList_)
	arg_4_0:RefreshSelectPanel()
end

function var_0_0.OnExit(arg_5_0)
	manager.notify:RemoveListener(EQUIP_FILTER_SELECT_CHANGE, arg_5_0.OnEquipFilterSelectChangeHandler)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.OnEquipFilterSelectChangeHandler = nil

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.selectItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.selectItemList_ = nil

	arg_6_0.suitUIList_:Dispose()

	arg_6_0.suitUIList_ = nil

	arg_6_0.skillUIList_:Dispose()

	arg_6_0.skillUIList_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.btnConfirm_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_7_0.filterParams_.suit) do
			table.insert(var_8_0, iter_8_1)
		end

		local var_8_1 = {}

		for iter_8_2, iter_8_3 in ipairs(arg_7_0.filterParams_.skill) do
			table.insert(var_8_1, iter_8_3)
		end

		manager.notify:Invoke(EQUIP_FILTER_SELECT_APPLY, {
			suitList = var_8_0,
			skillList = var_8_1
		})
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnSuit_, nil, function()
		arg_7_0:SwitchPanel(StoreConst.EQUIP_FILTER_TYPE.SUIT)
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnSkill_, nil, function()
		arg_7_0:SwitchPanel(StoreConst.EQUIP_FILTER_TYPE.SKILL)
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnMask_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.brnCloseSelected_, nil, function()
		arg_7_0.filterParams_.suit = {}
		arg_7_0.filterParams_.skill = {}

		arg_7_0:ClearSelectItemData()
		arg_7_0:RefreshSuitUIList()
		arg_7_0:RefreshSkillUIList()
		arg_7_0:RefreshSelectPanel()
	end)
end

function var_0_0.OnEquipFilterSelectChange(arg_13_0, arg_13_1)
	if arg_13_1.type == StoreConst.EQUIP_FILTER_TYPE.SUIT then
		if arg_13_1.state == StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.ADD then
			table.insert(arg_13_0.filterParams_.suit, arg_13_1.id)
			arg_13_0:AddSelectItemData(arg_13_1)
		else
			table.removebyvalue(arg_13_0.filterParams_.suit, arg_13_1.id)
			arg_13_0:RemoveSelectItemData(arg_13_1)
		end

		arg_13_0:RefreshSuitUIList()
	else
		if arg_13_1.state == StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.ADD then
			table.insert(arg_13_0.filterParams_.skill, arg_13_1.id)
			arg_13_0:AddSelectItemData(arg_13_1)
		else
			table.removebyvalue(arg_13_0.filterParams_.skill, arg_13_1.id)
			arg_13_0:RemoveSelectItemData(arg_13_1)
		end

		arg_13_0:RefreshSkillUIList()
	end

	arg_13_0:RefreshSelectPanel()
end

function var_0_0.SwitchPanel(arg_14_0, arg_14_1)
	if arg_14_0.selectPanelType_ ~= arg_14_1 then
		arg_14_0.selectPanelType_ = arg_14_1
		arg_14_0.filterParams_.suit = {}
		arg_14_0.filterParams_.skill = {}

		arg_14_0:ClearSelectItemData()
		arg_14_0:RefreshSelectPanel()

		if arg_14_1 == StoreConst.EQUIP_FILTER_TYPE.SUIT then
			arg_14_0.tabController_:SetSelectedState("suit")
		else
			arg_14_0.tabController_:SetSelectedState("skill")
		end

		arg_14_0:RefreshPanel()
	end
end

function var_0_0.RefreshPanel(arg_15_0)
	if arg_15_0.selectPanelType_ == StoreConst.EQUIP_FILTER_TYPE.SUIT then
		arg_15_0.suitUIList_:StartScroll(#arg_15_0.suitList_)
	else
		arg_15_0.skillUIList_:StartScroll(#arg_15_0.skillList_)
	end
end

function var_0_0.RefreshSelectPanel(arg_16_0)
	if #arg_16_0.selectList_ <= 0 then
		arg_16_0.selectController_:SetSelectedState("noselect")
	else
		arg_16_0.selectController_:SetSelectedState("select")
		arg_16_0:RefreshAllSelectItem()
	end
end

function var_0_0.RefreshSuitUIList(arg_17_0)
	arg_17_0.suitUIList_:Refresh()
end

function var_0_0.InitSuitDataList(arg_18_0)
	arg_18_0.suitList_ = {}

	for iter_18_0, iter_18_1 in ipairs(EquipSuitCfg.all) do
		local var_18_0 = EquipTools.GetSuitEquipNum(iter_18_1, nil, arg_18_0.params_.equipPosition)

		arg_18_0.suitList_[iter_18_0] = {
			type = StoreConst.EQUIP_FILTER_TYPE.SUIT,
			id = iter_18_1,
			cnt = var_18_0
		}
	end
end

function var_0_0.IndexSuitItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.suitList_[arg_19_1]

	arg_19_2:SetData(var_19_0, table.keyof(arg_19_0.filterParams_.suit, var_19_0.id) ~= nil)
end

function var_0_0.RefreshSkillUIList(arg_20_0)
	arg_20_0.skillUIList_:Refresh()
end

function var_0_0.InitSkillDataList(arg_21_0)
	arg_21_0.skillList_ = {}

	for iter_21_0, iter_21_1 in ipairs(EquipSkillCfg.get_id_list_by_skill_type[EquipConst.EQUIP_ATTRIBUTE_TYPE.ENCHANT]) do
		local var_21_0 = EquipTools.GetEquipSkillNum(iter_21_1, nil, arg_21_0.params_.equipPosition)

		arg_21_0.skillList_[iter_21_0] = {
			type = StoreConst.EQUIP_FILTER_TYPE.SKILL,
			id = iter_21_1,
			cnt = var_21_0
		}
	end
end

function var_0_0.IndexSkillItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.skillList_[arg_22_1]

	arg_22_2:SetData(var_22_0, table.keyof(arg_22_0.filterParams_.skill, var_22_0.id) ~= nil)
end

function var_0_0.InitSelectList(arg_23_0)
	arg_23_0.selectList_ = {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.filterParams_.suit) do
		local var_23_0 = {
			type = StoreConst.EQUIP_FILTER_TYPE.SUIT,
			id = iter_23_1
		}

		table.insert(arg_23_0.selectList_, var_23_0)
	end

	for iter_23_2, iter_23_3 in ipairs(arg_23_0.filterParams_.skill) do
		local var_23_1 = {
			type = StoreConst.EQUIP_FILTER_TYPE.SKILL,
			id = iter_23_3
		}

		table.insert(arg_23_0.selectList_, var_23_1)
	end
end

function var_0_0.AddSelectItemData(arg_24_0, arg_24_1)
	table.insert(arg_24_0.selectList_, {
		type = arg_24_1.type,
		id = arg_24_1.id
	})
end

function var_0_0.RemoveSelectItemData(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0.selectList_) do
		if iter_25_1.type == arg_25_1.type and iter_25_1.id == arg_25_1.id then
			table.remove(arg_25_0.selectList_, iter_25_0)

			return
		end
	end
end

function var_0_0.ClearSelectItemData(arg_26_0)
	arg_26_0.selectList_ = {}
end

function var_0_0.RefreshAllSelectItem(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.selectList_) do
		arg_27_0.selectItemList_[iter_27_0] = arg_27_0.selectItemList_[iter_27_0] or EquipFilterSelectItem.New(arg_27_0.filterItemGo_, arg_27_0.filterItemParentGo_)

		arg_27_0.selectItemList_[iter_27_0]:SetData(iter_27_1)
	end

	for iter_27_2 = #arg_27_0.selectList_ + 1, #arg_27_0.selectItemList_ do
		arg_27_0.selectItemList_[iter_27_2]:Show(false)
	end
end

return var_0_0
