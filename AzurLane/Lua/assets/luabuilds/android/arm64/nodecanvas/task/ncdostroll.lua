class = var_0_10000

local var_0_0 = "NcDoStroll"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.NodeCanvasBaseTask"))

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.index = 1
	arg_1_0.speed = 2
	arg_1_0.rotationSpeed = 10
	arg_1_0.isStopping = false

	return
end

function var_0_1.OnExecute(arg_2_0)
	_IslandCore = var_1_10001

	if not var_1_10001 then
		return
	end

	arg_2_0.agent = arg_2_0:GetAgent()

	local var_2_0 = arg_2_0.agent.gameObject

	arg_2_0.navAgent = var_1.GetComponent(var_2_0, "NavMeshAgent")

	local var_2_1 = arg_2_0.agent.gameObject
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	WorldObjectItem = var_1_10006
	arg_2_0.unitId = var_2_2(var_2_1, var_4(var_1_10006)).id
	arg_2_0.unitType = var_1.type
	_IslandFindUnit = var_2

	local var_2_3 = var_2(arg_2_0.unitType, arg_2_0.unitId).transform
	local var_2_4 = var_3.GetChild(var_2_3, 0)
	local var_2_5 = var_3.GetComponent

	typeof = var_6
	Animator = var_1_10008
	arg_2_0.animator = var_2_5(var_2_4, var_6(var_1_10008))

	local var_2_6 = arg_2_0:GetBlackboardVariable("pause")

	_IslandCore = var_4

	local var_2_7 = var_4:GetController().strollAllocator
	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.GetFloatArg(var_2_8, "pathId")

	arg_2_0.chaoticOrder = arg_2_0:GetBoolArg("chaoticOrder")

	local var_2_10 = var_2_7:GetWaypoints(var_2_9)

	assert = var_2_8

	var_2_8(#var_2_10 > 0, "waypoints is empty")

	_ = var_2_8
	arg_2_0.waypoints = var_2_8.map(var_2_10, function(arg_3_0)
		IslandWayPoint = var_2_10001

		return var_2_10001.New(arg_3_0)
	end)

	if not arg_2_0:IsLegalPath() then
		arg_2_0:EndAction(false)

		return
	end

	arg_2_0.delayInit = false

	if var_2_6 then
		arg_2_0:ResumeMove()
	elseif not arg_2_0.navAgent.isOnNavMesh then
		arg_2_0.delayInit = true
	else
		arg_2_0:NextOne()
	end

	return
end

function var_0_1.IsLegalPath(arg_4_0)
	local var_4_0

	if arg_4_0.waypoints then
		var_4_0 = #arg_4_0.waypoints > 1
	end

	return var_4_0
end

function var_0_1.OnUpdate(arg_5_0)
	if arg_5_0.delayInit and arg_5_0.navAgent.isOnNavMesh then
		arg_5_0:NextOne()

		arg_5_0.delayInit = false
	end

	if not arg_5_0.navAgent.enabled then
		return
	end

	if not arg_5_0.navAgent.isOnNavMesh then
		return
	end

	if not arg_5_0:IsLegalPath() then
		return
	end

	if arg_5_0.index <= 0 or arg_5_0.index > #arg_5_0.waypoints then
		arg_5_0:EndAction(false)

		return
	end

	arg_5_0:CheckProcessTime()
	arg_5_0:CheckProcessAnimation()
	arg_5_0:CheckArriveAnimation()
	arg_5_0:CheckArriveTime()
	arg_5_0:UpdateRatation()

	local var_5_0 = arg_5_0.waypoints[arg_5_0.index].position

	if not arg_5_0.navAgent.pathPending and arg_5_0.navAgent.remainingDistance <= arg_5_0.navAgent.stoppingDistance and not arg_5_0.isStopping then
		arg_5_0:OnArrive()
	end

	return
end

function var_0_1.UpdateRatation(arg_6_0)
	if not arg_6_0.targetRotation then
		return
	end

	local var_6_0 = arg_6_0.agent

	Quaternion = var_1_10002

	local var_6_1 = var_1_10002.Slerp
	local var_6_2 = arg_6_0.agent.rotation
	local var_6_3 = arg_6_0.targetRotation
	local var_6_4 = arg_6_0.rotationSpeed

	Time = var_1_10007
	var_6_0.rotation = var_6_1(var_6_2, var_6_3, var_6_4 * var_1_10007.deltaTime)
	Vector3 = var_6_0

	local var_6_5 = var_6_0.Dot
	local var_6_6 = arg_6_0.agent.forward
	local var_6_7 = arg_6_0.targetRotation

	if var_6_5(var_6_6, var_4.ToEulerAngles(var_6_7).normalized) >= 0.95 then
		arg_6_0.targetRotation = nil
	end

	return
end

function var_0_1.NextOne(arg_7_0)
	arg_7_0.targetRotation = nil
	arg_7_0.isStopping = false

	if arg_7_0.chaoticOrder then
		arg_7_0:Shuffle()
	end

	arg_7_0.index = arg_7_0.index + 1

	if arg_7_0.index > #arg_7_0.waypoints then
		arg_7_0.index = 1
	end

	local var_7_0 = arg_7_0.waypoints[arg_7_0.index].position

	_IslandMoveUnit = var_2

	var_2(arg_7_0.unitType, arg_7_0.unitId, var_7_0, arg_7_0.speed, 0.5)
	arg_7_0:OnProcess()

	return
end

function var_0_1.Shuffle(arg_8_0)
	local var_8_0 = arg_8_0.waypoints[arg_8_0.index]
	local var_8_1 = {}

	ipairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(arg_8_0.waypoints) do
		if iter_8_1 ~= var_8_0 then
			table = var_1_10008

			var_1_10008.insert(var_8_1, iter_8_1)
		end
	end

	shuffle = var_3

	var_3(var_8_1)

	table = var_3

	var_3.insert(var_8_1, 1, var_8_0)

	arg_8_0.waypoints = var_8_1

	return
end

function var_0_1.PauseMove(arg_9_0)
	_IslandStopMoveUnit = var_1_10001

	var_1_10001(arg_9_0.unitType, arg_9_0.unitId)

	return
end

function var_0_1.ResumeMove(arg_10_0)
	Animator = var_1_10001

	local var_10_0 = var_1_10001.StringToHash("movement")

	arg_10_0:CrossFadeInFixedTime(var_10_0, 0.2)

	local var_10_1 = arg_10_0.waypoints[arg_10_0.index].position

	_IslandMoveUnit = var_3

	var_3(arg_10_0.unitType, arg_10_0.unitId, var_10_1, arg_10_0.speed)

	return
end

function var_0_1.CheckAnimationState(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_1:GetCurrentAnimatorStateInfo(0)

	if var_4.IsName(var_11_0, arg_11_2) and not arg_11_0.endTime then
		local var_11_1 = var_4.length / arg_11_1.speed

		arg_11_0.endTime = arg_11_0:GetElapsedTime() + var_11_1
	end

	if arg_11_0.endTime and arg_11_0:GetElapsedTime() >= arg_11_0.endTime then
		arg_11_3()

		arg_11_0.endTime = nil
	end

	return
end

function var_0_1.CheckArriveAnimation(arg_12_0)
	if not arg_12_0.executeArriveAnimation then
		return
	end

	local var_12_0 = arg_12_0.executeArriveAnimation.state

	arg_12_0:CheckAnimationState(arg_12_0.animator, var_12_0, function()
		local var_13_0 = arg_12_0

		var_0.EndArriveAction(var_13_0)

		arg_12_0.executeArriveAnimation = nil

		return
	end)

	return
end

function var_0_1.CheckArriveTime(arg_14_0)
	if not arg_14_0.executeArriveTime then
		return
	end

	if arg_14_0:GetElapsedTime() >= arg_14_0.executeArriveTime then
		arg_14_0:NextOne()

		arg_14_0.executeArriveTime = nil
	end

	return
end

function var_0_1.OnArrive(arg_15_0)
	arg_15_0.isStopping = true

	arg_15_0:ClearProcessAction()

	local var_15_0 = arg_15_0:GetCurrWaypoint()

	if var_1.DisappearWhenArrive(var_15_0) then
		arg_15_0:DisappearUnit()

		return
	end

	arg_15_0:PauseMove()
	arg_15_0:DoRatation()
	var_1:RandomArriveAction()

	if not var_1:GetActionWhenArrive() then
		arg_15_0:EndArriveAction()

		return
	end

	arg_15_0:ExecuteArriveAction()

	return
end

function var_0_1.EndArriveAction(arg_16_0)
	local var_16_0 = arg_16_0:GetCurrWaypoint()

	if var_1.GetStartNextOneTime(var_16_0) <= 0 then
		arg_16_0:NextOne()
	else
		arg_16_0.executeArriveTime = arg_16_0:GetElapsedTime() + var_2
	end

	return
end

function var_0_1.DisappearUnit(arg_17_0)
	_IslandGetUnit = var_1_10001

	local var_17_0 = var_1_10001(arg_17_0.unitType, arg_17_0.unitId)

	var_1.Disable(var_17_0)

	return
end

function var_0_1.DoRatation(arg_18_0)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.GetCurrWaypoint(var_18_0)

	if var_1.GetRotationWhenArrive(var_18_1) == 0 then
		return
	end

	Quaternion = var_18_0
	arg_18_0.targetRotation = var_18_0.Euler(0, var_2, 0)

	return
end

function var_0_1.ExecuteArriveAction(arg_19_0)
	local var_19_0 = arg_19_0:GetCurrWaypoint()

	if not var_1.GetActionWhenArrive(var_19_0) then
		arg_19_0:EndArriveAction()

		return
	end

	local var_19_1 = var_2.type

	IslandWayPoint = var_19_0

	if var_19_1 == var_19_0.ACTION_TYPE_CHATBUBBLE then
		seriesAsync = var_19_1

		var_19_1({
			function(arg_20_0)
				_IslandPlayBubble = var_2_10001

				var_2_10001(var_0.action, arg_20_0)

				return
			end
		}, function()
			local var_21_0 = arg_19_0

			var_0.EndArriveAction(var_21_0)

			return
		end)
	else
		local var_19_2 = var_2.type

		IslandWayPoint = var_4

		if var_19_2 == var_4.ACTION_TYPE_ANIM then
			arg_19_0:PlayArriveAnimation(var_2.action)
		end
	end

	return
end

function var_0_1.PlayArriveAnimation(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.animator
	local var_22_1 = var_2.GetCurrentAnimatorStateInfo(var_22_0, 0)

	if not var_2.IsName(var_22_1, arg_22_1) then
		Animator = var_2

		local var_22_2 = var_2.StringToHash(arg_22_1)

		arg_22_0:CrossFadeInFixedTime(var_22_2, 0.2)

		arg_22_0.executeArriveAnimation = {
			state = arg_22_1
		}
	else
		arg_22_0:EndArriveAction()
	end

	return
end

function var_0_1.CheckProcessTime(arg_23_0)
	if not arg_23_0.executeProcessActionTime then
		return
	end

	if arg_23_0:GetElapsedTime() >= arg_23_0.executeProcessActionTime then
		arg_23_0:ExecuteProcessAction()

		arg_23_0.executeProcessActionTime = nil
	end

	return
end

function var_0_1.CheckProcessAnimation(arg_24_0)
	if not arg_24_0.executeProcessAnimation then
		return
	end

	local var_24_0 = arg_24_0.executeProcessAnimation.state

	arg_24_0:CheckAnimationState(arg_24_0.animator, var_24_0, function()
		local var_25_0 = arg_24_0

		var_0.ResumeMove(var_25_0)

		arg_24_0.executeProcessAnimation = nil

		return
	end)

	return
end

function var_0_1.OnProcess(arg_26_0)
	local var_26_0 = arg_26_0:GetPrevWaypoint()

	var_1.RandomProcessAction(var_26_0)

	if not var_1:GetActionWhenProcess() then
		return
	end

	arg_26_0.executeProcessActionTime = arg_26_0:GetElapsedTime() + var_2.time

	return
end

function var_0_1.ClearProcessAction(arg_27_0)
	if arg_27_0.executeProcessActionTime then
		arg_27_0.executeProcessActionTime = nil
	end

	if arg_27_0.executeProcessAnimation then
		arg_27_0.executeProcessAnimation = nil
	end

	return
end

function var_0_1.ExecuteProcessAction(arg_28_0)
	local var_28_0 = arg_28_0:GetPrevWaypoint()

	if not var_1.GetActionWhenProcess(var_28_0) then
		return
	end

	arg_28_0:PauseMove()

	local var_28_1 = var_2.type

	IslandWayPoint = var_28_0

	if var_28_1 == var_28_0.ACTION_TYPE_CHATBUBBLE then
		seriesAsync = var_28_1

		var_28_1({
			function(arg_29_0)
				_IslandPlayBubble = var_2_10001

				var_2_10001(var_0.action, arg_29_0)

				return
			end
		}, function()
			local var_30_0 = arg_28_0

			var_0.ResumeMove(var_30_0)

			return
		end)
	else
		local var_28_2 = var_2.type

		IslandWayPoint = var_4

		if var_28_2 == var_4.ACTION_TYPE_ANIM then
			arg_28_0:PlayProcessAnimation(var_2.action)
		end
	end

	return
end

function var_0_1.PlayProcessAnimation(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.animator
	local var_31_1 = var_2.GetCurrentAnimatorStateInfo(var_31_0, 0)

	if not var_2.IsName(var_31_1, arg_31_1) then
		Animator = var_2

		local var_31_2 = var_2.StringToHash(arg_31_1)

		arg_31_0:CrossFadeInFixedTime(var_31_2, 0.2)

		arg_31_0.executeProcessAnimation = {
			state = arg_31_1
		}
	else
		arg_31_0:ResumeMove()
	end

	return
end

function var_0_1.GetPrevWaypoint(arg_32_0)
	if arg_32_0.index == 1 then
		return arg_32_0.waypoints[#arg_32_0.waypoints]
	end

	return arg_32_0.waypoints[arg_32_0.index - 1]
end

function var_0_1.GetCurrWaypoint(arg_33_0)
	return arg_33_0.waypoints[arg_33_0.index]
end

function var_0_1.OnDrawGizmosSelected(arg_34_0)
	if not arg_34_0:IsLegalPath() then
		return
	end

	local var_34_0 = arg_34_0.waypoints[1].position

	for iter_34_0 = 1, #var_1 do
		if iter_34_0 == #var_1 then
			break
		end

		LuaHelper = var_1_10007
		var_1_10007 = var_1_10007.DrawText

		local var_34_1 = "point" .. iter_34_0
		local var_34_2 = var_34_0

		Vector3 = var_1_10011

		var_1_10007(var_34_1, var_34_2, var_1_10011(1, 0, 0))

		var_1_10007 = var_1[iter_34_0 + 1].position
		LuaHelper = var_1_10008
		var_1_10008 = var_1_10008.DrawLine

		local var_34_3 = var_34_0

		var_1_10011 = var_1_10007
		Vector3 = var_1_10012

		var_1_10008(var_34_3, var_1_10011, var_1_10012(1, 0, 0), 0)

		var_34_0 = var_1_10007
	end

	LuaHelper = var_3

	local var_34_4 = var_3.DrawText
	local var_34_5 = "point" .. #var_1
	local var_34_6 = var_1[#var_1].position

	Vector3 = var_1_10007

	var_34_4(var_34_5, var_34_6, var_1_10007(1, 0, 0))

	LuaHelper = var_34_4

	local var_34_7 = var_34_4.DrawLine
	local var_34_8 = var_1[#var_1].position
	local var_34_9 = var_1[1].position

	Vector3 = var_7

	var_34_7(var_34_8, var_34_9, var_7(1, 0, 0), 0)

	return
end

function var_0_1.CrossFadeInFixedTime(arg_35_0, arg_35_1, arg_35_2)
	for iter_35_0 = 1, arg_35_0.animator.layerCount do
		local var_35_0 = arg_35_0.animator

		var_7.CrossFadeInFixedTime(var_35_0, arg_35_1, 0.2, iter_35_0 - 1)
	end

	return
end

return var_0_1
