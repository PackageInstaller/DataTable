require = var_0_10000

local var_0_0 = var_0_10000("Framework.toLua.UnityEngine.Vector3")

require = var_1

local var_0_1 = var_1("Framework.toLua.UnityEngine.Quaternion")

class = var_2

local var_0_2 = "IslandDelegationFishUnit"

import = var_0_10004

local var_0_3 = var_2(var_0_2, var_0_10004(".IslandSceneUnit"))

LayerMask = var_0_2

local var_0_4 = var_0_2.NameToLayer("IgnoreIslandCharacter")

bit = var_4

local var_0_5 = var_4.bnot

bit = var_5

local var_0_6 = var_0_5(var_5.lshift(1, var_0_4))
local var_0_7 = {
	changeTargetInterval = 4,
	noiseAmplitude = 0.8,
	noiseScale = 0.5,
	avoidBoost = 1.5,
	avoidTurnAngle = 45,
	baseSpeed = 2,
	speedChangeRate = 0.5,
	turnDetectionThreshold = 0.4,
	turnSpeed = 2,
	maxSpeedFactor = 2,
	turnSlowdownFactor = 0.6,
	avoidBoostDuration = 1,
	minSpeedFactor = 0.5,
	avoidDistance = 2
}

function var_0_3.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_3.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	local var_1_0

	if not arg_1_2.speed then
		var_1_0 = var_0_7.baseSpeed
	end

	arg_1_0.speed = var_1_0

	return
end

function var_0_3.OnAttach(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0._tf = arg_2_1.transform

	local var_2_0

	if not arg_2_0.speed then
		var_2_0 = var_0_7.baseSpeed
	end

	arg_2_0.baseSpeed = var_2_0

	local var_2_1

	if not arg_2_0.turnSpeed then
		var_2_1 = var_0_7.turnSpeed
	end

	arg_2_0.turnSpeed = var_2_1

	local var_2_2

	if not arg_2_0.avoidDistance then
		var_2_2 = var_0_7.avoidDistance
	end

	arg_2_0.avoidDistance = var_2_2

	local var_2_3

	if not arg_2_0.avoidTurnAngle then
		var_2_3 = var_0_7.avoidTurnAngle
	end

	arg_2_0.avoidTurnAngle = var_2_3

	local var_2_4

	if not arg_2_0.obstacleMask then
		var_2_4 = var_0_7.obstacleMask
	end

	arg_2_0.obstacleMask = var_2_4

	local var_2_5

	if not arg_2_0.avoidBoost then
		var_2_5 = var_0_7.avoidBoost
	end

	arg_2_0.avoidBoost = var_2_5

	local var_2_6

	if not arg_2_0.avoidBoostDuration then
		var_2_6 = var_0_7.avoidBoostDuration
	end

	arg_2_0.avoidBoostDuration = var_2_6
	arg_2_0.minSpeed = arg_2_0.baseSpeed * var_0_7.minSpeedFactor

	local var_2_7

	if not arg_2_0.baseSpeed then
		var_2_7 = var_0_7.maxSpeedFactor
	end

	arg_2_0.maxSpeed = var_2_7

	local var_2_8

	if not arg_2_0.speedChangeRate then
		var_2_8 = var_0_7.speedChangeRate
	end

	arg_2_0.speedChangeRate = var_2_8

	local var_2_9

	if not arg_2_0.noiseScale then
		var_2_9 = var_0_7.noiseScale
	end

	arg_2_0.noiseScale = var_2_9

	local var_2_10

	if not arg_2_0.noiseAmplitude then
		var_2_10 = var_0_7.noiseAmplitude
	end

	arg_2_0.noiseAmplitude = var_2_10

	local var_2_11

	if not arg_2_0.turnSlowdownFactor then
		var_2_11 = var_0_7.turnSlowdownFactor
	end

	arg_2_0.turnSlowdownFactor = var_2_11

	local var_2_12

	if not arg_2_0.turnDetectionThreshold then
		var_2_12 = var_0_7.turnDetectionThreshold
	end

	arg_2_0.turnDetectionThreshold = var_2_12
	arg_2_0.changeTargetInterval = var_0_7.changeTargetInterval
	arg_2_0.targetPos = var_0_0.zero
	arg_2_0.timer = 0
	arg_2_0.currentSpeed = arg_2_0.baseSpeed
	math = var_2
	arg_2_0.noiseSeed = var_2.random() * 100
	arg_2_0.avoidBoostTimer = 0

	local var_2_13

	if not arg_2_0._tf.rotation then
		var_2_13 = var_0_1.identity
	end

	arg_2_0.lastRotation = var_2_13

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_2.GetChild(var_2_14, 0)
	local var_2_16 = var_2.GetComponent

	typeof = var_4
	Animator = var_1_10005
	arg_2_0.animator = var_2_16(var_2_15, var_4(var_1_10005))

	return
end

function var_0_3.SetFishPonds(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.view
	local var_3_1 = var_2.GetUnitModuleWithType

	IslandConst = var_1_10004

	local var_3_2 = var_3_1(var_3_0, var_1_10004.UNIT_LIST_OBJ, arg_3_1)._go.transform
	local var_3_3 = var_3.GetComponent

	typeof = var_5
	FishPond = var_1_10006

	local var_3_4 = var_3_3(var_3_2, var_5(var_1_10006))

	arg_3_0.pond = var_3.GetBounds(var_3_4)

	return
end

function var_0_3.GetRandomPoint(arg_4_0)
	local var_4_0 = arg_4_0.pond
	local var_4_1 = var_1.GetMin(var_4_0)
	local var_4_2 = arg_4_0.pond
	local var_4_3 = var_2.GetMax(var_4_2)
	local var_4_4 = var_0_0.New

	math = var_1_10004

	local var_4_5 = var_1_10004.random() * (var_4_3.x - var_4_1.x) + var_4_1.x

	math = var_5

	local var_4_6 = var_5.random() * (var_4_3.y - var_4_1.y) + var_4_1.y

	math = var_6

	return var_4_4(var_4_5, var_4_6, var_6.random() * (var_4_3.z - var_4_1.z) + var_4_1.z)
end

function var_0_3.StartFishing(arg_5_0)
	arg_5_0.startFishing = true
	arg_5_0._tf.position = arg_5_0:GetRandomPoint()

	local var_5_0 = arg_5_0.animator

	var_1.Play(var_5_0, "walk")

	return
end

function var_0_3.OnUpdate(arg_6_0)
	if not arg_6_0.startFishing then
		return
	end

	Time = var_1

	local var_6_0 = var_1.deltaTime

	arg_6_0.timer = arg_6_0.timer + var_6_0

	if arg_6_0.timer > arg_6_0.changeTargetInterval then
		arg_6_0:SetNewTarget()
	end

	arg_6_0:UpdateSpeed()
	arg_6_0:Move()
	arg_6_0:KeepInsideBounds()

	return
end

function var_0_3.Move(arg_7_0)
	local var_7_0 = arg_7_0._tf.position

	if (arg_7_0.targetPos - var_7_0).sqrMagnitude < 0.01 then
		return
	end

	if var_2.normalized ~= var_0_0.zero then
		local var_7_1 = var_0_1.LookRotation(var_2)
		local var_7_2 = arg_7_0._tf
		local var_7_3 = var_0_1.Slerp
		local var_7_4 = arg_7_0._tf.rotation
		local var_7_5 = var_7_1

		var_1_10008 = arg_7_0.turnSpeed
		Time = var_1_10009
		var_7_2.rotation = var_7_3(var_7_4, var_7_5, var_1_10008 * var_1_10009.deltaTime)
	end

	local var_7_6 = var_0_1.Angle(arg_7_0._tf.rotation, arg_7_0.lastRotation)

	Mathf = var_4

	local var_7_7 = var_7_6 * var_4.Deg2Rad

	arg_7_0.lastRotation = arg_7_0._tf.rotation

	local var_7_8 = 1

	if var_7_7 > arg_7_0.turnDetectionThreshold then
		var_7_8 = var_7_8 * arg_7_0.turnSlowdownFactor
	end

	local var_7_9 = arg_7_0.avoidBoostTimer

	if 0 < var_7_9 then
		local var_7_10 = arg_7_0.avoidBoostTimer

		Time = var_7
		arg_7_0.avoidBoostTimer = var_7_10 - var_7.deltaTime
		var_7_8 = var_7_8 * arg_7_0.avoidBoost
	end

	local var_7_11 = arg_7_0._tf.forward * (arg_7_0.currentSpeed * var_7_8)

	Time = var_1_10008

	local var_7_12 = var_7_11 * var_1_10008.deltaTime

	arg_7_0._tf.position = arg_7_0._tf.position + var_7_12

	return
end

function var_0_3.UpdateSpeed(arg_8_0)
	Mathf = var_1_10001

	local var_8_0 = var_1_10001.PerlinNoise
	local var_8_1 = arg_8_0.noiseSeed

	Time = var_1_10003

	local var_8_2 = var_8_0(var_8_1, var_1_10003.time * arg_8_0.noiseScale)

	Mathf = var_8_1

	local var_8_3 = var_8_1.Lerp(arg_8_0.minSpeed, arg_8_0.maxSpeed, var_8_2 * arg_8_0.noiseAmplitude)

	Mathf = var_3

	local var_8_4 = var_3.Lerp
	local var_8_5 = arg_8_0.currentSpeed
	local var_8_6 = var_8_3

	Time = var_1_10006
	arg_8_0.currentSpeed = var_8_4(var_8_5, var_8_6, var_1_10006.deltaTime * arg_8_0.speedChangeRate)

	return
end

function var_0_3.SetNewTarget(arg_9_0)
	arg_9_0.timer = 0

	local var_9_0 = arg_9_0.pond

	Mathf = var_1_10002

	local var_9_1 = var_1_10002.Lerp
	local var_9_2 = var_9_0.min.x
	local var_9_3 = var_9_0.max.x

	math = var_1_10005

	local var_9_4 = var_9_1(var_9_2, var_9_3, var_1_10005.random())

	Mathf = var_9_2

	local var_9_5 = var_9_2.Lerp
	local var_9_6 = var_9_0.min.y
	local var_9_7 = var_9_0.max.y

	math = var_1_10006

	local var_9_8 = var_9_5(var_9_6, var_9_7, var_1_10006.random())

	Mathf = var_9_6

	local var_9_9 = var_9_6.Lerp
	local var_9_10 = var_9_0.min.z
	local var_9_11 = var_9_0.max.z

	math = var_1_10007

	local var_9_12 = var_9_9(var_9_10, var_9_11, var_1_10007.random())

	arg_9_0.targetPos = var_0_0.New(var_9_4, var_9_8, var_9_12)
	arg_9_0.changeTargetInterval = (arg_9_0.targetPos - arg_9_0._tf.position).magnitude / arg_9_0.speed

	return
end

function var_0_3.AvoidCollision(arg_10_0)
	local var_10_0 = arg_10_0._tf.position
	local var_10_1 = arg_10_0._tf.forward
	local var_10_2 = 0.5
	local var_10_3

	if not arg_10_0.avoidDistance then
		var_10_3 = var_0_7.avoidDistance
	end

	Physics = var_1_10005

	local var_10_4, var_10_5 = var_1_10005.SphereCast(var_10_0, var_10_2, var_10_1, nil, var_10_3, var_0_6)

	if var_10_4 and var_10_5 and var_10_5.collider then
		math = var_7

		local var_10_6 = (var_7.random() - 0.5) * 2 * arg_10_0.avoidTurnAngle
		local var_10_7 = var_0_1.Euler(0, var_10_6, 0) * arg_10_0._tf.forward
		local var_10_8 = var_0_1.LookRotation(var_10_7)
		local var_10_9 = arg_10_0._tf
		local var_10_10 = var_0_1.Slerp
		local var_10_11 = arg_10_0._tf.rotation
		local var_10_12 = var_10_8
		local var_10_13 = arg_10_0.turnSpeed

		Time = var_1_10015
		var_10_9.rotation = var_10_10(var_10_11, var_10_12, var_10_13 * var_1_10015.deltaTime)

		arg_10_0:SetNewTarget()

		arg_10_0.avoidBoostTimer = arg_10_0.avoidBoostDuration
	end

	return
end

function var_0_3.KeepInsideBounds(arg_11_0)
	local var_11_0 = arg_11_0.pond
	local var_11_1 = arg_11_0._tf.position
	local var_11_2 = false

	if var_11_0.Contains then
		var_11_2 = var_11_0:Contains(var_11_1)
	else
		var_11_2 = var_11_1.x >= var_11_0.min.x and var_11_1.x <= var_11_0.max.x and var_11_1.y >= var_11_0.min.y and var_11_1.y <= var_11_0.max.y and var_11_1.z >= var_11_0.min.z and var_11_1.z <= var_11_0.max.z
	end

	if not var_11_2 then
		if (arg_11_0.pond.center - var_11_1).normalized ~= var_0_0.zero then
			local var_11_3 = var_0_1.LookRotation(var_4)
			local var_11_4 = arg_11_0._tf
			local var_11_5 = var_0_1.Slerp
			local var_11_6 = arg_11_0._tf.rotation
			local var_11_7 = var_11_3
			local var_11_8 = arg_11_0.turnSpeed

			Time = var_1_10011
			var_11_4.rotation = var_11_5(var_11_6, var_11_7, var_11_8 * var_1_10011.deltaTime)
		end

		if var_11_0.ClosestPoint then
			local var_11_9 = var_11_0:ClosestPoint(var_11_1)

			arg_11_0._tf.position = var_0_0.Lerp(var_11_1, var_11_9, 0.5)
		else
			arg_11_0._tf.position = var_0_0.Lerp(var_11_1, arg_11_0.pond.center, 0.5)
		end

		arg_11_0:SetNewTarget()
	end

	return
end

return var_0_3
