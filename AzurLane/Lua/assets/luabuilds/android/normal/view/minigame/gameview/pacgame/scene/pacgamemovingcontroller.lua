class = var_0_10000

local var_0_0 = var_0_10000("PacGameMovingController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._sceneMask = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._runningData = arg_1_3

	return
end

function var_0_0.Prepare(arg_2_0)
	arg_2_0._roles = {}
	arg_2_0._gridDic = {}

	local var_2_0 = arg_2_0._runningData

	arg_2_0._gridWidth, arg_2_0._gridHeight = var_1.GetGridRect(var_2_0)
	arg_2_0._halfGridWidth, arg_2_0._halfGridHeight = arg_2_0._gridWidth / 2, arg_2_0._gridHeight / 2

	local var_2_1 = arg_2_0._runningData

	arg_2_0._vertical, arg_2_0._horizontal = var_1.GetGridWH(var_2_1)

	return
end

function var_0_0.Start(arg_3_0)
	local var_3_0 = arg_3_0._runningData

	arg_3_0._roles = var_1.GetRoles(var_3_0)

	local var_3_1 = arg_3_0._runningData

	arg_3_0._gridDic = var_1.GetGridDic(var_3_1)

	return
end

function var_0_0.Step(arg_4_0, arg_4_1)
	arg_4_0._deltaTime = arg_4_1
	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0._roles) do
		arg_4_0:MovingRole(iter_4_1)
	end

	return
end

function var_0_0.MovingRole(arg_5_0, arg_5_1)
	if arg_5_1:HasTarget() then
		local var_5_0 = arg_5_1:GetMove()
		local var_5_1 = arg_5_1:GetSpeed()
		local var_5_2 = arg_5_1:GetGridIndex()
		local var_5_3 = arg_5_1
		local var_5_4 = arg_5_1.GetTargetIndex(var_5_3)

		Vector2 = var_5_3

		local var_5_5 = var_5_3(var_5_1 * var_5_0.x * arg_5_0._deltaTime, var_5_1 * var_5_0.y * arg_5_0._deltaTime)

		var_1_10007 = arg_5_1:GetTarget()
		var_1_10009 = arg_5_1

		local var_5_6 = arg_5_1.GetPosition(var_1_10009)

		Vector2 = var_1_10009
		var_1_10009 = var_1_10009(var_5_6.x + var_5_5.x, var_5_6.y + var_5_5.y)

		if arg_5_0:checkMoveToTarget(var_5_6, var_1_10009, var_1_10007) then
			arg_5_1:SetPosition(var_1_10007)
			arg_5_1:SetGridIndex(var_5_4)
			arg_5_1:SetTarget(nil)
			arg_5_0:MovingRole(arg_5_1)
		else
			local var_5_7 = true

			if var_5_7 then
				arg_5_1:MoveTo(var_1_10009)
			end
		end
	elseif arg_5_1:GetRoads() and #arg_5_1:GetRoads() > 0 and not arg_5_1:HasTarget() then
		local var_5_8 = arg_5_1:PopRoad()
		local var_5_9 = arg_5_1:GetGridIndex()
		local var_5_10 = arg_5_0._gridDic[var_5_8]

		if not arg_5_0:checkNear(var_5_8, var_5_9) then
			print = var_5

			local var_5_11 = "位置不相邻，结束 "

			tostring = var_1_10007
			var_1_10007 = var_1_10007(var_5_8)

			local var_5_12 = ":"

			tostring = var_1_10009

			var_5(var_5_11 .. var_1_10007 .. var_5_12 .. var_1_10009(var_5_9))

			return
		end

		local var_5_13 = arg_5_0:getDirectByIndex(var_5_9, var_5_8)

		var_1_10007 = arg_5_1

		local var_5_14 = arg_5_1.GetPosition(var_1_10007)

		var_1_10007 = var_5_10:GetPosition()

		local var_5_15 = arg_5_0:getMoving(var_5_14, var_1_10007)

		arg_5_1:SetTarget(var_1_10007, var_5_8, var_5_15, var_5_13)
	else
		if arg_5_1:GetDirect()[1] == 0 and var_2[2] == 0 then
			return
		end

		local var_5_16 = arg_5_1:GetGridIndex()
		local var_5_17 = arg_5_0._runningData
		local var_5_18 = var_4.getDirectGrid
		local var_5_19 = var_5_16

		Vector2 = var_1_10007

		if var_5_18(var_5_17, var_5_19, var_1_10007(var_2[1], var_2[2])) then
			local var_5_20 = arg_5_0:getMoving(arg_5_1:GetPosition(), var_4:GetPosition())

			arg_5_1:SetTarget(var_4:GetPosition(), var_4:GetIndex(), var_5_20, var_2)
		end
	end

	return
end

function var_0_0.Clear(arg_6_0)
	return
end

function var_0_0.Stop(arg_7_0)
	return
end

function var_0_0.Resume(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	return
end

function var_0_0.getDirectByIndex(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 + 1 == arg_10_2 then
		return {
			1,
			0
		}
	elseif arg_10_1 - 1 == arg_10_2 then
		return {
			-1,
			0
		}
	elseif arg_10_1 + arg_10_0._horizontal == arg_10_2 then
		return {
			0,
			-1
		}
	elseif arg_10_1 - arg_10_0._horizontal == arg_10_2 then
		return {
			0,
			1
		}
	end

	return
end

function var_0_0.checkNear(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 + 1 == arg_11_2 or arg_11_1 - 1 == arg_11_2 then
		return true
	elseif arg_11_1 + arg_11_0._horizontal == arg_11_2 or arg_11_1 - arg_11_0._horizontal == arg_11_2 then
		return true
	end

	return false
end

function var_0_0.checkMoveToTarget(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	math = var_1_10004

	if not (var_1_10004.abs(arg_12_3.x - arg_12_1.x) >= 300) then
		math = var_4

		if var_4.abs(arg_12_3.y - arg_12_1.y) >= 300 then
			warning = var_4

			var_4("超出正常坐标值")

			return true
		end

		if arg_12_1.x < arg_12_3.x and arg_12_2.x >= arg_12_3.x then
			return true
		elseif arg_12_1.x > arg_12_3.x and arg_12_2.x <= arg_12_3.x then
			return true
		elseif arg_12_1.y < arg_12_3.y and arg_12_2.y >= arg_12_3.y then
			return true
		elseif arg_12_1.y > arg_12_3.y and arg_12_2.y <= arg_12_3.y then
			return true
		end

		math = var_4

		if var_4.abs(arg_12_3.x - arg_12_1.x) <= 5 then
			math = var_4

			if var_4.abs(arg_12_3.y - arg_12_1.y) <= 5 then
				return true
			end
		end

		return false
	end
end

function var_0_0.getMoving(arg_13_0, arg_13_1, arg_13_2)
	math = var_1_10003

	local var_13_0 = var_1_10003.atan

	math = var_1_10004

	local var_13_1 = var_1_10004.abs(arg_13_2.y - arg_13_1.y)

	math = var_5

	local var_13_2 = var_13_0(var_13_1 / var_5.abs(arg_13_2.x - arg_13_1.x))
	local var_13_3 = arg_13_2.x >= arg_13_1.x and 1 or -1
	local var_13_4 = arg_13_2.y
	local var_13_5 = arg_13_1.y <= var_13_4 and 1 or -1

	math = var_6

	local var_13_6 = var_6.cos(var_13_2) * var_13_3

	math = var_7

	local var_13_7 = var_7.sin(var_13_2) * var_13_5

	math = var_8

	if var_8.abs(var_13_6) <= 0.01 then
		var_13_6 = 0
	end

	math = var_8

	if var_8.abs(var_13_7) <= 0.01 then
		var_13_7 = 0
	end

	Vector2 = var_8

	return var_8(var_13_6, var_13_7)
end

return var_0_0
