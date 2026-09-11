local NewHeroListFilterView = class("NewHeroListFilterView", ReduxView)

function NewHeroListFilterView:OnCtor(arg_1_1)
	self.isSelfHero_ = true
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function NewHeroListFilterView:Init()
	self.curOrder_ = "desc"
	self.isAll_ = true
	self.available_ = true
	self.curSortType_ = 0
	self.curSortRace_ = {}
	self.curAttackType_ = {}
	self.curEnergyType_ = {}

	self:InitUI()
	self:AddUIListeners()
end

function NewHeroListFilterView:InitDropdownData()
	self.sortTypeDropdown_.itemText.color = Color.New(0, 0, 0, 1)

	self.sortTypeDropdown_.options:Clear()

	self.dropDownText_ = {}

	if self.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
		self:AddDropDownOption("TIP_UNLOCK_HERO")
		self:AddDropDownOption("TIP_RARE")
	else
		self:AddDropDownOption("TIP_UPGRADE")
		self:AddDropDownOption("TIP_RARE")
	end

	if self.heroViewProxy_.isSelf then
		self:AddDropDownOption("TIP_FAVOR")
		self:AddDropDownOption("TIP_CLEARTIMES")
	end

	self:RefreshDropDownOptions()
end

function NewHeroListFilterView:AddDropDownOption(arg_4_1)
	self.sortTypeDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format("<color=#FFFFFF>%s</color>", GetTips(arg_4_1), nil)))

	self.dropDownText_[#self.dropDownText_ + 1] = GetTips(arg_4_1)
end

function NewHeroListFilterView:RefreshDropDownOptions()
	if self.dropDownText_ then
		for iter_5_0 = 1, self.sortTypeDropdown_.options.Count do
			self.sortTypeDropdown_.options[iter_5_0 - 1].text = iter_5_0 - 1 == self.sortTypeDropdown_.value and self.dropDownText_[iter_5_0] or string.format("<color=#FFFFFF>%s</color>", self.dropDownText_[iter_5_0])
		end
	end
end

function NewHeroListFilterView:InitUI()
	self:BindCfgUI()

	self.heroSorter_ = HeroSorter.New()
	self.orderController_ = ControllerUtil.GetController(self.transform_, "order")

	if self.filterController_ then
		self.filterColorController_ = self.filterController_:GetController("color")
	end
end

function NewHeroListFilterView:OnTop()
	self:RefreshDropDownOptions()
end

function NewHeroListFilterView:AddUIListeners()
	self:AddBtnListener(self.sortBtn_, nil, function()
		self:SortListByOrder(self.orderController_:GetSelectedState() == "asc" and "desc" or "asc")
	end)
	self:AddToggleListener(self.sortTypeDropdown_, function(arg_10_0)
		self:RefreshDropDownOptions()
		self:SortListByType(arg_10_0)
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.Hero_Filter_List
		})
	end)
end

function NewHeroListFilterView:SetAvailable(arg_12_1)
	self.available_ = arg_12_1
end

function NewHeroListFilterView:SortListByOrder(arg_13_1)
	self.curOrder_ = arg_13_1

	self.orderController_:SetSelectedState(arg_13_1)

	if not self.gameObject_.activeInHierarchy then
		return
	end

	self:UpdateList()
end

function NewHeroListFilterView:SortListByType(arg_14_1)
	self.curSortType_ = arg_14_1

	HeroData:SaveSortType(arg_14_1)

	if not self.gameObject_.activeInHierarchy then
		return
	end

	self:UpdateList()
end

function NewHeroListFilterView:RefreshSort(arg_15_1)
	if not self.available_ then
		return
	end

	self.displayHeroDataList_ = HeroTools.GetHeroShowData(self.heroDataList_, arg_15_1)

	self:UpdateList()
	self:RenderFilterBtn()
end

function NewHeroListFilterView:SetHeroIdList(arg_16_1, arg_16_2, arg_16_3)
	if #arg_16_1 > 0 and type(arg_16_1[1]) ~= "table" then
		arg_16_1 = HeroTools.FormatFilterHeroDataList(self.heroViewProxy_:GetViewDataType(), arg_16_1, arg_16_2, arg_16_3)
	end

	self.heroDataList_ = arg_16_1
	self.displayHeroDataList_ = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		if HeroTools.NeedToHideHero(iter_16_1.id, iter_16_1.type) then
			table.insert(self.displayHeroDataList_, iter_16_1)
		end
	end

	self:RefreshSort()
end

function NewHeroListFilterView:UpdateList()
	local var_17_0 = GameSetting.unlock_hero_need.value

	self.heroSorter_:Reset()
	table.sort(self.displayHeroDataList_, function(arg_18_0, arg_18_1)
		if self.extraSorter_ ~= nil then
			local var_18_2, var_18_3 = self.extraSorter_(arg_18_0, arg_18_1)

			if var_18_2 then
				return var_18_3
			end
		end

		local var_18_4 = arg_18_0.heroViewProxy:GetHeroData(arg_18_0.id)
		local var_18_5 = arg_18_1.heroViewProxy:GetHeroData(arg_18_1.id)

		if self.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
			if self.curSortType_ == 0 then
				local var_18_6, var_18_7 = self:UnlockSorter(var_18_4, var_18_5)

				if var_18_6 then
					return var_18_7
				end

				local var_18_8, var_18_9 = self:RareSorter(var_18_4, var_18_5)

				if var_18_8 then
					return var_18_9
				end

				local var_18_10, var_18_11 = self:IDSorter(var_18_4, var_18_5)

				if var_18_10 then
					return var_18_11
				end
			elseif self.curSortType_ == 1 then
				local var_18_12, var_18_13 = self:RareSorter(var_18_4, var_18_5)

				if var_18_12 then
					return var_18_13
				end

				local var_18_14, var_18_15 = self:IDSorter(var_18_4, var_18_5)

				if var_18_14 then
					return var_18_15
				end
			end
		end

		if var_18_4.unlock ~= var_18_5.unlock then
			return var_18_4.unlock > var_18_5.unlock
		end

		if var_18_4.unlock == 0 and var_18_5.unlock == 0 then
			if (var_17_0[HeroCfg[arg_18_0.id].rare] <= var_18_4.piece and 1 or 0) ~= (var_17_0[HeroCfg[arg_18_1.id].rare] <= var_18_5.piece and 1 or 0) then
				return (var_17_0[HeroCfg[arg_18_1.id].rare] <= var_18_5.piece and 1 or 0) < (var_17_0[HeroCfg[arg_18_0.id].rare] <= var_18_4.piece and 1 or 0)
			end
		end

		if self.heroViewProxy_.isSelf then
			local var_18_17 = HeroData:IsFavorite(arg_18_0.id)
			local var_18_18 = HeroData:IsFavorite(arg_18_1.id)

			if var_18_17 ~= var_18_18 and (not var_18_17 or not var_18_18) then
				return var_18_17 ~= false
			end
		end

		if self.curSortType_ == 0 then
			local var_18_19, var_18_20 = self:FightPowerSorter(var_18_4, var_18_5, arg_18_0.heroViewProxy, arg_18_1.heroViewProxy)

			if var_18_19 then
				return var_18_20
			end

			local var_18_21, var_18_22 = self:StarSorter(var_18_4, var_18_5)

			if var_18_21 then
				return var_18_22
			end

			local var_18_23, var_18_24 = self:RareSorter(var_18_4, var_18_5)

			if var_18_23 then
				return var_18_24
			end

			local var_18_25, var_18_26 = self:LevelSorter(var_18_4, var_18_5)

			if var_18_25 then
				return var_18_26
			end
		elseif self.curSortType_ == 1 then
			local var_18_27, var_18_28 = self:StarSorter(var_18_4, var_18_5)

			if var_18_27 then
				return var_18_28
			end

			local var_18_29, var_18_30 = self:RareSorter(var_18_4, var_18_5)

			if var_18_29 then
				return var_18_30
			end

			local var_18_31, var_18_32 = self:FightPowerSorter(var_18_4, var_18_5, arg_18_0.heroViewProxy, arg_18_1.heroViewProxy)

			if var_18_31 then
				return var_18_32
			end

			local var_18_33, var_18_34 = self:LevelSorter(var_18_4, var_18_5)

			if var_18_33 then
				return var_18_34
			end
		elseif self.curSortType_ == 2 then
			local var_18_35, var_18_36 = self:FavorSorter(var_18_4, var_18_5)

			if var_18_35 then
				return var_18_36
			end

			local var_18_37, var_18_38 = self:FightPowerSorter(var_18_4, var_18_5, arg_18_0.heroViewProxy, arg_18_1.heroViewProxy)

			if var_18_37 then
				return var_18_38
			end

			local var_18_39, var_18_40 = self:StarSorter(var_18_4, var_18_5)

			if var_18_39 then
				return var_18_40
			end

			local var_18_41, var_18_42 = self:RareSorter(var_18_4, var_18_5)

			if var_18_41 then
				return var_18_42
			end

			local var_18_43, var_18_44 = self:LevelSorter(var_18_4, var_18_5)

			if var_18_43 then
				return var_18_44
			end
		else
			local var_18_45, var_18_46 = self:UseTimesSorter(var_18_4, var_18_5)

			if var_18_45 then
				return var_18_46
			end

			local var_18_47, var_18_48 = self:FightPowerSorter(var_18_4, var_18_5, arg_18_0.heroViewProxy, arg_18_1.heroViewProxy)

			if var_18_47 then
				return var_18_48
			end

			local var_18_49, var_18_50 = self:StarSorter(var_18_4, var_18_5)

			if var_18_49 then
				return var_18_50
			end

			local var_18_51, var_18_52 = self:RareSorter(var_18_4, var_18_5)

			if var_18_51 then
				return var_18_52
			end

			local var_18_53, var_18_54 = self:LevelSorter(var_18_4, var_18_5)

			if var_18_53 then
				return var_18_54
			end
		end

		return arg_18_0.id > arg_18_1.id
	end)

	if self.callback_ ~= nil then
		local var_17_1 = {}

		for iter_17_0, iter_17_1 in ipairs(self.displayHeroDataList_) do
			var_17_1[#var_17_1 + 1] = iter_17_1.id
		end

		self.callback_(var_17_1, self.displayHeroDataList_, self.curSortType_)
	end
end

function NewHeroListFilterView:SetListChangeHandler(arg_19_1)
	self.callback_ = arg_19_1
end

function NewHeroListFilterView:SetExtraSorter(arg_20_1)
	self.extraSorter_ = arg_20_1
end

function NewHeroListFilterView:SetIsSelfHero(arg_21_1)
	self.isSelfHero_ = arg_21_1
end

function NewHeroListFilterView:RenderFilterBtn()
	if self.filterColorController_ then
		if CommonFilterData:AtLeastOneChoose(Filter_Root_Define.Hero_Filter_List.filter_id) then
			self.filterColorController_:SetSelectedState("orange")
		else
			self.filterColorController_:SetSelectedState("normal")
		end
	end
end

function NewHeroListFilterView:OnEnter(arg_23_1)
	self.heroViewProxy_ = arg_23_1

	self:InitDropdownData()
	self:RegistEventListener(COMMON_FILTER_OK, handler(self, self.RefreshSort))
	self:RenderFilterBtn()
end

function NewHeroListFilterView:OnExit()
	self:RemoveAllEventListener()
end

function NewHeroListFilterView:FightPowerSorter(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0
	local var_25_1

	var_25_0 = arg_25_1.tempID and arg_25_1.tempID ~= 0 and TempHeroData:GetBattlePower(arg_25_1.tempID) or self.heroSorter_:GetHeroPower(arg_25_1, handler(arg_25_3, arg_25_3.GetBattlePower))
	var_25_1 = arg_25_2.tempID and arg_25_2.tempID ~= 0 and TempHeroData:GetBattlePower(arg_25_2.tempID) or self.heroSorter_:GetHeroPower(arg_25_2, handler(arg_25_4, arg_25_4.GetBattlePower))

	if var_25_0 ~= var_25_1 then
		if self.curOrder_ == "desc" then
			return true, var_25_1 < var_25_0
		else
			return true, var_25_0 < var_25_1
		end
	end

	return false, false
end

function NewHeroListFilterView:StarSorter(arg_26_1, arg_26_2)
	if arg_26_1.star ~= arg_26_2.star then
		if self.curOrder_ == "desc" then
			return true, arg_26_1.star > arg_26_2.star
		else
			return true, arg_26_1.star < arg_26_2.star
		end
	end

	return false, false
end

function NewHeroListFilterView:UnlockSorter(arg_27_1, arg_27_2)
	if arg_27_1.unlock ~= arg_27_2.unlock then
		if self.curOrder_ == "desc" then
			return true, arg_27_1.unlock > arg_27_2.unlock
		else
			return true, arg_27_1.unlock < arg_27_2.unlock
		end
	end

	return false, false
end

function NewHeroListFilterView:IDSorter(arg_28_1, arg_28_2)
	if arg_28_1.id ~= arg_28_2.id then
		if self.curOrder_ == "desc" then
			return true, arg_28_1.id > arg_28_2.id
		else
			return true, arg_28_1.id < arg_28_2.id
		end
	end

	return false, false
end

function NewHeroListFilterView:RareSorter(arg_29_1, arg_29_2)
	local var_29_0 = HeroCfg[arg_29_1.id]
	local var_29_1 = HeroCfg[arg_29_2.id]

	if HeroCfg[arg_29_1.id].rare ~= HeroCfg[arg_29_2.id].rare then
		if self.curOrder_ == "desc" then
			return true, var_29_0.rare > var_29_1.rare
		else
			return true, var_29_0.rare < var_29_1.rare
		end
	end

	return false, false
end

function NewHeroListFilterView:LevelSorter(arg_30_1, arg_30_2)
	if arg_30_1.exp ~= arg_30_2.exp then
		if self.curOrder_ == "desc" then
			return true, arg_30_1.exp > arg_30_2.exp
		else
			return true, arg_30_1.exp < arg_30_2.exp
		end
	end

	return false, false
end

function NewHeroListFilterView:FavorSorter(arg_31_1, arg_31_2)
	local var_31_0 = ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[arg_31_1.id][1])
	local var_31_1 = ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[arg_31_2.id][1])

	if var_31_0.lv ~= var_31_1.lv then
		if self.curOrder_ == "desc" then
			return true, var_31_0.lv > var_31_1.lv
		else
			return true, var_31_0.lv < var_31_1.lv
		end
	end

	return false, false
end

function NewHeroListFilterView:UseTimesSorter(arg_32_1, arg_32_2)
	if arg_32_1.clear_times ~= arg_32_2.clear_times then
		if self.curOrder_ == "desc" then
			return true, arg_32_1.clear_times > arg_32_2.clear_times
		else
			return true, arg_32_1.clear_times < arg_32_2.clear_times
		end
	end

	return false, false
end

function NewHeroListFilterView:Reset(arg_33_1)
	self:RemoveAllListeners()

	self.curOrder_ = "desc"

	if arg_33_1 then
		self.isAll_, self.curSortType_, self.curSortRace_, self.curAttackType_, self.curEnergyType_ = HeroData:GetSortValue()
	else
		self.isAll_ = true
		self.curSortType_ = 0
		self.curSortRace_ = {}
		self.curAttackType_ = {}
		self.curEnergyType_ = {}
	end

	self.sortTypeDropdown_.value = self.curSortType_

	self:RefreshDropDownOptions()
	self.orderController_:SetSelectedState("desc")
	self:AddUIListeners()
end

function NewHeroListFilterView:Dispose()
	if self.heroSorter_ then
		self.heroSorter_:Reset()

		self.heroSorter_ = nil
	end

	NewHeroListFilterView.super.Dispose(self)
end

return NewHeroListFilterView
