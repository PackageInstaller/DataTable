local var_0_0 = class("OperationMultiItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.typeStateController_ = arg_3_0.controller_:GetController("type")
end

function var_0_0.RefreshActMulti(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0, var_4_1 = ActivityMultiRewardData:GetCountByActivityID(arg_4_2)

	arg_4_0.multipleTxt_.text = string.format(GetTips("DOUBLE_REWARD_DESC"), var_4_0, var_4_1)
	arg_4_0.ratioTxt_.text = arg_4_1 / 100

	local var_4_2 = ActivityData:GetActivityData(arg_4_2)

	arg_4_0.endTimeTxt_.text = manager.time:STimeDescS(var_4_2.stopTime, "!%Y/%m/%d %H:%M")
	arg_4_0.multiTimeRefresh_ = ActivityMultiRewardData:GetTimeByActivityID(arg_4_2)

	if manager.time:GetServerTime() >= arg_4_0.multiTimeRefresh_ then
		arg_4_0.refreshTimeTxt_.text = string.format(GetTips("REFRESH_LOST_TIME"), 1 .. GetTips("SECOND"))
	else
		arg_4_0.refreshTimeTxt_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(arg_4_0.multiTimeRefresh_))
	end

	arg_4_0.typeStateController_:SetSelectedState("normal")
	arg_4_0:AddTimer(arg_4_0.multiTimeRefresh_)
end

function var_0_0.AddTimer(arg_5_0, arg_5_1)
	if arg_5_0.timer_ then
		arg_5_0.timer_:Stop()

		arg_5_0.timer_ = nil
	end

	if arg_5_0.timer_ == nil then
		arg_5_0.timer_ = Timer.New(function()
			if manager.time:GetServerTime() >= arg_5_1 then
				arg_5_0.refreshTimeTxt_.text = string.format(GetTips("REFRESH_LOST_TIME"), 1 .. GetTips("SECOND"))

				manager.notify:Invoke(MULT_TIMES_UPDATE)

				if arg_5_0.timer_ then
					arg_5_0.timer_:Stop()

					arg_5_0.timer_ = nil
				end
			else
				arg_5_0.refreshTimeTxt_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(arg_5_1))
			end
		end, 1, -1)

		arg_5_0.timer_:Start()
	end
end

function var_0_0.RefreshRegressionMulti(arg_7_0)
	local var_7_0, var_7_1, var_7_2 = RegressionDataNew:GetMultipleValue()

	arg_7_0.multipleTxt_.text = string.format(GetTips("NEW_REGRESSION_DOUBLE_REWARD_DESC"), var_7_0, var_7_1)
	arg_7_0.ratioTxt_.text = var_7_2 / 100

	arg_7_0.typeStateController_:SetSelectedState("return")

	local var_7_3 = RegressionDataNew:GetRegressionEndTime()

	arg_7_0.endTimeTxt_.text = manager.time:STimeDescS(var_7_3, "!%Y/%m/%d %H:%M")
end

function var_0_0.OnExit(arg_8_0)
	if arg_8_0.timer_ then
		arg_8_0.timer_:Stop()

		arg_8_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.timer_ then
		arg_9_0.timer_:Stop()

		arg_9_0.timer_ = nil
	end

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
