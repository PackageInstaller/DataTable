local var_0_0 = import("game.views.recall.pages.RecallPageBase")
local var_0_1 = class("RecallSystemTaskView", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.list_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.listGo_, RecallSystemMissionItem)
end

function var_0_1.IndexItem(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = ActivityRecallData:GetDataByPara("taskList")

	arg_3_2:SetData(var_3_0[arg_3_1])
end

function var_0_1.OnTop(arg_4_0)
	return
end

function var_0_1.UpdateView(arg_5_0)
	ActivityRecallData:UpdateTaskData()
	ActivityRecallData:TaskSort()

	local var_5_0 = ActivityRecallData:GetDataByPara("taskList")

	arg_5_0.list_:StartScroll(#var_5_0)

	arg_5_0.activityTimeTxt_.text = ActivityRecallData:GetDataByPara("taskTime")
end

function var_0_1.OnEnter(arg_6_0)
	arg_6_0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(arg_6_0, arg_6_0.UpdateView))
	arg_6_0:UpdateView()
end

function var_0_1.OnExit(arg_7_0)
	arg_7_0:RemoveAllEventListener()

	arg_7_0.handler_ = nil
end

function var_0_1.Hide(arg_8_0)
	var_0_1.super.Hide(arg_8_0)
end

function var_0_1.Dispose(arg_9_0)
	arg_9_0:RemoveAllEventListener()

	if arg_9_0.list_ then
		arg_9_0.list_:Dispose()

		arg_9_0.list_ = nil
	end

	var_0_1.super.Dispose(arg_9_0)
end

return var_0_1
