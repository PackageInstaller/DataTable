local var_0_0 = class("CommonTaskPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	if arg_1_0.params_.prefab then
		return arg_1_0.params_.prefab
	end

	return "Widget/Common/Pop/CommonTask"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.InitModule(arg_3_0, arg_3_1)
	local var_3_0 = nullable(arg_3_0.constVar, "taskListModule")
	local var_3_1 = arg_3_1 and CommonActivityTaskListModule or CommonTaskListModule

	if var_3_0 and var_3_0.class ~= var_3_1 then
		var_3_0:Dispose()

		var_3_0 = nil
	end

	if var_3_0 == nil then
		local var_3_2 = arg_3_0.taskListModule_ or arg_3_0.m_taskList or arg_3_0.gameObject_

		arg_3_0.constVar.taskListModule = var_3_1.New(var_3_2)
	end
end

function var_0_0.InitContext(arg_4_0)
	arg_4_0.constVar = {
		taskIdList = {}
	}

	arg_4_0:InitModule(arg_4_0.params_.activityId)
end

function var_0_0.BuildContext(arg_5_0)
	arg_5_0.data = {
		activityId = arg_5_0.params_.activityId,
		taskType = arg_5_0.params_.taskType
	}
end

function var_0_0.Init(arg_6_0)
	arg_6_0:BindCfgUI()
	arg_6_0:InitContext()
	arg_6_0:AddUIListener()
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:BuildContext()
	arg_7_0.constVar.taskListModule:OnEnter()

	if arg_7_0.data.activityId then
		arg_7_0.constVar.taskListModule:RenderView(arg_7_0.data.activityId)
	elseif arg_7_0.data.taskType then
		arg_7_0.constVar.taskListModule:RenderTypeTaskList(arg_7_0.data.taskType)
	end
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0.constVar.taskListModule:OnExit()
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	arg_9_0.constVar.taskListModule:Dispose()
	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.AddUIListener(arg_10_0)
	local var_10_0 = arg_10_0.backBtn_ or arg_10_0.m_mask

	if var_10_0 then
		arg_10_0:AddBtnListener(var_10_0, nil, function()
			arg_10_0:Back()
		end)
	end
end

function var_0_0.Cacheable(arg_12_0)
	return false
end

function var_0_0.OnExitInput(arg_13_0)
	JumpTools.Back()

	return true
end

return var_0_0
