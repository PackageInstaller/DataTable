local CrossRoadGameHelper = class("CrossRoadGameHelper")

function CrossRoadGameHelper:IsRectCross(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8)
	return math.max(arg_1_1, arg_1_5) <= math.min(arg_1_3, arg_1_7) and math.max(arg_1_2, arg_1_6) <= math.min(arg_1_4, arg_1_8)
end

function CrossRoadGameHelper:GetPosDis(arg_2_1, arg_2_2)
	return math.sqrt((arg_2_1.x - arg_2_2.x) * (arg_2_1.x - arg_2_2.x) + (arg_2_1.y - arg_2_2.y) * (arg_2_1.y - arg_2_2.y))
end

function CrossRoadGameHelper:cross(arg_3_1, arg_3_2, arg_3_3)
	return (arg_3_2.x - arg_3_1.x) * (arg_3_3.y - arg_3_1.y) - (arg_3_3.x - arg_3_1.x) * (arg_3_2.y - arg_3_1.y)
end

function CrossRoadGameHelper:crossOp(arg_4_1, arg_4_2, arg_4_3)
	return self:sign(self:cross(arg_4_1, arg_4_2, arg_4_3))
end

function CrossRoadGameHelper:OnSeg(arg_5_1, arg_5_2, arg_5_3)
	return self:crossOp(arg_5_1, arg_5_3, arg_5_2) == 0 and self:IsPointMiddle(arg_5_1, arg_5_2, arg_5_3)
end

function CrossRoadGameHelper:IsPointMiddle(arg_6_1, arg_6_2, arg_6_3)
	return self:isMiddle(arg_6_1.x, arg_6_2.x, arg_6_3.x) and self:isMiddle(arg_6_1.y, arg_6_2.y, arg_6_3.y)
end

function CrossRoadGameHelper:isMiddle(arg_7_1, arg_7_2, arg_7_3)
	return self:sign(arg_7_1 - arg_7_2) == 0 or self:sign(arg_7_3 - arg_7_2) == 0 or arg_7_1 < arg_7_2 ~= (arg_7_3 < arg_7_2)
end

function CrossRoadGameHelper:IsInPoint(arg_8_1, arg_8_2)
	return self:sign(arg_8_1.x - arg_8_2.x) == 0 and self:sign(arg_8_1.y - arg_8_2.y) == 0
end

function CrossRoadGameHelper:sign(arg_9_1)
	return arg_9_1 < -CrossRoadGameConst.EPS and -1 or CrossRoadGameConst.EPS < arg_9_1 and 1 or 0
end

function CrossRoadGameHelper:GetRandomList(arg_10_1)
	local var_10_0 = {}

	for iter_10_0 = 1, #arg_10_1 do
		var_10_0[iter_10_0] = arg_10_1[iter_10_0]
	end

	for iter_10_1 = #arg_10_1, 2, -1 do
		local var_10_1 = math.random(1, iter_10_1)

		var_10_0[iter_10_1], var_10_0[var_10_1] = var_10_0[var_10_1], var_10_0[iter_10_1]
	end

	return var_10_0
end

function CrossRoadGameHelper:GetHalfPos(arg_11_1, arg_11_2)
	return Vector2.New(arg_11_1.x / 2 + arg_11_2.x / 2, arg_11_1.y / 2 + arg_11_2.y / 2)
end

function CrossRoadGameHelper:GetThirdPos(arg_12_1, arg_12_2)
	return Vector2.New(arg_12_1.x + (arg_12_2.x - arg_12_1.x) / 3, arg_12_1.y + (arg_12_2.y - arg_12_1.y) / 3)
end

function CrossRoadGameHelper:WeightCarRandom()
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(pg.crossroad_ship.all) do
		var_13_0 = var_13_0 + pg.crossroad_ship[iter_13_1].weight
	end

	local var_13_1 = math.random(0, var_13_0)

	if var_13_1 == 0 then
		return pg.crossroad_ship[pg.crossroad_ship.all[1]]
	end

	local var_13_2 = 0

	for iter_13_2, iter_13_3 in ipairs(pg.crossroad_ship.all) do
		if var_13_2 < var_13_1 and var_13_1 <= var_13_2 + pg.crossroad_ship[iter_13_3].weight then
			return pg.crossroad_ship[iter_13_3]
		end

		var_13_2 = var_13_2 + pg.crossroad_ship[iter_13_3].weight
	end

	warning("竟然有权重没有覆盖到的地方")

	return
end

function CrossRoadGameHelper:CheckTwoRoleIsCrash(arg_14_1, arg_14_2)
	local var_14_0, var_14_1, var_14_2, var_14_3 = arg_14_1:GetRoleRectPoint()
	local var_14_4, var_14_5, var_14_6, var_14_7 = arg_14_2:GetRoleRectPoint()

	return self:IsRectCross(var_14_0, var_14_1, var_14_2, var_14_3, var_14_4, var_14_5, var_14_6, var_14_7)
end

function CrossRoadGameHelper:CheckRoleInItem(arg_15_1, arg_15_2)
	local var_15_0, var_15_1, var_15_2, var_15_3 = arg_15_1:GetRoleRectPoint()
	local var_15_4, var_15_5 = self:GetPosByTf(arg_15_2.go)

	return math.max(var_15_0, var_15_4) <= math.min(var_15_2, var_15_5)
end

function CrossRoadGameHelper:CheckPlayerInItem(arg_16_1, arg_16_2)
	local var_16_0, var_16_1 = self:GetPosByTf(arg_16_1)
	local var_16_2, var_16_3 = self:GetPosByTf(arg_16_2)

	return math.max(var_16_0, var_16_2) <= math.min(var_16_1, var_16_3)
end

function CrossRoadGameHelper:GetPosByTf(arg_17_1)
	return arg_17_1.anchoredPosition.x - arg_17_1.rect.width / 2, arg_17_1.anchoredPosition.x + arg_17_1.rect.width / 2
end

function CrossRoadGameHelper:GetAddNum()
	if self <= 0 then
		return ""
	end

	return CrossRoadGameHelper.GetAddNum(math.floor(self / 10)) .. tostring(self % 10) .. " "
end

function CrossRoadGameHelper:CheckIsSPCar(arg_19_1)
	return CrossRoadGameConst.SP_CAR_ID[arg_19_1]
end

return CrossRoadGameHelper
