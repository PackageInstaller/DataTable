local var_0_0 = class("ActivityMemoryTaskItem", ReduxView)

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

	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		local var_5_0 = arg_4_0.cfg_.activity_jump_id

		if ActivityData:GetActivityData(var_5_0).startTime > manager.time:GetServerTime() then
			ShowTips("SOLO_NOT_OPEN")

			return
		end

		JumpTools.OpenPageByJump("activityMemoryPop", {
			activityId = arg_4_0.activityID_,
			id = arg_4_0.id_
		})
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.id_ = arg_7_1
	arg_7_0.activityID_ = arg_7_2
	arg_7_0.taskActivityID_ = ActivityMemoryTools.GetTaskActivityID(arg_7_0.activityID_)
	arg_7_0.cfg_ = SpringFestivalMemoryCfg[arg_7_0.id_]
	arg_7_0.taskID_ = arg_7_0.cfg_.task_id
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = AssignmentCfg[arg_8_0.taskID_]
	local var_8_1 = TaskData2:GetTask(arg_8_0.taskID_)

	if not var_8_1 or var_8_1.progress < var_8_0.need then
		arg_8_0.stateCon_:SetSelectedState("lock")
	elseif var_8_1.complete_flag < 1 then
		arg_8_0.stateCon_:SetSelectedState("get")
	else
		arg_8_0.stateCon_:SetSelectedState("normal")
	end
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
