local var_0_0 = class("AffixSelectFirstRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/DarkFlameUI/DFQualsDrilUI/DFQualsDrillFirstRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uiListGo_, AffixSelectRewardItemView)
	arg_5_0.btnController_ = arg_5_0.btnCon_:GetController("state")
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, nil, arg_6_0.idList_[arg_6_1], true)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnReceiveAll_, nil, function()
		ActivityAffixSelectAction.GetAllFirsrtRewards(arg_7_0.allRewards_)
	end)
end

function var_0_0.AddEventListeners(arg_10_0)
	arg_10_0:RegistEventListener(AFFIX_SELECT_FIRST_BONUS_UPDATE, function()
		arg_10_0:UpdateList()
	end)
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.OnBehind(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_14_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.activityId = arg_15_0.params_.affixActivityId

	arg_15_0:AddEventListeners()
	arg_15_0:UpdateList()
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.UpdateList(arg_17_0)
	arg_17_0.idList_ = deepClone(ActivityCfg[arg_17_0.activityId].sub_activity_list)

	table.sort(arg_17_0.idList_, function(arg_18_0, arg_18_1)
		local var_18_0 = ActivityAffixSelectData:GetSubActivityData(arg_18_0) or {
			clearState = 1
		}
		local var_18_1 = ActivityAffixSelectData:GetSubActivityData(arg_18_1) or {
			clearState = 1
		}

		if var_18_0.clearState ~= var_18_1.clearState then
			return var_18_0.clearState % 3 > var_18_1.clearState % 3
		end

		return arg_18_0 < arg_18_1
	end)
	arg_17_0.uiList_:StartScroll(#arg_17_0.idList_)

	arg_17_0.allRewards_ = ActivityAffixSelectData:GetAllFirstRewards()

	arg_17_0.btnController_:SetSelectedState(#arg_17_0.allRewards_ <= 0 and "hide" or "show")
end

function var_0_0.OnMainHomeViewTop(arg_19_0)
	return
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.uiList_ then
		arg_20_0.uiList_:Dispose()

		arg_20_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
