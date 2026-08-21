local var_0_0 = class("IslandNavigableUnit", import(".IslandSceneUnit"))

function var_0_0.WarpAgent(arg_1_0)
	arg_1_0.agent:Warp(arg_1_0._tf.position)

	;(arg_1_0.agent.steeringTarget - arg_1_0._tf.position).y = 0

	if (arg_1_0.agent.steeringTarget - arg_1_0._tf.position).sqrMagnitude > 0.001 then
		arg_1_0._tf.rotation = Quaternion.LookRotation(arg_1_0.agent.steeringTarget - arg_1_0._tf.position)
	end

	return
end

function var_0_0.OnLaterAttach(arg_2_0, arg_2_1)
	arg_2_0.agent = GetOrAddComponent(arg_2_1, typeof(UnityEngine.AI.NavMeshAgent))
	arg_2_0.agent.updatePosition = false
	arg_2_0.agent.updateRotation = false
	arg_2_0._tf = arg_2_0._go.transform
	arg_2_0._degreeSpeedDamping = 10
	arg_2_0._targetSpeed = 0
	arg_2_0._speed = 0
	arg_2_0._speedDamping = 1
	arg_2_0._walkingMaxSpeed = 1.5
	arg_2_0._runMaxSpeed = 5
	arg_2_0._targetPosition = Vector3.zero
	arg_2_0.verticalVelocity = 0
	arg_2_0.smoothVelocity = Vector3.zero
	arg_2_0.elapsedTime = 0
	arg_2_0._animator = arg_2_0._tf:GetChild(0):GetComponent(typeof(Animator))
	arg_2_0._characterController = arg_2_0._go:GetComponent(typeof(UnityEngine.CharacterController))

	arg_2_0:SetNavAgentStopDistance(2)

	arg_2_0.isNavigating = false

	return
end

function var_0_0.SetDestination(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.agent.radius = defaultValue(arg_3_3, 0.6)
	arg_3_0._characterController.radius = defaultValue(arg_3_4, 0.25)
	arg_3_0.isNavigating = true

	arg_3_0:SetNavAgentDestination(arg_3_1)

	arg_3_2 = Mathf.Clamp(arg_3_2 or 0, arg_3_0._walkingMaxSpeed, arg_3_0._runMaxSpeed)

	arg_3_0:SetNavAgentSpeed(arg_3_2)

	arg_3_0._targetPosition = arg_3_1
	arg_3_0.lastAvoidancePriority = arg_3_0.agent.avoidancePriority
	arg_3_0.agent.avoidancePriority = 0

	IslandHelper.SetLowQualityObstacle(arg_3_0.agent)

	return
end

function var_0_0.StopMove(arg_4_0)
	arg_4_0.agent.avoidancePriority = defaultValue(arg_4_0.lastAvoidancePriority, 10)
	arg_4_0.isNavigating = false

	arg_4_0:StopNavAgent()

	arg_4_0._targetSpeed = 0
	arg_4_0._characterController.radius = 0.5

	arg_4_0:WarpAgent()

	arg_4_0._targetPosition = Vector3.zero

	if arg_4_0._animator then
		arg_4_0._animator:SetFloat(IslandConst.SPEED_FLAG_HASH, 0)
	end

	arg_4_0.agent.radius = 0.5

	IslandHelper.SetHighQualityObstacle(arg_4_0.agent)

	return
end

function var_0_0.Update(arg_5_0)
	if not arg_5_0:IsLoaded() then
		return
	end

	arg_5_0.elapsedTime = arg_5_0.elapsedTime + Time.deltaTime

	if arg_5_0.stateCallback then
		arg_5_0:CheckAnimationState()
	end

	if not arg_5_0.active then
		return
	end

	if arg_5_0.isNavigating then
		arg_5_0:NavUpdate()
	else
		var_0_0.super.Update(arg_5_0)
	end

	return
end

function var_0_0.GetElapsedTime(arg_6_0)
	return arg_6_0.elapsedTime
end

function var_0_0.NavUpdate(arg_7_0)
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

	local var_7_0 = Vector3.zero

	if not arg_7_0.reached then
		local var_7_1 = 1

		if arg_7_0.agent.stoppingDistance * 2 > arg_7_0.agent.remainingDistance then
			var_7_1 = arg_7_0.agent.remainingDistance / (arg_7_0.agent.stoppingDistance * 2)
		end

		local var_7_3 = arg_7_0.smoothVelocity or Vector3.zero

		arg_7_0.smoothVelocity = var_7_2(var_7_3, Vector3(arg_7_0.agent.velocity.x, 0, arg_7_0.agent.velocity.z) * var_7_1, Time.deltaTime * 10)
		var_7_0 = arg_7_0.smoothVelocity
	end

	local var_7_4 = Vector3(var_7_0.x, 0, var_7_0.z)

	if not arg_7_0.reached and var_7_4.sqrMagnitude > 0.05 then
		arg_7_0._tf.rotation = Quaternion.Slerp(arg_7_0._tf.rotation, Quaternion.LookRotation(var_7_4), Time.deltaTime * 10)
	end

	arg_7_0.verticalVelocity = arg_7_0._characterController.isGrounded and -0.1 or arg_7_0.verticalVelocity + -9.81 * Time.deltaTime
	var_7_0.y = arg_7_0.verticalVelocity

	arg_7_0._characterController:Move(var_7_0 * Time.deltaTime)

	arg_7_0.agent.nextPosition = Vector3.Lerp(arg_7_0.agent.nextPosition, arg_7_0._tf.position, Time.deltaTime * 20)

	if arg_7_0._animator then
		arg_7_0._animator:SetFloat(IslandConst.SPEED_FLAG_HASH, var_7_4.magnitude * 1.5)
	end

	return
end

function var_0_0.SetNavAgentStopDistance(arg_8_0, arg_8_1)
	arg_8_0.agent.stoppingDistance = arg_8_1

	return
end

function var_0_0.SetNavAgentDestination(arg_9_0, arg_9_1)
	arg_9_0:CheckMovement()

	arg_9_0.agent.isStopped = false
	arg_9_0.agent.destination = arg_9_1

	return
end

function var_0_0.SetNavPosition(arg_10_0, arg_10_1)
	arg_10_0.agent.nextPosition = arg_10_1

	return
end

function var_0_0.CalculateNavPath(arg_11_0, arg_11_1)
	local var_11_0 = UnityEngine.AI.NavMeshPath.New()

	arg_11_0.agent:CalculatePath(arg_11_1, var_11_0)

	return (var_11_0.corners:ToTable())
end

function var_0_0.SetNavAgentSpeed(arg_12_0, arg_12_1)
	arg_12_0.agent.speed = arg_12_1

	return
end

function var_0_0.GetNavAgentSpeed(arg_13_0, arg_13_1)
	return arg_13_0.agent.speed
end

function var_0_0.SetNavAgentVelocity(arg_14_0, arg_14_1)
	arg_14_0.agent.velocity = arg_14_1

	return
end

function var_0_0.GetNavAgentVelocity(arg_15_0)
	return arg_15_0.agent.desiredVelocity * arg_15_0.agent.speed
end

function var_0_0.GetDesiredVelocity(arg_16_0)
	return arg_16_0.agent.desiredVelocity
end

function var_0_0.StopNavAgent(arg_17_0)
	arg_17_0.agent.isStopped = true

	return
end

function var_0_0.GetAnimator(arg_18_0)
	return arg_18_0._animator
end

function var_0_0.CheckMovement(arg_19_0)
	local var_19_0 = arg_19_0:GetAnimator():GetCurrentAnimatorStateInfo(0)

	if arg_19_0.cantMove then
		return false
	end

	if _.any(IslandConst.CANT_SWITCH_TO_MOVEMENT_STATES, function(arg_20_0)
		return var_19_0:IsName(arg_20_0)
	end) then
		return false
	end

	local var_19_1 = IslandConst.ANIMATION_MOVEMENT

	if not arg_19_0:GetAnimator():GetCurrentAnimatorStateInfo(0):IsName(IslandConst.ANIMATION_MOVEMENT) then
		arg_19_0:PlayAnimation(var_19_1, 0)

		return true
	end

	arg_19_0:ClearSatetCallback()

	return false
end

function var_0_0.PlayAnimation(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = defaultValue(arg_21_2, 0.25)

	if arg_21_1 == IslandConst.ANIMATION_HEROCOMING then
		var_21_0 = 0
	end

	local var_21_1 = arg_21_0:GetAnimator()
	local var_21_2 = Animator.StringToHash(arg_21_1)

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

function var_0_0.CheckAnimationState(arg_22_0)
	local var_22_0 = arg_22_0:GetAnimator()
	local var_22_1 = var_22_0:GetCurrentAnimatorStateInfo(0)

	if var_22_1:IsName(arg_22_0.stateCallback.state) and not arg_22_0.endTime then
		arg_22_0.endTime = arg_22_0:GetElapsedTime() + var_22_1.length / var_22_0.speed
	end

	if arg_22_0.endTime and arg_22_0:GetElapsedTime() >= arg_22_0.endTime then
		arg_22_0:ClearSatetCallback()
		arg_22_0.stateCallback.callback()
	end

	return
end

function var_0_0.ClearSatetCallback(arg_23_0)
	if arg_23_0.stateCallback then
		arg_23_0.stateCallback = nil
	end

	arg_23_0.endTime = nil

	return
end

function var_0_0.Enable(arg_24_0)
	var_0_0.super.Enable(arg_24_0)

	if not arg_24_0:IsLoaded() then
		return
	end

	arg_24_0.agent.enabled = true

	return
end

function var_0_0.Disable(arg_25_0)
	var_0_0.super.Disable(arg_25_0)

	if not arg_25_0:IsLoaded() then
		return
	end

	arg_25_0.agent.enabled = false

	return
end

function var_0_0.Dispose(arg_26_0)
	var_0_0.super.Dispose(arg_26_0)
	arg_26_0:ClearSatetCallback()

	return
end

return var_0_0
