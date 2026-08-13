class = var_0_10000

local var_0_0 = var_0_10000("BackYardLargeSpriteLoader")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.cnt = arg_1_1 or 6
	arg_1_0.maxCnt = arg_1_1 * 2 + 1
	arg_1_0.cache = {}
	arg_1_0.paths = {}

	return
end

function var_0_0.LoadSpriteAsync(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.cache[arg_2_1] then
		arg_2_2(arg_2_0.cache[arg_2_1])

		return
	end

	LoadSpriteAsync = var_3

	var_3(arg_2_1, function(arg_3_0)
		local var_3_0 = arg_2_0.cache

		var_3_0[arg_2_1] = arg_3_0
		table = var_3_0

		var_3_0.insert(arg_2_0.paths, arg_2_1)
		arg_2_2(arg_3_0)

		local var_3_1 = arg_2_0

		var_1.Check(var_3_1)

		return
	end)

	return
end

function var_0_0.Check(arg_4_0)
	if #arg_4_0.paths >= arg_4_0.maxCnt then
		arg_4_0:Clear()
	end

	return
end

function var_0_0.Clear(arg_5_0)
	for iter_5_0 = arg_5_0.cnt, 1, -1 do
		local var_5_0 = arg_5_0.paths[iter_5_0]
		local var_5_1 = arg_5_0.cache

		var_5_1[var_5_0] = nil
		table = var_5_1

		var_5_1.remove(arg_5_0.paths, iter_5_0)
	end

	gcAll = var_1

	var_1(false)

	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.cache = nil
	arg_6_0.paths = nil

	return
end

return var_0_0
