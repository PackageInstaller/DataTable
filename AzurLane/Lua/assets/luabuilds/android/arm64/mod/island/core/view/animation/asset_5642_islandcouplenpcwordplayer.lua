class = var_0_10000

local var_0_0 = "IslandCoupleNpcWordPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..IslandBaseUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	pg = var_2
	arg_1_0.delayTime = var_2.island_set.couple_word_cd.key_value_int
	arg_1_0.schedule = {}

	return
end

function var_0_1.Play(arg_2_0, arg_2_1)
	table = var_1_10002

	if var_1_10002.contains(arg_2_0.schedule, arg_2_1) then
		return
	end

	table = var_2

	var_2.insert(arg_2_0.schedule, arg_2_1)

	if #arg_2_0.schedule == 1 then
		arg_2_0:Start()
	end

	return
end

function var_0_1.Start(arg_3_0)
	if not arg_3_0.schedule or #arg_3_0.schedule <= 0 then
		return
	end

	local var_3_0 = arg_3_0.schedule[1]

	IslandCoupleNpcWordTask = var_1_10002

	local var_3_1 = var_1_10002.New(var_3_0, arg_3_0:GetView())

	var_2.Execute(var_3_1, var_3_0, function()
		local var_4_0 = arg_3_0

		var_4_0.player = nil
		table = var_4_0

		var_4_0.remove(arg_3_0.schedule, 1)

		local var_4_1 = arg_3_0

		var_0.DelayStart(var_4_1)

		return
	end)

	arg_3_0.player = var_2

	return
end

function var_0_1.DelayStart(arg_5_0)
	arg_5_0:RemoveTimer()

	if #arg_5_0.schedule <= 0 then
		return
	end

	Timer = var_1
	arg_5_0.timer = var_1.New(function()
		local var_6_0 = arg_5_0

		var_0.Start(var_6_0)

		return
	end, arg_5_0.delayTime, 1)

	local var_5_0 = arg_5_0.timer

	var_1.Start(var_5_0)

	return
end

function var_0_1.RemoveTimer(arg_7_0)
	if arg_7_0.timer then
		local var_7_0 = arg_7_0.timer

		var_1.Stop(var_7_0)

		arg_7_0.timer = nil
	end

	return
end

function var_0_1.Stop(arg_8_0, arg_8_1)
	table = var_1_10002

	if var_1_10002.contains(arg_8_0.schedule, arg_8_1) then
		table = var_2

		var_2.removebyvalue(arg_8_0.schedule, arg_8_1)
	end

	if arg_8_0.player then
		local var_8_0 = arg_8_0.player

		if var_2.IsCurrentTask(var_8_0, arg_8_1) then
			local var_8_1 = arg_8_0.player

			var_2.Stop(var_8_1)

			arg_8_0.player = nil

			arg_8_0:DelayStart()
		end
	end

	return
end

function var_0_1.OnDispose(arg_9_0)
	if arg_9_0.player then
		local var_9_0 = arg_9_0.player

		var_1.Stop(var_9_0)

		local var_9_1 = arg_9_0.player

		var_1.Dispose(var_9_1)

		arg_9_0.player = nil
	end

	arg_9_0.schedule = nil

	arg_9_0:RemoveTimer()

	return
end

return var_0_1
