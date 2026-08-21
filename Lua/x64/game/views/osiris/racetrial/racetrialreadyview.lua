local var_0_0 = class("RaceTrialReadyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return RaceTrialTools.GetReadyUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.customScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.CustomIndexItem), arg_4_0.customListGo_, CustomBox)
	arg_4_0.customDesScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.CustomDesIndexItem), arg_4_0.customDesListGo_, CustomDesItem)
end

function var_0_0.CustomIndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.customTable_.all[arg_5_1]
	local var_5_1 = arg_5_0:GetSelectCustom(var_5_0)

	arg_5_2:RefreshUI(var_5_0, arg_5_0.customTable_[var_5_0], var_5_1)
	arg_5_2:RegisterClickListener(function(arg_6_0)
		local var_6_0 = ActivityAffixPoolCfg[arg_6_0].affix[1]

		if arg_5_0:GetSelectCustom(var_6_0) ~= arg_6_0 then
			arg_5_0:SetSelectCustom(var_6_0, arg_6_0)
		else
			arg_5_0:SetSelectCustom(var_6_0)
		end

		arg_5_2:RefreshUI(var_6_0, arg_5_0.customTable_[var_6_0], arg_5_0:GetSelectCustom(var_6_0))
		arg_5_0:CalculatePoint()
		arg_5_0:RefreshDesList(false, arg_6_0)
	end)
end

function var_0_0.CustomDesIndexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.customSelectList_[arg_7_1]
	local var_7_1 = ActivityAffixPoolCfg[var_7_0].affix

	arg_7_2:RefreshUI(var_7_1)
end

function var_0_0.AddUIListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.battleBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_8_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		RaceTrialAction:SaveCustomList(arg_8_0.activityID_, arg_8_0.customSelectList_)
		arg_8_0:Go("/sectionSelectHero", {
			section = arg_8_0.activityID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.RACE_TRIAL,
			forceRace = ActivityRaceTrialCfg[arg_8_0.activityID_].race,
			activityID = arg_8_0.params_.activityID
		})
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.activityID_ = arg_10_0.params_.activityID
	arg_10_0.mainActivityID_ = arg_10_0.params_.mainActivityID
	arg_10_0.customSelectList_ = RaceTrialData:GetCustomList(arg_10_0.activityID_)

	arg_10_0:CreatCustomTable()
	arg_10_0:CreatCustomSelectTable()
	arg_10_0:RefreshUI()
end

function var_0_0.CreatCustomTable(arg_11_0)
	local var_11_0 = ActivityRaceTrialCfg[arg_11_0.activityID_].pool

	arg_11_0.customTable_ = {
		all = {}
	}

	local var_11_1

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_2 = ActivityAffixPoolCfg[iter_11_1]

		if var_11_2 then
			if not arg_11_0.customTable_[var_11_2.affix[1]] then
				arg_11_0.customTable_[var_11_2.affix[1]] = {}

				table.insert(arg_11_0.customTable_.all, var_11_2.affix[1])
			end

			table.insert(arg_11_0.customTable_[var_11_2.affix[1]], iter_11_1)
		end
	end
end

function var_0_0.CreatCustomSelectTable(arg_12_0)
	local var_12_0

	arg_12_0.customSelectTable_ = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.customSelectList_) do
		local var_12_1 = ActivityAffixPoolCfg[iter_12_1]

		arg_12_0.customSelectTable_[var_12_1.affix[1]] = iter_12_1
	end
end

function var_0_0.GetSelectCustom(arg_13_0, arg_13_1)
	if arg_13_0.customSelectTable_[arg_13_1] then
		return arg_13_0.customSelectTable_[arg_13_1]
	end

	return nil
end

function var_0_0.SetSelectCustom(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.customSelectTable_[arg_14_1]

	if var_14_0 then
		table.remove(arg_14_0.customSelectList_, table.indexof(arg_14_0.customSelectList_, var_14_0))
	end

	if arg_14_2 then
		arg_14_0.customSelectTable_[arg_14_1] = arg_14_2

		table.insert(arg_14_0.customSelectList_, arg_14_2)
	else
		arg_14_0.customSelectTable_[arg_14_1] = nil
	end
end

function var_0_0.RefreshUI(arg_15_0)
	arg_15_0:CalculatePoint()
	arg_15_0:RefreshDesList(true)
	arg_15_0.customScrollHelper_:StartScroll(#arg_15_0.customTable_.all)
end

function var_0_0.CalculatePoint(arg_16_0)
	local var_16_0
	local var_16_1 = ActivityRaceTrialCfg[arg_16_0.activityID_].base_point

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.customSelectList_) do
		var_16_1 = var_16_1 + ActivityAffixPoolCfg[iter_16_1].point
	end

	arg_16_0.pointText_.text = string.format("<color=#FE972E>%d</color>", var_16_1)
end

function var_0_0.RefreshDesList(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 then
		arg_17_0.customDesScrollHelper_:StartScroll(#arg_17_0.customSelectList_)
	else
		local var_17_0 = table.indexof(arg_17_0.customSelectList_, arg_17_2)

		if var_17_0 then
			arg_17_0.customDesScrollHelper_:StartScroll(#arg_17_0.customSelectList_, var_17_0)
		else
			arg_17_0.customDesScrollHelper_:StartScrollByPosition(#arg_17_0.customSelectList_, arg_17_0.customDesScrollHelper_:GetScrolledPosition())
		end
	end
end

function var_0_0.OnTop(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistHomeCallBack(function()
		RaceTrialAction:SaveCustomList(arg_18_0.activityID_, arg_18_0.customSelectList_)
		arg_18_0:Go("/home", nil, nil, true)
	end)
	manager.windowBar:RegistBackCallBack(function()
		RaceTrialAction:SaveCustomList(arg_18_0.activityID_, arg_18_0.customSelectList_)
		arg_18_0:Back()
	end)
end

function var_0_0.OnExit(arg_21_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0:RemoveAllListeners()
	arg_22_0.customScrollHelper_:Dispose()
	arg_22_0.customDesScrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
