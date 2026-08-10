local var_0_0 = class("EquipFilterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Com_dynamic/FilterPop"
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

	arg_4_0.suitScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexSuitItem), arg_4_0.suitListGo_, EquipBagSuitItem)
	arg_4_0.skillScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexSkillItem), arg_4_0.skillListGo_, SkillSelectItem)
	arg_4_0.filterBottomView_ = CommonFilterBottom.New(arg_4_0.fillListGo_)

	arg_4_0.filterBottomView_:RegisteClearBtnListener(handler(arg_4_0, arg_4_0.ClearFilter))
	arg_4_0.filterBottomView_:RegisteItemClickListener(handler(arg_4_0, arg_4_0.OnFilterItemClick))

	arg_4_0.tabController_ = arg_4_0.filterController_:GetController("tab")
	arg_4_0.selectController_ = arg_4_0.filterController_:GetController("select")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnConfirm_, nil, function()
		arg_5_0:OnClose(true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnSuit_, nil, function()
		arg_5_0:ClearFilter()
		arg_5_0.tabController_:SetSelectedState("suit")

		arg_5_0.filterIndex_ = 1
		arg_5_0.filterList_ = arg_5_0.filterGroup[arg_5_0.filterIndex_]
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnSkill_, nil, function()
		arg_5_0:ClearFilter()
		arg_5_0.tabController_:SetSelectedState("skill")

		arg_5_0.filterIndex_ = 2
		arg_5_0.filterList_ = arg_5_0.filterGroup[arg_5_0.filterIndex_]
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnMask_, nil, function()
		arg_5_0:OnClose(false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.brnCloseSelected_, nil, function()
		arg_5_0:ClearFilter()
	end)
end

function var_0_0.OnEnter(arg_11_0)
	manager.windowBar:HideBar()

	arg_11_0.info_ = clone(arg_11_0.params_.info) or {}
	arg_11_0.info_.heroId = arg_11_0.info_ and arg_11_0.info_.heroId or 0
	arg_11_0.info_.suitPos = arg_11_0.info_ and arg_11_0.info_.suitPos or 0
	arg_11_0.lastInfo_ = clone(arg_11_0.info_)
	arg_11_0.lastInfo_.filterIndex = arg_11_0.info_.filterIndex or 1
	arg_11_0.closeFunc = arg_11_0.params_.closeFunc
	arg_11_0.filterGroup = arg_11_0.info_.filterGroup or {
		{},
		{}
	}
	arg_11_0.selectedItem = arg_11_0.info_.selectedItem or {}
	arg_11_0.filterIndex_ = arg_11_0.info_.filterIndex or 1
	arg_11_0.filterList_ = arg_11_0.filterGroup[arg_11_0.filterIndex_]
	arg_11_0.isFilterEquiped_ = arg_11_0.params_.isFilterEquiped

	arg_11_0:InitSuitList()
	arg_11_0:InitSkillList()
	arg_11_0:RefreshBottom()
	arg_11_0.tabController_:SetSelectedState(arg_11_0.filterIndex_ == 1 and "suit" or "skill")
end

function var_0_0.InitSuitList(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = EquipRecommendCfg[arg_12_0.info_.heroId] and EquipRecommendCfg[arg_12_0.info_.heroId].suit_list or {}
	local var_12_2

	arg_12_0.suitList_, var_12_2 = EquipTools.GetHaveSuitList(true)

	if #var_12_1 > 0 then
		table.sort(arg_12_0.suitList_, function(arg_13_0, arg_13_1)
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

	arg_12_0.suitScrollHelper_:StartScroll(#arg_12_0.suitList_)
end

function var_0_0.InitSkillList(arg_14_0)
	arg_14_0.skillList_ = EquipTools.GetHaveSkillList(true)

	arg_14_0.skillScrollHelper_:StartScroll(#arg_14_0.skillList_)
end

function var_0_0.indexSuitItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.suitList_[arg_15_1]

	arg_15_2:RefreshData(arg_15_0.info_.heroId, var_15_0)
	arg_15_2:RefreshPos(arg_15_0.info_.suitPos, arg_15_0.isFilterEquiped_)

	local var_15_1 = arg_15_0.selectedItem[var_15_0] ~= nil and arg_15_0.filterIndex_ == 1

	if var_15_1 then
		arg_15_0.selectedItem[var_15_0] = arg_15_2
	end

	arg_15_2:SetSelect(var_15_1)
	arg_15_2:RegistCallBack(function(arg_16_0)
		arg_15_0:FilterItemCb(arg_15_2, arg_16_0)
	end)
end

function var_0_0.indexSkillItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.skillList_[arg_17_1]

	arg_17_2:RefreshData(arg_17_0, {
		id = var_17_0
	})
	arg_17_2:RefreshPos(arg_17_0.info_.suitPos, arg_17_0.isFilterEquiped_)

	local var_17_1 = arg_17_0.selectedItem[var_17_0] ~= nil and arg_17_0.filterIndex_ == 2

	if var_17_1 then
		arg_17_0.selectedItem[var_17_0] = arg_17_2
	end

	arg_17_2:SetSelect(var_17_1)
	arg_17_2:RegistCallBack(function(arg_18_0)
		arg_17_0:FilterItemCb(arg_17_2, arg_18_0)
	end)
end

function var_0_0.OnFilterItemClick(arg_19_0, arg_19_1)
	arg_19_0:FilterItemCb(nil, arg_19_1.id)
end

function var_0_0.FilterItemCb(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0.selectedItem[arg_20_2] ~= nil then
		local var_20_0 = table.indexof(arg_20_0.filterList_, arg_20_2)

		table.remove(arg_20_0.filterList_, var_20_0)
		arg_20_0.selectedItem[arg_20_2]:SetSelect(false)

		arg_20_0.selectedItem[arg_20_2] = nil
	else
		table.insert(arg_20_0.filterList_, arg_20_2)

		arg_20_0.selectedItem[arg_20_2] = arg_20_1

		arg_20_0.selectedItem[arg_20_2]:SetSelect(true)
	end

	arg_20_0:RefreshBottom()
end

function var_0_0.RefreshBottom(arg_21_0)
	local var_21_0 = #arg_21_0.filterList_ ~= 0

	arg_21_0.selectController_:SetSelectedState(var_21_0 and "select" or "noselect")

	local var_21_1 = {}

	if var_21_0 then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0.filterList_) do
			local var_21_2 = arg_21_0.filterIndex_ == 1 and EquipSuitCfg[iter_21_1].name or EquipSkillCfg[iter_21_1].name

			table.insert(var_21_1, {
				name = GetI18NText(var_21_2),
				id = iter_21_1
			})
		end

		arg_21_0.filterBottomView_:Refresh(var_21_1)
	end
end

function var_0_0.OnClose(arg_22_0, arg_22_1)
	arg_22_0:ShowDefaultBar()

	if arg_22_1 then
		arg_22_0:RefrehBagView()
	end

	if arg_22_0.closeFunc then
		arg_22_0.closeFunc()
	end

	arg_22_0:Back()
end

function var_0_0.ClearFilter(arg_23_0)
	arg_23_0.selectController_:SetSelectedState("noselect")

	for iter_23_0, iter_23_1 in pairs(arg_23_0.selectedItem) do
		iter_23_1:SetSelect(false)
	end

	arg_23_0.filterGroup = {
		{},
		{}
	}
	arg_23_0.filterList_ = arg_23_0.filterGroup[arg_23_0.filterIndex_]
	arg_23_0.selectedItem = {}
end

function var_0_0.RefrehBagView(arg_24_0)
	local var_24_0 = {
		filterGroup = arg_24_0.filterGroup,
		filterIndex = arg_24_0.filterIndex_,
		selectedItem = arg_24_0.selectedItem
	}

	if arg_24_0:CheckFilterChange() then
		manager.notify:Invoke(EQUIP_FILTER_CONFIRM, var_24_0)
	end
end

function var_0_0.CheckFilterChange(arg_25_0)
	local var_25_0 = arg_25_0.filterGroup[1]
	local var_25_1 = arg_25_0.filterGroup[2]
	local var_25_2 = arg_25_0.lastInfo_.filterGroup and arg_25_0.lastInfo_.filterGroup[1] or {}
	local var_25_3 = arg_25_0.lastInfo_.filterGroup and arg_25_0.lastInfo_.filterGroup[2] or {}

	if arg_25_0.lastInfo_.filterIndex ~= arg_25_0.filterIndex_ then
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
			local var_25_5 = iter_25_0 == 1 and var_25_2 or var_25_3

			for iter_25_1, iter_25_2 in ipairs(var_25_5) do
				var_25_4[iter_25_0][iter_25_2] = true
			end
		end

		for iter_25_3 = 1, 2 do
			local var_25_6 = iter_25_3 == 1 and var_25_0 or var_25_1

			for iter_25_4, iter_25_5 in ipairs(var_25_6) do
				if not var_25_4[iter_25_3][iter_25_5] then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.Dispose(arg_26_0)
	arg_26_0:RemoveAllListeners()
	arg_26_0.suitScrollHelper_:Dispose()
	arg_26_0.skillScrollHelper_:Dispose()
	arg_26_0.filterBottomView_:Dispose()
	var_0_0.super.Dispose(arg_26_0)
end

return var_0_0
