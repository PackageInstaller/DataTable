local var_0_0 = class("GuildActivityFilterView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.isSelfHero_ = true
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.curOrder_ = "desc"
	arg_2_0.isAll_ = true
	arg_2_0.curSortType_ = 0
	arg_2_0.curSortRace_ = {}
	arg_2_0.curAttackType_ = {}
	arg_2_0.curEnergyType_ = {}

	arg_2_0:InitUI()
	arg_2_0:InitDropDown()
	arg_2_0:AddUIListener()
end

function var_0_0.InitDropDown(arg_3_0)
	arg_3_0.sortTypeDropdown_.options:Clear()
	arg_3_0.sortTypeDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_UPGRADE"), nil))
	arg_3_0.sortTypeDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_RARE"), nil))
	arg_3_0.sortTypeDropdown_:RefreshShownValue()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.heroSorter_ = HeroSorter.New()
	arg_4_0.orderController_ = ControllerUtil.GetController(arg_4_0.sortBtn_.gameObject.transform, "order")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.sortBtn_, nil, function()
		local var_6_0 = arg_5_0.orderController_:GetSelectedState() == "asc" and "desc" or "asc"

		arg_5_0:SortListByOrder(var_6_0)
	end)
	arg_5_0:AddToggleListener(arg_5_0.sortTypeDropdown_, function(arg_7_0)
		arg_5_0:SortListByType(arg_7_0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.allBtn_, nil, function()
		JumpTools.OpenPageByJump("sortHeroType", {
			isAll = arg_5_0.isAll_,
			sortType = arg_5_0.curSortType_,
			sortRace = arg_5_0.curSortRace_,
			attackType = arg_5_0.curAttackType_,
			energyType = arg_5_0.curEnergyType_
		})
	end)
end

function var_0_0.SortListByOrder(arg_9_0, arg_9_1)
	arg_9_0.curOrder_ = arg_9_1

	arg_9_0.orderController_:SetSelectedState(arg_9_1)

	if not arg_9_0.gameObject_.activeInHierarchy then
		return
	end

	arg_9_0:UpdateList()
end

function var_0_0.SetHeroDataList(arg_10_0, arg_10_1)
	arg_10_0.heroList_ = arg_10_1

	arg_10_0:RefreshSort(arg_10_0.isAll_, arg_10_0.curSortType_, arg_10_0.curSortRace_, arg_10_0.curAttackType_, arg_10_0.curEnergyType_)
end

function var_0_0.SortListByType(arg_11_0, arg_11_1)
	arg_11_0.curSortType_ = arg_11_1

	HeroData:SaveSortType(arg_11_1)

	if not arg_11_0.gameObject_.activeInHierarchy then
		return
	end

	arg_11_0:UpdateList()
end

function var_0_0.RefreshSort(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	arg_12_0.isAll_ = arg_12_1
	arg_12_0.curSortType_ = arg_12_2
	arg_12_0.curSortRace_ = arg_12_3
	arg_12_0.curAttackType_ = arg_12_4
	arg_12_0.curEnergyType_ = arg_12_5
	arg_12_0.displayHeroList_ = {}

	if arg_12_0.isAll_ then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0.heroList_) do
			table.insert(arg_12_0.displayHeroList_, iter_12_1)
		end
	else
		for iter_12_2, iter_12_3 in ipairs(arg_12_0.heroList_) do
			local var_12_0 = iter_12_3.id
			local var_12_1 = HeroCfg[var_12_0]
			local var_12_2 = false

			if #arg_12_0.curSortRace_ <= 0 or table.indexof(arg_12_0.curSortRace_, var_12_1.race) then
				var_12_2 = true
			end

			local var_12_3 = false

			if #arg_12_0.curEnergyType_ <= 0 or table.indexof(arg_12_0.curEnergyType_, var_12_1.mechanism_type[1]) then
				var_12_3 = true
			end

			local var_12_4 = false
			local var_12_5 = var_12_1.ATK_attribute

			if #arg_12_0.curAttackType_ <= 0 or #var_12_5 > 1 and table.indexof(arg_12_0.curAttackType_, HeroConst.HERO_ATTACK_TYPE.MIX) then
				var_12_4 = true
			else
				for iter_12_4, iter_12_5 in ipairs(var_12_5) do
					if table.indexof(arg_12_0.curAttackType_, iter_12_5) then
						var_12_4 = true

						break
					end
				end
			end

			if var_12_2 and var_12_3 and var_12_4 then
				table.insert(arg_12_0.displayHeroList_, var_12_0)
			end
		end
	end

	arg_12_0:RefreshType()
	arg_12_0:UpdateList()
end

function var_0_0.RefreshType(arg_13_0)
	arg_13_0.typeTxt_.text = arg_13_0.isAll_ and GetTips("ALL") or GetTips("ROLE_FILTERING")
end

function var_0_0.UpdateList(arg_14_0)
	local var_14_0 = GameSetting.unlock_hero_need.value

	arg_14_0.heroSorter_:Reset()
	table.sort(arg_14_0.displayHeroList_, function(arg_15_0, arg_15_1)
		local var_15_0 = false
		local var_15_1 = false

		if arg_14_0.extraSorter_ ~= nil then
			local var_15_2, var_15_3 = arg_14_0.extraSorter_(arg_15_0, arg_15_1, arg_14_0.curSortType_, arg_14_0.curOrder_)
			local var_15_4 = var_15_3

			if var_15_2 then
				return var_15_4
			end
		end

		local var_15_5 = arg_15_0.id
		local var_15_6 = arg_15_1.id
		local var_15_7 = HeroData:GetHeroData(var_15_5)
		local var_15_8 = HeroData:GetHeroData(var_15_6)

		if var_15_7.unlock ~= var_15_8.unlock then
			return var_15_7.unlock > var_15_8.unlock
		end

		if var_15_7.unlock == 0 and var_15_8.unlock == 0 then
			local var_15_9 = var_14_0[HeroCfg[var_15_5].rare]
			local var_15_10 = var_14_0[HeroCfg[var_15_6].rare]
			local var_15_11 = var_15_9 <= var_15_7.piece and 1 or 0
			local var_15_12 = var_15_10 <= var_15_8.piece and 1 or 0

			if var_15_11 ~= var_15_12 then
				return var_15_12 < var_15_11
			end
		end

		local var_15_13 = HeroData:IsFavorite(var_15_5)
		local var_15_14 = HeroData:IsFavorite(var_15_6)

		if var_15_13 ~= var_15_14 and (not var_15_13 or not var_15_14) then
			return var_15_13 ~= false
		end

		if arg_14_0.curSortType_ == 0 then
			local var_15_15, var_15_16 = arg_14_0:EnergySorter(var_15_7, var_15_8)
			local var_15_17 = var_15_16

			if var_15_15 then
				return var_15_17
			end

			local var_15_18, var_15_19 = arg_14_0:FightPowerSorter(var_15_7, var_15_8)
			local var_15_20 = var_15_19

			if var_15_18 then
				return var_15_20
			end

			local var_15_21, var_15_22 = arg_14_0:StarSorter(var_15_7, var_15_8)
			local var_15_23 = var_15_22

			if var_15_21 then
				return var_15_23
			end

			local var_15_24, var_15_25 = arg_14_0:RareSorter(var_15_7, var_15_8)
			local var_15_26 = var_15_25

			if var_15_24 then
				return var_15_26
			end

			local var_15_27, var_15_28 = arg_14_0:LevelSorter(var_15_7, var_15_8)
			local var_15_29 = var_15_28

			if var_15_27 then
				return var_15_29
			end
		elseif arg_14_0.curSortType_ == 1 then
			local var_15_30, var_15_31 = arg_14_0:FightPowerSorter(var_15_7, var_15_8)
			local var_15_32 = var_15_31

			if var_15_30 then
				return var_15_32
			end

			local var_15_33, var_15_34 = arg_14_0:StarSorter(var_15_7, var_15_8)
			local var_15_35 = var_15_34

			if var_15_33 then
				return var_15_35
			end

			local var_15_36, var_15_37 = arg_14_0:RareSorter(var_15_7, var_15_8)
			local var_15_38 = var_15_37

			if var_15_36 then
				return var_15_38
			end

			local var_15_39, var_15_40 = arg_14_0:LevelSorter(var_15_7, var_15_8)
			local var_15_41 = var_15_40

			if var_15_39 then
				return var_15_41
			end
		else
			local var_15_42, var_15_43 = arg_14_0:StarSorter(var_15_7, var_15_8)
			local var_15_44 = var_15_43

			if var_15_42 then
				return var_15_44
			end

			local var_15_45, var_15_46 = arg_14_0:RareSorter(var_15_7, var_15_8)
			local var_15_47 = var_15_46

			if var_15_45 then
				return var_15_47
			end

			local var_15_48, var_15_49 = arg_14_0:FightPowerSorter(var_15_7, var_15_8)
			local var_15_50 = var_15_49

			if var_15_48 then
				return var_15_50
			end

			local var_15_51, var_15_52 = arg_14_0:LevelSorter(var_15_7, var_15_8)
			local var_15_53 = var_15_52

			if var_15_51 then
				return var_15_53
			end
		end

		return var_15_6 < var_15_5
	end)

	if arg_14_0.callback_ ~= nil then
		arg_14_0.callback_(arg_14_0.displayHeroList_)
	end
end

function var_0_0.SetListChangeHandler(arg_16_0, arg_16_1)
	arg_16_0.callback_ = arg_16_1
end

function var_0_0.SetExtraSorter(arg_17_0, arg_17_1)
	arg_17_0.extraSorter_ = arg_17_1
end

function var_0_0.SetIsSelfHero(arg_18_0, arg_18_1)
	arg_18_0.isSelfHero_ = arg_18_1
end

function var_0_0.OnEnter(arg_19_0)
	return
end

function var_0_0.OnExit(arg_20_0)
	return
end

function var_0_0.EnergySorter(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = GuildActivityData:GetHeroFatigue(arg_21_1.id)
	local var_21_1 = GuildActivityData:GetHeroFatigue(arg_21_2.id)

	if var_21_0 ~= var_21_1 then
		if arg_21_0.curOrder_ == "desc" then
			return true, var_21_1 < var_21_0
		else
			return true, var_21_0 < var_21_1
		end
	end

	return false, false
end

function var_0_0.FightPowerSorter(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.heroSorter_:GetHeroPower(arg_22_1)
	local var_22_1 = arg_22_0.heroSorter_:GetHeroPower(arg_22_2)

	if var_22_0 ~= var_22_1 then
		if arg_22_0.curOrder_ == "desc" then
			return true, var_22_1 < var_22_0
		else
			return true, var_22_0 < var_22_1
		end
	end

	return false, false
end

function var_0_0.StarSorter(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1.star ~= arg_23_2.star then
		if arg_23_0.curOrder_ == "desc" then
			return true, arg_23_1.star > arg_23_2.star
		else
			return true, arg_23_1.star < arg_23_2.star
		end
	end

	return false, false
end

function var_0_0.RareSorter(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = HeroCfg[arg_24_1.id]
	local var_24_1 = HeroCfg[arg_24_2.id]

	if var_24_0.rare ~= var_24_1.rare then
		if arg_24_0.curOrder_ == "desc" then
			return true, var_24_0.rare > var_24_1.rare
		else
			return true, var_24_0.rare < var_24_1.rare
		end
	end

	return false, false
end

function var_0_0.LevelSorter(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1.exp ~= arg_25_2.exp then
		if arg_25_0.curOrder_ == "desc" then
			return true, arg_25_1.exp > arg_25_2.exp
		else
			return true, arg_25_1.exp < arg_25_2.exp
		end
	end

	return false, false
end

function var_0_0.Reset(arg_26_0, arg_26_1)
	arg_26_0:RemoveAllListeners()
	arg_26_0.orderController_:SetSelectedState("desc")

	arg_26_0.curOrder_ = "desc"

	if arg_26_1 then
		arg_26_0.isAll_, arg_26_0.curSortType_, arg_26_0.curSortRace_, arg_26_0.curAttackType_, arg_26_0.curEnergyType_ = HeroData:GetSortValue()
	else
		arg_26_0.isAll_ = true
		arg_26_0.curSortType_ = 0
		arg_26_0.curSortRace_ = {}
		arg_26_0.curAttackType_ = {}
		arg_26_0.curEnergyType_ = {}
	end

	arg_26_0.sortTypeDropdown_.value = arg_26_0.curSortType_

	arg_26_0:AddUIListener()
	arg_26_0:RefreshType()
end

function var_0_0.ShowSortBtn(arg_27_0, arg_27_1)
	SetActive(arg_27_0.sortBtnGo_, arg_27_1)
end

function var_0_0.ShowDropDown(arg_28_0, arg_28_1)
	SetActive(arg_28_0.panel_, arg_28_1)
end

function var_0_0.Dispose(arg_29_0)
	if arg_29_0.heroSorter_ then
		arg_29_0.heroSorter_:Reset()

		arg_29_0.heroSorter_ = nil
	end

	var_0_0.super.Dispose(arg_29_0)
end

return var_0_0
