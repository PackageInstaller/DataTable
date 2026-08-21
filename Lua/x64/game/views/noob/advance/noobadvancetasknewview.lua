local var_0_0 = import("game.views.noob.advance.NoobAdvanceTaskView")
local var_0_1 = class("NoobAdvanceTaskNewView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activitynewbie/NewbieAdvanceTaskUI_new"
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.tree_ = LuaTree.New(arg_2_0.uiTreeGo_)
	arg_2_0.taskList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexTaskItem), arg_2_0.uiListGo_, NoobAdvanceTaskItem)
	arg_2_0.conditionList_ = {}
	arg_2_0.allReceiveBtnState_ = ControllerUtil.GetController(arg_2_0.transform_, "allReceive")
	arg_2_0.progressController_ = arg_2_0.controllerExcollection_:GetController("progress")
end

function var_0_1.UpdateNextType(arg_3_0)
	arg_3_0.curTaskTypeCfg_ = ActivityNewbieTools.GetAdvanceTaskCfg(arg_3_0.taskType_)
	arg_3_0.nextTypeIndex_ = arg_3_0.curTaskTypeCfg_.index + 1
	arg_3_0.nextType_ = NoobVersionCfg[arg_3_0.curTaskTypeCfg_.versionID].noob_advance_task_type[arg_3_0.nextTypeIndex_]
end

function var_0_1.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	local var_4_0, var_4_1 = ActivityNewbieTools.CheckAdvanceTaskOpen()

	if arg_4_0.taskType_ ~= var_4_1 then
		arg_4_0.taskType_ = var_4_1

		arg_4_0:UpdateNextType()

		if getData("noobAdvanceTask", string.format("need_level_enough_tips_%s", arg_4_0.taskType_)) == 1 == true then
			ShowTips("NOOB_ADVANCE_TASK_LEVEL_ENOUGH")
			saveData("noobAdvanceTask", string.format("need_level_enough_tips_%s", arg_4_0.taskType_), 0)
		end

		arg_4_0:GreatTree()
	end

	if arg_4_0.params_.isEnter == true then
		local var_4_2, var_4_3 = arg_4_0:GetSelectIndex()

		arg_4_0.tree_:SelectItem(var_4_2, var_4_3)

		arg_4_0.params_.isEnter = false
	elseif arg_4_0.params_.groupIndex and arg_4_0.params_.itemIndex then
		arg_4_0.tree_:SelectItem(arg_4_0.params_.groupIndex, arg_4_0.params_.itemIndex)
	else
		arg_4_0.tree_:SelectItem(1, 1)
	end

	arg_4_0:RefreshUI()

	arg_4_0.onSubmitTaskResponseHandle_ = handler(arg_4_0, arg_4_0.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_4_0.onSubmitTaskResponseHandle_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_4_0.onSubmitTaskResponseHandle_)
	arg_4_0:BindRedPoint()
end

function var_0_1.OnExit(arg_5_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, arg_5_0.onSubmitTaskResponseHandle_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_5_0.onSubmitTaskResponseHandle_)

	arg_5_0.params_.groupIndex = arg_5_0.curSelectedGroupIndex_
	arg_5_0.params_.itemIndex = arg_5_0.curSelectedItemIndex_
	arg_5_0.curSlectedItemID_ = nil

	arg_5_0:UnbindRedPoint()
end

function var_0_1.OnTop(arg_6_0)
	if arg_6_0.needShowTips_ then
		arg_6_0.needShowTips_ = false

		ShowTips(arg_6_0.tipsStr_)
	end
end

function var_0_1.RefreshUI(arg_7_0)
	arg_7_0:RefreshProgress()
end

function var_0_1.RefreshProgress(arg_8_0)
	if arg_8_0.nextType_ then
		arg_8_0.nextTypeTitle_.text = GetTips(NoobVersionCfg[arg_8_0.curTaskTypeCfg_.versionID].noob_advance_task_title[arg_8_0.nextTypeIndex_])

		for iter_8_0 = 1, 2 do
			if not arg_8_0.conditionList_[iter_8_0] then
				local var_8_0 = Object.Instantiate(arg_8_0.conditionItemGo_, arg_8_0.conditionContent_)

				arg_8_0.conditionList_[iter_8_0] = NoobAdvanceConditionItem.New(var_8_0)
			end

			arg_8_0.conditionList_[iter_8_0]:SetData(iter_8_0, arg_8_0.taskType_, arg_8_0.nextTypeIndex_)
		end
	end

	arg_8_0.curTypeTitle_.text = GetTips(NoobVersionCfg[arg_8_0.curTaskTypeCfg_.versionID].noob_advance_task_title[arg_8_0.curTaskTypeCfg_.index])

	arg_8_0.progressController_:SetSelectedState(tostring(arg_8_0.curTaskTypeCfg_.index))
end

function var_0_1.Dispose(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.conditionList_) do
		iter_9_1:Dispose()
	end

	arg_9_0.conditionList_ = nil

	var_0_1.super.Dispose(arg_9_0)
end

function var_0_1.OnTaskUpdate(arg_10_0)
	local var_10_0 = false

	if TaskTools:IsCompletedAllNoobAdvanceTask(arg_10_0.taskType_) then
		local var_10_1 = true
		local var_10_2 = arg_10_0.curTaskTypeCfg_.versionID
		local var_10_3 = NoobVersionCfg[var_10_2].noob_advance_task_open
		local var_10_4 = PlayerData:GetPlayerInfo().userLevel
		local var_10_5 = var_10_3[arg_10_0.nextTypeIndex_]

		if arg_10_0.nextType_ then
			if var_10_5 <= var_10_4 then
				var_10_0 = true
				var_10_1 = true
			else
				var_10_1 = false

				saveData("noobAdvanceTask", string.format("need_level_enough_tips_%s", arg_10_0.nextType_), 1)
			end
		end

		if var_10_1 then
			local var_10_6 = GetTips(NoobVersionCfg[var_10_2].noob_advance_task_title[arg_10_0.curTaskTypeCfg_.index])

			arg_10_0.needShowTips_ = true
			arg_10_0.tipsStr_ = string.format(GetTips("NOOB_ADVANCE_TASK_COMPLETE"), var_10_6)
		else
			arg_10_0.needShowTips_ = true
			arg_10_0.tipsStr_ = string.format(GetTips("NOOB_ADVANCE_TASK_LEVEL_NOTENOUGH"), var_10_5)
		end
	end

	if not var_10_0 then
		arg_10_0.taskDataList_ = TaskTools:GetNoobAdvanceTaskSortList(arg_10_0.taskType_, arg_10_0.curSlectedItemID_)

		arg_10_0.taskList_:StartScroll(#arg_10_0.taskDataList_)
		arg_10_0:RefreshReceiveBtn()
	else
		arg_10_0:UnbindRedPoint()

		arg_10_0.taskType_ = arg_10_0.nextType_

		arg_10_0:UpdateNextType()
		arg_10_0:GreatTree()
		arg_10_0:BindRedPoint()

		local var_10_7, var_10_8 = arg_10_0:GetSelectIndex()

		arg_10_0.curSlectedItemID_ = nil

		arg_10_0.tree_:SelectItem(var_10_7, var_10_8)
		arg_10_0:RefreshProgress()
	end
end

return var_0_1
