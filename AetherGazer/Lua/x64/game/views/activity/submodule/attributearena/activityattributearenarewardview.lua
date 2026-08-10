local var_0_0 = class("ActivityAttributeArenaRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return AttributeArenaTools.GetRewardUI(arg_1_0.params_.task_activity_id)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.taskUpdateHandler_ = handler(arg_3_0, arg_3_0.RefreshScroll)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.m_list, ActivityAttributeArenaRewardItem)
	arg_4_0.recevieAllController = ControllerUtil.GetController(arg_4_0.transform_, "recevieAll")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_mask, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_recevieBtn, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(arg_5_0._taskIDList) do
			if iter_7_1.progress < AssignmentCfg[iter_7_1.id].need or iter_7_1.complete_flag >= 1 then
				break
			end

			var_7_0[#var_7_0 + 1] = iter_7_1.id
		end

		TaskAction:SubmitTaskList(var_7_0)
	end)
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.activity_id = arg_9_0.params_.task_activity_id
	arg_9_0._taskIDList = TaskData2:GetActivityTaskSortList(arg_9_0.activity_id)

	arg_9_0.list:StartScroll(#arg_9_0._taskIDList)
	arg_9_0:RegistEventListener(OSIRIS_TASK_UPDATE, arg_9_0.taskUpdateHandler_)
	arg_9_0:RefreshReceiveBtn()
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.RefreshScroll(arg_11_0)
	arg_11_0._taskIDList = TaskData2:GetActivityTaskSortList(arg_11_0.activity_id)

	local var_11_0 = arg_11_0.list:GetScrolledPosition()

	arg_11_0.list:StartScrollWithoutAnimator(#arg_11_0._taskIDList, var_11_0)
	arg_11_0:RefreshReceiveBtn()
end

function var_0_0.RefreshReceiveBtn(arg_12_0)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._taskIDList) do
		if iter_12_1.progress >= AssignmentCfg[iter_12_1.id].need and iter_12_1.complete_flag < 1 then
			var_12_0 = 1

			break
		end
	end

	arg_12_0.recevieAllController:SetSelectedIndex(var_12_0 == 1 and 1 or 0)
end

function var_0_0.indexItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0._taskIDList[arg_13_1]

	arg_13_2:SetData(var_13_0, arg_13_1)
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.list:Dispose()

	arg_14_0.taskUpdateHandler_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.OnTaskListChange(arg_15_0)
	arg_15_0:RefreshScroll()
end

return var_0_0
