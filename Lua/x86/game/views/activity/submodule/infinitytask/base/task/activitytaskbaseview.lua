local var_0_0 = class("ActivityTaskBaseView", ReduxView)

function var_0_0.GetAssetName(arg_1_0)
	return "UI/VersionUI/OsirisUI/OsirisTaskContent"
end

function var_0_0.GetTaskClass(arg_2_0)
	return ActivityTaskBaseItem
end

function var_0_0.Ctor(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = Asset.Load(arg_3_0:GetAssetName())

	arg_3_0.gameObject_ = Object.Instantiate(var_3_0, arg_3_1.transform)
	arg_3_0.transform_ = arg_3_0.gameObject_.transform

	arg_3_0:BindCfgUI()

	arg_3_0.activityID_ = arg_3_2
	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.uiList_, arg_3_0:GetTaskClass())
	arg_3_0.osirisTaskUpdateHandler_ = handler(arg_3_0, arg_3_0.OsirisTaskUpdate)

	arg_3_0:OnEnter()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.scrollHelper_:StartScroll(#TaskData2:GetActivityTaskSortList(arg_4_0.activityID_))
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, arg_4_0.osirisTaskUpdateHandler_)

	arg_4_0.stopTime_ = ActivityData:GetActivityData(arg_4_0.activityID_).stopTime

	arg_4_0:AddTimer()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:StopTimer()
	manager.notify:RemoveListener(OSIRIS_TASK_UPDATE, arg_5_0.osirisTaskUpdateHandler_)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.osirisTaskUpdateHandler_ = nil

	arg_6_0.scrollHelper_:Dispose()
	Object.Destroy(arg_6_0.gameObject_)

	arg_6_0.transform_ = nil
	arg_6_0.gameObject_ = nil
end

function var_0_0.RefreshItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = TaskData2:GetActivityTaskSortList(arg_7_0.activityID_)[arg_7_1].id

	arg_7_2:SetData(var_7_0)
end

function var_0_0.Show(arg_8_0, arg_8_1)
	if arg_8_0.gameObject_.activeSelf == arg_8_1 then
		return
	end

	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.OsirisTaskUpdate(arg_9_0)
	arg_9_0.scrollHelper_:StartScroll(#TaskData2:GetActivityTaskSortList(arg_9_0.activityID_))
end

function var_0_0.AddTimer(arg_10_0)
	if manager.time:GetServerTime() >= arg_10_0.stopTime_ then
		arg_10_0.textTime_.text = GetTips("TIME_OVER")

		ShowTips("TIME_OVER")
		arg_10_0:Back()

		return
	end

	arg_10_0.textTime_.text = manager.time:GetLostTimeStr(arg_10_0.stopTime_)
	arg_10_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_10_0.stopTime_ then
			arg_10_0:StopTimer()

			arg_10_0.textTime_.text = GetTips("TIME_OVER")

			ShowTips("TIME_OVER")
			arg_10_0:Back()

			return
		end

		arg_10_0.textTime_.text = manager.time:GetLostTimeStr(arg_10_0.stopTime_)
	end, 1, -1)

	arg_10_0.timer_:Start()
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

return var_0_0
