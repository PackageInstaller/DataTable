class = var_0_10000

local var_0_0 = "IslandSystemDelegationUnit"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandNpcUnit"))

function var_0_1.OnLaterAttach(arg_1_0, arg_1_1)
	GetOrAddComponent = var_1_10002

	local var_1_0 = arg_1_1

	typeof = var_1_10004
	UnityEngine = var_1_10005
	arg_1_0.agent = var_1_10002(var_1_0, var_1_10004(var_1_10005.AI.NavMeshAgent))
	arg_1_0.agent.updatePosition = true
	arg_1_0.agent.updateRotation = true
	arg_1_0._tf = arg_1_0._go.transform
	arg_1_0._degreeSpeedDamping = 10
	arg_1_0._targetSpeed = 0
	arg_1_0._speed = 0
	arg_1_0._speedDamping = 1
	arg_1_0._walkingMaxSpeed = 1.5
	arg_1_0._runMaxSpeed = 5
	Vector3 = var_2
	arg_1_0._targetPosition = var_2.zero
	Vector3 = var_2
	arg_1_0._velocity = var_2.zero
	Vector3 = var_2
	arg_1_0._extraVelocity = var_2.zero

	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_2.GetChild(var_1_1, 0)
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Animator = var_5
	arg_1_0._animator = var_1_3(var_1_2, var_4(var_5))
	arg_1_0.elapsedTime = 0
	arg_1_0.isNavigating = false
	pg = var_2

	local var_1_4 = var_2.island_unit_character[arg_1_0.modelId]
	local var_1_5 = arg_1_0._go
	local var_1_6 = var_3.GetComponent

	typeof = var_5
	UnityEngine = var_1_10006
	arg_1_0._characterController = var_1_6(var_1_5, var_5(var_1_10006.CharacterController))

	local var_1_11

	if var_1_4.CollisionParam ~= "" then
		local var_1_7 = arg_1_0._characterController

		var_1_7.enabled = false
		GetOrAddComponent = var_1_7

		local var_1_8 = arg_1_0._go

		typeof = var_1_11

		local var_1_9 = var_1_7(var_1_8, var_1_11("UnityEngine.CapsuleCollider"))

		ReflectionHelp = var_1_8

		local var_1_10 = var_1_8.RefSetProperty

		typeof = var_1_11
		var_1_11 = var_1_11("UnityEngine.CapsuleCollider")

		local var_1_12 = "center"
		local var_1_13 = var_1_9

		Vector3 = var_1_10008

		var_1_10(var_1_11, var_1_12, var_1_13, var_1_10008(0, var_1_4.CollisionParam[1], 0))

		ReflectionHelp = var_1_10

		local var_1_14 = var_1_10.RefSetProperty

		typeof = var_1_11

		var_1_14(var_1_11("UnityEngine.CapsuleCollider"), "radius", var_1_9, var_1_4.CollisionParam[2])

		ReflectionHelp = var_1_14

		local var_1_15 = var_1_14.RefSetProperty

		typeof = var_1_11

		var_1_15(var_1_11("UnityEngine.CapsuleCollider"), "height", var_1_9, var_1_4.CollisionParam[3])

		arg_1_0.agent.radius = var_1_4.CollisionParam[2]
	else
		local var_1_16 = arg_1_0._characterController

		var_1_16.enabled = false
		GetOrAddComponent = var_1_16

		local var_1_17 = arg_1_0._go

		typeof = var_1_11

		local var_1_18 = var_1_16(var_1_17, var_1_11("UnityEngine.CapsuleCollider"))

		ReflectionHelp = var_1_17

		local var_1_19 = var_1_17.RefSetProperty

		typeof = var_5

		local var_1_20 = var_5("UnityEngine.CapsuleCollider")
		local var_1_21 = "center"
		local var_1_22 = var_1_18

		Vector3 = var_1_10008

		var_1_19(var_1_20, var_1_21, var_1_22, var_1_10008(0, 0.96, 0))

		ReflectionHelp = var_1_19

		local var_1_23 = var_1_19.RefSetProperty

		typeof = var_1_20

		var_1_23(var_1_20("UnityEngine.CapsuleCollider"), "radius", var_1_18, 0.5)

		ReflectionHelp = var_1_23

		local var_1_24 = var_1_23.RefSetProperty

		typeof = var_5

		var_1_24(var_5("UnityEngine.CapsuleCollider"), "height", var_1_18, 1.76)

		arg_1_0.agent.radius = 0.5
	end

	arg_1_0:SetNavAgentStopDistance(2.1)

	arg_1_0.isNavigating = false

	return
end

function var_0_1.SetDestination(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.isNavigating = true

	arg_2_0:SetNavAgentDestination(arg_2_1)

	Mathf = var_3
	arg_2_0._targetSpeed = var_3.Clamp(arg_2_2 or 0, arg_2_0._walkingMaxSpeed, arg_2_0._runMaxSpeed)
	arg_2_0._targetPosition = arg_2_1

	return
end

function var_0_1.StopMove(arg_3_0)
	arg_3_0.isNavigating = false

	arg_3_0:StopNavAgent()

	arg_3_0._targetSpeed = 0
	Vector3 = var_1
	arg_3_0._targetPosition = var_1.zero

	if not arg_3_0.isLoading then
		local var_3_0 = arg_3_0._animator
		local var_3_1 = var_1.SetFloat

		IslandConst = var_1_10003

		var_3_1(var_3_0, var_1_10003.SPEED_FLAG_HASH, 0)
	end

	return
end

function var_0_1.Update(arg_4_0)
	if not arg_4_0:IsLoaded() then
		return
	end

	if not arg_4_0.active then
		return
	end

	if arg_4_0.isNavigating then
		arg_4_0:NavUpdate()
	else
		var_0_1.super.Update(arg_4_0)
	end

	return
end

function var_0_1.NavUpdate(arg_5_0)
	Mathf = var_1_10001
	arg_5_0._speed = var_1_10001.Lerp(arg_5_0._speed, arg_5_0._targetSpeed, arg_5_0._speedDamping)

	arg_5_0:SetNavAgentSpeed(arg_5_0._speed * 0.5)

	if not arg_5_0.isLoading then
		local var_5_0 = arg_5_0._animator
		local var_5_1 = var_1.SetFloat

		IslandConst = var_3

		var_5_1(var_5_0, var_3.SPEED_FLAG_HASH, arg_5_0._speed)
	end

	return
end

function var_0_1.SetNavAgentStopDistance(arg_6_0, arg_6_1)
	arg_6_0.agent.stoppingDistance = arg_6_1

	return
end

function var_0_1.SetNavAgentDestination(arg_7_0, arg_7_1)
	arg_7_0.agent.isStopped = false
	arg_7_0.agent.destination = arg_7_1

	return
end

function var_0_1.SetNavPosition(arg_8_0, arg_8_1)
	arg_8_0.agent.nextPosition = arg_8_1

	return
end

function var_0_1.CalculateNavPath(arg_9_0, arg_9_1)
	UnityEngine = var_1_10002

	local var_9_0 = var_1_10002.AI.NavMeshPath.New()
	local var_9_1 = arg_9_0.agent

	var_3.CalculatePath(var_9_1, arg_9_1, var_9_0)

	local var_9_2 = var_9_0.corners

	return (var_3.ToTable(var_9_2))
end

function var_0_1.SetNavAgentSpeed(arg_10_0, arg_10_1)
	arg_10_0.agent.speed = arg_10_1

	return
end

function var_0_1.GetNavAgentSpeed(arg_11_0, arg_11_1)
	return arg_11_0.agent.speed
end

function var_0_1.SetNavAgentVelocity(arg_12_0, arg_12_1)
	arg_12_0.agent.velocity = arg_12_1

	return
end

function var_0_1.GetNavAgentVelocity(arg_13_0)
	return arg_13_0.agent.desiredVelocity * arg_13_0.agent.speed
end

function var_0_1.GetDesiredVelocity(arg_14_0)
	return arg_14_0.agent.desiredVelocity
end

function var_0_1.StopNavAgent(arg_15_0)
	arg_15_0.agent.isStopped = true

	return
end

function var_0_1.GetAnimator(arg_16_0)
	return arg_16_0._animator
end

function var_0_1.SetShipDressHelper(arg_17_0, arg_17_1)
	arg_17_0.shipDressHelper = arg_17_1

	return
end

function var_0_1.OnDetach(arg_18_0)
	if arg_18_0.shipDressHelper then
		local var_18_0 = arg_18_0.shipDressHelper

		var_1.Destroy(var_18_0)
	end

	return
end

function var_0_1.OnCharacterChangeDress(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_1 then
		var_1_10004 = {}

		local function var_19_0()
			local var_20_0 = arg_19_0
			local var_20_1 = arg_19_0._tf
			local var_20_2 = var_1.GetChild(var_20_1, 0)
			local var_20_3 = var_1.GetComponent

			typeof = var_3
			Animator = var_2_10004
			var_20_0._animator = var_20_3(var_20_2, var_3(var_2_10004))
			ipairs = var_20_0

			for iter_20_0, iter_20_1 in var_20_0(var_1_10004) do
				local var_20_4 = arg_19_0._animator

				var_5.Play(var_20_4, iter_20_1.shortNameHash, iter_20_0 - 1, iter_20_1.normalizedTime)
			end

			arg_19_0.isLoading = false

			local var_20_5 = arg_19_0._tf
			local var_20_6 = var_0.GetComponent

			typeof = var_2
			NodeCanvas = iter_20_0

			local var_20_7 = var_20_6(var_20_5, var_2(iter_20_0.BehaviourTrees.BehaviourTreeOwner))

			var_0.StartBehaviour(var_20_7)

			return
		end

		arg_19_0.isLoading = true

		local var_19_1 = arg_19_0._tf
		local var_19_2 = var_6.GetComponent

		typeof = var_1_10008
		NodeCanvas = var_1_10009

		local var_19_3 = var_19_2(var_19_1, var_1_10008(var_1_10009.BehaviourTrees.BehaviourTreeOwner))

		var_6.PauseBehaviour(var_19_3)

		local var_19_4 = 0

		var_1_10009 = arg_19_0._animator
		var_1_10009 = var_8.GetCurrentAnimatorStateInfo(var_1_10009, var_19_4).normalizedTime % 1
		var_1_10009 = normalizedTime

		for iter_19_0 = 1, arg_19_0._animator.layerCount do
			local var_19_5 = iter_19_0 - 1
			local var_19_6 = arg_19_0._animator
			local var_19_7 = var_14.GetCurrentAnimatorStateInfo(var_19_6, var_19_5)

			table = var_19_6

			var_19_6.insert(var_1_10004, {
				shortNameHash = var_19_7.shortNameHash,
				normalizedTime = var_19_7.normalizedTime
			})
		end

		arg_19_0:DestroyInteractiveTools()

		if #arg_19_2 == 0 and #arg_19_3 == 0 then
			local var_19_8 = arg_19_0.shipDressHelper

			var_1_10009.ChangeModelTransfromByUnitId(var_19_8, arg_19_1, var_19_0)
		else
			local var_19_9 = arg_19_0.shipDressHelper

			var_1_10009.ChangeModelTransfromByUnitIdAndChangeDress(var_19_9, arg_19_1, arg_19_2, arg_19_3, var_19_0)
		end
	else
		ipairs = var_1_10004

		for iter_19_1, iter_19_2 in var_1_10004(arg_19_2) do
			pg = var_1_10009
			var_1_10009 = var_1_10009.island_dress_template[iter_19_2].type

			local var_19_10 = arg_19_0.shipDressHelper

			var_10.ChangeDressByType(var_19_10, var_1_10009, {
				id = 0,
				colorId = 0
			})
		end

		ipairs = var_4

		for iter_19_3, iter_19_4 in var_4(arg_19_3) do
			pg = var_1_10009
			var_1_10009 = var_1_10009.island_dress_template[iter_19_4].type

			local var_19_11 = arg_19_0.shipDressHelper

			var_10.ChangeDressByType(var_19_11, var_1_10009, {
				colorId = 0,
				id = iter_19_4
			})
		end
	end

	return
end

return var_0_1
