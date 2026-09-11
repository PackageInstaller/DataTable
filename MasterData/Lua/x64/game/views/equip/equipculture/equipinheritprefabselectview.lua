local EquipInheritPrefabSelectView = class("EquipInheritPrefabSelectView", ReduxView)

function EquipInheritPrefabSelectView:UIName()
	return "Widget/System/Operation/EquipSelectPopUI"
end

function EquipInheritPrefabSelectView:UIParent()
	return manager.ui.uiPop.transform
end

local var_0_1 = {
	1,
	2,
	0
}

function EquipInheritPrefabSelectView:OnCtor()
	return
end

function EquipInheritPrefabSelectView:Init()
	self:InitUI()
	self:InitDropDown()
	self:AddListeners()
end

function EquipInheritPrefabSelectView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.suitListGo_, SuitSelectItem)
	self.stateController_ = self.controller:GetController("state")
end

function EquipInheritPrefabSelectView:InitDropDown()
	self.dropDown_.options:Clear()
	self.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("ALL"), nil))
	self.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("EQUIP_TYPE_1"), nil))
	self.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("EQUIP_TYPE_2"), nil))
	self.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("RACE_TYPE_10"), nil))
	self.dropDown_:RefreshShownValue()
end

function EquipInheritPrefabSelectView:AddListeners()
	self:AddBtnListener(self.btnBgMask_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListenerScale(self.btnConfirm_, nil, function()
		if self.selectSuitId_ == nil then
			JumpTools.Back()

			return
		end

		if self.selectHandler_ ~= nil then
			self.selectHandler_(self.selectSuitId_)
		end

		JumpTools.Back()
	end)
	self:AddToggleListener(self.dropDown_, function(arg_10_0)
		self.select_ = arg_10_0

		self:RefreshUI()
	end)
end

function EquipInheritPrefabSelectView:OnEnter()
	self.selectSuitId_ = self.params_.suitId
	self.choosedId_ = self.params_.suitId
	self.selectHandler_ = self.params_.selectSuitHandler
	self.equipTypeCfg_ = EquipSuitCfg.get_id_list_by_equip_type
	self.select_ = self.select_ or 0
	self.dropDown_.value = 0

	self:RefreshUI()
end

function EquipInheritPrefabSelectView:RefreshUI()
	self:UpdateData()

	local var_12_0 = table.indexof(self.suitList_, self.selectSuitId_)

	if not var_12_0 then
		var_12_0 = 1
		self.selectSuitId_ = self.suitList_[1]
	end

	self.stateController_:SetSelectedState(self.choosedId_ ~= self.selectSuitId_ and "confirm" or "select")
	self.scrollHelper_:StartScroll(#self.suitList_, var_12_0 - 6 < 1 and 1 or var_12_0 - 6)
	self:RefreshSelectSuitInfo()
end

function EquipInheritPrefabSelectView:UpdateData()
	self.suitList_ = {}

	local var_13_0 = HideInfoData:GetEquipSuitHideList()
	local var_13_1

	if self.select_ ~= 0 then
		var_13_1 = self.equipTypeCfg_[var_0_1[self.select_]] or EquipSuitCfg.all
	end

	local var_13_2 = EquipCfg[EquipData:GetEquipData(self.params_.equipID).prefab_id].suit

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		if not var_13_0[iter_13_1] and iter_13_1 ~= var_13_2 and EquipSuitCfg[iter_13_1].inherit_cost_type ~= 0 then
			table.insert(self.suitList_, iter_13_1)
		end
	end
end

function EquipInheritPrefabSelectView:RefreshSelectSuitInfo()
	if not EquipSuitCfg[self.selectSuitId_] then
		SetActive(self.infoGo_, false)

		return
	end

	self.name_.text = GetI18NText(EquipSuitCfg[self.selectSuitId_].name)
	self.num_.text = string.format(GetTips("EQUIP_SUIT_NUM"), EquipSuitCfg[self.selectSuitId_].need)
	self.desc_.text = GetI18NText(EquipTools.GetEffectDesc(EquipSuitCfg[self.selectSuitId_].suit_effect[1]))

	SetActive(self.infoGo_, true)
end

function EquipInheritPrefabSelectView:indexItem(arg_15_1, arg_15_2)
	local var_15_0 = self.suitList_[arg_15_1]

	arg_15_2:ShowSelect(self.suitList_[arg_15_1] == self.selectSuitId_)
	arg_15_2:ShowCurrentUp(var_15_0 == self.params_.suitId)
	arg_15_2:RefreshData(self, {
		id = var_15_0
	})
	arg_15_2:RegistCallBack(function(arg_16_0)
		self:SelectSuitItem(arg_16_0)
	end)
end

function EquipInheritPrefabSelectView:SelectSuitItem(arg_17_1)
	local var_17_0 = self.scrollHelper_:GetItemByIndex((table.indexof(self.suitList_, self.selectSuitId_)))

	if var_17_0 then
		var_17_0:ShowSelect(false)
	end

	self.scrollHelper_:GetItemByIndex((table.indexof(self.suitList_, arg_17_1.id))):ShowSelect(true)

	self.selectSuitId_ = arg_17_1.id

	self.stateController_:SetSelectedState(self.choosedId_ ~= self.selectSuitId_ and "confirm" or "select")
	self:RefreshSelectSuitInfo()
end

function EquipInheritPrefabSelectView:OnChangeUpSuit(arg_18_1, arg_18_2)
	if isSuccess(arg_18_1.result) then
		JumpTools.Back()
	end
end

function EquipInheritPrefabSelectView:OnExit()
	self.selectSuitId_ = nil
	self.params_.suitId = nil
end

function EquipInheritPrefabSelectView:Dispose()
	self.scrollHelper_:Dispose()
	EquipInheritPrefabSelectView.super.Dispose(self)
end

return EquipInheritPrefabSelectView
