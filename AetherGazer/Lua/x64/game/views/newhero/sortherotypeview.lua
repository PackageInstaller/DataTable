local var_0_0 = class("SortHeroTypeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Hero/HeroScreeningPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.allCon_ = ControllerUtil.GetController(arg_4_0.allBtn_.gameObject.transform, "select")
	arg_4_0.toggle_ = {}

	for iter_4_0 = 0, 1 do
		arg_4_0.toggle_[iter_4_0] = arg_4_0["tgl_" .. iter_4_0]
	end

	arg_4_0.raceBtn_ = {}
	arg_4_0.raceCon_ = {}

	for iter_4_1, iter_4_2 in ipairs(RaceEffectCfg.all) do
		arg_4_0.raceBtn_[iter_4_1] = arg_4_0["raceBtn_" .. iter_4_1]
		arg_4_0.raceCon_[iter_4_1] = ControllerUtil.GetController(arg_4_0.raceBtn_[iter_4_1].gameObject.transform, "select")
	end

	arg_4_0.attackBtn_ = {}
	arg_4_0.attackCon_ = {}
	arg_4_0.attackType_ = {
		HeroConst.HERO_ATTACK_TYPE.PYISICS,
		HeroConst.HERO_ATTACK_TYPE.WIND,
		HeroConst.HERO_ATTACK_TYPE.FLAME,
		HeroConst.HERO_ATTACK_TYPE.THUNDER,
		HeroConst.HERO_ATTACK_TYPE.DARK,
		HeroConst.HERO_ATTACK_TYPE.LIGHT,
		HeroConst.HERO_ATTACK_TYPE.FREEZE,
		HeroConst.HERO_ATTACK_TYPE.WATER,
		HeroConst.HERO_ATTACK_TYPE.MIX,
		HeroConst.HERO_ATTACK_TYPE.RANDOM
	}

	for iter_4_3, iter_4_4 in ipairs(arg_4_0.attackType_) do
		arg_4_0.attackBtn_[iter_4_3] = arg_4_0["attackBtn_" .. iter_4_3]
		arg_4_0.attackCon_[iter_4_3] = ControllerUtil.GetController(arg_4_0.attackBtn_[iter_4_3].gameObject.transform, "select")
	end

	arg_4_0.energyBtn_ = {}
	arg_4_0.energyCon_ = {}
	arg_4_0.energyType_ = {
		HeroConst.HERO_CHARGE_TYPE.RAGE,
		HeroConst.HERO_CHARGE_TYPE.ENERGY,
		HeroConst.HERO_CHARGE_TYPE.TRACES,
		HeroConst.HERO_CHARGE_TYPE.DIVINE_GRACE,
		HeroConst.HERO_CHARGE_TYPE.NONE
	}

	for iter_4_5, iter_4_6 in ipairs(arg_4_0.energyType_) do
		arg_4_0.energyBtn_[iter_4_5] = arg_4_0["energyBtn_" .. iter_4_5]
		arg_4_0.energyCon_[iter_4_5] = ControllerUtil.GetController(arg_4_0.energyBtn_[iter_4_5].gameObject.transform, "select")
	end
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.canelBtn_, nil, function()
		HeroData:ResetSortValue()
		manager.notify:CallUpdateFunc(HERO_SORT, true, 0, {}, {}, {})
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		manager.notify:CallUpdateFunc(HERO_SORT, arg_5_0.isAll_, arg_5_0.curSortType_, arg_5_0.curSortRace_, arg_5_0.curAttackType_, arg_5_0.curEnergyType_)
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.allBtn_, nil, function()
		arg_5_0.isAll_ = true
		arg_5_0.curSortRace_ = {}
		arg_5_0.curAttackType_ = {}
		arg_5_0.curEnergyType_ = {}

		arg_5_0:RefreshBtnState()
	end)

	for iter_5_0 = 0, 1 do
		arg_5_0:AddToggleListener(arg_5_0.toggle_[iter_5_0], function(arg_10_0)
			if arg_10_0 then
				arg_5_0.curSortType_ = iter_5_0
			end
		end)
	end

	for iter_5_1, iter_5_2 in ipairs(RaceEffectCfg.all) do
		arg_5_0:AddBtnListener(arg_5_0.raceBtn_[iter_5_1], nil, function()
			local var_11_0 = table.indexof(arg_5_0.curSortRace_, iter_5_2)

			if var_11_0 then
				table.remove(arg_5_0.curSortRace_, var_11_0)
				arg_5_0.raceCon_[iter_5_1]:SetSelectedState("off")
				arg_5_0:IsNeedAll()
			else
				table.insert(arg_5_0.curSortRace_, iter_5_2)
				arg_5_0.raceCon_[iter_5_1]:SetSelectedState("on")
				arg_5_0:SetAllOff()
			end
		end)
	end

	for iter_5_3, iter_5_4 in ipairs(arg_5_0.attackType_) do
		arg_5_0:AddBtnListener(arg_5_0.attackBtn_[iter_5_3], nil, function()
			local var_12_0 = arg_5_0.attackType_[iter_5_3]
			local var_12_1 = table.indexof(arg_5_0.curAttackType_, var_12_0)

			if var_12_1 then
				table.remove(arg_5_0.curAttackType_, var_12_1)
				arg_5_0.attackCon_[iter_5_3]:SetSelectedState("off")
				arg_5_0:IsNeedAll()
			else
				table.insert(arg_5_0.curAttackType_, var_12_0)
				arg_5_0.attackCon_[iter_5_3]:SetSelectedState("on")
				arg_5_0:SetAllOff()
			end
		end)
	end

	for iter_5_5, iter_5_6 in ipairs(arg_5_0.energyType_) do
		arg_5_0:AddBtnListener(arg_5_0.energyBtn_[iter_5_5], nil, function()
			local var_13_0 = arg_5_0.energyType_[iter_5_5]
			local var_13_1 = table.indexof(arg_5_0.curEnergyType_, var_13_0)

			if var_13_1 then
				table.remove(arg_5_0.curEnergyType_, var_13_1)
				arg_5_0.energyCon_[iter_5_5]:SetSelectedState("off")
				arg_5_0:IsNeedAll()
			else
				table.insert(arg_5_0.curEnergyType_, var_13_0)
				arg_5_0.energyCon_[iter_5_5]:SetSelectedState("on")
				arg_5_0:SetAllOff()
			end
		end)
	end
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.isAll_ = arg_14_0.params_.isAll
	arg_14_0.curSortType_ = arg_14_0.params_.sortType or 0
	arg_14_0.curSortRace_ = arg_14_0.params_.sortRace and deepClone(arg_14_0.params_.sortRace) or {}
	arg_14_0.curAttackType_ = arg_14_0.params_.attackType and deepClone(arg_14_0.params_.attackType) or {}
	arg_14_0.curEnergyType_ = arg_14_0.params_.energyType and deepClone(arg_14_0.params_.energyType) or {}

	arg_14_0:RefreshBtnState()
end

function var_0_0.RefreshBtnState(arg_15_0)
	arg_15_0.allCon_:SetSelectedState(arg_15_0.isAll_ and "on" or "off")

	arg_15_0.toggle_[arg_15_0.curSortType_].isOn = true

	for iter_15_0, iter_15_1 in ipairs(RaceEffectCfg.all) do
		local var_15_0 = table.indexof(arg_15_0.curSortRace_, iter_15_1)

		arg_15_0.raceCon_[iter_15_0]:SetSelectedState(var_15_0 and "on" or "off")
	end

	for iter_15_2, iter_15_3 in ipairs(arg_15_0.attackType_) do
		local var_15_1 = table.indexof(arg_15_0.curAttackType_, iter_15_3)

		arg_15_0.attackCon_[iter_15_2]:SetSelectedState(var_15_1 and "on" or "off")
	end

	for iter_15_4, iter_15_5 in ipairs(arg_15_0.energyType_) do
		local var_15_2 = table.indexof(arg_15_0.curEnergyType_, iter_15_5)

		arg_15_0.energyCon_[iter_15_4]:SetSelectedState(var_15_2 and "on" or "off")
	end
end

function var_0_0.SetAllOff(arg_16_0)
	arg_16_0.isAll_ = false

	arg_16_0.allCon_:SetSelectedState("off")
end

function var_0_0.IsNeedAll(arg_17_0)
	if #arg_17_0.curSortRace_ <= 0 and #arg_17_0.curAttackType_ <= 0 and #arg_17_0.curEnergyType_ <= 0 then
		arg_17_0.isAll_ = true

		arg_17_0.allCon_:SetSelectedState("on")
	end
end

function var_0_0.OnExit(arg_18_0)
	return
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
