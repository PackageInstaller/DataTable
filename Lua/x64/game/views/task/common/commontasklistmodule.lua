local var_0_0 = class("CommonTaskListModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.InitContext(arg_2_0)
	arg_2_0.constVar = {
		taskList = {},
		scrollHelper = LuaList.New(handler(arg_2_0, arg_2_0.OnRenderTask), arg_2_0.taskList_ or arg_2_0.m_list, CommonTaskItemModule)
	}
	arg_2_0.RenderType = {
		Type = 2,
		Activity = 1,
		OriginTask = 3,
		None = 0
	}
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.renderContext = {
		taskCount = 0,
		activityId = 0,
		taskType = 0,
		renderType = arg_3_0.RenderType.None
	}
	arg_3_0.constVar.taskList = {}
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitContext()
end

function var_0_0.RegisterTaskListChangedEvent(arg_5_0, arg_5_1)
	arg_5_0.constVar.changeEvent = arg_5_1
end

function var_0_0.GetActivityTaskList(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 < 0 then
		return
	end

	TaskData2:AddActivityTaskToList(arg_6_0, arg_6_1)

	local var_6_0 = ActivityTools.GetAllTaskSubActivityID(arg_6_1)

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		var_0_0.GetActivityTaskList(arg_6_0, iter_6_1, arg_6_2 - 1)
	end
end

function var_0_0.RenderActivityTaskList(arg_7_0, arg_7_1)
	arg_7_0:BuildContext()

	arg_7_0.renderContext.renderType = arg_7_0.RenderType.Activity
	arg_7_0.renderContext.activityId = arg_7_1

	local var_7_0 = {}

	var_0_0.GetActivityTaskList(var_7_0, arg_7_1, 1)
	TaskData2:SortTaskInfo(var_7_0)

	arg_7_0.constVar.taskList = var_7_0
	arg_7_0.renderContext.taskCount = #var_7_0

	arg_7_0:RenderView()
end

function var_0_0.RenderTypeTaskList(arg_8_0, arg_8_1)
	arg_8_0:BuildContext()

	arg_8_0.renderContext.renderType = arg_8_0.RenderType.Type
	arg_8_0.renderContext.taskType = arg_8_1

	local var_8_0 = TaskData2:GetTypedTaskSortList(arg_8_1)

	arg_8_0.constVar.taskList = var_8_0
	arg_8_0.renderContext.taskCount = #var_8_0

	arg_8_0:RenderView()
end

function var_0_0.RenderView(arg_9_0)
	arg_9_0.constVar.scrollHelper:StartScroll(arg_9_0.renderContext.taskCount, 1)
end

function var_0_0.RefreshView(arg_10_0)
	if arg_10_0.renderContext.renderType == arg_10_0.RenderType.Type then
		arg_10_0:RenderTypeTaskList(arg_10_0.renderContext.taskType)
	elseif arg_10_0.renderContext.renderType == arg_10_0.RenderType.Activity then
		arg_10_0:RenderActivityTaskList(arg_10_0.renderContext.activityId)
	end
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		arg_11_0:RefreshView()
		arg_11_0:OnTaskListChanged()
	end)
	arg_11_0:RegistEventListener(ON_TASK_SUBMIT_LIST_RESPONSE, function()
		arg_11_0:RefreshView()
		arg_11_0:OnTaskListChanged()
	end)
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllEventListener()
	arg_15_0.constVar.scrollHelper:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

function var_0_0.OnRenderTask(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.constVar.taskList[arg_16_1].id

	arg_16_2:RefreshTaskItem(var_16_0, arg_16_1)
end

function var_0_0.OnTaskListChanged(arg_17_0)
	local var_17_0 = arg_17_0.constVar.changeEvent

	if var_17_0 then
		var_17_0()
	end
end

return var_0_0
