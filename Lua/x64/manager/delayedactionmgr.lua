local var_0_0 = singletonClass("DelayedActionMgr")

function var_0_0.Ctor(arg_1_0)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.schedule = {}
	arg_2_0.addList = {}

	arg_2_0:StartSchedule()
end

local function var_0_1()
	return LuaForUtil.NowMilliSec * 0.001
end

local function var_0_2(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1.executeTime = arg_4_2 + arg_4_1.delay

	table.insert(arg_4_0.schedule, arg_4_1)
end

function var_0_0.StartSchedule(arg_5_0)
	arg_5_0:StopSchedule()

	arg_5_0.scheduler = FrameTimer.New(function()
		arg_5_0.updateLoopFlag = true

		local var_6_0 = var_0_1()

		for iter_6_0 = #arg_5_0.schedule, 1, -1 do
			local var_6_1 = arg_5_0.schedule[iter_6_0]

			if var_6_0 >= var_6_1.executeTime then
				var_6_1.func()
				table.remove(arg_5_0.schedule, iter_6_0)
			end
		end

		if #arg_5_0.addList > 0 then
			for iter_6_1, iter_6_2 in ipairs(arg_5_0.addList) do
				var_0_2(arg_5_0, iter_6_2, var_6_0)
			end

			arg_5_0.addList = {}
		end

		arg_5_0.updateLoopFlag = nil
	end, 1, -1)

	arg_5_0.scheduler:Start()
end

function var_0_0.StopSchedule(arg_7_0)
	if arg_7_0.scheduler then
		arg_7_0.scheduler:Stop()

		arg_7_0.scheduler = nil
	end
end

function var_0_0.Add(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = {
		func = arg_8_1,
		delay = arg_8_2
	}

	if arg_8_3 or arg_8_0.updateLoopFlag then
		table.insert(arg_8_0.addList, var_8_0)
	else
		var_0_2(arg_8_0, var_8_0, var_0_1())
	end

	return var_8_0
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:StopSchedule()

	arg_9_0.schedule = nil
	arg_9_0.addList = nil
end

return var_0_0
