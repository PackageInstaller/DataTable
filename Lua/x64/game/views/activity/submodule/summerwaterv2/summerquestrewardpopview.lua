local var_0_0 = class("SummerQuestRewardPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_Com/SummerUI_3_4_SwimsuitQuestUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.listGo_, SummeQuestRewardItem)
	arg_4_0.onClickController_ = arg_4_0.controller_:GetController("oneclick")
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.activityIds_[arg_5_1])
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.backBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.onClickBtn_, nil, function()
		local var_8_0 = arg_6_0:GetCanRewardTask()

		TaskAction:SubmitTaskList(var_8_0)
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.activityIds_ = arg_9_0.params_.activityIDList

	arg_9_0:RefreshUI()
	arg_9_0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(arg_9_0, arg_9_0.RefreshUI))
end

function var_0_0.OnWaterResult(arg_10_0)
	if arg_10_0.activityIds_[1] and AssignmentCfg[arg_10_0.activityIds_[1]] and AssignmentCfg[arg_10_0.activityIds_[1]].type == TaskConst.TASK_TYPE.SUMMER_WATER_WEEKLY then
		local var_10_0 = {}
		local var_10_1 = ActivitySummerWaterData:GetActivityID()

		if not var_10_1 then
			ShowTips("TIME_OVER")
			ActivityTools.JumpBackToActivityMainViewByTheme(ActivityCfg[ActivitySummerWaterData:GetMainActivityID()].activity_theme)

			return
		end

		local var_10_2 = AssignmentCfg.get_id_list_by_activity_id[var_10_1]

		for iter_10_0, iter_10_1 in ipairs(var_10_2) do
			if not table.indexof(var_10_0, iter_10_1) then
				table.insert(var_10_0, iter_10_1)
			end
		end

		arg_10_0.activityIds_ = var_10_0

		arg_10_0:RefreshUI()
	end
end

function var_0_0.RefreshUI(arg_11_0)
	table.sort(arg_11_0.activityIds_, function(arg_12_0, arg_12_1)
		local var_12_0 = TaskData2:GetTaskComplete(arg_12_0)
		local var_12_1 = TaskData2:GetTaskComplete(arg_12_1)
		local var_12_2 = TaskData2:GetTaskProgress(arg_12_0) >= AssignmentCfg[arg_12_0].need
		local var_12_3 = TaskData2:GetTaskProgress(arg_12_1) >= AssignmentCfg[arg_12_1].need

		if var_12_0 ~= var_12_1 then
			return var_12_1
		end

		if var_12_2 ~= var_12_3 then
			return var_12_2
		end

		return arg_12_0 < arg_12_1
	end)
	arg_11_0.uiList_:StartScroll(#arg_11_0.activityIds_)
	arg_11_0.onClickController_:SetSelectedState(tostring(not table.isEmpty(arg_11_0:GetCanRewardTask())))
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.GetCanRewardTask(arg_14_0)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(arg_14_0.activityIds_) do
		if iter_14_1 then
			local var_14_1 = TaskData2:GetTaskComplete(iter_14_1)

			if TaskData2:GetTaskProgress(iter_14_1) >= AssignmentCfg[iter_14_1].need and not var_14_1 then
				table.insert(var_14_0, iter_14_1)
			end
		end
	end

	return var_14_0
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.uiList_ then
		arg_15_0.uiList_:Dispose()

		arg_15_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
