local var_0_0 = {}
local var_0_1 = RandomUtil.GenRandom(os.time())
local var_0_2 = os.time()

function var_0_0.RandomSeed(arg_1_0)
	var_0_2 = arg_1_0
	var_0_1 = RandomUtil.GenRandom(arg_1_0)
end

function var_0_0.GetRandomSeed()
	return var_0_2
end

function var_0_0.Random(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0 == nil and arg_3_1 == nil and var_0_1:NextDouble() or arg_3_1 == nil and 1 + var_0_1:NextInt(arg_3_0) or arg_3_0 + var_0_1:NextInt(arg_3_1 - arg_3_0 + 1)

	if MathRandomFlag == false then
		print("<color=#ff0000>渲染帧请使用math.random()产生随机数</color>" .. " source:" .. debug.getinfo(2, "nfS").source, debug.traceback("", 2))
	end

	return var_3_0
end

return var_0_0
