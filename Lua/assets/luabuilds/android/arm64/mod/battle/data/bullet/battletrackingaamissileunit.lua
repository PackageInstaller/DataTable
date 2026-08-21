ys = ys or {}

local var_0_0 = ys
local var_0_1 = Vector3.up
local var_0_2 = ys.Battle.BattleTargetChoise
local var_0_3 = class("BattleTrackingAAMissileUnit", ys.Battle.BattleBulletUnit)

var_0_3.__name = "BattleTrackingAAMissileUnit"
ys.Battle.BattleTrackingAAMissileUnit = var_0_3

function var_0_3.doAccelerate(arg_1_0, arg_1_1)
	local var_1_0, var_1_1 = arg_1_0:GetAcceleration(arg_1_1)

	if var_1_0 == 0 and var_1_1 == 0 then
		return
	end

	if var_1_0 < 0 and arg_1_0._speedLength + var_1_0 < 0 then
		arg_1_0:reverseAcceleration()
	end

	arg_1_0._speed:Set(arg_1_0._speed.x + arg_1_0._speedNormal.x * var_1_0 + arg_1_0._speedCross.x * var_1_1, arg_1_0._speed.y + arg_1_0._speedNormal.y * var_1_0 + arg_1_0._speedCross.y * var_1_1, arg_1_0._speed.z + arg_1_0._speedNormal.z * var_1_0 + arg_1_0._speedCross.z * var_1_1)

	arg_1_0._speedLength = arg_1_0._speed:Magnitude()

	if arg_1_0._speedLength ~= 0 then
		arg_1_0._speedNormal:Copy(arg_1_0._speed)
		arg_1_0._speedNormal:Div(arg_1_0._speedLength)
	end

	arg_1_0._speedCross:Copy(arg_1_0._speedNormal)
	arg_1_0._speedCross:Cross2(var_0_1)

	return
end

function var_0_3.doTrack(arg_2_0)
	if arg_2_0:getTrackingTarget() == nil then
		local var_2_0 = var_0_2.TargetWeightiest(arg_2_0, nil, (arg_2_0:GetFilteredList()))[1]

		if var_2_0 ~= nil then
			arg_2_0:setTrackingTarget(var_2_0)
		end
	end

	local var_2_1 = arg_2_0:getTrackingTarget()

	if var_2_1 == nil or var_2_1 == -1 then
		return
	elseif not var_2_1:IsAlive() then
		arg_2_0:CleanAimMark()
		arg_2_0:setTrackingTarget(-1)

		return
	end

	local var_2_2 = var_2_1:GetBeenAimedPosition()

	if not var_2_2 then
		return
	end

	local var_2_3 = var_2_2 - arg_2_0:GetPosition()

	var_2_3:SetNormalize()

	local var_2_4 = Vector3.Normalize(arg_2_0._speed)
	local var_2_5 = arg_2_0:GetSpeedRatio()
	local var_2_6 = Vector3.Dot(var_2_4, var_2_3)

	arg_2_0._speed:Set(arg_2_0._speed.x * var_2_6 + arg_2_0._speed.z * (var_2_4.z * var_2_3.x - var_2_4.x * var_2_3.z), 0, arg_2_0._speed.z * var_2_6 - arg_2_0._speed.x * (var_2_4.z * var_2_3.x - var_2_4.x * var_2_3.z))

	return
end

function var_0_3.doNothing(arg_3_0)
	if arg_3_0._gravity ~= 0 then
		arg_3_0._verticalSpeed = arg_3_0._verticalSpeed + arg_3_0._gravity * arg_3_0:GetSpeedRatio()
	end

	return
end

function var_0_3.GetFilteredList(arg_4_0)
	return (arg_4_0:FilterAngle((arg_4_0:FilterRange((var_0_2.TargetAllHarm(arg_4_0))))))
end

function var_0_3.FilterRange(arg_5_0, arg_5_1)
	if not arg_5_0._trackDist then
		return arg_5_1
	end

	for iter_5_0 = #arg_5_1, 1, -1 do
		if arg_5_0:IsOutOfRange(arg_5_1[iter_5_0]) then
			table.remove(arg_5_1, iter_5_0)
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
			table.remove(arg_7_1, iter_7_0)
		end
	end

	return arg_7_1
end

function var_0_3.IsOutOfAngle(arg_8_0, arg_8_1)
	if not arg_8_0._trackAngle or arg_8_0._trackAngle >= 360 then
		return false
	end

	local var_8_0 = arg_8_1:GetPosition() - arg_8_0:GetPosition()
	local var_8_1 = math.acos(Vector3.Dot(var_8_0, arg_8_0._speedNormal) / var_8_0:Magnitude())

	return var_8_1 > arg_8_0._trackRadian or var_8_1 < -arg_8_0._trackRadian
end

function var_0_3.SetTrackingFXData(arg_9_0, arg_9_1)
	arg_9_0._trackingFXData = arg_9_1

	return
end

function var_0_3.InitSpeed(arg_10_0, arg_10_1)
	if arg_10_0._yAngle == nil then
		arg_10_0._yAngle = arg_10_0._targetPos ~= nil and arg_10_1 + arg_10_0._barrageAngle or arg_10_0._baseAngle + arg_10_0._barrageAngle
	end

	arg_10_0:calcSpeed()

	local var_10_0 = {}

	if arg_10_0:IsTracker() then
		arg_10_0._trackAngle = 360
		arg_10_0._trackDist = arg_10_0._accTable.tracker.range

		if arg_10_0._accTable.tracker.angular then
			arg_10_0._trackRadian = math.deg2Rad * arg_10_0._trackAngle * 0.5
		end

		table.insert({}, arg_10_0.doTrack)
	end

	if arg_10_0:HasAcceleration() then
		arg_10_0._speedLength = arg_10_0._speed:Magnitude()
		arg_10_0._speedNormal = arg_10_0._speed / arg_10_0._speedLength
		arg_10_0._speedCross = Vector3.Cross(arg_10_0._speedNormal, var_0_1)

		table.insert({}, function(arg_12_0, ...)
			arg_10_0._speedLength = arg_10_0._speed:Magnitude()
			arg_10_0._speedNormal = arg_10_0._speed / arg_10_0._speedLength
			arg_10_0._speedCross = Vector3.Cross(arg_10_0._speedNormal, var_0_1)

			arg_10_0.doAccelerate(arg_12_0, ...)

			return
		end)
	end

	if #{} == 0 then
		table.insert({}, arg_10_0.doNothing)
	end

	function arg_10_0.updateSpeed(arg_11_0, arg_11_1)
		for iter_11_0, iter_11_1 in ipairs(var_10_0) do
			iter_11_1(arg_11_0, arg_11_1)
		end

		local var_11_0 = arg_10_0:getTrackingTarget()

		if var_11_0 and var_11_0 ~= -1 and not arg_10_0._trackingFXData.aimingFX and arg_10_0._trackingFXData.fxName and arg_10_0._trackingFXData.fxName ~= "" then
			arg_10_0._trackingFXData.aimingFX = var_0_0.Battle.BattleState.GetInstance():GetSceneMediator():GetCharacter(var_11_0:GetUniqueID()):AddFX(arg_10_0._trackingFXData.fxName)
		end

		return
	end

	return
end

function var_0_3.CleanAimMark(arg_13_0)
	local var_13_0 = arg_13_0:getTrackingTarget()

	if var_13_0 and var_13_0 ~= -1 and arg_13_0._trackingFXData.aimingFX then
		local var_13_1 = var_0_0.Battle.BattleState.GetInstance():GetSceneMediator():GetCharacter(var_13_0:GetUniqueID())

		if var_13_1 then
			var_13_1:RemoveFX(arg_13_0._trackingFXData.aimingFX)
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
