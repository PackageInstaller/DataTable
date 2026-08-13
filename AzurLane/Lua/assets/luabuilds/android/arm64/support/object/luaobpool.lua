pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
class = var_0_10001
var_0.LuaObPool = var_0_10001("LuaObPool")

function var_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	assert = var_1_10004

	var_1_10004(arg_1_1.Init, "template should have func Init")

	assert = var_1_10004

	var_1_10004(arg_1_1.Recycle, "template should have func Recycle")

	assert = var_1_10004

	var_1_10004(arg_1_1.Dispose, "template should have func Dispose")

	arg_1_0.baseClass = arg_1_1
	arg_1_0.info = arg_1_2
	arg_1_0.list = {}
	arg_1_0.ob2index = {}

	for iter_1_0 = 1, arg_1_3 do
		arg_1_0.list[iter_1_0] = arg_1_1.New(arg_1_0, arg_1_2)
	end

	arg_1_0.usedEnd = 0

	return
end

function var_1.GetObject(arg_2_0)
	local var_2_0 = arg_2_0.list
	local var_2_1 = arg_2_0.usedEnd
	local var_2_2

	if var_2_1 >= #var_2_0 then
		var_2_0[#var_2_0 + 1] = arg_2_0.baseClass.New(arg_2_0, arg_2_0.info)
	end

	local var_2_3 = var_2_0[var_2_1 + 1]

	arg_2_0.ob2index[var_2_3] = var_2
	arg_2_0.usedEnd = var_2

	var_2_3:Init()

	return var_2_3
end

function var_1.Recycle(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.ob2index[arg_3_1]
	local var_3_1 = arg_3_0.usedEnd
	local var_3_2 = arg_3_0.list

	arg_3_1:Recycle()

	if var_3_1 ~= var_3_0 then
		local var_3_3 = var_3_2[var_3_1]

		arg_3_0.ob2index[var_3_3] = var_3_0
		var_3_2[var_3_1], var_3_2[var_3_0] = arg_3_1, var_3_3
	end

	arg_3_0.ob2index[arg_3_1] = nil
	arg_3_0.usedEnd = var_3_1 - 1

	return
end

function var_1.UpdateInfo(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.info[arg_4_1] = arg_4_2

	return
end

function var_1.Dispose(arg_5_0)
	ipairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.list) do
		iter_5_1:Dispose()
	end

	arg_5_0.ob2index = nil

	return
end

return
