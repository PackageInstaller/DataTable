local var_0_0 = class("EquipInheritPrefabSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/EquipSelectPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

local var_0_1 = {
	1,
	2,
	0
}

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:InitDropDown()
	arg_4_0:AddListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.scrollHelper_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.suitListGo_, SuitSelectItem)
	arg_5_0.stateController_ = arg_5_0.controller:GetController("state")
end

function var_0_0.InitDropDown(arg_6_0)
	arg_6_0.dropDown_.options:Clear()
	arg_6_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("ALL"), nil))
	arg_6_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("EQUIP_TYPE_1"), nil))
	arg_6_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("EQUIP_TYPE_2"), nil))
	arg_6_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("RACE_TYPE_10"), nil))
	arg_6_0.dropDown_:RefreshShownValue()
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.btnBgMask_, nil, function()
		JumpTools.Back()
	end)
	arg_7_0:AddBtnListenerScale(arg_7_0.btnConfirm_, nil, function()
		if arg_7_0.selectSuitId_ == nil then
			JumpTools.Back()

			return
		end

		if arg_7_0.selectHandler_ ~= nil then
			arg_7_0.selectHandler_(arg_7_0.selectSuitId_)
		end

		JumpTools.Back()
	end)
	arg_7_0:AddToggleListener(arg_7_0.dropDown_, function(arg_10_0)
		arg_7_0.select_ = arg_10_0

		arg_7_0:RefreshUI()
	end)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.selectSuitId_ = arg_11_0.params_.suitId
	arg_11_0.choosedId_ = arg_11_0.params_.suitId
	arg_11_0.selectHandler_ = arg_11_0.params_.selectSuitHandler
	arg_11_0.equipTypeCfg_ = EquipSuitCfg.get_id_list_by_equip_type
	arg_11_0.select_ = arg_11_0.select_ or 0
	arg_11_0.dropDown_.value = 0

	arg_11_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0:UpdateData()

	local var_12_0 = table.indexof(arg_12_0.suitList_, arg_12_0.selectSuitId_)

	if not var_12_0 then
		var_12_0 = 1
		arg_12_0.selectSuitId_ = arg_12_0.suitList_[1]
	end

	arg_12_0.stateController_:SetSelectedState(arg_12_0.choosedId_ ~= arg_12_0.selectSuitId_ and "confirm" or "select")

	local var_12_1 = 6
	local var_12_2 = var_12_0 - var_12_1 < 1 and 1 or var_12_0 - var_12_1

	arg_12_0.scrollHelper_:StartScroll(#arg_12_0.suitList_, var_12_2)
	arg_12_0:RefreshSelectSuitInfo()
end

function var_0_0.UpdateData(arg_13_0)
	arg_13_0.suitList_ = {}

	local var_13_0 = HideInfoData:GetEquipSuitHideList()
	local var_13_1 = arg_13_0.select_ ~= 0 and arg_13_0.equipTypeCfg_[var_0_1[arg_13_0.select_]] or EquipSuitCfg.all
	local var_13_2 = EquipData:GetEquipData(arg_13_0.params_.equipID)
	local var_13_3 = EquipCfg[var_13_2.prefab_id].suit

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		if not var_13_0[iter_13_1] and iter_13_1 ~= var_13_3 and EquipSuitCfg[iter_13_1].inherit_cost_type ~= 0 then
			table.insert(arg_13_0.suitList_, iter_13_1)
		end
	end
end

function var_0_0.RefreshSelectSuitInfo(arg_14_0)
	local var_14_0 = EquipSuitCfg[arg_14_0.selectSuitId_]

	if not var_14_0 then
		SetActive(arg_14_0.infoGo_, false)

		return
	end

	arg_14_0.name_.text = GetI18NText(var_14_0.name)
	arg_14_0.num_.text = string.format(GetTips("EQUIP_SUIT_NUM"), var_14_0.need)
	arg_14_0.desc_.text = GetI18NText(EquipTools.GetEffectDesc(var_14_0.suit_effect[1]))

	SetActive(arg_14_0.infoGo_, true)
end

function var_0_0.indexItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.suitList_[arg_15_1]

	arg_15_2:ShowSelect(var_15_0 == arg_15_0.selectSuitId_)
	arg_15_2:ShowCurrentUp(var_15_0 == arg_15_0.params_.suitId)
	arg_15_2:RefreshData(arg_15_0, {
		id = var_15_0
	})
	arg_15_2:RegistCallBack(function(arg_16_0)
		arg_15_0:SelectSuitItem(arg_16_0)
	end)
end

function var_0_0.SelectSuitItem(arg_17_0, arg_17_1)
	local var_17_0 = table.indexof(arg_17_0.suitList_, arg_17_1.id)
	local var_17_1 = table.indexof(arg_17_0.suitList_, arg_17_0.selectSuitId_)
	local var_17_2 = arg_17_0.scrollHelper_:GetItemByIndex(var_17_0)
	local var_17_3 = arg_17_0.scrollHelper_:GetItemByIndex(var_17_1)

	if var_17_3 then
		var_17_3:ShowSelect(false)
	end

	var_17_2:ShowSelect(true)

	arg_17_0.selectSuitId_ = arg_17_1.id

	arg_17_0.stateController_:SetSelectedState(arg_17_0.choosedId_ ~= arg_17_0.selectSuitId_ and "confirm" or "select")
	arg_17_0:RefreshSelectSuitInfo()
end

function var_0_0.OnChangeUpSuit(arg_18_0, arg_18_1, arg_18_2)
	if isSuccess(arg_18_1.result) then
		JumpTools.Back()
	end
end

function var_0_0.OnExit(arg_19_0)
	arg_19_0.selectSuitId_ = nil
	arg_19_0.params_.suitId = nil
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
