local var_0_0 = class("ChapterPlot19RewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/Chapter19SectionRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListGo_, ChapterPlot19RewardPanel)
	arg_3_0.OnSubmitTaskHandler_ = handler(arg_3_0, arg_3_0.OnSubmitTask)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.chapterID_ = tonumber(arg_4_0.params_.chapterID)
	arg_4_0.taskIDList_ = AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_19]

	local var_4_0 = arg_4_0:GetSortIndex()

	arg_4_0.uiList_:StartScroll(#AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_19], var_4_0)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_4_0.OnSubmitTaskHandler_)
end

function var_0_0.OnExit(arg_5_0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_5_0.OnSubmitTaskHandler_)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.OnSubmitTaskHandler_ = nil

	var_0_0.super.Dispose(arg_6_0)
	arg_6_0.uiList_:Dispose()

	arg_6_0.uiList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.taskIDList_[arg_9_1]

	arg_9_2:SetData(arg_9_1, var_9_0)
end

function var_0_0.OnSubmitTask(arg_10_0)
	arg_10_0.uiList_:Refresh()
end

function var_0_0.GetSortIndex(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.taskIDList_) do
		local var_11_0 = AssignmentCfg[iter_11_1]

		if TaskData2:GetTaskProgress(iter_11_1) >= var_11_0.need and not TaskData2:GetTaskComplete(iter_11_1) then
			return iter_11_0
		end
	end

	for iter_11_2, iter_11_3 in ipairs(arg_11_0.taskIDList_) do
		local var_11_1 = AssignmentCfg[iter_11_3]

		if TaskData2:GetTaskProgress(iter_11_3) < var_11_1.need then
			return iter_11_2
		end
	end

	return 1
end

return var_0_0
