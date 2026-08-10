local var_0_0 = class("HeroListFilterView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.isSelfHero_ = true
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.curOrder_ = "desc"
	arg_2_0.curSortType_ = 0
	arg_2_0.curRaceIndex_ = 0

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.heroSorter_ = HeroSorter.New()
	arg_3_0.orderController_ = ControllerUtil.GetController(arg_3_0.sortBtn_.gameObject.transform, "order")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.sortBtn_, nil, function()
		local var_5_0 = arg_4_0.orderController_:GetSelectedState() == "asc" and "desc" or "asc"

		arg_4_0:SortListByOrder(var_5_0)
	end)
	arg_4_0:AddToggleListener(arg_4_0.sortTypeDropdown_, function(arg_6_0)
		arg_4_0:SortListByType(arg_6_0)
	end)
	arg_4_0:AddBtnListener(arg_4_0.allBtn_, nil, function()
		JumpTools.OpenPageByJump("sortHeroType", {
			isAll = arg_4_0.isAll_,
			sortType = arg_4_0.curSortType_,
			sortRace = arg_4_0.curSortRace_,
			attackType = arg_4_0.curAttackType_,
			energyType = arg_4_0.curEnergyType_
		})
	end)
end

function var_0_0.SortListByOrder(arg_8_0, arg_8_1)
	arg_8_0.curOrder_ = arg_8_1

	arg_8_0.orderController_:SetSelectedState(arg_8_1)

	if not arg_8_0.gameObject_.activeInHierarchy then
		return
	end

	arg_8_0:UpdateList()
end

function var_0_0.SortListByType(arg_9_0, arg_9_1)
	arg_9_0.curSortType_ = arg_9_1

	if not arg_9_0.gameObject_.activeInHierarchy then
		return
	end

	arg_9_0:UpdateList()
end

function var_0_0.FilterListByRace(arg_10_0, arg_10_1)
	arg_10_0.curRaceIndex_ = arg_10_1
	arg_10_0.displayIdList_ = {}

	if arg_10_1 == 0 then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.idList_) do
			if not HeroTools.GetIsHide(iter_10_1) then
				table.insert(arg_10_0.displayIdList_, iter_10_1)
			end
		end
	else
		for iter_10_2, iter_10_3 in ipairs(arg_10_0.idList_) do
			if HeroCfg[iter_10_3].race == arg_10_1 and not HeroTools.GetIsHide(iter_10_3) then
				table.insert(arg_10_0.displayIdList_, iter_10_3)
			end
		end
	end

	if not arg_10_0.gameObject_.activeInHierarchy then
		return
	end

	arg_10_0:UpdateList()
end

function var_0_0.SetHeroIdList(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.idList_ = arg_11_1
	arg_11_0.displayIdList_ = {}
	arg_11_0.extra_ = arg_11_2
	arg_11_0.isForeign_ = arg_11_2 and arg_11_2.isForeign
	arg_11_0.isTemp_ = arg_11_2 and arg_11_2.isTemp

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if not HeroTools.GetIsHide(iter_11_1) then
			table.insert(arg_11_0.displayIdList_, iter_11_1)
		end
	end

	if arg_11_0.curRaceIndex_ ~= 0 then
		arg_11_0:FilterListByRace(arg_11_0.curRaceIndex_)
	end

	arg_11_0:UpdateList()
end

function var_0_0.UpdateList(arg_12_0)
	local var_12_0 = GameSetting.unlock_hero_need.value

	arg_12_0.heroSorter_:Reset()
	table.sort(arg_12_0.displayIdList_, function(arg_13_0, arg_13_1)
		local var_13_0 = false
		local var_13_1 = false

		if arg_12_0.extraSorter_ ~= nil then
			local var_13_2, var_13_3 = arg_12_0.extraSorter_(arg_13_0, arg_13_1)
			local var_13_4 = var_13_3

			if var_13_2 then
				return var_13_4
			end
		end

		local var_13_5
		local var_13_6

		if arg_12_0.isForeign_ then
			-- block empty
		elseif arg_12_0.isTemp_ then
			var_13_5 = TempHeroData:GetHeroData(arg_13_0, arg_12_0.extra_.tempHeroList)
			var_13_6 = TempHeroData:GetHeroData(arg_13_1, arg_12_0.extra_.tempHeroList)
		else
			var_13_5 = HeroData:GetHeroData(arg_13_0)
			var_13_6 = HeroData:GetHeroData(arg_13_1)
		end

		if var_13_5.unlock ~= var_13_6.unlock then
			return var_13_5.unlock > var_13_6.unlock
		end

		if var_13_5.unlock == 0 and var_13_6.unlock == 0 then
			local var_13_7 = var_12_0[HeroCfg[arg_13_0].rare]
			local var_13_8 = var_12_0[HeroCfg[arg_13_1].rare]
			local var_13_9 = var_13_7 <= var_13_5.piece and 1 or 0
			local var_13_10 = var_13_8 <= var_13_6.piece and 1 or 0

			if var_13_9 ~= var_13_10 then
				return var_13_10 < var_13_9
			end
		end

		if not arg_12_0.extra_ then
			local var_13_11 = HeroData:IsFavorite(arg_13_0)
			local var_13_12 = HeroData:IsFavorite(arg_13_1)

			if var_13_11 ~= var_13_12 and (not var_13_11 or not var_13_12) then
				return var_13_11 ~= false
			end
		end

		if arg_12_0.curSortType_ == 0 then
			local var_13_13, var_13_14 = arg_12_0:FightPowerSorter(var_13_5, var_13_6)
			local var_13_15 = var_13_14

			if var_13_13 then
				return var_13_15
			end

			local var_13_16, var_13_17 = arg_12_0:StarSorter(var_13_5, var_13_6)
			local var_13_18 = var_13_17

			if var_13_16 then
				return var_13_18
			end

			local var_13_19, var_13_20 = arg_12_0:RareSorter(var_13_5, var_13_6)
			local var_13_21 = var_13_20

			if var_13_19 then
				return var_13_21
			end

			local var_13_22, var_13_23 = arg_12_0:LevelSorter(var_13_5, var_13_6)
			local var_13_24 = var_13_23

			if var_13_22 then
				return var_13_24
			end
		else
			local var_13_25, var_13_26 = arg_12_0:StarSorter(var_13_5, var_13_6)
			local var_13_27 = var_13_26

			if var_13_25 then
				return var_13_27
			end

			local var_13_28, var_13_29 = arg_12_0:RareSorter(var_13_5, var_13_6)
			local var_13_30 = var_13_29

			if var_13_28 then
				return var_13_30
			end

			local var_13_31, var_13_32 = arg_12_0:FightPowerSorter(var_13_5, var_13_6)
			local var_13_33 = var_13_32

			if var_13_31 then
				return var_13_33
			end

			local var_13_34, var_13_35 = arg_12_0:LevelSorter(var_13_5, var_13_6)
			local var_13_36 = var_13_35

			if var_13_34 then
				return var_13_36
			end
		end

		return arg_13_1 < arg_13_0
	end)

	if arg_12_0.callback_ ~= nil then
		arg_12_0.callback_(arg_12_0.displayIdList_)
	end
end

function var_0_0.SetListChangeHandler(arg_14_0, arg_14_1)
	arg_14_0.callback_ = arg_14_1
end

function var_0_0.SetExtraSorter(arg_15_0, arg_15_1)
	arg_15_0.extraSorter_ = arg_15_1
end

function var_0_0.SetIsSelfHero(arg_16_0, arg_16_1)
	arg_16_0.isSelfHero_ = arg_16_1
end

function var_0_0.OnEnter(arg_17_0)
	return
end

function var_0_0.OnExit(arg_18_0)
	return
end

function var_0_0.FightPowerSorter(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0
	local var_19_1

	if arg_19_0.isForeign_ then
		-- block empty
	elseif arg_19_0.isTemp_ then
		var_19_0 = TempHeroData:GetBattlePower(arg_19_1, arg_19_0.extra_)
		var_19_1 = TempHeroData:GetBattlePower(arg_19_2, arg_19_0.extra_)
	else
		var_19_0 = arg_19_0.heroSorter_:GetHeroPower(arg_19_1)
		var_19_1 = arg_19_0.heroSorter_:GetHeroPower(arg_19_2)
	end

	if var_19_0 ~= var_19_1 then
		if arg_19_0.curOrder_ == "desc" then
			return true, var_19_1 < var_19_0
		else
			return true, var_19_0 < var_19_1
		end
	end

	return false, false
end

function var_0_0.StarSorter(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1.star ~= arg_20_2.star then
		if arg_20_0.curOrder_ == "desc" then
			return true, arg_20_1.star > arg_20_2.star
		else
			return true, arg_20_1.star < arg_20_2.star
		end
	end

	return false, false
end

function var_0_0.RareSorter(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = HeroCfg[arg_21_1.id]
	local var_21_1 = HeroCfg[arg_21_2.id]

	if var_21_0.rare ~= var_21_1.rare then
		if arg_21_0.curOrder_ == "desc" then
			return true, var_21_0.rare > var_21_1.rare
		else
			return true, var_21_0.rare < var_21_1.rare
		end
	end

	return false, false
end

function var_0_0.LevelSorter(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1.exp ~= arg_22_2.exp then
		if arg_22_0.curOrder_ == "desc" then
			return true, arg_22_1.exp > arg_22_2.exp
		else
			return true, arg_22_1.exp < arg_22_2.exp
		end
	end

	return false, false
end

function var_0_0.Reset(arg_23_0)
	arg_23_0:RemoveAllListeners()

	arg_23_0.sortTypeDropdown_.value = 0

	arg_23_0.orderController_:SetSelectedState("desc")

	arg_23_0.curOrder_ = "desc"
	arg_23_0.curSortType_ = 0
	arg_23_0.curRaceIndex_ = 0

	arg_23_0:AddUIListener()
end

function var_0_0.ShowDropDown(arg_24_0, arg_24_1)
	return
end

function var_0_0.Dispose(arg_25_0)
	if arg_25_0.heroSorter_ then
		arg_25_0.heroSorter_:Reset()

		arg_25_0.heroSorter_ = nil
	end

	var_0_0.super.Dispose(arg_25_0)
end

return var_0_0
