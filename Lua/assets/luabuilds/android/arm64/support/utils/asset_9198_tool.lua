pg = pg or {}

local var_0_0 = pg

pg.Tool = class("Tool")

function pg.Tool.Seq(arg_1_0)
	local var_1_0 = {}

	for iter_1_0 = 1, arg_1_0 do
		var_1_0[iter_1_0] = iter_1_0
	end

	return var_1_0
end

function pg.Tool:Swap(arg_2_1, arg_2_2)
	self[arg_2_2], self[arg_2_1] = self[arg_2_1], self[arg_2_2]

	return
end

function pg.Tool.RandomMN(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = var_0_0.Tool.Seq(arg_3_0)

	for iter_3_0 = 1, arg_3_1 do
		local var_3_2 = math.random(#var_3_1)

		var_3_0[iter_3_0] = var_3_1[var_3_2]

		var_0_0.Tool.Swap(var_3_1, var_3_2, #var_3_1)
	end

	return var_3_0
end

function pg.Tool:FilterY()
	return Vector3(self.x, 0, self.z)
end

function pg.Tool:FilterZ()
	return Vector3(self.x, self.y, 0)
end

function pg.Tool.GetShortName(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0 == nil or arg_6_1 == nil then
		return
	end

	local var_6_0 = arg_6_0
	local var_6_1 = {}
	local var_6_2 = {}
	local var_6_3 = 0

	if arg_6_2 == nil then
		arg_6_2 = arg_6_1 - 3
	end

	for iter_6_0 = 1, #arg_6_0 do
		local var_6_4 = string.byte(var_6_0, iter_6_0)
		local var_6_5 = 0

		if var_6_4 > 0 and var_6_4 <= 127 then
			var_6_5 = 1
		elseif var_6_4 >= 192 and var_6_4 < 223 then
			var_6_5 = 2
		elseif var_6_4 >= 224 and var_6_4 < 239 then
			var_6_5 = 3
		elseif var_6_4 >= 240 and var_6_4 <= 247 then
			var_6_5 = 4
		end

		local var_6_6

		if var_6_5 > 0 then
			var_6_6 = string.sub(var_6_0, iter_6_0, iter_6_0 + var_6_5 - 1)
			iter_6_0 = iter_6_0 + var_6_5 - 1
		end

		if var_6_5 == 1 then
			var_6_3 = var_6_3 + 1

			table.insert(var_6_2, var_6_6)
			table.insert(var_6_1, 1)
		elseif var_6_5 > 1 then
			var_6_3 = var_6_3 + 2

			table.insert(var_6_2, var_6_6)
			table.insert(var_6_1, 2)
		end
	end

	if arg_6_1 < var_6_3 then
		local var_6_7 = ""
		local var_6_8 = 0

		for iter_6_1 = 1, #var_6_2 do
			var_6_7 = var_6_7 .. var_6_2[iter_6_1]
			var_6_8 = var_6_8 + var_6_1[iter_6_1]

			if arg_6_2 <= var_6_8 then
				break
			end
		end

		arg_6_0 = var_6_7 .. "..."
	end

	return arg_6_0
end

function pg.Tool.Distances(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return 2 * math.asin(math.sqrt(math.pow(math.sin((arg_7_0 / 180 * math.pi - arg_7_2 / 180 * math.pi) / 2), 2) + math.cos(arg_7_0 / 180 * math.pi) * math.cos(arg_7_2 / 180 * math.pi) * math.pow(math.sin((arg_7_1 / 180 * math.pi - arg_7_3 / 180 * math.pi) / 2), 2))) * 6378.137
end

return
