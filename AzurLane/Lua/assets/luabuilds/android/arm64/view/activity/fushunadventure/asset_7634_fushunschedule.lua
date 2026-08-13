class = var_0_10000

local var_0_0 = var_0_10000("FushunSchedule")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.time = 0
	arg_1_0.schedules = {}

	return
end

function var_0_0.Update(arg_2_0)
	for iter_2_0 = #arg_2_0.schedules, 1, -1 do
		local var_2_0 = arg_2_0.schedules[iter_2_0]

		if arg_2_0.time - var_2_0.nowtime >= var_2_0.targetTime then
			var_2_0.callback()

			var_2_0.count = var_2_0.count - 1
			var_2_0.nowtime = arg_2_0.time

			if var_2_0.count == 0 then
				table = var_6

				var_6.remove(arg_2_0.schedules, iter_2_0)
			end
		end
	end

	local var_2_1 = arg_2_0.time

	Time = var_2
	arg_2_0.time = var_2_1 + var_2.deltaTime

	return
end

function var_0_0.AddSchedule(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	table = var_1_10004

	var_1_10004.insert(arg_3_0.schedules, {
		targetTime = arg_3_1,
		count = arg_3_2,
		callback = arg_3_3,
		nowtime = arg_3_0.time
	})

	return
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.schedules = nil

	return
end

return var_0_0
