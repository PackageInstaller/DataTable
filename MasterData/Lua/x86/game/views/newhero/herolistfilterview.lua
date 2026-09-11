local HeroListFilterView = class("HeroListFilterView", ReduxView)

function HeroListFilterView:OnCtor(arg_1_1)
	self.isSelfHero_ = true
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroListFilterView:Init()
	self.curOrder_ = "desc"
	self.curSortType_ = 0
	self.curRaceIndex_ = 0

	self:InitUI()
	self:AddUIListener()
end

function HeroListFilterView:InitUI()
	self:BindCfgUI()

	self.heroSorter_ = HeroSorter.New()
	self.orderController_ = ControllerUtil.GetController(self.sortBtn_.gameObject.transform, "order")
end

function HeroListFilterView:AddUIListener()
	self:AddBtnListener(self.sortBtn_, nil, function()
		self:SortListByOrder(self.orderController_:GetSelectedState() == "asc" and "desc" or "asc")
	end)
	self:AddToggleListener(self.sortTypeDropdown_, function(arg_6_0)
		self:SortListByType(arg_6_0)
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

function HeroListFilterView:SortListByOrder(arg_8_1)
	self.curOrder_ = arg_8_1

	self.orderController_:SetSelectedState(arg_8_1)

	if not self.gameObject_.activeInHierarchy then
		return
	end

	self:UpdateList()
end

function HeroListFilterView:SortListByType(arg_9_1)
	self.curSortType_ = arg_9_1

	if not self.gameObject_.activeInHierarchy then
		return
	end

	self:UpdateList()
end

function HeroListFilterView:FilterListByRace(arg_10_1)
	self.curRaceIndex_ = arg_10_1
	self.displayIdList_ = {}

	if arg_10_1 == 0 then
		for iter_10_0, iter_10_1 in ipairs(self.idList_) do
			if not HeroTools.GetIsHide(iter_10_1) then
				table.insert(self.displayIdList_, iter_10_1)
			end
		end
	else
		for iter_10_2, iter_10_3 in ipairs(self.idList_) do
			if HeroCfg[iter_10_3].race == arg_10_1 and not HeroTools.GetIsHide(iter_10_3) then
				table.insert(self.displayIdList_, iter_10_3)
			end
		end
	end

	if not self.gameObject_.activeInHierarchy then
		return
	end

	self:UpdateList()
end

function HeroListFilterView:SetHeroIdList(arg_11_1, arg_11_2)
	self.idList_ = arg_11_1
	self.displayIdList_ = {}
	self.extra_ = arg_11_2
	self.isForeign_ = arg_11_2 and arg_11_2.isForeign
	self.isTemp_ = arg_11_2 and arg_11_2.isTemp

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if not HeroTools.GetIsHide(iter_11_1) then
			table.insert(self.displayIdList_, iter_11_1)
		end
	end

	if self.curRaceIndex_ ~= 0 then
		self:FilterListByRace(self.curRaceIndex_)
	end

	self:UpdateList()
end

function HeroListFilterView:UpdateList()
	local var_12_0 = GameSetting.unlock_hero_need.value

	self.heroSorter_:Reset()
	table.sort(self.displayIdList_, function(arg_13_0, arg_13_1)
		if self.extraSorter_ ~= nil then
			local var_13_2, var_13_3 = self.extraSorter_(arg_13_0, arg_13_1)

			if var_13_2 then
				return var_13_3
			end
		end

		local var_13_4
		local var_13_5

		if self.isForeign_ then
			-- block empty
		elseif self.isTemp_ then
			var_13_4 = TempHeroData:GetHeroData(arg_13_0, self.extra_.tempHeroList)
			var_13_5 = TempHeroData:GetHeroData(arg_13_1, self.extra_.tempHeroList)
		else
			var_13_4 = HeroData:GetHeroData(arg_13_0)
			var_13_5 = HeroData:GetHeroData(arg_13_1)
		end

		if var_13_4.unlock ~= var_13_5.unlock then
			return var_13_4.unlock > var_13_5.unlock
		end

		if var_13_4.unlock == 0 and var_13_5.unlock == 0 then
			if (var_12_0[HeroCfg[arg_13_0].rare] <= var_13_4.piece and 1 or 0) ~= (var_12_0[HeroCfg[arg_13_1].rare] <= var_13_5.piece and 1 or 0) then
				return (var_12_0[HeroCfg[arg_13_1].rare] <= var_13_5.piece and 1 or 0) < (var_12_0[HeroCfg[arg_13_0].rare] <= var_13_4.piece and 1 or 0)
			end
		end

		if not self.extra_ then
			local var_13_7 = HeroData:IsFavorite(arg_13_0)
			local var_13_8 = HeroData:IsFavorite(arg_13_1)

			if var_13_7 ~= var_13_8 and (not var_13_7 or not var_13_8) then
				return var_13_7 ~= false
			end
		end

		if self.curSortType_ == 0 then
			local var_13_9, var_13_10 = self:FightPowerSorter(var_13_4, var_13_5)

			if var_13_9 then
				return var_13_10
			end

			local var_13_11, var_13_12 = self:StarSorter(var_13_4, var_13_5)

			if var_13_11 then
				return var_13_12
			end

			local var_13_13, var_13_14 = self:RareSorter(var_13_4, var_13_5)

			if var_13_13 then
				return var_13_14
			end

			local var_13_15, var_13_16 = self:LevelSorter(var_13_4, var_13_5)

			if var_13_15 then
				return var_13_16
			end
		else
			local var_13_17, var_13_18 = self:StarSorter(var_13_4, var_13_5)

			if var_13_17 then
				return var_13_18
			end

			local var_13_19, var_13_20 = self:RareSorter(var_13_4, var_13_5)

			if var_13_19 then
				return var_13_20
			end

			local var_13_21, var_13_22 = self:FightPowerSorter(var_13_4, var_13_5)

			if var_13_21 then
				return var_13_22
			end

			local var_13_23, var_13_24 = self:LevelSorter(var_13_4, var_13_5)

			if var_13_23 then
				return var_13_24
			end
		end

		return arg_13_1 < arg_13_0
	end)

	if self.callback_ ~= nil then
		self.callback_(self.displayIdList_)
	end
end

function HeroListFilterView:SetListChangeHandler(arg_14_1)
	self.callback_ = arg_14_1
end

function HeroListFilterView:SetExtraSorter(arg_15_1)
	self.extraSorter_ = arg_15_1
end

function HeroListFilterView:SetIsSelfHero(arg_16_1)
	self.isSelfHero_ = arg_16_1
end

function HeroListFilterView:OnEnter()
	return
end

function HeroListFilterView:OnExit()
	return
end

function HeroListFilterView:FightPowerSorter(arg_19_1, arg_19_2)
	local var_19_0
	local var_19_1

	if self.isForeign_ then
		-- block empty
	elseif self.isTemp_ then
		var_19_0 = TempHeroData:GetBattlePower(arg_19_1, self.extra_)
		var_19_1 = TempHeroData:GetBattlePower(arg_19_2, self.extra_)
	else
		var_19_0 = self.heroSorter_:GetHeroPower(arg_19_1)
		var_19_1 = self.heroSorter_:GetHeroPower(arg_19_2)
	end

	if var_19_0 ~= var_19_1 then
		if self.curOrder_ == "desc" then
			return true, var_19_1 < var_19_0
		else
			return true, var_19_0 < var_19_1
		end
	end

	return false, false
end

function HeroListFilterView:StarSorter(arg_20_1, arg_20_2)
	if arg_20_1.star ~= arg_20_2.star then
		if self.curOrder_ == "desc" then
			return true, arg_20_1.star > arg_20_2.star
		else
			return true, arg_20_1.star < arg_20_2.star
		end
	end

	return false, false
end

function HeroListFilterView:RareSorter(arg_21_1, arg_21_2)
	local var_21_0 = HeroCfg[arg_21_1.id]
	local var_21_1 = HeroCfg[arg_21_2.id]

	if HeroCfg[arg_21_1.id].rare ~= HeroCfg[arg_21_2.id].rare then
		if self.curOrder_ == "desc" then
			return true, var_21_0.rare > var_21_1.rare
		else
			return true, var_21_0.rare < var_21_1.rare
		end
	end

	return false, false
end

function HeroListFilterView:LevelSorter(arg_22_1, arg_22_2)
	if arg_22_1.exp ~= arg_22_2.exp then
		if self.curOrder_ == "desc" then
			return true, arg_22_1.exp > arg_22_2.exp
		else
			return true, arg_22_1.exp < arg_22_2.exp
		end
	end

	return false, false
end

function HeroListFilterView:Reset()
	self:RemoveAllListeners()

	self.sortTypeDropdown_.value = 0

	self.orderController_:SetSelectedState("desc")

	self.curOrder_ = "desc"
	self.curSortType_ = 0
	self.curRaceIndex_ = 0

	self:AddUIListener()
end

function HeroListFilterView:ShowDropDown(arg_24_1)
	return
end

function HeroListFilterView:Dispose()
	if self.heroSorter_ then
		self.heroSorter_:Reset()

		self.heroSorter_ = nil
	end

	HeroListFilterView.super.Dispose(self)
end

return HeroListFilterView
