local var_0_0 = class("InfinityTaskBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/OsirisUI/OsirisUITaskUI"
end

function var_0_0.GetTaskViewClass(arg_2_0)
	return ActivityTaskBaseView
end

function var_0_0.GetInfinityPoolViewClass(arg_3_0)
	return ActivityInfinityBaseView
end

function var_0_0.GetInfinityPoolItemID(arg_4_0)
	return CurrencyConst.CURRENCY_TYPE_OSIRIS_INFINITY_COIN
end

function var_0_0.GetHelpTips(arg_5_0)
	return "ACTIVITY_OSIRIS_INFINITY_POOL_DESCRIPE"
end

function var_0_0.UIParent(arg_6_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_7_0)
	arg_7_0:BindCfgUI()
	arg_7_0:AddListeners()

	arg_7_0.viewList_ = {}
	arg_7_0.controller_ = {}

	for iter_7_0 = 1, 5 do
		arg_7_0.controller_[iter_7_0] = ControllerUtil.GetController(arg_7_0[string.format("transformTreeItem%s_", iter_7_0)], "lock")
	end

	arg_7_0.refreshTreeItemHandler_ = handler(arg_7_0, arg_7_0.RefreshInfinityBtn)
	arg_7_0.toggleUpdateHandler_ = handler(arg_7_0, arg_7_0.OnToggleUpdate)
	arg_7_0.toggleListView_ = ToggleListView.New(arg_7_0.goToggleList_, {
		0,
		5
	})
end

function var_0_0.OnEnter(arg_8_0)
	manager.notify:RegistListener(OSIRIS_INFINITY_OPEN_CORE_ITEM, arg_8_0.refreshTreeItemHandler_)
	manager.notify:RegistListener(TOGGLE_LIST_UPDATE, arg_8_0.toggleUpdateHandler_)

	for iter_8_0, iter_8_1 in pairs(arg_8_0.viewList_) do
		iter_8_1:OnEnter()
	end

	arg_8_0.toggleListView_:OnEnter()

	if arg_8_0.params_.activityType == OsirisConst.ACTIVITY_TYPE.TASK then
		arg_8_0.toggleListView_:SetSelectOn(1)
	else
		arg_8_0.toggleListView_:SetSelectOn(2, OsirisInfinityPoolData:GetClickPhaseValue(arg_8_0.params_.activityInfinityID))
		arg_8_0:ChangeSelect(2)
	end

	local var_8_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_8_0.params_.activityTaskID)

	manager.redPoint:bindUIandKey(arg_8_0.transformTask_, var_8_0, {
		x = 0,
		y = 0
	})
	arg_8_0:RefreshInfinityBtn()
end

function var_0_0.OnTop(arg_9_0)
	if arg_9_0.curActivityType ~= arg_9_0.params_.activityType then
		if arg_9_0.params_.activityType == OsirisConst.ACTIVITY_TYPE.TASK then
			arg_9_0.toggleListView_:SetSelectOn(1)
		else
			arg_9_0.toggleListView_:SetSelectOn(2, OsirisInfinityPoolData:GetClickPhaseValue(arg_9_0.params_.activityInfinityID))
			arg_9_0:ChangeSelect(2)
		end
	end
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(OSIRIS_INFINITY_OPEN_CORE_ITEM, arg_10_0.refreshTreeItemHandler_)
	manager.notify:RemoveListener(TOGGLE_LIST_UPDATE, arg_10_0.toggleUpdateHandler_)

	local var_10_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_10_0.params_.activityTaskID)

	manager.redPoint:unbindUIandKey(arg_10_0.transformTask_, var_10_0, {
		x = 0,
		y = 0
	})

	for iter_10_0, iter_10_1 in pairs(arg_10_0.viewList_) do
		iter_10_1:OnExit()
	end

	arg_10_0.toggleListView_:OnExit()
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
	arg_11_0.toggleListView_:Dispose()

	arg_11_0.toggleListView_ = nil
	arg_11_0.refreshTreeItemHandler_ = nil
	arg_11_0.toggleUpdateHandler_ = nil

	for iter_11_0, iter_11_1 in pairs(arg_11_0.viewList_) do
		iter_11_1:Dispose()
	end

	arg_11_0.viewList_ = nil
end

function var_0_0.AddListeners(arg_12_0)
	return
end

function var_0_0.RefreshInfinityBtn(arg_13_0)
	local var_13_0 = OsirisInfinityPoolData:GetOpenPhase(arg_13_0.params_.activityInfinityID)

	for iter_13_0 = 1, 5 do
		arg_13_0.controller_[iter_13_0]:SetSelectedState(iter_13_0 <= var_13_0 and "false" or "true")
	end
end

function var_0_0.OnToggleUpdate(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:ChangeSelect(arg_14_1)

	if arg_14_1 == 2 and arg_14_2 == nil then
		arg_14_0.toggleListView_:SetSelectOn(2, OsirisInfinityPoolData:GetClickPhaseValue(arg_14_0.params_.activityInfinityID))

		return
	end

	if arg_14_0.viewList_[arg_14_1] == nil then
		if arg_14_1 == 1 then
			arg_14_0.viewList_[arg_14_1] = arg_14_0:GetTaskViewClass().New(arg_14_0.goContent_, arg_14_0.params_.activityTaskID)
		else
			arg_14_0.viewList_[arg_14_1] = arg_14_0:GetInfinityPoolViewClass().New(arg_14_0.goContent_, arg_14_0.params_.activityInfinityID)
		end
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		arg_14_0:GetInfinityPoolItemID()
	})
	manager.windowBar:SetBarCanAdd(arg_14_0:GetInfinityPoolItemID(), true)
	manager.windowBar:SetGameHelpKey(arg_14_0:GetHelpTips())

	for iter_14_0, iter_14_1 in pairs(arg_14_0.viewList_) do
		iter_14_1:Show(iter_14_0 == arg_14_1)
	end

	if arg_14_2 then
		local var_14_0 = OsirisInfinityPoolData:GetOpenPhase(arg_14_0.params_.activityInfinityID)

		if var_14_0 < arg_14_2 then
			local var_14_1 = OsirisInfinityPoolData:GetClickPhaseValue(arg_14_0.params_.activityInfinityID)

			arg_14_0.toggleListView_:SetSelectOn(2, var_14_0 < var_14_1 and var_14_0 or var_14_1)
			ShowTips("INFINITY_LOCK")

			return
		end

		OsirisInfinityPoolData:SetClickPhaseValue(arg_14_0.params_.activityInfinityID, arg_14_2)
		arg_14_0.viewList_[2]:SetPhase(arg_14_2)
	end
end

function var_0_0.ChangeSelect(arg_15_0, arg_15_1)
	arg_15_0.curActivityType = arg_15_1
	arg_15_0.params_.activityType = arg_15_1
end

return var_0_0
