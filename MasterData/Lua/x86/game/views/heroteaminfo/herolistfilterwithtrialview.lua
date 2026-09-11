local HeroListFilterWithTrialView = class("HeroListFilterWithTrialView", ReduxView)

function HeroListFilterWithTrialView:OnCtor(arg_1_1)
	self.isSelfHero_ = true
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroListFilterWithTrialView:Init()
	self.curOrder_ = "desc"
	self.isAll_ = true
	self.curSortType_ = 0
	self.curSortRace_ = {}
	self.curAttackType_ = {}
	self.curEnergyType_ = {}

	self:InitUI()
	self:InitDropDown()
	self:AddUIListener()
end

function HeroListFilterWithTrialView:InitDropDown()
	self.sortTypeDropdown_.options:Clear()
	self.sortTypeDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_UPGRADE"), nil))
	self.sortTypeDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_RARE"), nil))
	self.sortTypeDropdown_:RefreshShownValue()
end

function HeroListFilterWithTrialView:InitUI()
	self:BindCfgUI()

	self.heroSorter_ = HeroSorter.New()
	self.orderController_ = ControllerUtil.GetController(self.sortBtn_.gameObject.transform, "order")
end

function HeroListFilterWithTrialView:AddUIListener()
	self:AddBtnListener(self.sortBtn_, nil, function()
		self:SortListByOrder(self.orderController_:GetSelectedState() == "asc" and "desc" or "asc")
	end)
	self:AddToggleListener(self.sortTypeDropdown_, function(arg_7_0)
		self:SortListByType(arg_7_0)
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		JumpTools.OpenPageByJump("sortHeroType", {
			isAll = self.isAll_,
			sortType = self.curSortType_,
			sortRace = self.curSortRace_,
			attackType = self.curAttackType_,
			energyType = self.curEnergyType_
		})
	end)
end

function HeroListFilterWithTrialView:SortListByOrder(arg_9_1)
	self.curOrder_ = arg_9_1

	self.orderController_:SetSelectedState(arg_9_1)

	if not self.gameObject_.activeInHierarchy then
		return
	end

	self:UpdateList()
end

function HeroListFilterWithTrialView:SortListByType(arg_10_1)
	self.curSortType_ = arg_10_1

	HeroData:SaveSortType(arg_10_1)

	if not self.gameObject_.activeInHierarchy then
		return
	end

	self:UpdateList()
end

function HeroListFilterWithTrialView:SetHeroDataList(arg_11_1)
	self.heroList_ = arg_11_1

	self:RefreshSort(self.isAll_, self.curSortType_, self.curSortRace_, self.curAttackType_, self.curEnergyType_)
end

function HeroListFilterWithTrialView:RefreshSort(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	self.isAll_ = arg_12_1
	self.curSortType_ = arg_12_2
	self.curSortRace_ = arg_12_3
	self.curAttackType_ = arg_12_4
	self.curEnergyType_ = arg_12_5
	self.displayHeroList_ = {}

	if self.isAll_ then
		for iter_12_0, iter_12_1 in ipairs(self.heroList_) do
			table.insert(self.displayHeroList_, iter_12_1)
		end
	else
		for iter_12_2, iter_12_3 in ipairs(self.heroList_) do
			local var_12_0 = HeroCfg[iter_12_3.id]
			local var_12_1 = false

			var_12_1 = (#self.curSortRace_ <= 0 or table.indexof(self.curSortRace_, var_12_0.race)) and true

			local var_12_2 = false

			var_12_2 = (#self.curEnergyType_ <= 0 or table.indexof(self.curEnergyType_, var_12_0.mechanism_type[1])) and true

			local var_12_3 = false

			if #self.curAttackType_ <= 0 or #HeroCfg[iter_12_3.id].ATK_attribute > 1 and table.indexof(self.curAttackType_, HeroConst.HERO_ATTACK_TYPE.MIX) then
				var_12_3 = true
			else
				for iter_12_4, iter_12_5 in ipairs(HeroCfg[iter_12_3.id].ATK_attribute) do
					if table.indexof(self.curAttackType_, iter_12_5) then
						var_12_3 = true

						break
					end
				end
			end

			if var_12_1 and var_12_2 and var_12_3 then
				table.insert(self.displayHeroList_, iter_12_3)
			end
		end
	end

	self:RefreshType()
	self:UpdateList()
end

function HeroListFilterWithTrialView:RefreshType()
	self.typeTxt_.text = self.isAll_ and GetTips("ALL") or GetTips("ROLE_FILTERING")
end

function HeroListFilterWithTrialView:UpdateList()
	local var_14_0 = GameSetting.unlock_hero_need.value

	self.heroSorter_:Reset()
	table.sort(self.displayHeroList_, function(arg_15_0, arg_15_1)
		if self.extraSorter_ ~= nil then
			local var_15_2, var_15_3 = self.extraSorter_(arg_15_0, arg_15_1, self.curSortType_, self.curOrder_)

			if var_15_2 then
				return var_15_3
			end
		end

		local var_15_4 = arg_15_0.id
		local var_15_5 = arg_15_1.id
		local var_15_6 = HeroData:GetHeroData(arg_15_0.id)
		local var_15_7 = HeroData:GetHeroData(arg_15_1.id)

		if var_15_6.unlock ~= var_15_7.unlock then
			return var_15_6.unlock > var_15_7.unlock
		end

		if var_15_6.unlock == 0 and var_15_7.unlock == 0 then
			if (var_14_0[HeroCfg[var_15_4].rare] <= var_15_6.piece and 1 or 0) ~= (var_14_0[HeroCfg[var_15_5].rare] <= var_15_7.piece and 1 or 0) then
				return (var_14_0[HeroCfg[var_15_5].rare] <= var_15_7.piece and 1 or 0) < (var_14_0[HeroCfg[var_15_4].rare] <= var_15_6.piece and 1 or 0)
			end
		end

		if not self.extra_ then
			local var_15_9 = HeroData:IsFavorite(var_15_4)
			local var_15_10 = HeroData:IsFavorite(var_15_5)

			if var_15_9 ~= var_15_10 and (not var_15_9 or not var_15_10) then
				return var_15_9 ~= false
			end
		end

		if self.curSortType_ == 0 then
			local var_15_11, var_15_12 = self:FightPowerSorter(var_15_6, var_15_7)

			if var_15_11 then
				return var_15_12
			end

			local var_15_13, var_15_14 = self:StarSorter(var_15_6, var_15_7)

			if var_15_13 then
				return var_15_14
			end

			local var_15_15, var_15_16 = self:RareSorter(var_15_6, var_15_7)

			if var_15_15 then
				return var_15_16
			end

			local var_15_17, var_15_18 = self:LevelSorter(var_15_6, var_15_7)

			if var_15_17 then
				return var_15_18
			end
		else
			local var_15_19, var_15_20 = self:StarSorter(var_15_6, var_15_7)

			if var_15_19 then
				return var_15_20
			end

			local var_15_21, var_15_22 = self:RareSorter(var_15_6, var_15_7)

			if var_15_21 then
				return var_15_22
			end

			local var_15_23, var_15_24 = self:FightPowerSorter(var_15_6, var_15_7)

			if var_15_23 then
				return var_15_24
			end

			local var_15_25, var_15_26 = self:LevelSorter(var_15_6, var_15_7)

			if var_15_25 then
				return var_15_26
			end
		end

		return var_15_5 < var_15_4
	end)

	if self.callback_ ~= nil then
		self.callback_(self.displayHeroList_)
	end
end

function HeroListFilterWithTrialView:SetListChangeHandler(arg_16_1)
	self.callback_ = arg_16_1
end

function HeroListFilterWithTrialView:SetExtraSorter(arg_17_1)
	self.extraSorter_ = arg_17_1
end

function HeroListFilterWithTrialView:SetIsSelfHero(arg_18_1)
	self.isSelfHero_ = arg_18_1
end

function HeroListFilterWithTrialView:OnEnter()
	return
end

function HeroListFilterWithTrialView:OnExit()
	return
end

function HeroListFilterWithTrialView:FightPowerSorter(arg_21_1, arg_21_2)
	local var_21_0 = self.heroSorter_:GetHeroPower(arg_21_1)
	local var_21_1 = self.heroSorter_:GetHeroPower(arg_21_2)

	if var_21_0 ~= var_21_1 then
		if self.curOrder_ == "desc" then
			return true, var_21_1 < var_21_0
		else
			return true, var_21_0 < var_21_1
		end
	end

	return false, false
end

function HeroListFilterWithTrialView:StarSorter(arg_22_1, arg_22_2)
	if arg_22_1.star ~= arg_22_2.star then
		if self.curOrder_ == "desc" then
			return true, arg_22_1.star > arg_22_2.star
		else
			return true, arg_22_1.star < arg_22_2.star
		end
	end

	return false, false
end

function HeroListFilterWithTrialView:RareSorter(arg_23_1, arg_23_2)
	local var_23_0 = HeroCfg[arg_23_1.id]
	local var_23_1 = HeroCfg[arg_23_2.id]

	if HeroCfg[arg_23_1.id].rare ~= HeroCfg[arg_23_2.id].rare then
		if self.curOrder_ == "desc" then
			return true, var_23_0.rare > var_23_1.rare
		else
			return true, var_23_0.rare < var_23_1.rare
		end
	end

	return false, false
end

function HeroListFilterWithTrialView:LevelSorter(arg_24_1, arg_24_2)
	if arg_24_1.exp ~= arg_24_2.exp then
		if self.curOrder_ == "desc" then
			return true, arg_24_1.exp > arg_24_2.exp
		else
			return true, arg_24_1.exp < arg_24_2.exp
		end
	end

	return false, false
end

function HeroListFilterWithTrialView:Reset(arg_25_1)
	self:RemoveAllListeners()
	self.orderController_:SetSelectedState("desc")

	self.curOrder_ = "desc"

	if arg_25_1 then
		self.isAll_, self.curSortType_, self.curSortRace_, self.curAttackType_, self.curEnergyType_ = HeroData:GetSortValue()
	else
		self.isAll_ = true
		self.curSortType_ = 0
		self.curSortRace_ = {}
		self.curAttackType_ = {}
		self.curEnergyType_ = {}
	end

	self.sortTypeDropdown_.value = self.curSortType_

	self:AddUIListener()
	self:RefreshType()
end

function HeroListFilterWithTrialView:ShowDropDown(arg_26_1)
	SetActive(self.panel_, arg_26_1)
end

function HeroListFilterWithTrialView:Dispose()
	if self.heroSorter_ then
		self.heroSorter_:Reset()

		self.heroSorter_ = nil
	end

	HeroListFilterWithTrialView.super.Dispose(self)
end

return HeroListFilterWithTrialView
