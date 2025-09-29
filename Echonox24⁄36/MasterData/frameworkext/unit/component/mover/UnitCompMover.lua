module("frameworkext.unit.component.mover.UnitCompMover", package.seeall)

local var_0_0 = class("UnitCompMover", UnitComponentBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._speed = 0
	arg_1_0._speedX = 0
	arg_1_0._speedY = 0
	arg_1_0._posX = 0
	arg_1_0._posY = 0
	arg_1_0._wpPool = NavWayPoint.getPool()
	arg_1_0._wayPoints = {}
	arg_1_0._curWayPoint = nil
	arg_1_0._accerationTime = 0
	arg_1_0._startMoveTime = 0
end

function var_0_0.setPosDirectly(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:clearWayPoints()

	arg_2_0._posX = arg_2_1
	arg_2_0._posY = arg_2_2

	arg_2_0._unit:dispatchInnerEvent(UnitActionType.PosChanged)
end

function var_0_0.getCurWayPoint(arg_3_0)
	return arg_3_0._curWayPoint
end

function var_0_0.getPos(arg_4_0)
	return arg_4_0._posX, arg_4_0._posY
end

function var_0_0.setSpeed(arg_5_0, arg_5_1)
	arg_5_0._speed = arg_5_1

	if not arg_5_0._curWayPoint then
		arg_5_0._speedX = 0
		arg_5_0._speedY = 0
	else
		local var_5_0 = arg_5_0._curWayPoint.x - arg_5_0._posX
		local var_5_1 = arg_5_0._curWayPoint.y - arg_5_0._posY
		local var_5_2 = math.sqrt(var_5_0 * var_5_0 + var_5_1 * var_5_1)
		local var_5_3 = var_5_0 / var_5_2
		local var_5_4 = var_5_1 / var_5_2

		arg_5_0._speedX = var_5_3 * arg_5_0._speed
		arg_5_0._speedY = var_5_4 * arg_5_0._speed
	end
end

function var_0_0.setAccelerationTime(arg_6_0, arg_6_1)
	arg_6_0._accerationTime = arg_6_1
end

function var_0_0.getAccelerationTime(arg_7_0)
	return arg_7_0._accerationTime
end

function var_0_0.setWayPoint(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._wayPoints then
		return
	end

	local var_8_0 = #arg_8_0._wayPoints

	for iter_8_0 = 1, var_8_0 do
		arg_8_0._wpPool:returnObject(arg_8_0._wayPoints[iter_8_0])

		arg_8_0._wayPoints[iter_8_0] = nil
	end

	local var_8_1 = arg_8_0._wpPool:fetchObject()

	var_8_1.x = arg_8_1
	var_8_1.y = arg_8_2

	arg_8_0:_setNewWayPoint(var_8_1)
end

function var_0_0.addWayPoint(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._posX == arg_9_1 and arg_9_0._posY == arg_9_2 then
		if not arg_9_0._curWayPoint then
			return
		elseif arg_9_0._curWayPoint.x == arg_9_1 and arg_9_0._curWayPoint.y == arg_9_2 then
			return
		end
	end

	local var_9_0 = arg_9_0._wpPool:fetchObject()

	var_9_0.x = arg_9_1
	var_9_0.y = arg_9_2

	if not arg_9_0._curWayPoint then
		arg_9_0:_setNewWayPoint(var_9_0)
	else
		table.insert(arg_9_0._wayPoints, var_9_0)
	end
end

function var_0_0.clearWayPoints(arg_10_0)
	local var_10_0 = #arg_10_0._wayPoints

	for iter_10_0 = 1, var_10_0 do
		arg_10_0._wpPool:returnObject(arg_10_0._wayPoints[iter_10_0])

		arg_10_0._wayPoints[iter_10_0] = nil
	end

	if arg_10_0._curWayPoint then
		arg_10_0:_setNewWayPoint(nil)
		arg_10_0._unit:dispatchInnerEvent(UnitActionType.Interrupt)
	end
end

function var_0_0._setNewWayPoint(arg_11_0, arg_11_1)
	local var_11_0 = false

	if arg_11_0._curWayPoint then
		arg_11_0._wpPool:returnObject(arg_11_0._curWayPoint)
	elseif arg_11_1 then
		var_11_0 = true
	end

	arg_11_0._curWayPoint = arg_11_1

	if not arg_11_0._curWayPoint then
		arg_11_0._speedX = 0
		arg_11_0._speedY = 0
	else
		local var_11_1 = arg_11_0._curWayPoint.x - arg_11_0._posX
		local var_11_2 = arg_11_0._curWayPoint.y - arg_11_0._posY
		local var_11_3 = math.sqrt(var_11_1 * var_11_1 + var_11_2 * var_11_2)
		local var_11_4 = var_11_1 / var_11_3
		local var_11_5 = var_11_2 / var_11_3

		arg_11_0._speedX = var_11_4 * arg_11_0._speed
		arg_11_0._speedY = var_11_5 * arg_11_0._speed
	end

	if var_11_0 then
		arg_11_0._startMoveTime = Time.time

		arg_11_0._unit:dispatchInnerEvent(UnitActionType.StartMove)
	end
end

function var_0_0.update(arg_12_0)
	if arg_12_0._curWayPoint then
		local var_12_0 = Time.deltaTime

		if arg_12_0._accerationTime > 0 then
			local var_12_1 = Time.time - arg_12_0._startMoveTime

			if var_12_1 < arg_12_0._accerationTime then
				var_12_0 = var_12_0 * (var_12_1 / arg_12_0._accerationTime)
			end
		end

		local var_12_2 = arg_12_0._posX + arg_12_0._speedX * var_12_0
		local var_12_3 = arg_12_0._posY + arg_12_0._speedY * var_12_0
		local var_12_4 = var_12_2 - arg_12_0._posX
		local var_12_5 = var_12_3 - arg_12_0._posY
		local var_12_6 = arg_12_0._curWayPoint.x - arg_12_0._posX
		local var_12_7 = arg_12_0._curWayPoint.y - arg_12_0._posY

		if var_12_4 * var_12_4 + var_12_5 * var_12_5 >= var_12_6 * var_12_6 + var_12_7 * var_12_7 then
			arg_12_0._posX = arg_12_0._curWayPoint.x
			arg_12_0._posY = arg_12_0._curWayPoint.y

			arg_12_0._unit:dispatchInnerEvent(UnitActionType.PosChanged)
			arg_12_0._unit:dispatchInnerEvent(UnitActionType.PassWayPoint, arg_12_0._posX, arg_12_0._posY)

			if #arg_12_0._wayPoints > 0 then
				local var_12_8 = arg_12_0._wayPoints[1]

				table.remove(arg_12_0._wayPoints, 1)
				arg_12_0:_setNewWayPoint(var_12_8)
			else
				arg_12_0:_setNewWayPoint(nil)
				arg_12_0._unit:dispatchInnerEvent(UnitActionType.Arrive)
			end
		else
			arg_12_0._posX = var_12_2
			arg_12_0._posY = var_12_3

			arg_12_0._unit:dispatchInnerEvent(UnitActionType.PosChanged)
		end
	end
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0:clearWayPoints()

	arg_13_0._wpPool = nil
	arg_13_0._wayPoints = nil
	arg_13_0._curWayPoint = nil
end

return var_0_0
