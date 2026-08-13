class = var_0_10000

local var_0_0 = var_0_10000("CrossRoadGameHelper")

function var_0_0.IsRectCross(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8)
	math = var_1_10009

	local var_1_0 = var_1_10009.max(arg_1_1, arg_1_5)

	math = var_10

	if var_1_0 <= var_10.min(arg_1_3, arg_1_7) then
		math = var_1_0

		local var_1_1 = var_1_0.max(arg_1_2, arg_1_6)

		math = var_10

		local var_1_2

		if not (var_1_1 <= var_10.min(arg_1_4, arg_1_8)) then
			var_1_2 = false
		else
			var_1_2 = true
		end

		return var_1_2
	end
end

function var_0_0.GetPosDis(arg_2_0, arg_2_1, arg_2_2)
	math = var_1_10003

	return var_1_10003.sqrt((arg_2_1.x - arg_2_2.x) * (arg_2_1.x - arg_2_2.x) + (arg_2_1.y - arg_2_2.y) * (arg_2_1.y - arg_2_2.y))
end

function var_0_0.cross(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	return (arg_3_2.x - arg_3_1.x) * (arg_3_3.y - arg_3_1.y) - (arg_3_3.x - arg_3_1.x) * (arg_3_2.y - arg_3_1.y)
end

function var_0_0.crossOp(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	return arg_4_0:sign(arg_4_0:cross(arg_4_1, arg_4_2, arg_4_3))
end

function var_0_0.OnSeg(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	return arg_5_0:crossOp(arg_5_1, arg_5_3, arg_5_2) == 0 and arg_5_0:IsPointMiddle(arg_5_1, arg_5_2, arg_5_3)
end

function var_0_0.IsPointMiddle(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0

	if arg_6_0:isMiddle(arg_6_1.x, arg_6_2.x, arg_6_3.x) then
		var_6_0 = arg_6_0:isMiddle(arg_6_1.y, arg_6_2.y, arg_6_3.y)
	end

	return var_6_0
end

function var_0_0.isMiddle(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return arg_7_0:sign(arg_7_1 - arg_7_2) == 0 or arg_7_0:sign(arg_7_3 - arg_7_2) == 0 or arg_7_1 < arg_7_2 ~= (arg_7_3 < arg_7_2)
end

function var_0_0.IsInPoint(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0:sign(arg_8_1.x - arg_8_2.x) == 0 and arg_8_0:sign(arg_8_1.y - arg_8_2.y) == 0
end

function var_0_0.sign(arg_9_0, arg_9_1)
	CrossRoadGameConst = var_1_10002

	return arg_9_1 < -var_1_10002.EPS and -1 or var_2 < arg_9_1 and 1 or 0
end

function var_0_0.GetRandomList(arg_10_0, arg_10_1)
	local var_10_0 = #arg_10_1
	local var_10_1 = {}

	for iter_10_0 = 1, var_10_0 do
		var_10_1[iter_10_0] = arg_10_1[iter_10_0]
	end

	for iter_10_1 = var_10_0, 2, -1 do
		math = var_1_10008
		var_10_1[iter_10_1], var_10_1[var_1_10008] = var_10_1[var_1_10008.random(1, iter_10_1)], var_10_1[iter_10_1]
	end

	return var_10_1
end

function var_0_0.GetHalfPos(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1.x / 2 + arg_11_2.x / 2
	local var_11_1 = arg_11_1.y / 2 + arg_11_2.y / 2

	Vector2 = var_5

	return var_5.New(var_11_0, var_11_1)
end

function var_0_0.GetThirdPos(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1.x + (arg_12_2.x - arg_12_1.x) / 3
	local var_12_1 = arg_12_1.y + (arg_12_2.y - arg_12_1.y) / 3

	Vector2 = var_5

	return var_5.New(var_12_0, var_12_1)
end

function var_0_0.WeightCarRandom(arg_13_0)
	local var_13_0 = 0

	ipairs = var_1_10002
	pg = var_1_10003

	for iter_13_0, iter_13_1 in var_1_10002(var_1_10003.crossroad_ship.all) do
		pg = var_1_10007
		var_13_0 = var_13_0 + var_1_10007.crossroad_ship[iter_13_1].weight
	end

	math = var_2

	local var_13_1

	if var_2.random(0, var_13_0) == 0 then
		pg = var_13_1
		var_13_1 = var_13_1.crossroad_ship.all[1]
		pg = var_4

		return var_4.crossroad_ship[var_13_1]
	end

	local var_13_2 = 0

	ipairs = var_13_1
	pg = var_4

	for iter_13_2, iter_13_3 in var_13_1(var_4.crossroad_ship.all) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.crossroad_ship[iter_13_3]

		if var_13_2 < var_2 and var_2 <= var_13_2 + var_1_10008.weight then
			pg = var_9

			return var_9.crossroad_ship[iter_13_3]
		end

		var_13_2 = var_13_2 + var_1_10008.weight
	end

	warning = var_3

	var_3("竟然有权重没有覆盖到的地方")

	return
end

function var_0_0.CheckTwoRoleIsCrash(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0, var_14_1, var_14_2, var_14_3 = arg_14_1:GetRoleRectPoint()
	local var_14_4, var_14_5, var_14_6, var_14_7 = arg_14_2:GetRoleRectPoint()

	return arg_14_0:IsRectCross(var_14_0, var_14_1, var_14_2, var_14_3, var_14_4, var_14_5, var_14_6, var_14_7)
end

function var_0_0.CheckRoleInItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0, var_15_1, var_15_2, var_15_3 = arg_15_1:GetRoleRectPoint()
	local var_15_4, var_15_5 = arg_15_0:GetPosByTf(arg_15_2.go)

	math = var_9

	local var_15_6 = var_9.max(var_15_0, var_15_4)

	math = var_10

	return var_15_6 <= var_10.min(var_15_2, var_15_5)
end

function var_0_0.CheckPlayerInItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0, var_16_1 = arg_16_0:GetPosByTf(arg_16_1)
	local var_16_2, var_16_3 = arg_16_0:GetPosByTf(arg_16_2)

	math = var_7

	local var_16_4 = var_7.max(var_16_0, var_16_2)

	math = var_8

	return var_16_4 <= var_8.min(var_16_1, var_16_3)
end

function var_0_0.GetPosByTf(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.anchoredPosition
	local var_17_1 = arg_17_1.rect
	local var_17_2 = var_17_0.x - var_17_1.width / 2
	local var_17_3 = var_17_0.x + var_17_1.width / 2

	return var_17_2, var_17_3
end

function var_0_0.GetAddNum(arg_18_0)
	if arg_18_0 <= 0 then
		return ""
	end

	CrossRoadGameHelper = var_1

	local var_18_0 = var_1.GetAddNum

	math = var_1_10002

	local var_18_1 = var_18_0(var_1_10002.floor(arg_18_0 / 10))

	tostring = var_2

	return var_18_1 .. var_2(arg_18_0 % 10) .. " "
end

function var_0_0.CheckIsSPCar(arg_19_0, arg_19_1)
	CrossRoadGameConst = var_1_10002

	return var_1_10002.SP_CAR_ID[arg_19_1]
end

return var_0_0
