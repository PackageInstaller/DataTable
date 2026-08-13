class = var_0_10000

local var_0_0 = "IslandNavigableUnit"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandSceneUnit"))

function var_0_1.WarpAgent(arg_1_0)
	local var_1_0 = arg_1_0.agent

	var_1.Warp(var_1_0, arg_1_0._tf.position)

	local var_1_1 = arg_1_0.agent.steeringTarget - arg_1_0._tf.position

	var_1_1.y = 0

	local var_1_2 = var_1_1.sqrMagnitude

	if 0.001 < var_1_2 then
		local var_1_3 = arg_1_0._tf

		Quaternion = var_3
		var_1_3.rotation = var_3.LookRotation(var_1_1)
	end

	return
end

function var_0_1.OnLaterAttach(arg_2_0, arg_2_1)
	GetOrAddComponent = var_1_10002

	local var_2_0 = arg_2_1

	typeof = var_1_10005
	UnityEngine = var_1_10007
	arg_2_0.agent = var_1_10002(var_2_0, var_1_10005(var_1_10007.AI.NavMeshAgent))
	arg_2_0.agent.updatePosition = false
	arg_2_0.agent.updateRotation = false
	arg_2_0._tf = arg_2_0._go.transform
	arg_2_0._degreeSpeedDamping = 10
	arg_2_0._targetSpeed = 0
	arg_2_0._speed = 0
	arg_2_0._speedDamping = 1
	arg_2_0._walkingMaxSpeed = 1.5
	arg_2_0._runMaxSpeed = 5
	Vector3 = var_2
	arg_2_0._targetPosition = var_2.zero
	arg_2_0.verticalVelocity = 0
	Vector3 = var_2
	arg_2_0.smoothVelocity = var_2.zero
	arg_2_0.elapsedTime = 0

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_2.GetChild(var_2_1, 0)
	local var_2_3 = var_2.GetComponent

	typeof = var_5
	Animator = var_7
	arg_2_0._animator = var_2_3(var_2_2, var_5(var_7))

	local var_2_4 = arg_2_0._go
	local var_2_5 = var_2.GetComponent

	typeof = var_5
	UnityEngine = var_7
	arg_2_0._characterController = var_2_5(var_2_4, var_5(var_7.CharacterController))

	arg_2_0:SetNavAgentStopDistance(2)

	arg_2_0.isNavigating = false

	return
end

function var_0_1.SetDestination(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = arg_3_0.agent

	defaultValue = var_1_10006
	var_3_0.radius = var_1_10006(arg_3_3, 0.6)

	local var_3_1 = arg_3_0._characterController

	defaultValue = var_6
	var_3_1.radius = var_6(arg_3_4, 0.25)
	arg_3_0.isNavigating = true

	arg_3_0:SetNavAgentDestination(arg_3_1)

	Mathf = var_5
	arg_3_2 = var_5.Clamp(arg_3_2 or 0, arg_3_0._walkingMaxSpeed, arg_3_0._runMaxSpeed)

	arg_3_0:SetNavAgentSpeed(arg_3_2)

	arg_3_0._targetPosition = arg_3_1
	arg_3_0.lastAvoidancePriority = arg_3_0.agent.avoidancePriority

	local var_3_2 = arg_3_0.agent

	var_3_2.avoidancePriority = 0
	IslandHelper = var_3_2

	var_3_2.SetLowQualityObstacle(arg_3_0.agent)

	return
end

function var_0_1.StopMove(arg_4_0)
	local var_4_0 = arg_4_0.agent

	defaultValue = var_1_10002
	var_4_0.avoidancePriority = var_1_10002(arg_4_0.lastAvoidancePriority, 10)
	arg_4_0.isNavigating = false

	arg_4_0:StopNavAgent()

	arg_4_0._targetSpeed = 0
	arg_4_0._characterController.radius = 0.5

	arg_4_0:WarpAgent()

	Vector3 = var_1
	arg_4_0._targetPosition = var_1.zero

	if arg_4_0._animator then
		local var_4_1 = arg_4_0._animator
		local var_4_2 = var_1.SetFloat

		IslandConst = var_4

		var_4_2(var_4_1, var_4.SPEED_FLAG_HASH, 0)
	end

	local var_4_3 = arg_4_0.agent

	var_4_3.radius = 0.5
	IslandHelper = var_4_3

	var_4_3.SetHighQualityObstacle(arg_4_0.agent)

	return
end

function var_0_1.Update(arg_5_0)
	if not arg_5_0:IsLoaded() then
		return
	end

	local var_5_0 = arg_5_0.elapsedTime

	Time = var_1_10002
	arg_5_0.elapsedTime = var_5_0 + var_1_10002.deltaTime

	if arg_5_0.stateCallback then
		arg_5_0:CheckAnimationState()
	end

	if not arg_5_0.active then
		return
	end

	if arg_5_0.isNavigating then
		arg_5_0:NavUpdate()
	else
		var_0_1.super.Update(arg_5_0)
	end

	return
end

function var_0_1.GetElapsedTime(arg_6_0)
	return arg_6_0.elapsedTime
end

function var_0_1.NavUpdate(arg_7_0)
	if not arg_7_0.agent then
		return
	end

	if not arg_7_0.agent.pathPending and arg_7_0.agent.remainingDistance <= arg_7_0.agent.stoppingDistance then
		if not arg_7_0.agent.hasPath or arg_7_0.agent.velocity.sqrMagnitude < 0.01 then
			arg_7_0.reached = true
		end
	else
		arg_7_0.reached = false
	end

	Vector3 = var_1

	local var_7_0 = var_1.zero
	local var_7_1

	if not arg_7_0.reached then
		var_7_1 = arg_7_0.agent.velocity
		Vector3 = var_1_10003

		local var_7_2 = var_1_10003(var_7_1.x, 0, var_7_1.z)
		local var_7_3 = 1
		local var_7_4 = arg_7_0.agent.stoppingDistance * 2

		if arg_7_0.agent.remainingDistance < var_7_4 then
			var_7_3 = arg_7_0.agent.remainingDistance / var_7_4
		end

		Vector3 = var_6

		local var_7_5 = var_6.Lerp
		local var_7_6

		if not arg_7_0.smoothVelocity then
			Vector3 = var_7_6
			var_7_6 = var_7_6.zero
		end

		var_1_10009 = var_7_2 * var_7_3
		Time = var_1_10010
		arg_7_0.smoothVelocity = var_7_5(var_7_6, var_1_10009, var_1_10010.deltaTime * 10)
		var_7_0 = arg_7_0.smoothVelocity
	end

	Vector3 = var_7_1

	local var_7_7 = var_7_1(var_7_0.x, 0, var_7_0.z)
	local var_7_10

	if not arg_7_0.reached then
		local var_7_8 = var_7_7.sqrMagnitude

		if 0.05 < var_7_8 then
			Quaternion = var_7_8

			local var_7_9 = var_7_8.LookRotation(var_7_7)

			var_7_10 = arg_7_0._tf
			Quaternion = var_5

			local var_7_11 = var_5.Slerp
			local var_7_12 = arg_7_0._tf.rotation
			local var_7_13 = var_7_9

			Time = var_1_10009
			var_7_10.rotation = var_7_11(var_7_12, var_7_13, var_1_10009.deltaTime * 10)
		end
	end

	if arg_7_0._characterController.isGrounded then
		arg_7_0.verticalVelocity = -0.1
	else
		local var_7_14 = arg_7_0.verticalVelocity

		Time = var_7_10
		arg_7_0.verticalVelocity = var_7_14 + -9.81 * var_7_10.deltaTime
	end

	var_7_0.y = arg_7_0.verticalVelocity

	local var_7_15 = arg_7_0._characterController
	local var_7_16 = var_3.Move

	Time = var_6

	var_7_16(var_7_15, var_7_0 * var_6.deltaTime)

	local var_7_17 = arg_7_0._tf.position
	local var_7_18 = arg_7_0.agent

	Vector3 = var_7_15

	local var_7_19 = var_7_15.Lerp
	local var_7_20 = arg_7_0.agent.nextPosition
	local var_7_21 = var_7_17

	Time = var_1_10009
	var_7_18.nextPosition = var_7_19(var_7_20, var_7_21, var_1_10009.deltaTime * 20)

	local var_7_22 = var_7_7.magnitude * 1.5

	if arg_7_0._animator then
		local var_7_23 = arg_7_0._animator
		local var_7_24 = var_5.SetFloat

		IslandConst = var_7_21

		var_7_24(var_7_23, var_7_21.SPEED_FLAG_HASH, var_7_22)
	end

	return
end

function var_0_1.SetNavAgentStopDistance(arg_8_0, arg_8_1)
	arg_8_0.agent.stoppingDistance = arg_8_1

	return
end

function var_0_1.SetNavAgentDestination(arg_9_0, arg_9_1)
	arg_9_0:CheckMovement()

	arg_9_0.agent.isStopped = false
	arg_9_0.agent.destination = arg_9_1

	return
end

function var_0_1.SetNavPosition(arg_10_0, arg_10_1)
	arg_10_0.agent.nextPosition = arg_10_1

	return
end

function var_0_1.CalculateNavPath(arg_11_0, arg_11_1)
	UnityEngine = var_1_10002

	local var_11_0 = var_1_10002.AI.NavMeshPath.New()
	local var_11_1 = arg_11_0.agent

	var_3.CalculatePath(var_11_1, arg_11_1, var_11_0)

	local var_11_2 = var_11_0.corners

	return (var_3.ToTable(var_11_2))
end

function var_0_1.SetNavAgentSpeed(arg_12_0, arg_12_1)
	arg_12_0.agent.speed = arg_12_1

	return
end

function var_0_1.GetNavAgentSpeed(arg_13_0, arg_13_1)
	return arg_13_0.agent.speed
end

function var_0_1.SetNavAgentVelocity(arg_14_0, arg_14_1)
	arg_14_0.agent.velocity = arg_14_1

	return
end

function var_0_1.GetNavAgentVelocity(arg_15_0)
	return arg_15_0.agent.desiredVelocity * arg_15_0.agent.speed
end

function var_0_1.GetDesiredVelocity(arg_16_0)
	return arg_16_0.agent.desiredVelocity
end

function var_0_1.StopNavAgent(arg_17_0)
	arg_17_0.agent.isStopped = true

	return
end

function var_0_1.GetAnimator(arg_18_0)
	return arg_18_0._animator
end

function var_0_1.CheckMovement(arg_19_0)
	local var_19_0 = arg_19_0:GetAnimator()
	local var_19_1 = var_1.GetCurrentAnimatorStateInfo(var_19_0, 0)

	if arg_19_0.cantMove then
		return false
	end

	_ = var_3

	local var_19_2 = var_3.any

	IslandConst = var_5

	if var_19_2(var_5.CANT_SWITCH_TO_MOVEMENT_STATES, function(arg_20_0)
		local var_20_0 = var_19_1

		return var_1.IsName(var_20_0, arg_20_0)
	end) then
		return false
	end

	IslandConst = var_3

	local var_19_3 = var_3.ANIMATION_MOVEMENT

	if not var_19_1:IsName(var_19_3) then
		arg_19_0:PlayAnimation(var_19_3, 0)

		return true
	end

	arg_19_0:ClearSatetCallback()

	return false
end

function var_0_1.PlayAnimation(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	defaultValue = var_1_10004

	local var_21_0 = var_1_10004(arg_21_2, 0.25)

	IslandConst = var_1_10005

	if arg_21_1 == var_1_10005.ANIMATION_HEROCOMING then
		var_21_0 = 0
	end

	local var_21_1 = arg_21_0:GetAnimator()

	Animator = var_6

	local var_21_2 = var_6.StringToHash(arg_21_1)

	for iter_21_0 = 1, var_21_1.layerCount do
		var_21_1:CrossFadeInFixedTime(var_21_2, var_21_0, iter_21_0 - 1)
	end

	if arg_21_3 then
		arg_21_0:ClearSatetCallback()

		arg_21_0.stateCallback = {
			state = arg_21_1,
			callback = arg_21_3
		}
	end

	return
end

function var_0_1.CheckAnimationState(arg_22_0)
	local var_22_0 = arg_22_0.stateCallback.state
	local var_22_1 = arg_22_0.stateCallback.callback
	local var_22_2 = arg_22_0:GetAnimator()
	local var_22_3 = var_3.GetCurrentAnimatorStateInfo(var_22_2, 0)

	if var_4.IsName(var_22_3, var_22_0) and not arg_22_0.endTime then
		local var_22_4 = var_4.length / var_3.speed

		arg_22_0.endTime = arg_22_0:GetElapsedTime() + var_22_4
	end

	if arg_22_0.endTime and arg_22_0:GetElapsedTime() >= arg_22_0.endTime then
		arg_22_0:ClearSatetCallback()
		var_22_1()
	end

	return
end

function var_0_1.ClearSatetCallback(arg_23_0)
	if arg_23_0.stateCallback then
		arg_23_0.stateCallback = nil
	end

	arg_23_0.endTime = nil

	return
end

function var_0_1.Enable(arg_24_0)
	var_0_1.super.Enable(arg_24_0)

	if not arg_24_0:IsLoaded() then
		return
	end

	arg_24_0.agent.enabled = true

	return
end

function var_0_1.Disable(arg_25_0)
	var_0_1.super.Disable(arg_25_0)

	if not arg_25_0:IsLoaded() then
		return
	end

	arg_25_0.agent.enabled = false

	return
end

function var_0_1.Dispose(arg_26_0)
	var_0_1.super.Dispose(arg_26_0)
	arg_26_0:ClearSatetCallback()

	return
end

return var_0_1
