class = var_0_10000

local var_0_0 = var_0_10000("FrameListener")

FrameListener = FrameListener

function var_0.Ctor(arg_1_0)
	arg_1_0.jobs = {}

	return
end

function var_0.UnShift(arg_2_0, ...)
	for iter_2_0 = #{
		...
	}, 1, -1 do
		table = var_1_10006

		var_1_10006.insert(arg_2_0.jobs, 1, var_1[iter_2_0])
	end

	arg_2_0:TryStart()

	return
end

function var_0.Push(arg_3_0, ...)
	local var_3_0 = {
		...
	}

	for iter_3_0 = 1, #var_3_0 do
		table = var_1_10006

		var_1_10006.insert(arg_3_0.jobs, var_3_0[iter_3_0])
	end

	arg_3_0:TryStart()

	return
end

function var_0.Remove(arg_4_0, arg_4_1)
	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.jobs) do
		if iter_4_1 == arg_4_1 then
			table = var_1_10007

			var_1_10007.remove(arg_4_0.jobs, iter_4_0)
			arg_4_0:TryStop()

			break
		end
	end

	return
end

function var_0.TryStart(arg_5_0)
	if not arg_5_0.running and #arg_5_0.jobs > 0 then
		arg_5_0.running = true
		UpdateBeat = var_1

		var_1:Add(arg_5_0.Update, arg_5_0)
	end

	return
end

function var_0.TryStop(arg_6_0)
	if arg_6_0.running and #arg_6_0.jobs == 0 then
		UpdateBeat = var_1

		var_1:Remove(arg_6_0.Update, arg_6_0)

		arg_6_0.running = false
	end

	return
end

function var_0.Update(arg_7_0)
	if #arg_7_0.jobs == 0 then
		arg_7_0:TryStop()
	else
		table = var_1

		var_1.remove(arg_7_0.jobs, 1)()
	end

	return
end

return var_0
