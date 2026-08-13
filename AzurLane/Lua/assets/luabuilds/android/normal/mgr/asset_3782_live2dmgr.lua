pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.Live2DMgr = var_0_10001("Live2DMgr")
pg = var_0

local var_0_1 = var_0.Live2DMgr

function var_0_1.Ctor(arg_1_0)
	arg_1_0.loadingDic = {}
	arg_1_0.nameList = {}

	return
end

function var_0_1.GetLive2DModelAsync(arg_2_0, arg_2_1, arg_2_2)
	table = var_1_10003

	var_1_10003.insert(arg_2_0.nameList, arg_2_1)

	local var_2_0 = #arg_2_0.nameList
	local var_2_1 = arg_2_0.loadingDic

	var_2_1[arg_2_1] = var_2_0
	PoolMgr = var_2_1

	local var_2_2 = var_2_1.GetInstance()

	var_4.GetLive2D(var_2_2, arg_2_1, true, function(arg_3_0)
		if arg_2_0.loadingDic[arg_2_1] ~= var_2_0 then
			warning = var_1

			var_1("l2d loaded dispose return  " .. arg_2_1)

			PoolMgr = var_1

			local var_3_0 = var_1.GetInstance()

			var_1.ReturnLive2D(var_3_0, arg_2_1, arg_3_0)
		end

		local var_3_1 = arg_2_0.loadingDic

		var_3_1[arg_2_1] = nil
		existCall = var_3_1

		var_3_1(arg_2_2, arg_3_0)

		return
	end)

	return
end

function var_0_1.ReturnLive2DModel(arg_4_0, arg_4_1, arg_4_2)
	PoolMgr = var_1_10003

	local var_4_0 = var_1_10003.GetInstance()

	var_3.ReturnLive2D(var_4_0, arg_4_1, arg_4_2)

	return
end

function var_0_1.StopLoadingLive2d(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.nameList[arg_5_1]

	if arg_5_0.loadingDic[var_5_0] == arg_5_1 then
		arg_5_0.loadingDic[var_5_0] = nil
	end

	return
end

return
