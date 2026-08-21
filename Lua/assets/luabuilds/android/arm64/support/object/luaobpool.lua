pg = pg or {}

local var_0_0 = class("LuaObPool")

pg.LuaObPool = var_0_0

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	assert(arg_1_1.Init, "template should have func Init")
	assert(arg_1_1.Recycle, "template should have func Recycle")
	assert(arg_1_1.Dispose, "template should have func Dispose")

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

function var_0_0.GetObject(arg_2_0)
	if arg_2_0.usedEnd >= #arg_2_0.list then
		arg_2_0.list[#arg_2_0.list + 1] = arg_2_0.baseClass.New(arg_2_0, arg_2_0.info)
	end

	local var_2_1 = arg_2_0.usedEnd + 1

	arg_2_0.ob2index[arg_2_0.list[arg_2_0.usedEnd + 1]] = arg_2_0.usedEnd + 1
	arg_2_0.usedEnd = var_2_1

	arg_2_0.list[arg_2_0.usedEnd + 1]:Init()

	return arg_2_0.list[arg_2_0.usedEnd + 1]
end

function var_0_0.Recycle(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.ob2index[arg_3_1]
	local var_3_1 = arg_3_0.usedEnd
	local var_3_2 = arg_3_0.list

	arg_3_1:Recycle()

	if arg_3_0.usedEnd ~= arg_3_0.ob2index[arg_3_1] then
		arg_3_0.ob2index[arg_3_0.list[arg_3_0.usedEnd]] = arg_3_0.ob2index[arg_3_1]
		var_3_2[var_3_1], var_3_2[var_3_0] = arg_3_1, arg_3_0.list[arg_3_0.usedEnd]
	end

	arg_3_0.ob2index[arg_3_1] = nil
	arg_3_0.usedEnd = arg_3_0.usedEnd - 1

	return
end

function var_0_0.UpdateInfo(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.info[arg_4_1] = arg_4_2

	return
end

function var_0_0.Dispose(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.list) do
		iter_5_1:Dispose()
	end

	arg_5_0.ob2index = nil

	return
end

return
