local var_0_0 = class("ActivityRaceRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.taskItemList_ = {}
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.activityID_ = arg_4_1
	arg_4_0.accumulateTaskIDList_ = ActivityRaceCfg[arg_4_1].task_list_id
	arg_4_0.taskIDList_ = ActivityRaceCfg[arg_4_1].task_list
	arg_4_0.title_.text = GetI18NText(ActivityRaceCfg[arg_4_1].map_name)

	local var_4_0 = 1

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.accumulateTaskIDList_) do
		if arg_4_0.taskItemList_[var_4_0] == nil then
			arg_4_0.taskItemList_[var_4_0] = ActivityRaceTaskItem.New(arg_4_0.taskItemTemplate_, arg_4_0.taskPanel_)
		end

		arg_4_0.taskItemList_[var_4_0]:SetData(iter_4_1, arg_4_0.activityID_, true)

		var_4_0 = var_4_0 + 1
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0.taskIDList_) do
		if arg_4_0.taskItemList_[var_4_0] == nil then
			arg_4_0.taskItemList_[var_4_0] = ActivityRaceTaskItem.New(arg_4_0.taskItemTemplate_, arg_4_0.taskPanel_)
		end

		arg_4_0.taskItemList_[var_4_0]:SetData(iter_4_3, arg_4_0.activityID_, false)

		var_4_0 = var_4_0 + 1
	end
end

function var_0_0.Dispose(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.taskItemList_) do
		iter_5_1:Dispose()
	end

	arg_5_0.taskItemList_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

return var_0_0
