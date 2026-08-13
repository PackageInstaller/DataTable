ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleTargetChoise
local var_0_2 = var_0.Battle.BattleFormulas

class = var_0_10003

local var_0_3 = var_0_10003("BattleSpaceLaserUnit", var_0.Battle.BattleColumnAreaBulletUnit)

var_0_3.__name = "BattleSpaceLaserUnit"
var_0.Battle.BattleSpaceLaserUnit = var_0_3
var_0_3.STATE_READY = "Ready"
var_0_3.STATE_PRECAST = "Precast"
var_0_3.STATE_ATTACK = "Attack"
var_0_3.STATE_DESTROY = "Destroy"

function var_0_3.Ctor(arg_1_0, ...)
	var_0_3.super.Ctor(arg_1_0, ...)

	arg_1_0._collidedTimes = {}

	return
end

function var_0_3.Dispose(arg_2_0)
	arg_2_0._lifeEndCb = nil
	arg_2_0._collidedTimes = nil

	var_0_3.super.Dispose(arg_2_0)

	return
end

function var_0_3.ExecuteLifeEndCallback(arg_3_0)
	if arg_3_0._lifeEndCb then
		arg_3_0._lifeEndCb()
	end

	return
end

function var_0_3.AssertFields(arg_4_0, arg_4_1)
	assert = var_1_10002

	var_1_10002(arg_4_0[arg_4_1], "Lack Field " .. arg_4_1)

	return
end

function var_0_3.SetTemplateData(arg_5_0, arg_5_1)
	arg_5_0.AssertFields(arg_5_1.extra_param, "attack_time")
	arg_5_0.AssertFields(arg_5_1.hit_type, "interval")
	var_0_3.super.SetTemplateData(arg_5_0, arg_5_1)

	arg_5_0._hitInterval = arg_5_1.hit_type.interval

	return
end

function var_0_3.GetHitInterval(arg_6_0)
	return arg_6_0._hitInterval
end

function var_0_3.DoTrack(arg_7_0)
	local var_7_0 = arg_7_0

	if not var_1.getTrackingTarget(var_7_0) or var_2 == -1 then
		return
	elseif not var_2:IsAlive() then
		var_1:setTrackingTarget(-1)

		local var_7_1 = var_1._speed
		local var_7_2 = var_3.SetNormalize(var_7_1)

		var_3.Mul(var_7_2, arg_7_0._convertedVelocity)

		return
	elseif var_1:GetDistance(var_2) > var_1._trackRange then
		var_1:setTrackingTarget(-1)

		local var_7_3 = var_1._speed
		local var_7_4 = var_4.SetNormalize(var_7_3)

		var_4.Mul(var_7_4, arg_7_0._convertedVelocity)

		return
	end

	local var_7_5 = var_2:GetPosition() - var_1:GetPosition()

	if var_3.Magnitude(var_7_5) <= 1e-05 then
		local var_7_6 = arg_7_0._speed

		var_5.Set(var_7_6, 0, 0, 0)

		return
	end

	local var_7_7 = arg_7_0._speedNormal

	var_3:SetNormalize()

	local var_7_8 = var_3.x * var_7_7.x + var_3.z * var_7_7.z
	local var_7_9 = var_3.z * var_7_7.x - var_3.x * var_7_7.z
	local var_7_10 = var_1
	local var_7_11 = var_1.GetSpeedRatio(var_7_10)

	math = var_9

	local var_7_12 = var_9.cos(var_1._cosAngularSpeed * var_7_11)

	math = var_7_10

	local var_7_13 = var_7_10.sin(var_1._sinAngularSpeed * var_7_11)
	local var_7_14 = var_7_8
	local var_7_15 = var_7_9

	if var_7_8 < var_7_12 then
		var_7_14 = var_7_12
		var_7_15 = var_7_13 * (var_7_15 > 0 and 1 or -1)
	end

	local var_7_16 = var_7_7.x * var_7_14 - var_7_7.z * var_7_15
	local var_7_17 = var_7_7.z * var_7_14 + var_7_7.x * var_7_15

	math = var_15

	local var_7_18 = var_15.min(arg_7_0._convertedVelocity, var_4)
	local var_7_19 = var_1._speed

	var_16.Set(var_7_19, var_7_16, 0, var_7_17)

	local var_7_20 = var_1._speed

	var_16.Mul(var_7_20, var_7_18)

	local var_7_21 = arg_7_0._speedNormal

	var_16.Set(var_7_21, var_7_16, 0, var_7_17)

	local var_7_22 = arg_7_0._speedNormal

	var_16.SetNormalize(var_7_22)

	math = var_16

	local var_7_23 = var_16.rad2Deg

	math = var_17
	arg_7_0._yAngle = var_7_23 * var_17.atan2(var_7_16, var_7_17)

	return
end

function var_0_3.InitSpeed(arg_8_0, ...)
	var_0_3.super.InitSpeed(arg_8_0, ...)

	if arg_8_0:IsTracker() then
		math = var_1

		local var_8_0 = var_1.deg2Rad * arg_8_0._yAngle

		Vector3 = var_2
		math = var_4

		local var_8_1 = var_4.cos(var_8_0)
		local var_8_2 = 0

		math = var_6
		arg_8_0._speedNormal = var_2(var_8_1, var_8_2, var_6.sin(var_8_0))
		arg_8_0.updateSpeed = arg_8_0.DoTrack
	elseif arg_8_0:IsCircle() and arg_8_0:IsAlert() then
		arg_8_0._centripetalSpeed = arg_8_0._centripetalSpeed * arg_8_0.alertSpeedRatio
	end

	return
end

function var_0_3.SetLifeTime(arg_9_0, arg_9_1)
	arg_9_0._lifeTime = arg_9_1

	return
end

function var_0_3.SetAlert(arg_10_0, arg_10_1)
	arg_10_0._alertFlag = arg_10_1

	if not arg_10_0:GetTemplate().extra_param.alertSpeed then
		return
	end

	arg_10_0:ResetVelocity(arg_10_0._velocity * var_2.alertSpeed)

	arg_10_0.alertSpeedRatio = var_2.alertSpeed

	return
end

function var_0_3.IsAlert(arg_11_0)
	return arg_11_0._alertFlag
end

function var_0_3.Update(arg_12_0, arg_12_1)
	var_0_3.super.Update(arg_12_0, arg_12_1)

	arg_12_0._reachDestFlag = arg_12_1 > arg_12_0._timeStamp + arg_12_0._lifeTime
	pg = var_2

	local var_12_0 = var_2.TimeMgr.GetInstance()
	local var_12_1 = var_2.GetCombatTime(var_12_0)

	pairs = var_3

	for iter_12_0, iter_12_1 in var_3(arg_12_0._collidedTimes) do
		if var_12_1 > iter_12_1 + arg_12_0._hitInterval then
			arg_12_0._collidedTimes[iter_12_0] = nil
			arg_12_0._collidedList[iter_12_0] = nil
		end
	end

	return
end

function var_0_3.GetCollidedList(arg_13_0)
	return arg_13_0._collidedList, arg_13_0._collidedTimes
end

function var_0_3.RegisterLifeEndCB(arg_14_0, arg_14_1)
	arg_14_0._lifeEndCb = arg_14_1

	return
end

function var_0_3.UnRegisterLifeEndCB(arg_15_0)
	arg_15_0._lifeEndCb = nil

	return
end

return
