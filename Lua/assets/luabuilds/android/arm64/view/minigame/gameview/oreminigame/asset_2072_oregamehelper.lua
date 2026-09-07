local OreGameHelper = class("OreGameHelper")

local function var_0_1(arg_1_0)
	local var_1_0 = arg_1_0.x * 90 + 90

	if arg_1_0.y * 90 + 90 < 90 then
		if arg_1_0.x * 90 + 90 <= 90 then
			var_1_0 = 14 + (arg_1_0.y * 90 + 90)
		elseif arg_1_0.x * 90 + 90 > 90 then
			var_1_0 = 180 + (90 - (arg_1_0.y * 90 + 90))
		end
	end

	return var_1_0
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
local var_0_3 = {
	W = Vector2(-1, 0),
	NW = Vector2(-1, 1).normalized,
	N = Vector2(0, 1),
	NE = Vector2(1, 1).normalized,
	E = Vector2(1, 0),
	SE = Vector2(1, -1).normalized,
	S = Vector2(0, -1),
	SW = Vector2(-1, -1).normalized,
	STAND = Vector2(0, 0)
}

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
		elseif 22.5 + (iter_2_0 - 2) * 45 < var_2_0 and var_2_0 <= 22.5 + (iter_2_0 - 2) * 45 + 45 then
			return var_0_2[iter_2_0]
		end
	end

	return "STAND"
end

function OreGameHelper:GetEightDirVector()
	return var_0_3[var_0_4(self)]
end

local var_0_5 = {
	"W",
	"N",
	"E",
	"S"
}

function OreGameHelper:GetFourDirLabel()
	if self.x == 0 and self.y == 0 then
		return "STAND"
	end

	local var_4_0 = var_0_1(self)

	for iter_4_0 = 1, 4 do
		if iter_4_0 == 1 then
			if var_4_0 >= 0 and var_4_0 <= 45 or var_4_0 >= 315 and var_4_0 <= 360 then
				return var_0_5[iter_4_0]
			end
		elseif 45 + (iter_4_0 - 2) * 90 < var_4_0 and var_4_0 <= 45 + (iter_4_0 - 2) * 90 + 90 then
			return var_0_5[iter_4_0]
		end
	end

	return "STAND"
end

function OreGameHelper:CheckRemovable()
	if self.x >= OreGameConfig.RANGE_X[1] and self.x <= OreGameConfig.RANGE_X[2] and self.y >= OreGameConfig.RANGE_Y[1] and self.y <= OreGameConfig.RANGE_Y[2] then
		if self.y >= OreGameConfig.BAN_Y[1] then
			return true
		elseif self.x >= OreGameConfig.BAN_Y[2][1] and self.x <= OreGameConfig.BAN_Y[2][2] then
			return true
		end
	end

	return false
end

function OreGameHelper:GetBeziersPoints(arg_6_1, arg_6_2, arg_6_3)
	local var_6_1 = self:Clone():Mul((1 - arg_6_3) * (1 - arg_6_3)):Add((arg_6_2:Clone():Mul(2 * arg_6_3 * (1 - arg_6_3)))).Add

	return self:Clone():Mul((1 - arg_6_3) * (1 - arg_6_3)):Add((arg_6_2:Clone():Mul(2 * arg_6_3 * (1 - arg_6_3)))):Add((arg_6_1:Clone():Mul(arg_6_3 * arg_6_3)))
end

function OreGameHelper:GetOreIDWithWeight()
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(self) do
		var_7_0 = var_7_0 + iter_7_1[2]
	end

	local var_7_1 = math.random() * var_7_0
	local var_7_2 = 0

	for iter_7_2, iter_7_3 in ipairs(self) do
		var_7_2 = var_7_2 + iter_7_3[2]

		if var_7_1 <= var_7_2 then
			return iter_7_3[1]
		end
	end

	return
end

function OreGameHelper:GetAABBWithTF(arg_8_1)
	local var_8_0 = {
		self.anchoredPosition.x - self.rect.width / 2,
		self.anchoredPosition.y + self.rect.height / 2
	}
	local var_8_1 = {
		self.anchoredPosition.x + self.rect.width / 2,
		self.anchoredPosition.y - self.rect.height / 2
	}

	if arg_8_1 then
		var_8_0 = {
			self.anchoredPosition.x + self.rect.width / 2,
			self.anchoredPosition.y + self.rect.height / 2
		}
		var_8_1 = {
			self.anchoredPosition.x - self.rect.width / 2,
			self.anchoredPosition.y - self.rect.height / 2
		}
	end

	return {
		var_8_0,
		var_8_1
	}
end

return OreGameHelper
