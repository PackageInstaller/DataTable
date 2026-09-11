local GuildActivitySPFilterView = class("GuildActivitySPFilterView", ReduxView)

function GuildActivitySPFilterView:OnCtor(arg_1_1)
	self.isSelfHero_ = true
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildActivitySPFilterView:Init()
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

function GuildActivitySPFilterView:InitDropDown()
	self.sortTypeDropdown_.options:Clear()
	self.sortTypeDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("ACTIVITY_CLUB_QSDK"), nil))
	self.sortTypeDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_RARE"), nil))
	self.sortTypeDropdown_:RefreshShownValue()
end

function GuildActivitySPFilterView:InitUI()
	self:BindCfgUI()

	self.heroSorter_ = HeroSorter.New()
	self.orderController_ = ControllerUtil.GetController(self.sortBtn_.gameObject.transform, "order")
end

function GuildActivitySPFilterView:AddUIListener()
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

function GuildActivitySPFilterView:SortListByOrder(arg_9_1)
	self.curOrder_ = arg_9_1

	self.orderController_:SetSelectedState(arg_9_1)

	if not self.gameObject_.activeInHierarchy then
		return
	end

	self:UpdateList()
end

function GuildActivitySPFilterView:SetHeroDataList(arg_10_1)
	self.heroList_ = arg_10_1

	self:RefreshSort(self.isAll_, self.curSortType_, self.curSortRace_, self.curAttackType_, self.curEnergyType_)
end

function GuildActivitySPFilterView:SortListByType(arg_11_1)
	self.curSortType_ = arg_11_1

	HeroData:SaveSortType(arg_11_1)

	if not self.gameObject_.activeInHierarchy then
		return
	end

	self:UpdateList()
end

function GuildActivitySPFilterView:RefreshSort(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
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

function GuildActivitySPFilterView:RefreshType()
	self.typeTxt_.text = self.isAll_ and GetTips("ALL") or GetTips("ROLE_FILTERING")
end

function GuildActivitySPFilterView:UpdateList()
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

		local var_15_9 = HeroData:IsFavorite(var_15_4)
		local var_15_10 = HeroData:IsFavorite(var_15_5)

		if var_15_9 ~= var_15_10 and (not var_15_9 or not var_15_10) then
			return var_15_9 ~= false
		end

		if self.curSortType_ == 0 then
			local var_15_11, var_15_12 = self:EnergySorter(var_15_6, var_15_7)

			if var_15_11 then
				return var_15_12
			end

			local var_15_13, var_15_14 = self:FightPowerSorter(var_15_6, var_15_7)

			if var_15_13 then
				return var_15_14
			end

			local var_15_15, var_15_16 = self:StarSorter(var_15_6, var_15_7)

			if var_15_15 then
				return var_15_16
			end

			local var_15_17, var_15_18 = self:RareSorter(var_15_6, var_15_7)

			if var_15_17 then
				return var_15_18
			end

			local var_15_19, var_15_20 = self:LevelSorter(var_15_6, var_15_7)

			if var_15_19 then
				return var_15_20
			end
		elseif self.curSortType_ == 1 then
			local var_15_21, var_15_22 = self:StarSorter(var_15_6, var_15_7)

			if var_15_21 then
				return var_15_22
			end

			local var_15_23, var_15_24 = self:RareSorter(var_15_6, var_15_7)

			if var_15_23 then
				return var_15_24
			end

			local var_15_25, var_15_26 = self:FightPowerSorter(var_15_6, var_15_7)

			if var_15_25 then
				return var_15_26
			end

			local var_15_27, var_15_28 = self:LevelSorter(var_15_6, var_15_7)

			if var_15_27 then
				return var_15_28
			end
		else
			local var_15_29, var_15_30 = self:StarSorter(var_15_6, var_15_7)

			if var_15_29 then
				return var_15_30
			end

			local var_15_31, var_15_32 = self:RareSorter(var_15_6, var_15_7)

			if var_15_31 then
				return var_15_32
			end

			local var_15_33, var_15_34 = self:FightPowerSorter(var_15_6, var_15_7)

			if var_15_33 then
				return var_15_34
			end

			local var_15_35, var_15_36 = self:LevelSorter(var_15_6, var_15_7)

			if var_15_35 then
				return var_15_36
			end
		end

		return var_15_5 < var_15_4
	end)

	if self.callback_ ~= nil then
		self.callback_(self.displayHeroList_)
	end
end

function GuildActivitySPFilterView:SetListChangeHandler(arg_16_1)
	self.callback_ = arg_16_1
end

function GuildActivitySPFilterView:SetExtraSorter(arg_17_1)
	self.extraSorter_ = arg_17_1
end

function GuildActivitySPFilterView:SetIsSelfHero(arg_18_1)
	self.isSelfHero_ = arg_18_1
end

function GuildActivitySPFilterView:OnEnter()
	return
end

function GuildActivitySPFilterView:OnExit()
	return
end

function GuildActivitySPFilterView:EnergySorter(arg_21_1, arg_21_2)
	local var_21_0 = GuildActivitySPData:GetHeroFatigue(arg_21_1.id)
	local var_21_1 = GuildActivitySPData:GetHeroFatigue(arg_21_2.id)

	if var_21_0 ~= var_21_1 then
		if self.curOrder_ == "desc" then
			return true, var_21_1 < var_21_0
		else
			return true, var_21_0 < var_21_1
		end
	end

	return false, false
end

function GuildActivitySPFilterView:FightPowerSorter(arg_22_1, arg_22_2)
	local var_22_0 = self.heroSorter_:GetHeroPower(arg_22_1)
	local var_22_1 = self.heroSorter_:GetHeroPower(arg_22_2)

	if var_22_0 ~= var_22_1 then
		if self.curOrder_ == "desc" then
			return true, var_22_1 < var_22_0
		else
			return true, var_22_0 < var_22_1
		end
	end

	return false, false
end

function GuildActivitySPFilterView:StarSorter(arg_23_1, arg_23_2)
	if arg_23_1.star ~= arg_23_2.star then
		if self.curOrder_ == "desc" then
			return true, arg_23_1.star > arg_23_2.star
		else
			return true, arg_23_1.star < arg_23_2.star
		end
	end

	return false, false
end

function GuildActivitySPFilterView:RareSorter(arg_24_1, arg_24_2)
	local var_24_0 = HeroCfg[arg_24_1.id]
	local var_24_1 = HeroCfg[arg_24_2.id]

	if HeroCfg[arg_24_1.id].rare ~= HeroCfg[arg_24_2.id].rare then
		if self.curOrder_ == "desc" then
			return true, var_24_0.rare > var_24_1.rare
		else
			return true, var_24_0.rare < var_24_1.rare
		end
	end

	return false, false
end

function GuildActivitySPFilterView:LevelSorter(arg_25_1, arg_25_2)
	if arg_25_1.exp ~= arg_25_2.exp then
		if self.curOrder_ == "desc" then
			return true, arg_25_1.exp > arg_25_2.exp
		else
			return true, arg_25_1.exp < arg_25_2.exp
		end
	end

	return false, false
end

function GuildActivitySPFilterView:Reset(arg_26_1)
	self:RemoveAllListeners()
	self.orderController_:SetSelectedState("desc")

	self.curOrder_ = "desc"

	if arg_26_1 then
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

function GuildActivitySPFilterView:ShowSortBtn(arg_27_1)
	SetActive(self.sortBtnGo_, arg_27_1)
end

function GuildActivitySPFilterView:ShowDropDown(arg_28_1)
	SetActive(self.panel_, arg_28_1)
end

function GuildActivitySPFilterView:Dispose()
	if self.heroSorter_ then
		self.heroSorter_:Reset()

		self.heroSorter_ = nil
	end

	GuildActivitySPFilterView.super.Dispose(self)
end

return GuildActivitySPFilterView
