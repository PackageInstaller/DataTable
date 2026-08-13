class = var_0_10000

local var_0_0 = var_0_10000("DelayedDataProcesseor")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.delayedDataDic = {}
	arg_1_0.preTimeStampDic = {}
	arg_1_0.delayedTime = arg_1_1
	arg_1_0.intervalTime = arg_1_2
	arg_1_0.func = arg_1_3

	return
end

function var_0_0.Add(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0
	local var_2_1

	if arg_2_0.preTimeStampDic[arg_2_1] then
		math = var_2_1
		var_2_1 = var_2_1.min

		local var_2_2 = arg_2_0.preTimeStampDic[arg_2_1] + arg_2_0.intervalTime

		pg = var_7

		local var_2_3 = var_7.TimeMgr.GetInstance()

		var_2_0 = var_2_1(var_2_2, var_7.GetServerTimeMs(var_2_3) + arg_2_0.delayedTime)
	else
		var_2_1 = arg_2_0.delayedDataDic
		var_2_1[arg_2_1] = {}
		pg = var_2_1

		local var_2_4 = var_2_1.TimeMgr.GetInstance()

		var_2_0 = var_2_1.GetServerTimeMs(var_2_4) + arg_2_0.delayedTime
	end

	table = var_2_1

	var_2_1.insert(arg_2_0.delayedDataDic[arg_2_1], {
		data = arg_2_2,
		timeStamp = var_2_0
	})

	arg_2_0.preTimeStampDic[arg_2_1] = var_2_0

	return
end

function var_0_0.Update(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.TimeMgr.GetInstance()
	local var_3_1 = var_1.GetServerTimeMs(var_3_0)

	pairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0.delayedDataDic) do
		if #iter_3_1 > 0 and iter_3_1[1].timeStamp <= var_3_1 then
			xpcall = var_7

			var_7(function()
				arg_3_0.func(iter_3_1[1].data)

				return
			end, function(...)
				errorMsg = var_2_10000
				debug = var_2_10002

				var_2_10000(var_2_10002.traceback(...))

				return
			end)

			table = var_7

			var_7.remove(iter_3_1, 1)
		end
	end

	return
end

function var_0_0.RemoveDataById(arg_6_0, arg_6_1)
	if arg_6_0.delayedDataDic[arg_6_1] then
		arg_6_0.delayedDataDic[arg_6_1] = nil
	end

	if arg_6_0.preTimeStampDic[arg_6_1] then
		arg_6_0.preTimeStampDic[arg_6_1] = nil
	end

	return
end

function var_0_0.Dispose(arg_7_0)
	return
end

return var_0_0
