pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.EasyRedDotMgr = var_0_10001("EasyRedDotMgr")
pg = var_0

local var_0_1 = var_0.EasyRedDotMgr

function var_0_1.Init(arg_1_0, arg_1_1)
	arg_1_0.registerDic = {}
	arg_1_0.markDic = {}

	if arg_1_1 then
		arg_1_1()
	end

	return
end

function var_0_1.RegisterRedDot(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_0.registerDic[arg_2_1] then
		arg_2_0:UnRegisterRedDot(arg_2_1)
	end

	local var_2_0 = arg_2_0.registerDic

	var_2_0[arg_2_1] = {
		arg_2_2,
		arg_2_3
	}
	ipairs = var_2_0

	for iter_2_0, iter_2_1 in var_2_0(arg_2_2) do
		local var_2_1 = arg_2_0.markDic
		local var_2_2

		if not arg_2_0.markDic[iter_2_1] then
			var_2_2 = {}
		end

		var_2_1[iter_2_1] = var_2_2
		arg_2_0.markDic[iter_2_1][arg_2_1] = true
	end

	arg_2_3(arg_2_1)

	return
end

function var_0_1.UnRegisterRedDot(arg_3_0, arg_3_1)
	if not arg_3_0.registerDic[arg_3_1] then
		return
	end

	unpack = var_2

	local var_3_0, var_3_1 = var_2(arg_3_0.registerDic[arg_3_1])

	ipairs = var_1_10004

	for iter_3_0, iter_3_1 in var_1_10004(var_3_0) do
		arg_3_0.markDic[iter_3_1][arg_3_1] = nil
	end

	arg_3_0.registerDic[arg_3_1] = nil

	return
end

function var_0_1.TriggerMarks(arg_4_0, ...)
	local var_4_0 = {}

	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002({
		...
	}) do
		pairs = var_1_10007

		local var_4_1

		if not arg_4_0.markDic[iter_4_1] then
			var_4_1 = {}
		end

		for iter_4_2, iter_4_3 in var_1_10007(var_4_1) do
			IsNil = var_1_10012

			if var_1_10012(iter_4_2) then
				var_4_0[iter_4_2] = false
			elseif iter_4_3 then
				var_4_0[iter_4_2] = true
			end
		end
	end

	pairs = var_2

	for iter_4_4, iter_4_5 in var_2(var_4_0) do
		if iter_4_5 then
			arg_4_0.registerDic[iter_4_4][2](iter_4_4)
		else
			arg_4_0:UnRegisterRedDot(iter_4_4)
		end
	end

	return
end

return
