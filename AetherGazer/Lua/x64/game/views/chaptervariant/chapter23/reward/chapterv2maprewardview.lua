local var_0_0 = class("ChapterV2MapRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Xuheng_PlotMap/XuhengStarExchangepopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, ChapterV2MapRewardPanel)
	arg_3_0.OnSubmitTaskHandler_ = handler(arg_3_0, arg_3_0.OnSubmitTask)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.chapterClientID_ = tonumber(arg_4_0.params_.chapterClientID)

	local var_4_0 = ChapterV2MapTools.GetChapterTaskType(arg_4_0.chapterClientID_)

	arg_4_0.taskIDList_ = AssignmentCfg.get_id_list_by_type[var_4_0] or {}

	local var_4_1 = arg_4_0:GetSortIndex()

	arg_4_0.uiList_:StartScroll(#arg_4_0.taskIDList_, var_4_1)
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
	arg_7_0:AddBtnListener(arg_7_0.buttonClose_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.OnExitInput(arg_9_0)
	JumpTools.Back()

	return true
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.taskIDList_[arg_10_1]

	arg_10_2:SetData(arg_10_1, var_10_0)
end

function var_0_0.OnSubmitTask(arg_11_0)
	TaskRedPoint:UpdateChapterV2TaskRedTip()
	arg_11_0.uiList_:Refresh()
end

function var_0_0.GetSortIndex(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.taskIDList_) do
		local var_12_0 = AssignmentCfg[iter_12_1]

		if TaskData2:GetTaskProgress(iter_12_1) >= var_12_0.need and not TaskData2:GetTaskComplete(iter_12_1) then
			return iter_12_0
		end
	end

	for iter_12_2, iter_12_3 in ipairs(arg_12_0.taskIDList_) do
		local var_12_1 = AssignmentCfg[iter_12_3]

		if TaskData2:GetTaskProgress(iter_12_3) < var_12_1.need then
			return iter_12_2
		end
	end

	return 1
end

return var_0_0
