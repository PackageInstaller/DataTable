local var_0_0 = class("WSTimer", import("...BaseEntity"))

var_0_0.Fields = {
	inMapTweens = "table",
	inMapTimers = "table",
	tweens = "table",
	timers = "table"
}
var_0_0.Listeners = {}

function var_0_0.Setup(arg_1_0)
	arg_1_0.inMapTimers = {}
	arg_1_0.timers = {}
	arg_1_0.inMapTweens = {}
	arg_1_0.tweens = {}

	return
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0:ClearInMapTweens()
	arg_2_0:ClearInMapTimers()
	arg_2_0:ClearTweens()
	arg_2_0:ClearTimers()
	arg_2_0:Clear()

	return
end

function var_0_0.AddInMapTimer(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Timer.New(arg_3_1, arg_3_2, arg_3_3, arg_3_4)

	table.insert(arg_3_0.inMapTimers, var_3_0)

	return var_3_0
end

function var_0_0.RemoveInMapTimer(arg_4_0, arg_4_1)
	arg_4_1:Stop()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.inMapTimers) do
		if iter_4_1 == arg_4_1 then
			table.remove(arg_4_0.inMapTimers, iter_4_0)
		end
	end

	return
end

function var_0_0.ClearInMapTimers(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.inMapTimers) do
		iter_5_1:Stop()
	end

	arg_5_0.inMapTimers = {}

	return
end

function var_0_0.AddTimer(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = Timer.New(arg_6_1, arg_6_2, arg_6_3, arg_6_4)

	table.insert(arg_6_0.timers, var_6_0)

	return var_6_0
end

function var_0_0.RemoveTimer(arg_7_0, arg_7_1)
	arg_7_1:Stop()

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.timers) do
		if iter_7_1 == arg_7_1 then
			table.remove(arg_7_0.timers, iter_7_0)
		end
	end

	return
end

function var_0_0.ClearTimers(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.timers) do
		iter_8_1:Stop()
	end

	arg_8_0.timers = {}

	return
end

function var_0_0.AddInMapTween(arg_9_0, arg_9_1)
	assert(arg_9_1 and type(arg_9_1) == "number")
	table.insert(arg_9_0.inMapTweens, arg_9_1)

	return
end

function var_0_0.RemoveInMapTween(arg_10_0, arg_10_1)
	assert(arg_10_1 and type(arg_10_1) == "number")
	LeanTween.cancel(arg_10_1)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.inMapTweens) do
		if iter_10_1 == arg_10_1 then
			table.remove(arg_10_0.inMapTweens, iter_10_0)

			break
		end
	end

	return
end

function var_0_0.ClearInMapTweens(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.inMapTweens) do
		LeanTween.cancel(iter_11_1)
	end

	arg_11_0.inMapTweens = {}

	return
end

function var_0_0.AddTween(arg_12_0, arg_12_1)
	assert(arg_12_1 and type(arg_12_1) == "number")
	table.insert(arg_12_0.tweens, arg_12_1)

	return
end

function var_0_0.RemoveTween(arg_13_0, arg_13_1)
	assert(arg_13_1 and type(arg_13_1) == "number")
	LeanTween.cancel(arg_13_1)

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.tweens) do
		if iter_13_1 == arg_13_1 then
			table.remove(arg_13_0.tweens, iter_13_0)
		end
	end

	return
end

function var_0_0.ClearTweens(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.tweens) do
		LeanTween.cancel(iter_14_1)
	end

	arg_14_0.tweens = {}

	return
end

return var_0_0
