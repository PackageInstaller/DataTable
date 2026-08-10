local var_0_0 = class("IdolCompetitionRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Competition/IdolCompetitionRewardUI"
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

	arg_4_0.taskLuaList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.taskUIList_, IdolCompetitionRewardItem)
	arg_4_0.recevieAllController_ = ControllerUtil.GetController(arg_4_0.transform_, "recevieAll")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.retBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.recAllBtn_, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(arg_5_0.taskList_) do
			if iter_7_1.progress < AssignmentCfg[iter_7_1.id].need or iter_7_1.complete_flag >= 1 then
				break
			end

			var_7_0[#var_7_0 + 1] = iter_7_1.id
		end

		TaskAction:SubmitTaskList(var_7_0)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	manager.windowBar:SwitchBar({})

	arg_8_0.mainActivityID_ = arg_8_0.params_.activity

	arg_8_0:UpdateView()
	arg_8_0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(arg_8_0, arg_8_0.UpdateView))
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
	arg_9_0:RemoveAllEventListener()
end

function var_0_0.UpdateView(arg_10_0)
	arg_10_0.taskList_ = TaskData2:GetActivityTaskSortList(arg_10_0.mainActivityID_)

	arg_10_0.taskLuaList_:StartScroll(#arg_10_0.taskList_)

	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.taskList_) do
		if iter_10_1.progress >= AssignmentCfg[iter_10_1.id].need and iter_10_1.complete_flag < 1 then
			var_10_0 = 1

			break
		end
	end

	arg_10_0.recevieAllController_:SetSelectedIndex(var_10_0 == 1 and 1 or 0)
end

function var_0_0.indexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.taskList_[arg_11_1]

	arg_11_2:SetData(var_11_0, arg_11_1)
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)

	if arg_12_0.taskLuaList_ then
		arg_12_0.taskLuaList_:Dispose()

		arg_12_0.taskLuaList_ = nil
	end
end

function var_0_0.OnTaskListChange(arg_13_0)
	arg_13_0:UpdateView()
end

return var_0_0
