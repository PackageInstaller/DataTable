local var_0_0 = class("SandPlayQuestRewardPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com/SandPlay_Com_rewardPopUI"
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

	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.taskList_, SandPlayQuestRewardItem)
	arg_4_0.oneClickController_ = arg_4_0.controllers_:GetController("oneclick")
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.taskIDList_[arg_5_1])
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.backBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.oneClickBtn_, nil, function()
		local var_8_0 = arg_6_0:GetCanRewardTask()

		TaskAction:SubmitTaskList(var_8_0)
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.taskIDList_ = arg_9_0.params_.taskIDList

	arg_9_0:RefreshUI()
	arg_9_0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(arg_9_0, arg_9_0.RefreshUI))
end

function var_0_0.RefreshUI(arg_10_0)
	table.sort(arg_10_0.taskIDList_, function(arg_11_0, arg_11_1)
		local var_11_0 = TaskData2:GetTaskComplete(arg_11_0)
		local var_11_1 = TaskData2:GetTaskComplete(arg_11_1)
		local var_11_2 = TaskData2:GetTaskProgress(arg_11_0) >= AssignmentCfg[arg_11_0].need
		local var_11_3 = TaskData2:GetTaskProgress(arg_11_1) >= AssignmentCfg[arg_11_1].need

		if var_11_0 ~= var_11_1 then
			return var_11_1
		end

		if var_11_2 ~= var_11_3 then
			return var_11_2
		end

		return arg_11_0 < arg_11_1
	end)
	arg_10_0.uiList_:StartScroll(#arg_10_0.taskIDList_)
	arg_10_0.oneClickController_:SetSelectedState(tostring(not table.isEmpty(arg_10_0:GetCanRewardTask())))
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.GetCanRewardTask(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0.taskIDList_) do
		if iter_13_1 then
			local var_13_1 = TaskData2:GetTaskComplete(iter_13_1)

			if TaskData2:GetTaskProgress(iter_13_1) >= AssignmentCfg[iter_13_1].need and not var_13_1 then
				table.insert(var_13_0, iter_13_1)
			end
		end
	end

	return var_13_0
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.uiList_ then
		arg_14_0.uiList_:Dispose()

		arg_14_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
