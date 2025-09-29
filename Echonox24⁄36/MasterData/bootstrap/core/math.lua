module("bootstrap.core.math", package.seeall)

function math.round(arg_1_0)
	arg_1_0 = checknumber(arg_1_0)

	return math.floor(arg_1_0 + 0.5)
end

local var_0_0 = math.pi / 180

function math.angle2radian(arg_2_0)
	return arg_2_0 * var_0_0
end

local var_0_1 = math.pi * 180

function math.radian2angle(arg_3_0)
	return arg_3_0 / var_0_1
end

math.randomseed(os.time())
math.random(1, 10000)
