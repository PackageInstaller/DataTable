class = var_0_10000

local var_0_0 = "WSMapPath"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
	path = "table",
	startPos = "table",
	upOffset = "number",
	theme = "table",
	moveAction = "string",
	wsObject = "table",
	twId = "number",
	paused = "boolean",
	dirType = "number",
	step = "number"
}
var_0_1.EventStartTrip = "WSMapPath.EventStartTrip"
var_0_1.EventArrivedStep = "WSMapPath.EventArrivedStep"
var_0_1.EventArrived = "WSMapPath.EventArrived"

function var_0_1.Setup(arg_1_0, arg_1_1)
	arg_1_0.theme = arg_1_1

	return
end

function var_0_1.Dispose(arg_2_0)
	if arg_2_0.twId then
		LeanTween = var_1

		var_1.cancel(arg_2_0.twId)
	end

	arg_2_0:Clear()

	return
end

function var_0_1.UpdateObject(arg_3_0, arg_3_1)
	assert = var_1_10002

	local var_3_0

	if arg_3_1.GetModelAngles and arg_3_1.UpdateModelAngles then
		var_3_0 = arg_3_1.UpdateModelAction
	end

	var_1_10002(var_3_0)

	arg_3_0.wsObject = arg_3_1

	return
end

function var_0_1.UpdateAction(arg_4_0, arg_4_1)
	arg_4_0.moveAction = arg_4_1

	return
end

function var_0_1.UpdateDirType(arg_5_0, arg_5_1)
	arg_5_0.dirType = arg_5_1

	return
end

function var_0_1.StartMove(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.startPos = arg_6_1
	arg_6_0.path = arg_6_2
	arg_6_0.upOffset = arg_6_3 or 0
	arg_6_0.step = 0
	arg_6_0.wsObject.isMoving = true

	local var_6_0 = arg_6_0.wsObject

	var_4.UpdateModelAction(var_6_0, arg_6_0.moveAction)
	arg_6_0:DispatchEvent(var_0_1.EventStartTrip)
	arg_6_0:MoveStep()

	return
end

function var_0_1.MoveStep(arg_7_0)
	local var_7_0 = arg_7_0.wsObject
	local var_7_1 = arg_7_0.path
	local var_7_2

	if not (arg_7_0.step > 0) or not var_7_1[arg_7_0.step] then
		var_7_2 = arg_7_0.startPos
	end

	local var_7_3 = var_7_1[arg_7_0.step + 1]
	local var_7_4 = var_7_1[#var_7_1]
	local var_7_5 = var_7_0:GetModelAngles()
	local var_7_6 = arg_7_0.dirType

	WorldConst = var_1_10008

	local var_7_9

	if var_7_6 == var_1_10008.DirType4 then
		if var_7_3.column < var_7_2.column then
			var_7_5.z = 180
		else
			local var_7_7 = var_7_3.column

			if var_7_2.column < var_7_7 then
				var_7_5.z = 0
			elseif var_7_3.row < var_7_2.row then
				var_7_5.z = 90
			else
				local var_7_8 = var_7_3.row

				if var_7_2.row < var_7_8 then
					var_7_5.z = 270
				end
			end
		end

		var_7_9 = var_7_0

		var_7_0.UpdateModelAngles(var_7_9, var_7_5)
	else
		local var_7_10 = arg_7_0.dirType

		WorldConst = var_7_9

		if var_7_10 == var_7_9.DirType2 then
			if var_7_3.column < var_7_2.column or var_7_3.column == var_7_2.column and var_7_4.column < var_7_2.column then
				var_7_5.y = 180
			elseif var_7_3.column ~= var_7_2.column or var_7_4.column ~= var_7_2.column then
				var_7_5.y = 0
			end

			var_7_0:UpdateModelAngles(var_7_5)
		end
	end

	local var_7_11 = arg_7_0.theme
	local var_7_12 = var_7.GetLinePosition(var_7_11, var_7_2.row, var_7_2.column)
	local var_7_13 = arg_7_0.theme
	local var_7_14 = var_8.GetLinePosition(var_7_13, var_7_3.row, var_7_3.column)

	assert = var_7_13

	var_7_13(var_7_3.duration, "without move duration")

	LeanTween = var_7_13

	local var_7_15 = var_7_13.value(var_7_0.transform.gameObject, 0, 1, var_7_3.duration)
	local var_7_16 = var_9.setOnUpdate

	System = var_11

	local var_7_17 = var_7_16(var_7_15, var_11.Action_float(function(arg_8_0)
		Vector3 = var_2_10001

		local var_8_0 = var_2_10001.Lerp(var_7_12, var_7_14, arg_8_0)
		local var_8_1 = arg_7_0
		local var_8_2, var_8_3 = var_2.CalcUpOffset(var_8_1, arg_7_0.step, arg_8_0)

		var_7_0.transform.localPosition = var_8_0 + var_8_2

		if var_7_0.rtShadow then
			local var_8_4 = var_7_0.rtShadow

			Vector3 = var_5
			var_8_4.localPosition = var_5(0, -var_8_3, 0)
		end

		return
	end))
	local var_7_18 = var_9.setOnComplete

	System = var_11
	arg_7_0.twId = var_7_18(var_7_17, var_11.Action(function()
		arg_7_0.step = arg_7_0.step + 1

		if arg_7_0.step >= #var_7_1 then
			arg_7_0.twId = nil

			local var_9_0 = var_7_0
			local var_9_1 = var_0.UpdateModelAction

			WorldConst = var_2_10002

			var_9_1(var_9_0, var_2_10002.ActionIdle)

			var_7_0.isMoving = false

			local var_9_2 = arg_7_0

			var_0.DispatchEvent(var_9_2, var_0_1.EventArrived)
		else
			local var_9_3 = arg_7_0

			var_0.DispatchEvent(var_9_3, var_0_1.EventArrivedStep, var_7_3)

			onDelayTick = var_0

			var_0(function()
				local var_10_0 = arg_7_0

				var_0.MoveStep(var_10_0)

				return
			end, 0.015)
		end

		return
	end)).uniqueId

	arg_7_0:FlushPaused()

	return
end

function var_0_1.UpdatePaused(arg_11_0, arg_11_1)
	if arg_11_0.paused ~= arg_11_1 then
		arg_11_0.paused = arg_11_1

		arg_11_0:FlushPaused()
	end

	return
end

function var_0_1.FlushPaused(arg_12_0)
	local var_12_1

	if arg_12_0.paused then
		LeanTween = var_12_1

		var_12_1.pause(arg_12_0.twId)

		local var_12_0 = arg_12_0.wsObject

		var_12_1 = var_12_1.UpdateModelAction
		WorldConst = var_1_10003

		var_12_1(var_12_0, var_1_10003.ActionIdle)
	else
		LeanTween = var_12_1

		var_12_1.resume(arg_12_0.twId)

		local var_12_2 = arg_12_0.wsObject

		var_1.UpdateModelAction(var_12_2, arg_12_0.moveAction)
	end

	return
end

function var_0_1.CalcUpOffset(arg_13_0, arg_13_1, arg_13_2)
	math = var_1_10003

	local var_13_0 = var_1_10003.sin
	local var_13_1 = (arg_13_1 + arg_13_2) / #arg_13_0.path

	math = var_5

	local var_13_2 = var_13_0(var_13_1 * var_5.pi)

	math = var_4

	local var_13_3 = var_4.clamp(var_13_2, 0, 1) * arg_13_0.upOffset

	Vector3 = var_5

	return var_5(0, arg_13_0.theme.cosAngle * var_13_3, -arg_13_0.theme.sinAngle * var_13_3), var_13_3
end

function var_0_1.IsMoving(arg_14_0)
	return arg_14_0.twId ~= nil
end

return var_0_1
