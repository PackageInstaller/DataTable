local var_0_0 = class("NcDoStroll", import("..base.NodeCanvasBaseTask"))

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.index = 1
	arg_1_0.speed = 2
	arg_1_0.rotationSpeed = 10
	arg_1_0.isStopping = false

	return
end

function var_0_0.OnExecute(arg_2_0)
	if not _IslandCore then
		return
	end

	arg_2_0.agent = arg_2_0:GetAgent()
	arg_2_0.navAgent = arg_2_0.agent.gameObject:GetComponent("NavMeshAgent")

	local var_2_0 = arg_2_0.agent.gameObject:GetComponent(typeof(WorldObjectItem))

	arg_2_0.unitId = var_2_0.id
	arg_2_0.unitType = var_2_0.type
	arg_2_0.animator = _IslandFindUnit(arg_2_0.unitType, arg_2_0.unitId).transform:GetChild(0):GetComponent(typeof(Animator))

	local var_2_1 = arg_2_0:GetBlackboardVariable("pause")

	arg_2_0.chaoticOrder = arg_2_0:GetBoolArg("chaoticOrder")

	local var_2_2 = _IslandCore:GetController().strollAllocator:GetWaypoints((arg_2_0:GetFloatArg("pathId")))

	assert(#var_2_2 > 0, "waypoints is empty")

	arg_2_0.waypoints = _.map(var_2_2, function(arg_3_0)
		return IslandWayPoint.New(arg_3_0)
	end)

	if not arg_2_0:IsLegalPath() then
		arg_2_0:EndAction(false)

		return
	end

	arg_2_0.delayInit = false

	if var_2_1 then
		arg_2_0:ResumeMove()
	elseif not arg_2_0.navAgent.isOnNavMesh then
		arg_2_0.delayInit = true
	else
		arg_2_0:NextOne()
	end

	return
end

function var_0_0.IsLegalPath(arg_4_0)
	return arg_4_0.waypoints and #arg_4_0.waypoints > 1
end

function var_0_0.OnUpdate(arg_5_0)
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

	if not arg_5_0.navAgent.pathPending and arg_5_0.navAgent.remainingDistance <= arg_5_0.navAgent.stoppingDistance and not arg_5_0.isStopping then
		arg_5_0:OnArrive()
	end

	return
end

function var_0_0.UpdateRatation(arg_6_0)
	if not arg_6_0.targetRotation then
		return
	end

	arg_6_0.agent.rotation = Quaternion.Slerp(arg_6_0.agent.rotation, arg_6_0.targetRotation, arg_6_0.rotationSpeed * Time.deltaTime)

	if Vector3.Dot(arg_6_0.agent.forward, arg_6_0.targetRotation:ToEulerAngles().normalized) >= 0.95 then
		arg_6_0.targetRotation = nil
	end

	return
end

function var_0_0.NextOne(arg_7_0)
	arg_7_0.targetRotation = nil
	arg_7_0.isStopping = false

	if arg_7_0.chaoticOrder then
		arg_7_0:Shuffle()
	end

	arg_7_0.index = arg_7_0.index + 1

	if arg_7_0.index > #arg_7_0.waypoints then
		arg_7_0.index = 1
	end

	_IslandMoveUnit(arg_7_0.unitType, arg_7_0.unitId, arg_7_0.waypoints[arg_7_0.index].position, arg_7_0.speed, 0.5)
	arg_7_0:OnProcess()

	return
end

function var_0_0.Shuffle(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.waypoints) do
		if iter_8_1 ~= arg_8_0.waypoints[arg_8_0.index] then
			table.insert({}, iter_8_1)
		end
	end

	shuffle({})
	table.insert({}, 1, arg_8_0.waypoints[arg_8_0.index])

	arg_8_0.waypoints = {}

	return
end

function var_0_0.PauseMove(arg_9_0)
	_IslandStopMoveUnit(arg_9_0.unitType, arg_9_0.unitId)

	return
end

function var_0_0.ResumeMove(arg_10_0)
	arg_10_0:CrossFadeInFixedTime(Animator.StringToHash("movement"), 0.2)
	_IslandMoveUnit(arg_10_0.unitType, arg_10_0.unitId, arg_10_0.waypoints[arg_10_0.index].position, arg_10_0.speed)

	return
end

function var_0_0.CheckAnimationState(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_1:GetCurrentAnimatorStateInfo(0)

	if var_11_0:IsName(arg_11_2) and not arg_11_0.endTime then
		arg_11_0.endTime = arg_11_0:GetElapsedTime() + var_11_0.length / arg_11_1.speed
	end

	if arg_11_0.endTime and arg_11_0:GetElapsedTime() >= arg_11_0.endTime then
		arg_11_3()

		arg_11_0.endTime = nil
	end

	return
end

function var_0_0.CheckArriveAnimation(arg_12_0)
	if not arg_12_0.executeArriveAnimation then
		return
	end

	arg_12_0:CheckAnimationState(arg_12_0.animator, arg_12_0.executeArriveAnimation.state, function()
		arg_12_0:EndArriveAction()

		arg_12_0.executeArriveAnimation = nil

		return
	end)

	return
end

function var_0_0.CheckArriveTime(arg_14_0)
	if not arg_14_0.executeArriveTime then
		return
	end

	if arg_14_0:GetElapsedTime() >= arg_14_0.executeArriveTime then
		arg_14_0:NextOne()

		arg_14_0.executeArriveTime = nil
	end

	return
end

function var_0_0.OnArrive(arg_15_0)
	arg_15_0.isStopping = true

	arg_15_0:ClearProcessAction()

	local var_15_0 = arg_15_0:GetCurrWaypoint()

	if var_15_0:DisappearWhenArrive() then
		arg_15_0:DisappearUnit()

		return
	end

	arg_15_0:PauseMove()
	arg_15_0:DoRatation()
	var_15_0:RandomArriveAction()

	if not var_15_0:GetActionWhenArrive() then
		arg_15_0:EndArriveAction()

		return
	end

	arg_15_0:ExecuteArriveAction()

	return
end

function var_0_0.EndArriveAction(arg_16_0)
	local var_16_0 = arg_16_0:GetCurrWaypoint():GetStartNextOneTime()

	if var_16_0 <= 0 then
		arg_16_0:NextOne()
	else
		arg_16_0.executeArriveTime = arg_16_0:GetElapsedTime() + var_16_0
	end

	return
end

function var_0_0.DisappearUnit(arg_17_0)
	_IslandGetUnit(arg_17_0.unitType, arg_17_0.unitId):Disable()

	return
end

function var_0_0.DoRatation(arg_18_0)
	local var_18_0 = arg_18_0:GetCurrWaypoint():GetRotationWhenArrive()

	if var_18_0 == 0 then
		return
	end

	arg_18_0.targetRotation = Quaternion.Euler(0, var_18_0, 0)

	return
end

function var_0_0.ExecuteArriveAction(arg_19_0)
	local var_19_0 = arg_19_0:GetCurrWaypoint():GetActionWhenArrive()

	if not var_19_0 then
		arg_19_0:EndArriveAction()

		return
	end

	if var_19_0.type == IslandWayPoint.ACTION_TYPE_CHATBUBBLE then
		seriesAsync({
			function(arg_20_0)
				_IslandPlayBubble(var_19_0.action, arg_20_0)

				return
			end
		}, function()
			arg_19_0:EndArriveAction()

			return
		end)
	elseif var_19_0.type == IslandWayPoint.ACTION_TYPE_ANIM then
		arg_19_0:PlayArriveAnimation(var_19_0.action)
	end

	return
end

function var_0_0.PlayArriveAnimation(arg_22_0, arg_22_1)
	if not arg_22_0.animator:GetCurrentAnimatorStateInfo(0):IsName(arg_22_1) then
		arg_22_0:CrossFadeInFixedTime(Animator.StringToHash(arg_22_1), 0.2)

		arg_22_0.executeArriveAnimation = {
			state = arg_22_1
		}
	else
		arg_22_0:EndArriveAction()
	end

	return
end

function var_0_0.CheckProcessTime(arg_23_0)
	if not arg_23_0.executeProcessActionTime then
		return
	end

	if arg_23_0:GetElapsedTime() >= arg_23_0.executeProcessActionTime then
		arg_23_0:ExecuteProcessAction()

		arg_23_0.executeProcessActionTime = nil
	end

	return
end

function var_0_0.CheckProcessAnimation(arg_24_0)
	if not arg_24_0.executeProcessAnimation then
		return
	end

	arg_24_0:CheckAnimationState(arg_24_0.animator, arg_24_0.executeProcessAnimation.state, function()
		arg_24_0:ResumeMove()

		arg_24_0.executeProcessAnimation = nil

		return
	end)

	return
end

function var_0_0.OnProcess(arg_26_0)
	local var_26_0 = arg_26_0:GetPrevWaypoint()

	var_26_0:RandomProcessAction()

	local var_26_1 = var_26_0:GetActionWhenProcess()

	if not var_26_1 then
		return
	end

	arg_26_0.executeProcessActionTime = arg_26_0:GetElapsedTime() + var_26_1.time

	return
end

function var_0_0.ClearProcessAction(arg_27_0)
	if arg_27_0.executeProcessActionTime then
		arg_27_0.executeProcessActionTime = nil
	end

	if arg_27_0.executeProcessAnimation then
		arg_27_0.executeProcessAnimation = nil
	end

	return
end

function var_0_0.ExecuteProcessAction(arg_28_0)
	local var_28_0 = arg_28_0:GetPrevWaypoint():GetActionWhenProcess()

	if not var_28_0 then
		return
	end

	arg_28_0:PauseMove()

	if var_28_0.type == IslandWayPoint.ACTION_TYPE_CHATBUBBLE then
		seriesAsync({
			function(arg_29_0)
				_IslandPlayBubble(var_28_0.action, arg_29_0)

				return
			end
		}, function()
			arg_28_0:ResumeMove()

			return
		end)
	elseif var_28_0.type == IslandWayPoint.ACTION_TYPE_ANIM then
		arg_28_0:PlayProcessAnimation(var_28_0.action)
	end

	return
end

function var_0_0.PlayProcessAnimation(arg_31_0, arg_31_1)
	if not arg_31_0.animator:GetCurrentAnimatorStateInfo(0):IsName(arg_31_1) then
		arg_31_0:CrossFadeInFixedTime(Animator.StringToHash(arg_31_1), 0.2)

		arg_31_0.executeProcessAnimation = {
			state = arg_31_1
		}
	else
		arg_31_0:ResumeMove()
	end

	return
end

function var_0_0.GetPrevWaypoint(arg_32_0)
	if arg_32_0.index == 1 then
		return arg_32_0.waypoints[#arg_32_0.waypoints]
	end

	return arg_32_0.waypoints[arg_32_0.index - 1]
end

function var_0_0.GetCurrWaypoint(arg_33_0)
	return arg_33_0.waypoints[arg_33_0.index]
end

function var_0_0.OnDrawGizmosSelected(arg_34_0)
	if not arg_34_0:IsLegalPath() then
		return
	end

	local var_34_0 = arg_34_0.waypoints

	for iter_34_0 = 1, #arg_34_0.waypoints do
		if iter_34_0 == #var_34_0 then
			break
		end

		LuaHelper.DrawText("point" .. iter_34_0, arg_34_0.waypoints[1].position, Vector3(1, 0, 0))
		LuaHelper.DrawLine(arg_34_0.waypoints[1].position, var_34_0[iter_34_0 + 1].position, Vector3(1, 0, 0), 0)
	end

	LuaHelper.DrawText("point" .. #var_34_0, var_34_0[#var_34_0].position, Vector3(1, 0, 0))
	LuaHelper.DrawLine(var_34_0[#var_34_0].position, var_34_0[1].position, Vector3(1, 0, 0), 0)

	return
end

function var_0_0.CrossFadeInFixedTime(arg_35_0, arg_35_1, arg_35_2)
	for iter_35_0 = 1, arg_35_0.animator.layerCount do
		arg_35_0.animator:CrossFadeInFixedTime(arg_35_1, 0.2, iter_35_0 - 1)
	end

	return
end

return var_0_0
