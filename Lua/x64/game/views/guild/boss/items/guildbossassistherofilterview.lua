local var_0_0 = class("GuildBossAssistHeroFilterView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
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
	arg_2_0:AddUIListener()
	arg_2_0:InitDropDown()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

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

function var_0_0.InitDropDown(arg_8_0)
	arg_8_0.sortTypeDropdown_.options:Clear()
	arg_8_0.sortTypeDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_UPGRADE"), nil))
	arg_8_0.sortTypeDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_RARE"), nil))
	arg_8_0.sortTypeDropdown_:RefreshShownValue()
end

function var_0_0.AddEventListeners(arg_9_0)
	return
end

function var_0_0.SetData(arg_10_0, arg_10_1)
	arg_10_0.data_ = arg_10_1

	arg_10_0:UpdateView()
end

function var_0_0.UpdateView(arg_11_0)
	return
end

function var_0_0.SetHeroList(arg_12_0, arg_12_1)
	arg_12_0.heroList_ = arg_12_1
	arg_12_0.displayHeroList_ = {}

	arg_12_0:RefreshSort(arg_12_0.isAll_, arg_12_0.curSortType_, arg_12_0.curSortRace_, arg_12_0.curAttackType_, arg_12_0.curEnergyType_)
end

function var_0_0.SortListByType(arg_13_0, arg_13_1)
	arg_13_0.curSortType_ = arg_13_1

	HeroData:SaveSortType(arg_13_1)

	if not arg_13_0.gameObject_.activeInHierarchy then
		return
	end

	arg_13_0:UpdateList()
end

function var_0_0.RefreshSort(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	arg_14_0.isAll_ = arg_14_1
	arg_14_0.curSortType_ = arg_14_2
	arg_14_0.curSortRace_ = arg_14_3
	arg_14_0.curAttackType_ = arg_14_4
	arg_14_0.curEnergyType_ = arg_14_5
	arg_14_0.displayHeroList_ = {}

	if arg_14_0.isAll_ then
		for iter_14_0, iter_14_1 in ipairs(arg_14_0.heroList_ or {}) do
			table.insert(arg_14_0.displayHeroList_, iter_14_1)
		end
	else
		for iter_14_2, iter_14_3 in ipairs(arg_14_0.heroList_ or {}) do
			local var_14_0 = iter_14_3.assist_hero_id
			local var_14_1 = HeroCfg[var_14_0]
			local var_14_2 = false

			if #arg_14_0.curSortRace_ <= 0 or table.indexof(arg_14_0.curSortRace_, var_14_1.race) then
				var_14_2 = true
			end

			local var_14_3 = false

			if #arg_14_0.curEnergyType_ <= 0 or table.indexof(arg_14_0.curEnergyType_, var_14_1.mechanism_type[1]) then
				var_14_3 = true
			end

			local var_14_4 = false
			local var_14_5 = var_14_1.ATK_attribute

			if #arg_14_0.curAttackType_ <= 0 or #var_14_5 > 1 and table.indexof(arg_14_0.curAttackType_, HeroConst.HERO_ATTACK_TYPE.MIX) then
				var_14_4 = true
			else
				for iter_14_4, iter_14_5 in ipairs(var_14_5) do
					if table.indexof(arg_14_0.curAttackType_, iter_14_5) then
						var_14_4 = true

						break
					end
				end
			end

			if var_14_2 and var_14_3 and var_14_4 then
				table.insert(arg_14_0.displayHeroList_, iter_14_3)
			end
		end
	end

	arg_14_0:RefreshType()
	arg_14_0:UpdateList()
end

function var_0_0.RefreshType(arg_15_0)
	arg_15_0.typeTxt_.text = arg_15_0.isAll_ and GetTips("ALL") or GetTips("ROLE_FILTERING")
end

function var_0_0.SortListByOrder(arg_16_0, arg_16_1)
	arg_16_0.curOrder_ = arg_16_1

	arg_16_0.orderController_:SetSelectedState(arg_16_1)

	if not arg_16_0.gameObject_.activeInHierarchy then
		return
	end

	arg_16_0:UpdateList()
end

function var_0_0.UpdateList(arg_17_0)
	local var_17_0 = GameSetting.unlock_hero_need.value

	table.sort(arg_17_0.displayHeroList_, function(arg_18_0, arg_18_1)
		local var_18_0 = false
		local var_18_1 = false

		if arg_17_0.extraSorter_ ~= nil then
			local var_18_2, var_18_3 = arg_17_0.extraSorter_(arg_18_0, arg_18_1)
			local var_18_4 = var_18_3

			if var_18_2 then
				return var_18_4
			end
		end

		local var_18_5 = arg_18_0
		local var_18_6 = arg_18_1

		if arg_17_0.curSortType_ == 0 then
			local var_18_7, var_18_8 = arg_17_0:FightPowerSorter(var_18_5, var_18_6)
			local var_18_9 = var_18_8

			if var_18_7 then
				return var_18_9
			end

			local var_18_10, var_18_11 = arg_17_0:RareSorter(var_18_5, var_18_6)
			local var_18_12 = var_18_11

			if var_18_10 then
				return var_18_12
			end

			local var_18_13, var_18_14 = arg_17_0:LevelSorter(var_18_5, var_18_6)
			local var_18_15 = var_18_14

			if var_18_13 then
				return var_18_15
			end
		else
			local var_18_16, var_18_17 = arg_17_0:RareSorter(var_18_5, var_18_6)
			local var_18_18 = var_18_17

			if var_18_16 then
				return var_18_18
			end

			local var_18_19, var_18_20 = arg_17_0:FightPowerSorter(var_18_5, var_18_6)
			local var_18_21 = var_18_20

			if var_18_19 then
				return var_18_21
			end

			local var_18_22, var_18_23 = arg_17_0:LevelSorter(var_18_5, var_18_6)
			local var_18_24 = var_18_23

			if var_18_22 then
				return var_18_24
			end
		end

		if arg_18_0.assist_hero_id ~= arg_18_1.assist_hero_id then
			return arg_18_0.assist_hero_id > arg_18_1.assist_hero_id
		end

		return tonumber(arg_18_0.member_id) > tonumber(arg_18_1.member_id)
	end)

	if arg_17_0.callback_ ~= nil then
		arg_17_0.callback_(arg_17_0.displayHeroList_)
	end
end

function var_0_0.FightPowerSorter(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1.fight_capacity
	local var_19_1 = arg_19_2.fight_capacity

	if var_19_0 ~= var_19_1 then
		if arg_19_0.curOrder_ == "desc" then
			return true, var_19_1 < var_19_0
		else
			return true, var_19_0 < var_19_1
		end
	end

	return false, false
end

function var_0_0.RareSorter(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1.hero_rare
	local var_20_1 = arg_20_2.hero_rare

	if var_20_0 ~= var_20_1 then
		if arg_20_0.curOrder_ == "desc" then
			return true, var_20_1 < var_20_0
		else
			return true, var_20_0 < var_20_1
		end
	end

	return false, false
end

function var_0_0.LevelSorter(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1.hero_level ~= arg_21_2.hero_level then
		if arg_21_0.curOrder_ == "desc" then
			return true, arg_21_1.hero_level > arg_21_2.hero_level
		else
			return true, arg_21_1.hero_level < arg_21_2.hero_level
		end
	end

	return false, false
end

function var_0_0.SetListChangeHandler(arg_22_0, arg_22_1)
	arg_22_0.callback_ = arg_22_1
end

function var_0_0.SetExtraSorter(arg_23_0, arg_23_1)
	arg_23_0.extraSorter_ = arg_23_1
end

function var_0_0.OnEnter(arg_24_0)
	arg_24_0:AddEventListeners()
end

function var_0_0.Reset(arg_25_0, arg_25_1)
	arg_25_0:RemoveAllListeners()
	arg_25_0.orderController_:SetSelectedState("desc")

	arg_25_0.curOrder_ = "desc"

	if arg_25_1 then
		arg_25_0.isAll_, arg_25_0.curSortType_, arg_25_0.curSortRace_, arg_25_0.curAttackType_, arg_25_0.curEnergyType_ = HeroData:GetSortValue()
	else
		arg_25_0.isAll_ = true
		arg_25_0.curSortType_ = 0
		arg_25_0.curSortRace_ = {}
		arg_25_0.curAttackType_ = {}
		arg_25_0.curEnergyType_ = {}
	end

	arg_25_0.sortTypeDropdown_.value = arg_25_0.curSortType_

	arg_25_0:AddUIListener()
	arg_25_0:RefreshType()
end

function var_0_0.OnExit(arg_26_0)
	arg_26_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_27_0)
	return
end

function var_0_0.Dispose(arg_28_0)
	arg_28_0.data_ = nil

	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
