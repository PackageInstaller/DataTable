local var_0_0 = class("BackYardLargeSpriteLoader")

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

	LoadSpriteAsync(arg_2_1, function(arg_3_0)
		arg_2_0.cache[arg_2_1] = arg_3_0

		table.insert(arg_2_0.paths, arg_2_1)
		arg_2_2(arg_3_0)
		arg_2_0:Check()

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
		arg_5_0.cache[arg_5_0.paths[iter_5_0]] = nil

		table.remove(arg_5_0.paths, iter_5_0)
	end

	gcAll(false)

	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.cache = nil
	arg_6_0.paths = nil

	return
end

return var_0_0
