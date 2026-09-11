local GuildBossAssistHeroFilterView = class("GuildBossAssistHeroFilterView", ReduxView)

function GuildBossAssistHeroFilterView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildBossAssistHeroFilterView:Init()
	self.curOrder_ = "desc"
	self.isAll_ = true
	self.curSortType_ = 0
	self.curSortRace_ = {}
	self.curAttackType_ = {}
	self.curEnergyType_ = {}

	self:InitUI()
	self:AddUIListener()
	self:InitDropDown()
end

function GuildBossAssistHeroFilterView:InitUI()
	self:BindCfgUI()

	self.orderController_ = ControllerUtil.GetController(self.sortBtn_.gameObject.transform, "order")
end

function GuildBossAssistHeroFilterView:AddUIListener()
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

function GuildBossAssistHeroFilterView:InitDropDown()
	self.sortTypeDropdown_.options:Clear()
	self.sortTypeDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_UPGRADE"), nil))
	self.sortTypeDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_RARE"), nil))
	self.sortTypeDropdown_:RefreshShownValue()
end

function GuildBossAssistHeroFilterView:AddEventListeners()
	return
end

function GuildBossAssistHeroFilterView:SetData(arg_10_1)
	self.data_ = arg_10_1

	self:UpdateView()
end

function GuildBossAssistHeroFilterView:UpdateView()
	return
end

function GuildBossAssistHeroFilterView:SetHeroList(arg_12_1)
	self.heroList_ = arg_12_1
	self.displayHeroList_ = {}

	self:RefreshSort(self.isAll_, self.curSortType_, self.curSortRace_, self.curAttackType_, self.curEnergyType_)
end

function GuildBossAssistHeroFilterView:SortListByType(arg_13_1)
	self.curSortType_ = arg_13_1

	HeroData:SaveSortType(arg_13_1)

	if not self.gameObject_.activeInHierarchy then
		return
	end

	self:UpdateList()
end

function GuildBossAssistHeroFilterView:RefreshSort(arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	self.isAll_ = arg_14_1
	self.curSortType_ = arg_14_2
	self.curSortRace_ = arg_14_3
	self.curAttackType_ = arg_14_4
	self.curEnergyType_ = arg_14_5
	self.displayHeroList_ = {}

	if self.isAll_ then
		for iter_14_0, iter_14_1 in ipairs(self.heroList_ or {}) do
			table.insert(self.displayHeroList_, iter_14_1)
		end
	else
		for iter_14_2, iter_14_3 in ipairs((not self.heroList_ or nil) and {}) do
			local var_14_2 = HeroCfg[iter_14_3.assist_hero_id]
			local var_14_3 = false

			var_14_3 = (#self.curSortRace_ <= 0 or table.indexof(self.curSortRace_, var_14_2.race)) and true

			local var_14_4 = false

			var_14_4 = (#self.curEnergyType_ <= 0 or table.indexof(self.curEnergyType_, var_14_2.mechanism_type[1])) and true

			local var_14_5 = false

			if #self.curAttackType_ <= 0 or #HeroCfg[iter_14_3.assist_hero_id].ATK_attribute > 1 and table.indexof(self.curAttackType_, HeroConst.HERO_ATTACK_TYPE.MIX) then
				var_14_5 = true
			else
				for iter_14_4, iter_14_5 in ipairs(HeroCfg[iter_14_3.assist_hero_id].ATK_attribute) do
					if table.indexof(self.curAttackType_, iter_14_5) then
						var_14_5 = true

						break
					end
				end
			end

			if var_14_3 and var_14_4 and var_14_5 then
				table.insert(self.displayHeroList_, iter_14_3)
			end
		end
	end

	self:RefreshType()
	self:UpdateList()
end

function GuildBossAssistHeroFilterView:RefreshType()
	self.typeTxt_.text = self.isAll_ and GetTips("ALL") or GetTips("ROLE_FILTERING")
end

function GuildBossAssistHeroFilterView:SortListByOrder(arg_16_1)
	self.curOrder_ = arg_16_1

	self.orderController_:SetSelectedState(arg_16_1)

	if not self.gameObject_.activeInHierarchy then
		return
	end

	self:UpdateList()
end

function GuildBossAssistHeroFilterView:UpdateList()
	table.sort(self.displayHeroList_, function(arg_18_0, arg_18_1)
		if self.extraSorter_ ~= nil then
			local var_18_2, var_18_3 = self.extraSorter_(arg_18_0, arg_18_1)

			if var_18_2 then
				return var_18_3
			end
		end

		local var_18_4 = arg_18_0

		if self.curSortType_ == 0 then
			local var_18_5, var_18_6 = self:FightPowerSorter(var_18_4, arg_18_1)

			if var_18_5 then
				return var_18_6
			end

			local var_18_7, var_18_8 = self:RareSorter(var_18_4, arg_18_1)

			if var_18_7 then
				return var_18_8
			end

			local var_18_9, var_18_10 = self:LevelSorter(var_18_4, arg_18_1)

			if var_18_9 then
				return var_18_10
			end
		else
			local var_18_11, var_18_12 = self:RareSorter(var_18_4, arg_18_1)

			if var_18_11 then
				return var_18_12
			end

			local var_18_13, var_18_14 = self:FightPowerSorter(var_18_4, arg_18_1)

			if var_18_13 then
				return var_18_14
			end

			local var_18_15, var_18_16 = self:LevelSorter(var_18_4, arg_18_1)

			if var_18_15 then
				return var_18_16
			end
		end

		if arg_18_0.assist_hero_id ~= arg_18_1.assist_hero_id then
			return arg_18_0.assist_hero_id > arg_18_1.assist_hero_id
		end

		return tonumber(arg_18_0.member_id) > tonumber(arg_18_1.member_id)
	end)

	if self.callback_ ~= nil then
		self.callback_(self.displayHeroList_)
	end
end

function GuildBossAssistHeroFilterView:FightPowerSorter(arg_19_1, arg_19_2)
	local var_19_0 = arg_19_2.fight_capacity

	if arg_19_1.fight_capacity ~= arg_19_2.fight_capacity then
		if self.curOrder_ == "desc" then
			return true, var_19_0 < arg_19_1.fight_capacity
		else
			return true, arg_19_1.fight_capacity < var_19_0
		end
	end

	return false, false
end

function GuildBossAssistHeroFilterView:RareSorter(arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2.hero_rare

	if arg_20_1.hero_rare ~= arg_20_2.hero_rare then
		if self.curOrder_ == "desc" then
			return true, var_20_0 < arg_20_1.hero_rare
		else
			return true, arg_20_1.hero_rare < var_20_0
		end
	end

	return false, false
end

function GuildBossAssistHeroFilterView:LevelSorter(arg_21_1, arg_21_2)
	if arg_21_1.hero_level ~= arg_21_2.hero_level then
		if self.curOrder_ == "desc" then
			return true, arg_21_1.hero_level > arg_21_2.hero_level
		else
			return true, arg_21_1.hero_level < arg_21_2.hero_level
		end
	end

	return false, false
end

function GuildBossAssistHeroFilterView:SetListChangeHandler(arg_22_1)
	self.callback_ = arg_22_1
end

function GuildBossAssistHeroFilterView:SetExtraSorter(arg_23_1)
	self.extraSorter_ = arg_23_1
end

function GuildBossAssistHeroFilterView:OnEnter()
	self:AddEventListeners()
end

function GuildBossAssistHeroFilterView:Reset(arg_25_1)
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

function GuildBossAssistHeroFilterView:OnExit()
	self:RemoveAllEventListener()
end

function GuildBossAssistHeroFilterView:OnMainHomeViewTop()
	return
end

function GuildBossAssistHeroFilterView:Dispose()
	self.data_ = nil

	GuildBossAssistHeroFilterView.super.Dispose(self)
end

return GuildBossAssistHeroFilterView
