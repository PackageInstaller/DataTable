class = var_0_10000

local var_0_0 = var_0_10000("OreGameHelper")

local function var_0_1(arg_1_0)
	local var_1_0 = arg_1_0.x * 90 + 90
	local var_1_1 = arg_1_0.y * 90 + 90
	local var_1_2 = var_1_0

	if var_1_1 < 90 then
		if var_1_0 <= 90 then
			var_1_2 = 14 + var_1_1
		elseif var_1_0 > 90 then
			var_1_2 = 180 + (90 - var_1_1)
		end
	end

	return var_1_2
end

local var_0_2 = {
	"W",
	"NW",
	"N",
	"NE",
	"E",
	"SE",
	"S",
	"SW",
	"STAND"
}
local var_0_3 = {}

Vector2 = var_0_10004
var_0_3.W = var_0_10004(-1, 0)
Vector2 = var_4
var_0_3.NW = var_4(-1, 1).normalized
Vector2 = var_4
var_0_3.N = var_4(0, 1)
Vector2 = var_4
var_0_3.NE = var_4(1, 1).normalized
Vector2 = var_4
var_0_3.E = var_4(1, 0)
Vector2 = var_4
var_0_3.SE = var_4(1, -1).normalized
Vector2 = var_4
var_0_3.S = var_4(0, -1)
Vector2 = var_4
var_0_3.SW = var_4(-1, -1).normalized
Vector2 = var_4
var_0_3.STAND = var_4(0, 0)

local function var_0_4(arg_2_0)
	if arg_2_0.x == 0 and arg_2_0.y == 0 then
		return "STAND"
	end

	local var_2_0 = var_0_1(arg_2_0)

	for iter_2_0 = 1, 8 do
		if iter_2_0 == 1 then
			if var_2_0 >= 0 and var_2_0 <= 22.5 or var_2_0 >= 337.5 and var_2_0 <= 360 then
				return var_0_2[iter_2_0]
			end
		elseif 22.5 + (iter_2_0 - 2) * 45 < var_2_0 and var_2_0 <= var_6 + 45 then
			return var_0_2[iter_2_0]
		end
	end

	return "STAND"
end

function var_0_0.GetEightDirVector(arg_3_0)
	local var_3_0 = var_0_4(arg_3_0)

	return var_0_3[var_3_0]
end

local var_0_5 = {
	"W",
	"N",
	"E",
	"S"
}

function var_0_0.GetFourDirLabel(arg_4_0)
	if arg_4_0.x == 0 and arg_4_0.y == 0 then
		return "STAND"
	end

	local var_4_0 = var_0_1(arg_4_0)

	for iter_4_0 = 1, 4 do
		if iter_4_0 == 1 then
			if var_4_0 >= 0 and var_4_0 <= 45 or var_4_0 >= 315 and var_4_0 <= 360 then
				return var_0_5[iter_4_0]
			end
		elseif 45 + (iter_4_0 - 2) * 90 < var_4_0 and var_4_0 <= var_6 + 90 then
			return var_0_5[iter_4_0]
		end
	end

	return "STAND"
end

function var_0_0.CheckRemovable(arg_5_0)
	local var_5_0 = arg_5_0.x

	OreGameConfig = var_1_10002

	if var_1_10002.RANGE_X[1] <= var_5_0 then
		local var_5_1 = arg_5_0.x

		OreGameConfig = var_2

		if var_5_1 <= var_2.RANGE_X[2] then
			local var_5_2 = arg_5_0.y

			OreGameConfig = var_2

			if var_2.RANGE_Y[1] <= var_5_2 then
				local var_5_3 = arg_5_0.y

				OreGameConfig = var_2

				if var_5_3 <= var_2.RANGE_Y[2] then
					local var_5_4 = arg_5_0.y

					OreGameConfig = var_2

					if var_2.BAN_Y[1] <= var_5_4 then
						return true
					else
						local var_5_5 = arg_5_0.x

						OreGameConfig = var_2

						if var_2.BAN_Y[2][1] <= var_5_5 then
							local var_5_6 = arg_5_0.x

							OreGameConfig = var_2

							if var_5_6 <= var_2.BAN_Y[2][2] then
								return true
							end
						end
					end
				end
			end
		end
	end

	return false
end

function var_0_0.GetBeziersPoints(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0:Clone()
	local var_6_1 = var_4.Mul(var_6_0, (1 - arg_6_3) * (1 - arg_6_3))
	local var_6_2 = arg_6_2:Clone()
	local var_6_3 = var_5.Mul(var_6_2, 2 * arg_6_3 * (1 - arg_6_3))
	local var_6_4 = arg_6_1:Clone()
	local var_6_5 = var_6.Mul(var_6_4, arg_6_3 * arg_6_3)
	local var_6_6 = var_6_1:Add(var_6_3)

	return var_7.Add(var_6_6, var_6_5)
end

function var_0_0.GetOreIDWithWeight(arg_7_0)
	local var_7_0 = 0

	ipairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_0) do
		var_7_0 = var_7_0 + iter_7_1[2]
	end

	math = var_2

	local var_7_1 = var_2.random() * var_7_0
	local var_7_2 = 0

	ipairs = var_4

	for iter_7_2, iter_7_3 in var_4(arg_7_0) do
		if var_7_1 <= var_7_2 + iter_7_3[2] then
			return iter_7_3[1]
		end
	end

	return
end

function var_0_0.GetAABBWithTF(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.rect.width
	local var_8_1 = arg_8_0.rect.height
	local var_8_2 = arg_8_0.anchoredPosition
	local var_8_3 = {
		var_8_2.x - var_8_0 / 2,
		var_8_2.y + var_8_1 / 2
	}
	local var_8_4 = {
		var_8_2.x + var_8_0 / 2,
		var_8_2.y - var_8_1 / 2
	}

	if arg_8_1 then
		var_8_3 = {
			var_8_2.x + var_8_0 / 2,
			var_8_2.y + var_8_1 / 2
		}
		var_8_4 = {
			var_8_2.x - var_8_0 / 2,
			var_8_2.y - var_8_1 / 2
		}
	end

	return {
		var_8_3,
		var_8_4
	}
end

return var_0_0
