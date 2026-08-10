local var_0_0 = class("NoobAdvanceTaskView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activitynewbie/NewbieAdvanceTaskUI_old"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.tree_ = LuaTree.New(arg_4_0.uiTreeGo_)
	arg_4_0.taskList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexTaskItem), arg_4_0.uiListGo_, NoobAdvanceTaskItem)

	local var_4_0 = ActivityNewbieTools.GetVersionID()

	arg_4_0.taskType_ = NoobVersionCfg[var_4_0].noob_advance_task_type[1]

	arg_4_0:GreatTree()

	arg_4_0.noobTaskUpdateHandler_ = handler(arg_4_0, arg_4_0.OnTaskUpdate)
	arg_4_0.allReceiveBtnState_ = ControllerUtil.GetController(arg_4_0.transform_, "allReceive")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.receiveAllBtn_, nil, function()
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(arg_5_0.taskDataList_) do
			if iter_6_1.progress >= AssignmentCfg[iter_6_1.id].need and iter_6_1.complete_flag < 1 then
				var_6_0[#var_6_0 + 1] = iter_6_1.id
			else
				break
			end
		end

		TaskAction:SubmitTaskList(var_6_0, TaskConst.TASK_TYPE.NOOB_ADVANCE)
	end)
end

function var_0_0.onSubmitTaskResponse(arg_7_0)
	arg_7_0:OnTaskUpdate()
end

function var_0_0.OnEnter(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if arg_8_0.params_.isEnter == true then
		local var_8_0, var_8_1 = arg_8_0:GetSelectIndex()

		arg_8_0.tree_:SelectItem(var_8_0, var_8_1)

		arg_8_0.params_.isEnter = false
	elseif arg_8_0.params_.groupIndex and arg_8_0.params_.itemIndex then
		arg_8_0.tree_:SelectItem(arg_8_0.params_.groupIndex, arg_8_0.params_.itemIndex)
	else
		arg_8_0.tree_:SelectItem(1, 1)
	end

	manager.notify:RegistListener(NEWBIE_TASK_UPDATE, arg_8_0.noobTaskUpdateHandler_)

	arg_8_0.onSubmitTaskResponseHandle_ = handler(arg_8_0, arg_8_0.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_8_0.onSubmitTaskResponseHandle_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_8_0.onSubmitTaskResponseHandle_)
	arg_8_0:BindRedPoint()
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(NEWBIE_TASK_UPDATE, arg_9_0.noobTaskUpdateHandler_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_9_0.onSubmitTaskResponseHandle_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_9_0.onSubmitTaskResponseHandle_)

	arg_9_0.params_.groupIndex = arg_9_0.curSelectedGroupIndex_
	arg_9_0.params_.itemIndex = arg_9_0.curSelectedItemIndex_
	arg_9_0.curSlectedItemID_ = nil

	arg_9_0:UnbindRedPoint()
end

function var_0_0.IndexTaskItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_0.taskDataList_[arg_10_1].id, arg_10_0.maxRewardNum_)
end

function var_0_0.OnGroupSelect(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	arg_11_0.curSelectedGroupIndex_ = arg_11_1
end

function var_0_0.OnItemSelect(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_0.curSlectedItemID_ == arg_12_2 then
		return
	end

	arg_12_0.curSelectedItemIndex_ = arg_12_1
	arg_12_0.curSlectedItemID_ = arg_12_2
	arg_12_0.taskDataList_ = TaskTools:GetNoobAdvanceTaskSortList(arg_12_0.taskType_, arg_12_2)
	arg_12_0.maxRewardNum_ = 0

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.taskDataList_) do
		local var_12_0 = iter_12_1.id
		local var_12_1 = #AssignmentCfg[var_12_0].reward

		arg_12_0.maxRewardNum_ = var_12_1 > arg_12_0.maxRewardNum_ and var_12_1 or arg_12_0.maxRewardNum_
	end

	arg_12_0.taskList_:StartScroll(#arg_12_0.taskDataList_)
	arg_12_0:RefreshReceiveBtn()
end

function var_0_0.RefreshReceiveBtn(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.taskDataList_) do
		if iter_13_1.progress >= AssignmentCfg[iter_13_1.id].need and iter_13_1.complete_flag < 1 then
			arg_13_0.allReceiveBtnState_:SetSelectedState("true")

			return
		end
	end

	arg_13_0.allReceiveBtnState_:SetSelectedState("false")
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.tree_:Dispose()

	arg_14_0.tree_ = nil

	arg_14_0.taskList_:Dispose()

	arg_14_0.taskList_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.GreatTree(arg_15_0)
	local var_15_0 = ActivityNewbieTools.GetVersionID()
	local var_15_1 = ActivityNewbieTools.GetAdvanceTaskCfg(arg_15_0.taskType_)
	local var_15_2 = NoobVersionCfg[var_15_0].noob_advance_task_phase[var_15_1.index]
	local var_15_3 = arg_15_0.tree_

	var_15_3:SetSelectedHandler(nil, nil)

	local var_15_4 = UITreeData.New()

	arg_15_0.groupCfgList_ = NoobAdvanceTaskPhaseListCfg[var_15_2].phase_list

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.groupCfgList_) do
		local var_15_5 = UITreeGroupData.New()

		var_15_5.id = iter_15_0
		var_15_5.text = GetTips(iter_15_1[1])

		local var_15_6 = iter_15_1[2]

		for iter_15_2, iter_15_3 in ipairs(var_15_6) do
			local var_15_7 = iter_15_3[3] or 0

			if var_15_7 == 0 or not SystemCfg[var_15_7] or SystemCfg[var_15_7].system_hide == 0 then
				local var_15_8 = UITreeItemData.New()

				var_15_8.id = iter_15_3[1]
				var_15_8.text = GetTips(iter_15_3[2])

				var_15_5.itemDatas:Add(var_15_8)
			end
		end

		var_15_4.groupDatas:Add(var_15_5)
	end

	var_15_3:SetData(var_15_4)
	var_15_3:SetSelectedHandler(handler(arg_15_0, arg_15_0.OnGroupSelect), handler(arg_15_0, arg_15_0.OnItemSelect))
end

function var_0_0.GetSelectIndex(arg_16_0)
	local var_16_0 = 1
	local var_16_1 = 1

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.groupCfgList_) do
		var_16_0 = iter_16_0

		for iter_16_2, iter_16_3 in ipairs(iter_16_1[2]) do
			var_16_1 = iter_16_2

			local var_16_2 = TaskTools:GetNoobAdvanceTaskSortList(arg_16_0.taskType_, iter_16_3[1])

			for iter_16_4, iter_16_5 in pairs(var_16_2) do
				if AssignmentCfg[iter_16_5.id].need > iter_16_5.progress or iter_16_5.complete_flag == 0 then
					return var_16_0, var_16_1
				end
			end
		end
	end

	return var_16_0, var_16_1
end

function var_0_0.OnTaskUpdate(arg_17_0)
	arg_17_0.taskDataList_ = TaskTools:GetNoobAdvanceTaskSortList(arg_17_0.taskType_, arg_17_0.curSlectedItemID_)

	arg_17_0.taskList_:StartScroll(#arg_17_0.taskDataList_)
	arg_17_0:RefreshReceiveBtn()
end

function var_0_0.BindRedPoint(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.groupCfgList_) do
		manager.redPoint:bindUIandKey(arg_18_0.tree_:GetGroupRedPointContainerById(iter_18_0), string.format("%s_%d_%d", RedPointConst.NOOB_ADVANCE, arg_18_0.taskType_, iter_18_0))

		for iter_18_2, iter_18_3 in ipairs(iter_18_1[2]) do
			local var_18_0 = iter_18_3[3] or 0

			if var_18_0 == 0 or not SystemCfg[var_18_0] or SystemCfg[var_18_0].system_hide == 0 then
				manager.redPoint:bindUIandKey(arg_18_0.tree_:GetItemRedPointContainerById(iter_18_0, iter_18_3[1]), string.format("%s_%d_%d_%d", RedPointConst.NOOB_ADVANCE, arg_18_0.taskType_, iter_18_0, iter_18_3[1]))
			end
		end
	end
end

function var_0_0.UnbindRedPoint(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.groupCfgList_) do
		manager.redPoint:unbindUIandKey(arg_19_0.tree_:GetGroupRedPointContainerById(iter_19_0), string.format("%s_%d_%d", RedPointConst.NOOB_ADVANCE, arg_19_0.taskType_, iter_19_0))

		for iter_19_2, iter_19_3 in ipairs(iter_19_1[2]) do
			local var_19_0 = iter_19_3[3] or 0

			if var_19_0 == 0 or not SystemCfg[var_19_0] or SystemCfg[var_19_0].system_hide == 0 then
				manager.redPoint:unbindUIandKey(arg_19_0.tree_:GetItemRedPointContainerById(iter_19_0, iter_19_3[1]), string.format("%s_%d_%d_%d", RedPointConst.NOOB_ADVANCE, arg_19_0.taskType_, iter_19_0, iter_19_3[1]))
			end
		end
	end
end

return var_0_0
