local var_0_0 = class("SpringWelfareTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rewardItems_ = {}
	arg_3_0.rewardList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.rewardListGo_, SpringWelfareTaskRewardItem)
	arg_3_0.typeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.getBtn_, nil, function()
		if arg_4_0.handler_ then
			arg_4_0.handler_(arg_4_0, arg_4_0.taskID_)
		end
	end)
end

function var_0_0.OnTaskListChange(arg_6_0)
	arg_6_0:RefreshUI()
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.cfg_.reward

	arg_7_2:SetData(var_7_0[arg_7_1])
end

function var_0_0.SetClickHandler(arg_8_0, arg_8_1)
	arg_8_0.handler_ = arg_8_1
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.taskID_ = arg_9_1
	arg_9_0.activityID_ = arg_9_2
	arg_9_0.cfg_ = AssignmentCfg[arg_9_1]

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshReward()
	arg_10_0:RefreshTask()
end

function var_0_0.RefreshReward(arg_11_0)
	local var_11_0 = arg_11_0.cfg_.reward

	arg_11_0.rewardList_:StartScroll(#var_11_0)
end

function var_0_0.RefreshTask(arg_12_0)
	local var_12_0 = TaskData2:GetTask(arg_12_0.taskID_)

	arg_12_0.descText_.text = arg_12_0.cfg_.desc

	local var_12_1 = var_12_0.progress > arg_12_0.cfg_.need and arg_12_0.cfg_.need or var_12_0.progress

	arg_12_0.progressText_.text = string.format("%d/%d", var_12_1, arg_12_0.cfg_.need)
	arg_12_0.slider_.value = var_12_1 / arg_12_0.cfg_.need

	if arg_12_0.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		arg_12_0.typeCon_:SetSelectedState("normal")
	else
		arg_12_0.typeCon_:SetSelectedState("challenge")
	end

	local var_12_2 = var_12_0.complete_flag >= 1
	local var_12_3 = var_12_0.progress >= arg_12_0.cfg_.need

	if var_12_2 then
		arg_12_0.stateCon_:SetSelectedState("received")
	elseif var_12_3 then
		arg_12_0.stateCon_:SetSelectedState("complete")
	else
		arg_12_0.stateCon_:SetSelectedState("unfinish")
	end
end

function var_0_0.OnExit(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.rewardList_:Dispose()
	arg_14_0.super.Dispose(arg_14_0)
end

return var_0_0
