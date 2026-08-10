local var_0_0 = class("ActivityPushBoxRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10AnniversaryQuestPopup"
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

	arg_4_0.clearCon_ = ControllerUtil.GetController(arg_4_0.transform_, "clear")
	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, ActivityPushBoxRewardItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:Refresh(arg_5_0.list_[arg_5_1])
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.receiveBtn_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_6_0.list_) do
			local var_8_1 = iter_8_1.id
			local var_8_2 = AssignmentCfg[var_8_1]

			if iter_8_1.complete_flag == 0 and var_8_2.need <= iter_8_1.progress then
				table.insert(var_8_0, var_8_1)
			end
		end

		TaskAction:SubmitTaskList(var_8_0)
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.activityID_ = arg_9_0.params_.activityID
	arg_9_0.taskActivityID_ = ActivityConst.ACTIVITY_2_10_PUSH_BOX_TASK

	arg_9_0:RefreshTask()
	arg_9_0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(arg_9_0, arg_9_0.RefreshTask))
end

function var_0_0.RefreshTask(arg_10_0)
	arg_10_0.list_ = TaskData2:GetActivityTaskSortList(arg_10_0.taskActivityID_)

	arg_10_0.scrollHelper_:StartScroll(#arg_10_0.list_)

	local var_10_0 = arg_10_0.list_[1]

	if var_10_0 then
		local var_10_1 = var_10_0.id
		local var_10_2 = AssignmentCfg[var_10_1]

		if var_10_0.complete_flag == 0 and var_10_2.need <= var_10_0.progress then
			arg_10_0.clearCon_:SetSelectedState("true")
		else
			arg_10_0.clearCon_:SetSelectedState("false")
		end
	else
		arg_10_0.clearCon_:SetSelectedState("false")
	end
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.scrollHelper_:GetItemList()) do
		iter_11_1:OnExit()
	end
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.scrollHelper_:GetItemList()) do
		iter_12_1:Dispose()
	end

	arg_12_0.scrollHelper_:Dispose()
	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
