local var_0_0 = class("PacGameMovingController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._sceneMask = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._runningData = arg_1_3

	return
end

function var_0_0.Prepare(arg_2_0)
	arg_2_0._roles = {}
	arg_2_0._gridDic = {}
	arg_2_0._gridWidth, arg_2_0._gridHeight = arg_2_0._runningData:GetGridRect()
	arg_2_0._halfGridWidth, arg_2_0._halfGridHeight = arg_2_0._gridWidth / 2, arg_2_0._gridHeight / 2
	arg_2_0._vertical, arg_2_0._horizontal = arg_2_0._runningData:GetGridWH()

	return
end

function var_0_0.Start(arg_3_0)
	arg_3_0._roles = arg_3_0._runningData:GetRoles()
	arg_3_0._gridDic = arg_3_0._runningData:GetGridDic()

	return
end

function var_0_0.Step(arg_4_0, arg_4_1)
	arg_4_0._deltaTime = arg_4_1

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._roles) do
		arg_4_0:MovingRole(iter_4_1)
	end

	return
end

function var_0_0.MovingRole(arg_5_0, arg_5_1)
	if arg_5_1:HasTarget() then
		local var_5_0 = arg_5_1:GetMove()
		local var_5_1 = arg_5_1:GetSpeed()
		local var_5_2 = arg_5_1:GetGridIndex()
		local var_5_3 = Vector2(var_5_1 * var_5_0.x * arg_5_0._deltaTime, var_5_1 * var_5_0.y * arg_5_0._deltaTime)
		local var_5_4 = arg_5_1:GetTarget()
		local var_5_5 = arg_5_1:GetPosition()
		local var_5_6 = Vector2(var_5_5.x + var_5_3.x, var_5_5.y + var_5_3.y)

		if arg_5_0:checkMoveToTarget(var_5_5, var_5_6, var_5_4) then
			arg_5_1:SetPosition(var_5_4)
			arg_5_1:SetGridIndex((arg_5_1:GetTargetIndex()))
			arg_5_1:SetTarget(nil)
			arg_5_0:MovingRole(arg_5_1)
		else
			local var_5_7 = true

			if var_5_7 then
				arg_5_1:MoveTo(var_5_6)
			end
		end
	elseif arg_5_1:GetRoads() and #arg_5_1:GetRoads() > 0 and not arg_5_1:HasTarget() then
		local var_5_8 = arg_5_1:PopRoad()
		local var_5_9 = arg_5_1:GetGridIndex()
		local var_5_10

		if not arg_5_0:checkNear(var_5_8, var_5_9) then
			print("位置不相邻，结束 " .. tostring(var_5_8) .. ":" .. tostring(var_5_9))

			do return end

			var_5_10 = arg_5_0._gridDic[var_5_8]:GetPosition()
		end

		arg_5_1:SetTarget(var_5_10, var_5_8, arg_5_0:getMoving(arg_5_1:GetPosition(), var_5_10), (arg_5_0:getDirectByIndex(var_5_9, var_5_8)))
	else
		local var_5_11 = arg_5_1:GetDirect()

		if var_5_11[1] == 0 and var_5_11[2] == 0 then
			return
		end

		local var_5_12 = arg_5_0._runningData:getDirectGrid(arg_5_1:GetGridIndex(), Vector2(var_5_11[1], var_5_11[2]))

		if var_5_12 then
			arg_5_1:SetTarget(var_5_12:GetPosition(), var_5_12:GetIndex(), arg_5_0:getMoving(arg_5_1:GetPosition(), var_5_12:GetPosition()), var_5_11)
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
	if math.abs(arg_12_3.x - arg_12_1.x) >= 300 or math.abs(arg_12_3.y - arg_12_1.y) >= 300 then
		warning("超出正常坐标值")

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

	if math.abs(arg_12_3.x - arg_12_1.x) <= 5 and math.abs(arg_12_3.y - arg_12_1.y) <= 5 then
		return true
	end

	return false
end

function var_0_0.getMoving(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = math.atan(math.abs(arg_13_2.y - arg_13_1.y) / math.abs(arg_13_2.x - arg_13_1.x))
	local var_13_1 = math.cos(var_13_0) * (arg_13_2.x >= arg_13_1.x and 1 or -1)
	local var_13_2 = math.sin(var_13_0) * (arg_13_2.y >= arg_13_1.y and 1 or -1)

	if math.abs(var_13_1) <= 0.01 then
		var_13_1 = 0
	end

	if math.abs(var_13_2) <= 0.01 then
		var_13_2 = 0
	end

	return Vector2(var_13_1, var_13_2)
end

return var_0_0
