ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
Vector3 = var_0_10001

local var_0_1 = var_0_10001.up
local var_0_2 = var_0.Battle.BattleTargetChoise

class = var_0_10003

local var_0_3 = var_0_10003("BattleTrackingAAMissileUnit", var_0.Battle.BattleBulletUnit)

var_0_3.__name = "BattleTrackingAAMissileUnit"
var_0.Battle.BattleTrackingAAMissileUnit = var_0_3

function var_0_3.doAccelerate(arg_1_0, arg_1_1)
	local var_1_0, var_1_1 = arg_1_0:GetAcceleration(arg_1_1)

	if var_1_0 == 0 and var_1_1 == 0 then
		return
	end

	if var_1_0 < 0 and arg_1_0._speedLength + var_1_0 < 0 then
		arg_1_0:reverseAcceleration()
	end

	local var_1_2 = arg_1_0._speed

	var_4.Set(var_1_2, arg_1_0._speed.x + arg_1_0._speedNormal.x * var_1_0 + arg_1_0._speedCross.x * var_1_1, arg_1_0._speed.y + arg_1_0._speedNormal.y * var_1_0 + arg_1_0._speedCross.y * var_1_1, arg_1_0._speed.z + arg_1_0._speedNormal.z * var_1_0 + arg_1_0._speedCross.z * var_1_1)

	local var_1_3 = arg_1_0._speed

	arg_1_0._speedLength = var_4.Magnitude(var_1_3)

	if arg_1_0._speedLength ~= 0 then
		local var_1_4 = arg_1_0._speedNormal

		var_4.Copy(var_1_4, arg_1_0._speed)

		local var_1_5 = arg_1_0._speedNormal

		var_4.Div(var_1_5, arg_1_0._speedLength)
	end

	local var_1_6 = arg_1_0._speedCross

	var_4.Copy(var_1_6, arg_1_0._speedNormal)

	local var_1_7 = arg_1_0._speedCross

	var_4.Cross2(var_1_7, var_0_1)

	return
end

function var_0_3.doTrack(arg_2_0)
	if arg_2_0:getTrackingTarget() == nil then
		local var_2_0 = arg_2_0:GetFilteredList()

		if var_0_2.TargetWeightiest(arg_2_0, nil, var_2_0)[1] ~= nil then
			arg_2_0:setTrackingTarget(var_2)
		end
	end

	if arg_2_0:getTrackingTarget() == nil or var_1 == -1 then
		return
	elseif not var_1:IsAlive() then
		arg_2_0:CleanAimMark()
		arg_2_0:setTrackingTarget(-1)

		return
	end

	if not var_1:GetBeenAimedPosition() then
		return
	end

	local var_2_1 = arg_2_0
	local var_2_2 = var_2 - arg_2_0.GetPosition(var_2_1)

	var_3.SetNormalize(var_2_2)

	Vector3 = var_4

	local var_2_3 = var_4.Normalize(arg_2_0._speed)

	Vector3 = var_2_1

	local var_2_4 = var_2_1.Dot(var_2_3, var_3)
	local var_2_5 = var_2_3.z * var_3.x - var_2_3.x * var_3.z
	local var_2_6 = arg_2_0:GetSpeedRatio()
	local var_2_7 = var_2_4
	local var_2_8 = var_2_5
	local var_2_9 = arg_2_0._speed.x * var_2_7 + arg_2_0._speed.z * var_2_8
	local var_2_10 = arg_2_0._speed.z * var_2_7 - arg_2_0._speed.x * var_2_8
	local var_2_11 = arg_2_0._speed

	var_12.Set(var_2_11, var_2_9, 0, var_2_10)

	return
end

function var_0_3.doNothing(arg_3_0)
	if arg_3_0._gravity ~= 0 then
		arg_3_0._verticalSpeed = arg_3_0._verticalSpeed + arg_3_0._gravity * arg_3_0:GetSpeedRatio()
	end

	return
end

function var_0_3.GetFilteredList(arg_4_0)
	local var_4_0 = var_0_2.TargetAllHarm(arg_4_0)
	local var_4_1 = arg_4_0:FilterRange(var_4_0)

	return (arg_4_0:FilterAngle(var_4_1))
end

function var_0_3.FilterRange(arg_5_0, arg_5_1)
	if not arg_5_0._trackDist then
		return arg_5_1
	end

	for iter_5_0 = #arg_5_1, 1, -1 do
		if arg_5_0:IsOutOfRange(arg_5_1[iter_5_0]) then
			table = var_6

			var_6.remove(arg_5_1, iter_5_0)
		end
	end

	return arg_5_1
end

function var_0_3.IsOutOfRange(arg_6_0, arg_6_1)
	if not arg_6_0._trackDist then
		return true
	end

	return arg_6_0:GetDistance(arg_6_1) > arg_6_0._trackDist
end

function var_0_3.FilterAngle(arg_7_0, arg_7_1)
	if not arg_7_0._trackAngle or arg_7_0._trackAngle >= 360 then
		return arg_7_1
	end

	for iter_7_0 = #arg_7_1, 1, -1 do
		if arg_7_0:IsOutOfAngle(arg_7_1[iter_7_0]) then
			table = var_6

			var_6.remove(arg_7_1, iter_7_0)
		end
	end

	return arg_7_1
end

function var_0_3.IsOutOfAngle(arg_8_0, arg_8_1)
	if not arg_8_0._trackAngle or arg_8_0._trackAngle >= 360 then
		return false
	end

	local var_8_0 = arg_8_0:GetPosition()
	local var_8_1 = arg_8_1:GetPosition() - var_8_0
	local var_8_2 = arg_8_0._speedNormal

	Vector3 = var_1_10006

	local var_8_3 = var_1_10006.Dot(var_8_1, var_8_2) / var_8_1:Magnitude()

	math = var_7

	return var_7.acos(var_8_3) > arg_8_0._trackRadian or var_7 < -arg_8_0._trackRadian
end

function var_0_3.SetTrackingFXData(arg_9_0, arg_9_1)
	arg_9_0._trackingFXData = arg_9_1

	return
end

function var_0_3.InitSpeed(arg_10_0, arg_10_1)
	if arg_10_0._yAngle == nil then
		if arg_10_0._targetPos ~= nil then
			arg_10_0._yAngle = arg_10_1 + arg_10_0._barrageAngle
		else
			arg_10_0._yAngle = arg_10_0._baseAngle + arg_10_0._barrageAngle
		end
	end

	arg_10_0:calcSpeed()

	local var_10_0 = {}

	local function var_10_1(arg_11_0, arg_11_1)
		ipairs = var_2_10002

		for iter_11_0, iter_11_1 in var_2_10002(var_10_0) do
			iter_11_1(arg_11_0, arg_11_1)
		end

		local var_11_0 = arg_10_0

		if var_2.getTrackingTarget(var_11_0) and var_2 ~= -1 and not arg_10_0._trackingFXData.aimingFX and arg_10_0._trackingFXData.fxName and arg_10_0._trackingFXData.fxName ~= "" then
			local var_11_1 = var_0.Battle.BattleState.GetInstance()
			local var_11_2 = var_3.GetSceneMediator(var_11_1)
			local var_11_3 = var_3.GetCharacter(var_11_2, var_2:GetUniqueID())

			arg_10_0._trackingFXData.aimingFX = var_11_3:AddFX(arg_10_0._trackingFXData.fxName)
		end

		return
	end

	if arg_10_0:IsTracker() then
		local var_10_2 = arg_10_0._accTable.tracker

		arg_10_0._trackAngle = 360
		arg_10_0._trackDist = var_10_2.range

		if var_10_2.angular then
			math = var_5
			arg_10_0._trackRadian = var_5.deg2Rad * arg_10_0._trackAngle * 0.5
		end

		table = var_5

		var_5.insert(var_10_0, arg_10_0.doTrack)
	end

	if arg_10_0:HasAcceleration() then
		local var_10_3 = arg_10_0._speed

		arg_10_0._speedLength = var_4.Magnitude(var_10_3)
		arg_10_0._speedNormal = arg_10_0._speed / arg_10_0._speedLength
		Vector3 = var_4
		arg_10_0._speedCross = var_4.Cross(arg_10_0._speedNormal, var_0_1)
		table = var_4

		var_4.insert(var_10_0, function(arg_12_0, ...)
			local var_12_0 = arg_10_0
			local var_12_1 = arg_10_0._speed

			var_12_0._speedLength = var_2.Magnitude(var_12_1)
			arg_10_0._speedNormal = arg_10_0._speed / arg_10_0._speedLength

			local var_12_2 = arg_10_0

			Vector3 = var_2
			var_12_2._speedCross = var_2.Cross(arg_10_0._speedNormal, var_0_1)

			arg_10_0.doAccelerate(arg_12_0, ...)

			return
		end)
	end

	if #var_10_0 == 0 then
		table = var_4

		var_4.insert(var_10_0, arg_10_0.doNothing)
	end

	arg_10_0.updateSpeed = var_10_1

	return
end

function var_0_3.CleanAimMark(arg_13_0)
	if arg_13_0:getTrackingTarget() and var_1 ~= -1 and arg_13_0._trackingFXData.aimingFX then
		local var_13_0 = var_0.Battle.BattleState.GetInstance()
		local var_13_1 = var_2.GetSceneMediator(var_13_0)

		if var_2.GetCharacter(var_13_1, var_1:GetUniqueID()) then
			var_3:RemoveFX(arg_13_0._trackingFXData.aimingFX)
		end

		arg_13_0._trackingFXData.aimingFX = nil
	end

	return
end

function var_0_3.OutRange(arg_14_0, ...)
	arg_14_0:CleanAimMark()
	var_0_3.super.OutRange(arg_14_0, ...)

	return
end

return
