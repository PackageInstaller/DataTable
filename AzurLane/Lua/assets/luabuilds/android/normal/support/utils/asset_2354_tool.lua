pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
class = var_0_10001
var_0.Tool = var_0_10001("Tool")

function var_0.Tool.Seq(arg_1_0)
	local var_1_0 = {}

	for iter_1_0 = 1, arg_1_0 do
		var_1_0[iter_1_0] = iter_1_0
	end

	return var_1_0
end

function var_0.Tool.Swap(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0[arg_2_2], arg_2_0[arg_2_1] = arg_2_0[arg_2_1], arg_2_0[arg_2_2]

	return
end

function var_0.Tool.RandomMN(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = #var_0.Tool.Seq(arg_3_0)

	for iter_3_0 = 1, arg_3_1 do
		math = var_1_10009
		var_3_0[iter_3_0] = var_3[var_1_10009.random(var_3_1)]

		var_0.Tool.Swap(var_3, var_1_10009, var_3_1)

		var_3_1 = var_3_1 - 1
	end

	return var_3_0
end

function var_0.Tool.FilterY(arg_4_0)
	Vector3 = var_1_10001

	return var_1_10001(arg_4_0.x, 0, arg_4_0.z)
end

function var_0.Tool.FilterZ(arg_5_0)
	Vector3 = var_1_10001

	return var_1_10001(arg_5_0.x, arg_5_0.y, 0)
end

function var_0.Tool.GetShortName(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0 == nil or arg_6_1 == nil then
		return
	end

	local var_6_0 = arg_6_0
	local var_6_1 = {}
	local var_6_2 = {}
	local var_6_3 = #var_6_0
	local var_6_4 = 0

	if arg_6_2 == nil then
		arg_6_2 = arg_6_1 - 3
	end

	for iter_6_0 = 1, var_6_3 do
		string = var_1_10012
		var_1_10012 = var_1_10012.byte(var_6_0, iter_6_0)

		local var_6_5 = 0

		if var_1_10012 > 0 and var_1_10012 <= 127 then
			var_6_5 = 1
		elseif var_1_10012 >= 192 and var_1_10012 < 223 then
			var_6_5 = 2
		elseif var_1_10012 >= 224 and var_1_10012 < 239 then
			var_6_5 = 3
		elseif var_1_10012 >= 240 and var_1_10012 <= 247 then
			var_6_5 = 4
		end

		local var_6_6

		if 0 < var_6_5 then
			string = var_15
			var_6_6 = var_15.sub(var_6_0, iter_6_0, iter_6_0 + var_6_5 - 1)
			iter_6_0 = iter_6_0 + var_6_5 - 1
		end

		if var_6_5 == 1 then
			var_6_4 = var_6_4 + 1
			table = var_15

			var_15.insert(var_6_2, var_6_6)

			table = var_15

			var_15.insert(var_6_1, 1)
		elseif 1 < var_6_5 then
			var_6_4 = var_6_4 + 2
			table = var_15

			var_15.insert(var_6_2, var_6_6)

			table = var_15

			var_15.insert(var_6_1, 2)
		end
	end

	if arg_6_1 < var_6_4 then
		local var_6_7 = ""
		local var_6_8 = 0

		for iter_6_1 = 1, #var_6_2 do
			var_6_7 = var_6_7 .. var_6_2[iter_6_1]

			if arg_6_2 <= var_6_8 + var_6_1[iter_6_1] then
				break
			end
		end

		arg_6_0 = var_6_7 .. "..."
	end

	return arg_6_0
end

function var_0.Tool.Distances(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0 / 180

	math = var_1_10005

	local var_7_1 = var_7_0 * var_1_10005.pi
	local var_7_2 = arg_7_2 / 180

	math = var_1_10006

	local var_7_3 = var_7_2 * var_1_10006.pi
	local var_7_4 = arg_7_1 / 180

	math = var_1_10007

	local var_7_5 = var_7_4 * var_1_10007.pi
	local var_7_6 = arg_7_3 / 180

	math = var_1_10008

	local var_7_7 = var_7_6 * var_1_10008.pi
	local var_7_8 = var_7_1 - var_7_3
	local var_7_9 = var_7_5 - var_7_7

	math = var_1_10010

	local var_7_10 = var_1_10010.asin

	math = var_1_10011

	local var_7_11 = var_1_10011.sqrt

	math = var_1_10012

	local var_7_12 = var_1_10012.pow

	math = var_1_10013

	local var_7_13 = var_7_12(var_1_10013.sin(var_7_8 / 2), 2)

	math = var_13

	local var_7_14 = var_13.cos(var_7_1)

	math = var_14

	local var_7_15 = var_7_14 * var_14.cos(var_7_3)

	math = var_14

	local var_7_16 = var_14.pow

	math = var_15

	return 2 * var_7_10(var_7_11(var_7_13 + var_7_15 * var_7_16(var_15.sin(var_7_9 / 2), 2))) * 6378.137
end

return
