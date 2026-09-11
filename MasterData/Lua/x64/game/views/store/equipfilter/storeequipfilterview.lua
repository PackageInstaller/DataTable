local StoreEquipFilterView = class("StoreEquipFilterView", ReduxView)

function StoreEquipFilterView:UIName()
	return "Widget/System/Bag/BagEquipFilterUI"
end

function StoreEquipFilterView:UIParent()
	return manager.ui.uiPop.transform
end

function StoreEquipFilterView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.suitUIList_ = LuaList.New(handler(self, self.IndexSuitItem), self.suitListGo_, EquipFilterSuitItem)
	self.skillUIList_ = LuaList.New(handler(self, self.IndexSkillItem), self.skillListGo_, EquipFilterSkillItem)
	self.tabController_ = self.filterController_:GetController("tab")
	self.selectController_ = self.filterController_:GetController("select")
	self.suitList_ = {}
	self.skillList_ = {}
	self.selectList_ = {}
	self.selectItemList_ = {}
	self.selectPanelType_ = StoreConst.EQUIP_FILTER_TYPE.SUIT
	self.OnEquipFilterSelectChangeHandler = handler(self, self.OnEquipFilterSelectChange)
end

function StoreEquipFilterView:OnEnter()
	manager.notify:RegistListener(EQUIP_FILTER_SELECT_CHANGE, self.OnEquipFilterSelectChangeHandler)

	self.filterParams_ = clone(self.params_.filterParams)

	self:InitSuitDataList()
	self:InitSkillDataList()
	self:InitSelectList()
	self.suitUIList_:StartScroll(#self.suitList_)
	self.skillUIList_:StartScroll(#self.skillList_)
	self:RefreshSelectPanel()
end

function StoreEquipFilterView:OnExit()
	manager.notify:RemoveListener(EQUIP_FILTER_SELECT_CHANGE, self.OnEquipFilterSelectChangeHandler)
end

function StoreEquipFilterView:Dispose()
	self.OnEquipFilterSelectChangeHandler = nil

	for iter_6_0, iter_6_1 in ipairs(self.selectItemList_) do
		iter_6_1:Dispose()
	end

	self.selectItemList_ = nil

	self.suitUIList_:Dispose()

	self.suitUIList_ = nil

	self.skillUIList_:Dispose()

	self.skillUIList_ = nil

	StoreEquipFilterView.super.Dispose(self)
end

function StoreEquipFilterView:AddListeners()
	self:AddBtnListener(self.btnConfirm_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(self.filterParams_.suit) do
			table.insert(var_8_0, iter_8_1)
		end

		local var_8_1 = {}

		for iter_8_2, iter_8_3 in ipairs(self.filterParams_.skill) do
			table.insert(var_8_1, iter_8_3)
		end

		manager.notify:Invoke(EQUIP_FILTER_SELECT_APPLY, {
			suitList = var_8_0,
			skillList = var_8_1
		})
		self:Back()
	end)
	self:AddBtnListener(self.btnSuit_, nil, function()
		self:SwitchPanel(StoreConst.EQUIP_FILTER_TYPE.SUIT)
	end)
	self:AddBtnListener(self.btnSkill_, nil, function()
		self:SwitchPanel(StoreConst.EQUIP_FILTER_TYPE.SKILL)
	end)
	self:AddBtnListener(self.btnMask_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.brnCloseSelected_, nil, function()
		self.filterParams_.suit = {}
		self.filterParams_.skill = {}

		self:ClearSelectItemData()
		self:RefreshSuitUIList()
		self:RefreshSkillUIList()
		self:RefreshSelectPanel()
	end)
end

function StoreEquipFilterView:OnEquipFilterSelectChange(arg_13_1)
	if arg_13_1.type == StoreConst.EQUIP_FILTER_TYPE.SUIT then
		if arg_13_1.state == StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.ADD then
			table.insert(self.filterParams_.suit, arg_13_1.id)
			self:AddSelectItemData(arg_13_1)
		else
			table.removebyvalue(self.filterParams_.suit, arg_13_1.id)
			self:RemoveSelectItemData(arg_13_1)
		end

		self:RefreshSuitUIList()
	else
		if arg_13_1.state == StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.ADD then
			table.insert(self.filterParams_.skill, arg_13_1.id)
			self:AddSelectItemData(arg_13_1)
		else
			table.removebyvalue(self.filterParams_.skill, arg_13_1.id)
			self:RemoveSelectItemData(arg_13_1)
		end

		self:RefreshSkillUIList()
	end

	self:RefreshSelectPanel()
end

function StoreEquipFilterView:SwitchPanel(arg_14_1)
	if self.selectPanelType_ ~= arg_14_1 then
		self.selectPanelType_ = arg_14_1
		self.filterParams_.suit = {}
		self.filterParams_.skill = {}

		self:ClearSelectItemData()
		self:RefreshSelectPanel()

		if arg_14_1 == StoreConst.EQUIP_FILTER_TYPE.SUIT then
			self.tabController_:SetSelectedState("suit")
		else
			self.tabController_:SetSelectedState("skill")
		end

		self:RefreshPanel()
	end
end

function StoreEquipFilterView:RefreshPanel()
	if self.selectPanelType_ == StoreConst.EQUIP_FILTER_TYPE.SUIT then
		self.suitUIList_:StartScroll(#self.suitList_)
	else
		self.skillUIList_:StartScroll(#self.skillList_)
	end
end

function StoreEquipFilterView:RefreshSelectPanel()
	if #self.selectList_ <= 0 then
		self.selectController_:SetSelectedState("noselect")
	else
		self.selectController_:SetSelectedState("select")
		self:RefreshAllSelectItem()
	end
end

function StoreEquipFilterView:RefreshSuitUIList()
	self.suitUIList_:Refresh()
end

function StoreEquipFilterView:InitSuitDataList()
	self.suitList_ = {}

	for iter_18_0, iter_18_1 in ipairs(EquipSuitCfg.all) do
		self.suitList_[iter_18_0] = {
			type = StoreConst.EQUIP_FILTER_TYPE.SUIT,
			id = iter_18_1,
			cnt = EquipTools.GetSuitEquipNum(iter_18_1, nil, self.params_.equipPosition)
		}
	end
end

function StoreEquipFilterView:IndexSuitItem(arg_19_1, arg_19_2)
	arg_19_2:SetData(self.suitList_[arg_19_1], table.keyof(self.filterParams_.suit, self.suitList_[arg_19_1].id) ~= nil)
end

function StoreEquipFilterView:RefreshSkillUIList()
	self.skillUIList_:Refresh()
end

function StoreEquipFilterView:InitSkillDataList()
	self.skillList_ = {}

	for iter_21_0, iter_21_1 in ipairs(EquipSkillCfg.get_id_list_by_skill_type[EquipConst.EQUIP_ATTRIBUTE_TYPE.ENCHANT]) do
		self.skillList_[iter_21_0] = {
			type = StoreConst.EQUIP_FILTER_TYPE.SKILL,
			id = iter_21_1,
			cnt = EquipTools.GetEquipSkillNum(iter_21_1, nil, self.params_.equipPosition)
		}
	end
end

function StoreEquipFilterView:IndexSkillItem(arg_22_1, arg_22_2)
	arg_22_2:SetData(self.skillList_[arg_22_1], table.keyof(self.filterParams_.skill, self.skillList_[arg_22_1].id) ~= nil)
end

function StoreEquipFilterView:InitSelectList()
	self.selectList_ = {}

	for iter_23_0, iter_23_1 in ipairs(self.filterParams_.suit) do
		table.insert(self.selectList_, {
			type = StoreConst.EQUIP_FILTER_TYPE.SUIT,
			id = iter_23_1
		})
	end

	for iter_23_2, iter_23_3 in ipairs(self.filterParams_.skill) do
		table.insert(self.selectList_, {
			type = StoreConst.EQUIP_FILTER_TYPE.SKILL,
			id = iter_23_3
		})
	end
end

function StoreEquipFilterView:AddSelectItemData(arg_24_1)
	table.insert(self.selectList_, {
		type = arg_24_1.type,
		id = arg_24_1.id
	})
end

function StoreEquipFilterView:RemoveSelectItemData(arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(self.selectList_) do
		if iter_25_1.type == arg_25_1.type and iter_25_1.id == arg_25_1.id then
			table.remove(self.selectList_, iter_25_0)

			return
		end
	end
end

function StoreEquipFilterView:ClearSelectItemData()
	self.selectList_ = {}
end

function StoreEquipFilterView:RefreshAllSelectItem()
	for iter_27_0, iter_27_1 in ipairs(self.selectList_) do
		self.selectItemList_[iter_27_0] = self.selectItemList_[iter_27_0] or EquipFilterSelectItem.New(self.filterItemGo_, self.filterItemParentGo_)

		self.selectItemList_[iter_27_0]:SetData(iter_27_1)
	end

	for iter_27_2 = #self.selectList_ + 1, #self.selectItemList_ do
		self.selectItemList_[iter_27_2]:Show(false)
	end
end

return StoreEquipFilterView
