local var_0_0 = class("SummerChessBoardChessTaskPanel", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.mainActivityID_ = arg_1_3
	arg_1_0.taskActivityID_ = arg_1_4

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.taskItemList_ = {}
	arg_1_0.titleText_.text = ActivityCfg[arg_1_4].remark
	arg_1_0.taskChangedHandler_ = handler(arg_1_0, arg_1_0.OnTaskChanged)

	arg_1_0:OnEnter()
end

function var_0_0.OnEnter(arg_2_0)
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, arg_2_0.taskChangedHandler_)
end

function var_0_0.OnExit(arg_3_0)
	manager.notify:RemoveListener(OSIRIS_TASK_UPDATE, arg_3_0.taskChangedHandler_)
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.taskChangedHandler_ = nil

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.taskItemList_) do
		iter_4_1:Dispose()
	end

	arg_4_0.taskItemList_ = nil

	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.transform = nil
	arg_4_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	return
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = SummerChessBoardData:CallFun("GetTaskIDList", arg_6_0.mainActivityID_, arg_6_0.taskActivityID_)
	local var_6_1 = TaskTools:SortTaskList(var_6_0)

	for iter_6_0 = 1, #var_6_1 do
		if arg_6_0.taskItemList_[iter_6_0] == nil then
			arg_6_0.taskItemList_[iter_6_0] = SummerChessBoardChessTaskItem.New(arg_6_0.item_, arg_6_0.transform_, var_6_1[iter_6_0])

			SetActive(arg_6_0.taskItemList_[iter_6_0].gameObject_, true)
		end

		arg_6_0.taskItemList_[iter_6_0]:SetData(var_6_1[iter_6_0])
	end

	SetActive(arg_6_0.gameObject_, #var_6_1 > 0)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.transform_)
end

function var_0_0.OnTaskChanged(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.GetLocalPosition(arg_8_0)
	return arg_8_0.transform_.localPosition
end

function var_0_0.GetHeight(arg_9_0)
	return arg_9_0.rectTf_.rect.height
end

return var_0_0
