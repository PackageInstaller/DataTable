local var_0_0 = class("NewServerTaskPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/NewServer/NewServerQuestListUI")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_1)

	arg_1_0.gameObject_ = var_1_1
	arg_1_0.transform_ = var_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.taskTypeList_ = {
		TaskConst.TASK_TYPE.NEW_SERVER_DAILY,
		TaskConst.TASK_TYPE.NEW_SERVER_WEEK,
		TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE
	}
	arg_3_0.clickItemHandler_ = handler(arg_3_0, arg_3_0.SwitchPage)
	arg_3_0.switchItemList_ = {}

	local var_3_0 = arg_3_0.switchPanelTrans_.childCount

	for iter_3_0 = 1, var_3_0 do
		local var_3_1 = arg_3_0.switchPanelTrans_:GetChild(iter_3_0 - 1).gameObject

		arg_3_0.switchItemList_[iter_3_0] = NewServerTaskSwitchItem.New(var_3_1, arg_3_0.taskTypeList_[iter_3_0])

		arg_3_0.switchItemList_[iter_3_0]:SetClickCallBack(arg_3_0.clickItemHandler_)
	end

	arg_3_0.itemList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.uiListGo_, NewServerTaskItem)
	arg_3_0.allReceiveBtnState_ = arg_3_0.controllerEx_:GetController("allReceive")
end

function var_0_0.UpdateBar(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(arg_5_0.activityID_) then
			return
		end

		TaskAction:SubmitTaskList(TaskTools:GetFinishTaskIds(arg_5_0.taskType_), arg_5_0.taskType_)
	end)
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.OnEnter(arg_8_0)
	manager.redPoint:bindUIandKey(arg_8_0.switchItemList_[1].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_DAILY))
	manager.redPoint:bindUIandKey(arg_8_0.switchItemList_[2].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_WEEK))
	manager.redPoint:bindUIandKey(arg_8_0.switchItemList_[3].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE))
end

function var_0_0.OnExit(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.switchItemList_[1].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_DAILY))
	manager.redPoint:unbindUIandKey(arg_9_0.switchItemList_[2].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_WEEK))
	manager.redPoint:unbindUIandKey(arg_9_0.switchItemList_[3].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE))
	ActivityNewServerTools.SetLastTaskScrollPos(arg_9_0.itemList_:GetScrolledPosition())

	arg_9_0.taskType_ = nil
end

function var_0_0.SetIsBack(arg_10_0, arg_10_1)
	arg_10_0.isBack_ = arg_10_1
end

function var_0_0.SetData(arg_11_0, arg_11_1)
	arg_11_0.activityID_ = arg_11_1

	if not arg_11_0.isBack_ then
		arg_11_0:SwitchPage(arg_11_0.taskTypeList_[1])
	else
		arg_11_0.isBack_ = false
		arg_11_0.targetScrollPos_ = ActivityNewServerTools.GetLastTaskScrollPos()

		arg_11_0:SwitchPage(ActivityNewServerTools.GetLastSelectTaskType())
	end
end

function var_0_0.SwitchPage(arg_12_0, arg_12_1)
	if arg_12_0.taskType_ == arg_12_1 then
		return
	end

	arg_12_0.taskType_ = arg_12_1

	ActivityNewServerTools.SetLastSelectTaskType(arg_12_0.taskType_)

	arg_12_0.taskIDList_ = TaskData2:GetTypedTaskSortListCommonFilter(arg_12_0.taskType_)
	arg_12_0.finishList_ = TaskTools:GetFinishTaskIds(arg_12_0.taskType_)
	arg_12_0.maxRewardNum_ = 0

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.taskIDList_) do
		local var_12_0 = iter_12_1.id

		if not AssignmentCfg[var_12_0] then
			print(var_12_0)
		else
			local var_12_1 = #AssignmentCfg[var_12_0].reward

			arg_12_0.maxRewardNum_ = var_12_1 > arg_12_0.maxRewardNum_ and var_12_1 or arg_12_0.maxRewardNum_
		end
	end

	if arg_12_0.targetScrollPos_ then
		arg_12_0.itemList_:StartScrollByPosition(#arg_12_0.taskIDList_, arg_12_0.targetScrollPos_)

		arg_12_0.targetScrollPos_ = nil
	else
		arg_12_0.itemList_:StartScroll(#arg_12_0.taskIDList_)
	end

	arg_12_0:RefreshRecivedAll()
	arg_12_0:RefreshSelect()
end

function var_0_0.Refresh(arg_13_0)
	arg_13_0.taskIDList_ = TaskData2:GetTypedTaskSortListCommonFilter(arg_13_0.taskType_)
	arg_13_0.finishList_ = TaskTools:GetFinishTaskIds(arg_13_0.taskType_)

	arg_13_0.itemList_:Refresh()
	arg_13_0:RefreshRecivedAll()
end

function var_0_0.RefreshRecivedAll(arg_14_0)
	arg_14_0.allReceiveBtnState_:SetSelectedState(#arg_14_0.finishList_ > 0 and "true" or "false")
end

function var_0_0.RefreshSelect(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.switchItemList_) do
		iter_15_1:RefreshSelect(arg_15_0.taskType_)
	end
end

function var_0_0.indexItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.taskIDList_[arg_16_1].id

	arg_16_2:SetData(var_16_0, arg_16_0.maxRewardNum_)
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.itemList_:Dispose()

	arg_17_0.itemList_ = nil

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.switchItemList_) do
		iter_17_1:Dispose()
	end

	arg_17_0.switchItemList_ = nil

	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.RefreshScroll(arg_18_0)
	arg_18_0.taskIDList_ = TaskData2:GetTypedTaskSortListCommonFilter(arg_18_0.taskType_)

	local var_18_0 = arg_18_0.itemList_:GetScrolledPosition()

	arg_18_0.itemList_:StartScrollWithoutAnimator(#arg_18_0.taskIDList_, var_18_0)
end

function var_0_0.OnTaskListChange(arg_19_0)
	arg_19_0:RefreshScroll()

	arg_19_0.finishList_ = TaskTools:GetFinishTaskIds(arg_19_0.taskType_)

	arg_19_0:RefreshRecivedAll()
end

return var_0_0
