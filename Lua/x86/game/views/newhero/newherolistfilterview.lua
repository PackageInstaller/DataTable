local var_0_0 = class("NewHeroListFilterView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.isSelfHero_ = true
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.curOrder_ = "desc"
	arg_2_0.isAll_ = true
	arg_2_0.available_ = true
	arg_2_0.curSortType_ = 0
	arg_2_0.curSortRace_ = {}
	arg_2_0.curAttackType_ = {}
	arg_2_0.curEnergyType_ = {}

	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitDropdownData(arg_3_0)
	arg_3_0.sortTypeDropdown_.itemText.color = Color.New(0, 0, 0, 1)

	arg_3_0.sortTypeDropdown_.options:Clear()

	arg_3_0.dropDownText_ = {}

	if arg_3_0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
		arg_3_0:AddDropDownOption("TIP_UNLOCK_HERO")
		arg_3_0:AddDropDownOption("TIP_RARE")
	else
		arg_3_0:AddDropDownOption("TIP_UPGRADE")
		arg_3_0:AddDropDownOption("TIP_RARE")
	end

	if arg_3_0.heroViewProxy_.isSelf then
		arg_3_0:AddDropDownOption("TIP_FAVOR")
		arg_3_0:AddDropDownOption("TIP_CLEARTIMES")
	end

	arg_3_0:RefreshDropDownOptions()
end

function var_0_0.AddDropDownOption(arg_4_0, arg_4_1)
	local var_4_0 = "<color=#FFFFFF>%s</color>"

	arg_4_0.sortTypeDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(var_4_0, GetTips(arg_4_1), nil)))

	arg_4_0.dropDownText_[#arg_4_0.dropDownText_ + 1] = GetTips(arg_4_1)
end

function var_0_0.RefreshDropDownOptions(arg_5_0)
	if arg_5_0.dropDownText_ then
		local var_5_0 = "<color=#FFFFFF>%s</color>"
		local var_5_1 = arg_5_0.sortTypeDropdown_.options.Count

		for iter_5_0 = 1, var_5_1 do
			if iter_5_0 - 1 == arg_5_0.sortTypeDropdown_.value then
				arg_5_0.sortTypeDropdown_.options[iter_5_0 - 1].text = arg_5_0.dropDownText_[iter_5_0]
			else
				arg_5_0.sortTypeDropdown_.options[iter_5_0 - 1].text = string.format(var_5_0, arg_5_0.dropDownText_[iter_5_0])
			end
		end
	end
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.heroSorter_ = HeroSorter.New()
	arg_6_0.orderController_ = ControllerUtil.GetController(arg_6_0.transform_, "order")

	if arg_6_0.filterController_ then
		arg_6_0.filterColorController_ = arg_6_0.filterController_:GetController("color")
	end
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0:RefreshDropDownOptions()
end

function var_0_0.AddUIListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.sortBtn_, nil, function()
		local var_9_0 = arg_8_0.orderController_:GetSelectedState() == "asc" and "desc" or "asc"

		arg_8_0:SortListByOrder(var_9_0)
	end)
	arg_8_0:AddToggleListener(arg_8_0.sortTypeDropdown_, function(arg_10_0)
		arg_8_0:RefreshDropDownOptions()
		arg_8_0:SortListByType(arg_10_0)
	end)
	arg_8_0:AddBtnListener(arg_8_0.allBtn_, nil, function()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.Hero_Filter_List
		})
	end)
end

function var_0_0.SetAvailable(arg_12_0, arg_12_1)
	arg_12_0.available_ = arg_12_1
end

function var_0_0.SortListByOrder(arg_13_0, arg_13_1)
	arg_13_0.curOrder_ = arg_13_1

	arg_13_0.orderController_:SetSelectedState(arg_13_1)

	if not arg_13_0.gameObject_.activeInHierarchy then
		return
	end

	arg_13_0:UpdateList()
end

function var_0_0.SortListByType(arg_14_0, arg_14_1)
	arg_14_0.curSortType_ = arg_14_1

	HeroData:SaveSortType(arg_14_1)

	if not arg_14_0.gameObject_.activeInHierarchy then
		return
	end

	arg_14_0:UpdateList()
end

function var_0_0.RefreshSort(arg_15_0, arg_15_1)
	if not arg_15_0.available_ then
		return
	end

	arg_15_0.displayHeroDataList_ = HeroTools.GetHeroShowData(arg_15_0.heroDataList_, arg_15_1)

	arg_15_0:UpdateList()
	arg_15_0:RenderFilterBtn()
end

function var_0_0.SetHeroIdList(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if #arg_16_1 > 0 and type(arg_16_1[1]) ~= "table" then
		arg_16_1 = HeroTools.FormatFilterHeroDataList(arg_16_0.heroViewProxy_:GetViewDataType(), arg_16_1, arg_16_2, arg_16_3)
	end

	arg_16_0.heroDataList_ = arg_16_1
	arg_16_0.displayHeroDataList_ = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		if HeroTools.NeedToHideHero(iter_16_1.id, iter_16_1.type) then
			table.insert(arg_16_0.displayHeroDataList_, iter_16_1)
		end
	end

	arg_16_0:RefreshSort()
end

function var_0_0.UpdateList(arg_17_0)
	local var_17_0 = GameSetting.unlock_hero_need.value

	arg_17_0.heroSorter_:Reset()
	table.sort(arg_17_0.displayHeroDataList_, function(arg_18_0, arg_18_1)
		local var_18_0 = false
		local var_18_1 = false

		if arg_17_0.extraSorter_ ~= nil then
			local var_18_2, var_18_3 = arg_17_0.extraSorter_(arg_18_0, arg_18_1)
			local var_18_4 = var_18_3

			if var_18_2 then
				return var_18_4
			end
		end

		local var_18_5 = arg_18_0.heroViewProxy:GetHeroData(arg_18_0.id)
		local var_18_6 = arg_18_1.heroViewProxy:GetHeroData(arg_18_1.id)

		if arg_17_0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
			if arg_17_0.curSortType_ == 0 then
				local var_18_7, var_18_8 = arg_17_0:UnlockSorter(var_18_5, var_18_6)
				local var_18_9 = var_18_8

				if var_18_7 then
					return var_18_9
				end

				local var_18_10, var_18_11 = arg_17_0:RareSorter(var_18_5, var_18_6)
				local var_18_12 = var_18_11

				if var_18_10 then
					return var_18_12
				end

				local var_18_13, var_18_14 = arg_17_0:IDSorter(var_18_5, var_18_6)
				local var_18_15 = var_18_14

				if var_18_13 then
					return var_18_15
				end
			elseif arg_17_0.curSortType_ == 1 then
				local var_18_16, var_18_17 = arg_17_0:RareSorter(var_18_5, var_18_6)
				local var_18_18 = var_18_17

				if var_18_16 then
					return var_18_18
				end

				local var_18_19, var_18_20 = arg_17_0:IDSorter(var_18_5, var_18_6)
				local var_18_21 = var_18_20

				if var_18_19 then
					return var_18_21
				end
			end
		end

		if var_18_5.unlock ~= var_18_6.unlock then
			return var_18_5.unlock > var_18_6.unlock
		end

		if var_18_5.unlock == 0 and var_18_6.unlock == 0 then
			local var_18_22 = var_17_0[HeroCfg[arg_18_0.id].rare]
			local var_18_23 = var_17_0[HeroCfg[arg_18_1.id].rare]
			local var_18_24 = var_18_22 <= var_18_5.piece and 1 or 0
			local var_18_25 = var_18_23 <= var_18_6.piece and 1 or 0

			if var_18_24 ~= var_18_25 then
				return var_18_25 < var_18_24
			end
		end

		if arg_17_0.heroViewProxy_.isSelf then
			local var_18_26 = HeroData:IsFavorite(arg_18_0.id)
			local var_18_27 = HeroData:IsFavorite(arg_18_1.id)

			if var_18_26 ~= var_18_27 and (not var_18_26 or not var_18_27) then
				return var_18_26 ~= false
			end
		end

		if arg_17_0.curSortType_ == 0 then
			local var_18_28, var_18_29 = arg_17_0:FightPowerSorter(var_18_5, var_18_6, arg_18_0.heroViewProxy, arg_18_1.heroViewProxy)
			local var_18_30 = var_18_29

			if var_18_28 then
				return var_18_30
			end

			local var_18_31, var_18_32 = arg_17_0:StarSorter(var_18_5, var_18_6)
			local var_18_33 = var_18_32

			if var_18_31 then
				return var_18_33
			end

			local var_18_34, var_18_35 = arg_17_0:RareSorter(var_18_5, var_18_6)
			local var_18_36 = var_18_35

			if var_18_34 then
				return var_18_36
			end

			local var_18_37, var_18_38 = arg_17_0:LevelSorter(var_18_5, var_18_6)
			local var_18_39 = var_18_38

			if var_18_37 then
				return var_18_39
			end
		elseif arg_17_0.curSortType_ == 1 then
			local var_18_40, var_18_41 = arg_17_0:StarSorter(var_18_5, var_18_6)
			local var_18_42 = var_18_41

			if var_18_40 then
				return var_18_42
			end

			local var_18_43, var_18_44 = arg_17_0:RareSorter(var_18_5, var_18_6)
			local var_18_45 = var_18_44

			if var_18_43 then
				return var_18_45
			end

			local var_18_46, var_18_47 = arg_17_0:FightPowerSorter(var_18_5, var_18_6, arg_18_0.heroViewProxy, arg_18_1.heroViewProxy)
			local var_18_48 = var_18_47

			if var_18_46 then
				return var_18_48
			end

			local var_18_49, var_18_50 = arg_17_0:LevelSorter(var_18_5, var_18_6)
			local var_18_51 = var_18_50

			if var_18_49 then
				return var_18_51
			end
		elseif arg_17_0.curSortType_ == 2 then
			local var_18_52, var_18_53 = arg_17_0:FavorSorter(var_18_5, var_18_6)
			local var_18_54 = var_18_53

			if var_18_52 then
				return var_18_54
			end

			local var_18_55, var_18_56 = arg_17_0:FightPowerSorter(var_18_5, var_18_6, arg_18_0.heroViewProxy, arg_18_1.heroViewProxy)
			local var_18_57 = var_18_56

			if var_18_55 then
				return var_18_57
			end

			local var_18_58, var_18_59 = arg_17_0:StarSorter(var_18_5, var_18_6)
			local var_18_60 = var_18_59

			if var_18_58 then
				return var_18_60
			end

			local var_18_61, var_18_62 = arg_17_0:RareSorter(var_18_5, var_18_6)
			local var_18_63 = var_18_62

			if var_18_61 then
				return var_18_63
			end

			local var_18_64, var_18_65 = arg_17_0:LevelSorter(var_18_5, var_18_6)
			local var_18_66 = var_18_65

			if var_18_64 then
				return var_18_66
			end
		else
			local var_18_67, var_18_68 = arg_17_0:UseTimesSorter(var_18_5, var_18_6)
			local var_18_69 = var_18_68

			if var_18_67 then
				return var_18_69
			end

			local var_18_70, var_18_71 = arg_17_0:FightPowerSorter(var_18_5, var_18_6, arg_18_0.heroViewProxy, arg_18_1.heroViewProxy)
			local var_18_72 = var_18_71

			if var_18_70 then
				return var_18_72
			end

			local var_18_73, var_18_74 = arg_17_0:StarSorter(var_18_5, var_18_6)
			local var_18_75 = var_18_74

			if var_18_73 then
				return var_18_75
			end

			local var_18_76, var_18_77 = arg_17_0:RareSorter(var_18_5, var_18_6)
			local var_18_78 = var_18_77

			if var_18_76 then
				return var_18_78
			end

			local var_18_79, var_18_80 = arg_17_0:LevelSorter(var_18_5, var_18_6)
			local var_18_81 = var_18_80

			if var_18_79 then
				return var_18_81
			end
		end

		return arg_18_0.id > arg_18_1.id
	end)

	if arg_17_0.callback_ ~= nil then
		local var_17_1 = {}

		for iter_17_0, iter_17_1 in ipairs(arg_17_0.displayHeroDataList_) do
			var_17_1[#var_17_1 + 1] = iter_17_1.id
		end

		arg_17_0.callback_(var_17_1, arg_17_0.displayHeroDataList_, arg_17_0.curSortType_)
	end
end

function var_0_0.SetListChangeHandler(arg_19_0, arg_19_1)
	arg_19_0.callback_ = arg_19_1
end

function var_0_0.SetExtraSorter(arg_20_0, arg_20_1)
	arg_20_0.extraSorter_ = arg_20_1
end

function var_0_0.SetIsSelfHero(arg_21_0, arg_21_1)
	arg_21_0.isSelfHero_ = arg_21_1
end

function var_0_0.RenderFilterBtn(arg_22_0)
	if arg_22_0.filterColorController_ then
		if CommonFilterData:AtLeastOneChoose(Filter_Root_Define.Hero_Filter_List.filter_id) then
			arg_22_0.filterColorController_:SetSelectedState("orange")
		else
			arg_22_0.filterColorController_:SetSelectedState("normal")
		end
	end
end

function var_0_0.OnEnter(arg_23_0, arg_23_1)
	arg_23_0.heroViewProxy_ = arg_23_1

	arg_23_0:InitDropdownData()
	arg_23_0:RegistEventListener(COMMON_FILTER_OK, handler(arg_23_0, arg_23_0.RefreshSort))
	arg_23_0:RenderFilterBtn()
end

function var_0_0.OnExit(arg_24_0)
	arg_24_0:RemoveAllEventListener()
end

function var_0_0.FightPowerSorter(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0
	local var_25_1

	if arg_25_1.tempID and arg_25_1.tempID ~= 0 then
		var_25_0 = TempHeroData:GetBattlePower(arg_25_1.tempID)
	else
		var_25_0 = arg_25_0.heroSorter_:GetHeroPower(arg_25_1, handler(arg_25_3, arg_25_3.GetBattlePower))
	end

	if arg_25_2.tempID and arg_25_2.tempID ~= 0 then
		var_25_1 = TempHeroData:GetBattlePower(arg_25_2.tempID)
	else
		var_25_1 = arg_25_0.heroSorter_:GetHeroPower(arg_25_2, handler(arg_25_4, arg_25_4.GetBattlePower))
	end

	if var_25_0 ~= var_25_1 then
		if arg_25_0.curOrder_ == "desc" then
			return true, var_25_1 < var_25_0
		else
			return true, var_25_0 < var_25_1
		end
	end

	return false, false
end

function var_0_0.StarSorter(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1.star ~= arg_26_2.star then
		if arg_26_0.curOrder_ == "desc" then
			return true, arg_26_1.star > arg_26_2.star
		else
			return true, arg_26_1.star < arg_26_2.star
		end
	end

	return false, false
end

function var_0_0.UnlockSorter(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1.unlock ~= arg_27_2.unlock then
		if arg_27_0.curOrder_ == "desc" then
			return true, arg_27_1.unlock > arg_27_2.unlock
		else
			return true, arg_27_1.unlock < arg_27_2.unlock
		end
	end

	return false, false
end

function var_0_0.IDSorter(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1.id ~= arg_28_2.id then
		if arg_28_0.curOrder_ == "desc" then
			return true, arg_28_1.id > arg_28_2.id
		else
			return true, arg_28_1.id < arg_28_2.id
		end
	end

	return false, false
end

function var_0_0.RareSorter(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = HeroCfg[arg_29_1.id]
	local var_29_1 = HeroCfg[arg_29_2.id]

	if var_29_0.rare ~= var_29_1.rare then
		if arg_29_0.curOrder_ == "desc" then
			return true, var_29_0.rare > var_29_1.rare
		else
			return true, var_29_0.rare < var_29_1.rare
		end
	end

	return false, false
end

function var_0_0.LevelSorter(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1.exp ~= arg_30_2.exp then
		if arg_30_0.curOrder_ == "desc" then
			return true, arg_30_1.exp > arg_30_2.exp
		else
			return true, arg_30_1.exp < arg_30_2.exp
		end
	end

	return false, false
end

function var_0_0.FavorSorter(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[arg_31_1.id][1])
	local var_31_1 = ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[arg_31_2.id][1])

	if var_31_0.lv ~= var_31_1.lv then
		if arg_31_0.curOrder_ == "desc" then
			return true, var_31_0.lv > var_31_1.lv
		else
			return true, var_31_0.lv < var_31_1.lv
		end
	end

	return false, false
end

function var_0_0.UseTimesSorter(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_1.clear_times ~= arg_32_2.clear_times then
		if arg_32_0.curOrder_ == "desc" then
			return true, arg_32_1.clear_times > arg_32_2.clear_times
		else
			return true, arg_32_1.clear_times < arg_32_2.clear_times
		end
	end

	return false, false
end

function var_0_0.Reset(arg_33_0, arg_33_1)
	arg_33_0:RemoveAllListeners()

	arg_33_0.curOrder_ = "desc"

	if arg_33_1 then
		arg_33_0.isAll_, arg_33_0.curSortType_, arg_33_0.curSortRace_, arg_33_0.curAttackType_, arg_33_0.curEnergyType_ = HeroData:GetSortValue()
	else
		arg_33_0.isAll_ = true
		arg_33_0.curSortType_ = 0
		arg_33_0.curSortRace_ = {}
		arg_33_0.curAttackType_ = {}
		arg_33_0.curEnergyType_ = {}
	end

	arg_33_0.sortTypeDropdown_.value = arg_33_0.curSortType_

	arg_33_0:RefreshDropDownOptions()
	arg_33_0.orderController_:SetSelectedState("desc")
	arg_33_0:AddUIListeners()
end

function var_0_0.Dispose(arg_34_0)
	if arg_34_0.heroSorter_ then
		arg_34_0.heroSorter_:Reset()

		arg_34_0.heroSorter_ = nil
	end

	var_0_0.super.Dispose(arg_34_0)
end

return var_0_0
