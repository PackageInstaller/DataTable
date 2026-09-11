local EquipFilterView = class("EquipFilterView", ReduxView)

function EquipFilterView:UIName()
	return "Widget/System/Com_dynamic/FilterPop"
end

function EquipFilterView:UIParent()
	return manager.ui.uiPop.transform
end

function EquipFilterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EquipFilterView:InitUI()
	self:BindCfgUI()

	self.suitScrollHelper_ = LuaList.New(handler(self, self.indexSuitItem), self.suitListGo_, EquipBagSuitItem)
	self.skillScrollHelper_ = LuaList.New(handler(self, self.indexSkillItem), self.skillListGo_, SkillSelectItem)
	self.filterBottomView_ = CommonFilterBottom.New(self.fillListGo_)

	self.filterBottomView_:RegisteClearBtnListener(handler(self, self.ClearFilter))
	self.filterBottomView_:RegisteItemClickListener(handler(self, self.OnFilterItemClick))

	self.tabController_ = self.filterController_:GetController("tab")
	self.selectController_ = self.filterController_:GetController("select")
end

function EquipFilterView:AddUIListener()
	self:AddBtnListener(self.btnConfirm_, nil, function()
		self:OnClose(true)
	end)
	self:AddBtnListener(self.btnSuit_, nil, function()
		self:ClearFilter()
		self.tabController_:SetSelectedState("suit")

		self.filterIndex_ = 1
		self.filterList_ = self.filterGroup[self.filterIndex_]
	end)
	self:AddBtnListener(self.btnSkill_, nil, function()
		self:ClearFilter()
		self.tabController_:SetSelectedState("skill")

		self.filterIndex_ = 2
		self.filterList_ = self.filterGroup[self.filterIndex_]
	end)
	self:AddBtnListener(self.btnMask_, nil, function()
		self:OnClose(false)
	end)
	self:AddBtnListener(self.brnCloseSelected_, nil, function()
		self:ClearFilter()
	end)
end

function EquipFilterView:OnEnter()
	manager.windowBar:HideBar()

	self.info_ = clone(self.params_.info) or {}

	if self.info_ then
		self.info_.heroId = self.info_.heroId or 0
	end

	if self.info_ then
		self.info_.suitPos = self.info_.suitPos or 0
	end

	self.lastInfo_ = clone(self.info_)
	self.lastInfo_.filterIndex = self.info_.filterIndex or 1
	self.closeFunc = self.params_.closeFunc
	self.filterGroup = self.info_.filterGroup or {
		{},
		{}
	}
	self.selectedItem = self.info_.selectedItem or {}
	self.filterIndex_ = self.info_.filterIndex or 1
	self.filterList_ = self.filterGroup[self.filterIndex_]
	self.isFilterEquiped_ = self.params_.isFilterEquiped

	self:InitSuitList()
	self:InitSkillList()
	self:RefreshBottom()
	self.tabController_:SetSelectedState(self.filterIndex_ == 1 and "suit" or "skill")
end

function EquipFilterView:InitSuitList()
	local var_12_1

	if EquipRecommendCfg[self.info_.heroId] then
		var_12_1 = EquipRecommendCfg[self.info_.heroId].suit_list or {}
	end

	local var_12_2

	self.suitList_, var_12_2 = EquipTools.GetHaveSuitList(true)

	if #var_12_1 > 0 then
		table.sort(self.suitList_, function(arg_13_0, arg_13_1)
			local var_13_0 = not not table.indexof(var_12_1, arg_13_0)
			local var_13_1 = not not table.indexof(var_12_1, arg_13_1)

			if var_12_2[arg_13_0] ~= var_12_2[arg_13_1] then
				if var_13_0 == var_13_1 then
					return not var_12_2[arg_13_1]
				else
					return not var_13_1
				end
			elseif var_13_0 == var_13_1 then
				return arg_13_0 < arg_13_1
			else
				return not var_13_1
			end
		end)
	end

	self.suitScrollHelper_:StartScroll(#self.suitList_)
end

function EquipFilterView:InitSkillList()
	self.skillList_ = EquipTools.GetHaveSkillList(true)

	self.skillScrollHelper_:StartScroll(#self.skillList_)
end

function EquipFilterView:indexSuitItem(arg_15_1, arg_15_2)
	local var_15_0 = self.suitList_[arg_15_1]

	arg_15_2:RefreshData(self.info_.heroId, self.suitList_[arg_15_1])
	arg_15_2:RefreshPos(self.info_.suitPos, self.isFilterEquiped_)

	if self.selectedItem[var_15_0] ~= nil and self.filterIndex_ == 1 then
		self.selectedItem[var_15_0] = arg_15_2
	end

	arg_15_2:SetSelect(self.selectedItem[var_15_0] ~= nil and self.filterIndex_ == 1)
	arg_15_2:RegistCallBack(function(arg_16_0)
		self:FilterItemCb(arg_15_2, arg_16_0)
	end)
end

function EquipFilterView:indexSkillItem(arg_17_1, arg_17_2)
	local var_17_0 = self.skillList_[arg_17_1]

	arg_17_2:RefreshData(self, {
		id = self.skillList_[arg_17_1]
	})
	arg_17_2:RefreshPos(self.info_.suitPos, self.isFilterEquiped_)

	if self.selectedItem[var_17_0] ~= nil and self.filterIndex_ == 2 then
		self.selectedItem[var_17_0] = arg_17_2
	end

	arg_17_2:SetSelect(self.selectedItem[var_17_0] ~= nil and self.filterIndex_ == 2)
	arg_17_2:RegistCallBack(function(arg_18_0)
		self:FilterItemCb(arg_17_2, arg_18_0)
	end)
end

function EquipFilterView:OnFilterItemClick(arg_19_1)
	self:FilterItemCb(nil, arg_19_1.id)
end

function EquipFilterView:FilterItemCb(arg_20_1, arg_20_2)
	if self.selectedItem[arg_20_2] ~= nil then
		table.remove(self.filterList_, (table.indexof(self.filterList_, arg_20_2)))
		self.selectedItem[arg_20_2]:SetSelect(false)

		self.selectedItem[arg_20_2] = nil
	else
		table.insert(self.filterList_, arg_20_2)

		self.selectedItem[arg_20_2] = arg_20_1

		self.selectedItem[arg_20_2]:SetSelect(true)
	end

	self:RefreshBottom()
end

function EquipFilterView:RefreshBottom()
	local var_21_0 = #self.filterList_ ~= 0

	self.selectController_:SetSelectedState(#self.filterList_ ~= 0 and "select" or "noselect")

	local var_21_1 = {}

	if var_21_0 then
		for iter_21_0, iter_21_1 in ipairs(self.filterList_) do
			table.insert(var_21_1, {
				name = GetI18NText((self.filterIndex_ == 1 or nil) and (EquipSuitCfg[iter_21_1].name or EquipSkillCfg[iter_21_1].name)),
				id = iter_21_1
			})
		end

		self.filterBottomView_:Refresh(var_21_1)
	end
end

function EquipFilterView:OnClose(arg_22_1)
	self:ShowDefaultBar()

	if arg_22_1 then
		self:RefrehBagView()
	end

	if self.closeFunc then
		self.closeFunc()
	end

	self:Back()
end

function EquipFilterView:ClearFilter()
	self.selectController_:SetSelectedState("noselect")

	for iter_23_0, iter_23_1 in pairs(self.selectedItem) do
		iter_23_1:SetSelect(false)
	end

	self.filterGroup = {
		{},
		{}
	}
	self.filterList_ = self.filterGroup[self.filterIndex_]
	self.selectedItem = {}
end

function EquipFilterView:RefrehBagView()
	if self:CheckFilterChange() then
		manager.notify:Invoke(EQUIP_FILTER_CONFIRM, {
			filterGroup = self.filterGroup,
			filterIndex = self.filterIndex_,
			selectedItem = self.selectedItem
		})
	end
end

function EquipFilterView:CheckFilterChange()
	local var_25_0 = self.filterGroup[1]
	local var_25_1 = self.filterGroup[2]

	if self.lastInfo_.filterGroup then
		local var_25_2 = self.lastInfo_.filterGroup[1] or {}

		if self.lastInfo_.filterGroup then
			local var_25_3 = self.lastInfo_.filterGroup[2] or {}

			if self.lastInfo_.filterIndex ~= self.filterIndex_ then
				return true
			end

			if #var_25_2 ~= #var_25_0 or #var_25_3 ~= #var_25_1 then
				return true
			end

			if #var_25_2 ~= 0 and #var_25_0 ~= 0 or #var_25_3 ~= 0 and #var_25_1 ~= 0 then
				local var_25_4 = {
					{},
					{}
				}

				for iter_25_0 = 1, 2 do
					for iter_25_1, iter_25_2 in ipairs(iter_25_0 == 1 and var_25_2 or var_25_3) do
						var_25_4[iter_25_0][iter_25_2] = true
					end
				end

				for iter_25_3 = 1, 2 do
					for iter_25_4, iter_25_5 in ipairs(iter_25_3 == 1 and var_25_0 or var_25_1) do
						if not var_25_4[iter_25_3][iter_25_5] then
							return true
						end
					end
				end
			end
		end
	end

	return false
end

function EquipFilterView:Dispose()
	self:RemoveAllListeners()
	self.suitScrollHelper_:Dispose()
	self.skillScrollHelper_:Dispose()
	self.filterBottomView_:Dispose()
	EquipFilterView.super.Dispose(self)
end

return EquipFilterView
