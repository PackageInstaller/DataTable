local var_0_0 = class("UITimeMgr")

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.StartUITimer(arg_2_0)
	arg_2_0.uiTimeRecord_ = {}
	arg_2_0.startEnterTime_ = {}
	arg_2_0.timer_ = Timer.New(handler(arg_2_0, arg_2_0.SendMessage), 60, -1)

	arg_2_0.timer_:Start()
end

function var_0_0.OnEnterRoute(arg_3_0, arg_3_1, arg_3_2)
	if UITimeConst[arg_3_1] or arg_3_2 then
		local var_3_0 = arg_3_2 and arg_3_1 or UITimeConst[arg_3_1]

		if arg_3_0.startEnterTime_[var_3_0] then
			arg_3_0:OnExitRoute(arg_3_1, arg_3_2)
		end

		local var_3_1 = manager.time:GetServerTime()

		arg_3_0.startEnterTime_[var_3_0] = var_3_1
	end
end

function var_0_0.OnEnterStory(arg_4_0, arg_4_1)
	local var_4_0 = "story_" .. arg_4_1

	arg_4_0.startEnterTime_[var_4_0] = manager.time:GetServerTime()
end

function var_0_0.OnExitRoute(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2 and arg_5_1 or UITimeConst[arg_5_1]

	arg_5_0:ExitRecord(var_5_0)
end

function var_0_0.OnExitStory(arg_6_0, arg_6_1)
	local var_6_0 = "story_" .. arg_6_1

	arg_6_0:ExitRecord(var_6_0)
end

function var_0_0.ExitRecord(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.startEnterTime_[arg_7_1]

	if var_7_0 then
		local var_7_1 = manager.time:GetServerTime() - var_7_0

		var_7_1 = var_7_1 > 0 and var_7_1 or 0
		arg_7_0.startEnterTime_[arg_7_1] = nil

		if arg_7_0.uiTimeRecord_[arg_7_1] then
			arg_7_0.uiTimeRecord_[arg_7_1].time = arg_7_0.uiTimeRecord_[arg_7_1].time + var_7_1
		else
			arg_7_0.uiTimeRecord_[arg_7_1] = {
				id = tostring(arg_7_1),
				time = var_7_1
			}
		end
	end
end

function var_0_0.StopTimer(arg_8_0)
	if arg_8_0.timer_ then
		arg_8_0.timer_:Stop()

		arg_8_0.timer_ = nil
	end
end

function var_0_0.SendMessage(arg_9_0)
	if arg_9_0.uiTimeRecord_ and next(arg_9_0.uiTimeRecord_) then
		manager.net:Push(38016, {
			log_list = arg_9_0.uiTimeRecord_
		})
	end

	arg_9_0.uiTimeRecord_ = {}
end

function var_0_0.OnLogout(arg_10_0)
	arg_10_0:SendMessage()
	arg_10_0:StopTimer()

	arg_10_0.uiTimeRecord_ = {}
	arg_10_0.startEnterTime_ = {}
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:OnLogout()
end

return var_0_0
