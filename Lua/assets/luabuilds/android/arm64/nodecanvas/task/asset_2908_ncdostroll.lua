local NcDoStroll = class("NcDoStroll", import("..base.NodeCanvasBaseTask"))

function NcDoStroll:Ctor()
	NcDoStroll.super.Ctor(self)

	self.index = 1
	self.speed = 2
	self.rotationSpeed = 10
	self.isStopping = false

	return
end

function NcDoStroll:OnExecute()
	if not _IslandCore then
		return
	end

	self.agent = self:GetAgent()
	self.navAgent = self.agent.gameObject:GetComponent("NavMeshAgent")

	local var_2_0 = self.agent.gameObject:GetComponent(typeof(WorldObjectItem))

	self.unitId = var_2_0.id
	self.unitType = var_2_0.type
	self.animator = _IslandFindUnit(self.unitType, self.unitId).transform:GetChild(0):GetComponent(typeof(Animator))

	local var_2_1 = self:GetBlackboardVariable("pause")

	self.chaoticOrder = self:GetBoolArg("chaoticOrder")

	local var_2_2 = _IslandCore:GetController().strollAllocator:GetWaypoints((self:GetFloatArg("pathId")))

	assert(#var_2_2 > 0, "waypoints is empty")

	self.waypoints = _.map(var_2_2, function(arg_3_0)
		return IslandWayPoint.New(arg_3_0)
	end)

	if not self:IsLegalPath() then
		self:EndAction(false)

		return
	end

	self.delayInit = false

	if var_2_1 then
		self:ResumeMove()
	elseif not self.navAgent.isOnNavMesh then
		self.delayInit = true
	else
		self:NextOne()
	end

	return
end

function NcDoStroll:IsLegalPath()
	return self.waypoints and #self.waypoints > 1
end

function NcDoStroll:OnUpdate()
	if self.delayInit and self.navAgent.isOnNavMesh then
		self:NextOne()

		self.delayInit = false
	end

	if not self.navAgent.enabled then
		return
	end

	if not self.navAgent.isOnNavMesh then
		return
	end

	if not self:IsLegalPath() then
		return
	end

	if self.index <= 0 or self.index > #self.waypoints then
		self:EndAction(false)

		return
	end

	self:CheckProcessTime()
	self:CheckProcessAnimation()
	self:CheckArriveAnimation()
	self:CheckArriveTime()
	self:UpdateRatation()

	if not self.navAgent.pathPending and self.navAgent.remainingDistance <= self.navAgent.stoppingDistance and not self.isStopping then
		self:OnArrive()
	end

	return
end

function NcDoStroll:UpdateRatation()
	if not self.targetRotation then
		return
	end

	self.agent.rotation = Quaternion.Slerp(self.agent.rotation, self.targetRotation, self.rotationSpeed * Time.deltaTime)

	if Vector3.Dot(self.agent.forward, self.targetRotation:ToEulerAngles().normalized) >= 0.95 then
		self.targetRotation = nil
	end

	return
end

function NcDoStroll:NextOne()
	self.targetRotation = nil
	self.isStopping = false

	if self.chaoticOrder then
		self:Shuffle()
	end

	self.index = self.index + 1

	if self.index > #self.waypoints then
		self.index = 1
	end

	_IslandMoveUnit(self.unitType, self.unitId, self.waypoints[self.index].position, self.speed, 0.5)
	self:OnProcess()

	return
end

function NcDoStroll:Shuffle()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(self.waypoints) do
		if iter_8_1 ~= self.waypoints[self.index] then
			table.insert(var_8_0, iter_8_1)
		end
	end

	shuffle(var_8_0)
	table.insert(var_8_0, 1, self.waypoints[self.index])

	self.waypoints = var_8_0

	return
end

function NcDoStroll:PauseMove()
	_IslandStopMoveUnit(self.unitType, self.unitId)

	return
end

function NcDoStroll:ResumeMove()
	self:CrossFadeInFixedTime(Animator.StringToHash("movement"), 0.2)
	_IslandMoveUnit(self.unitType, self.unitId, self.waypoints[self.index].position, self.speed)

	return
end

function NcDoStroll:CheckAnimationState(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_1:GetCurrentAnimatorStateInfo(0)

	if var_11_0:IsName(arg_11_2) and not self.endTime then
		self.endTime = self:GetElapsedTime() + var_11_0.length / arg_11_1.speed
	end

	if self.endTime and self:GetElapsedTime() >= self.endTime then
		arg_11_3()

		self.endTime = nil
	end

	return
end

function NcDoStroll:CheckArriveAnimation()
	if not self.executeArriveAnimation then
		return
	end

	self:CheckAnimationState(self.animator, self.executeArriveAnimation.state, function()
		self:EndArriveAction()

		self.executeArriveAnimation = nil

		return
	end)

	return
end

function NcDoStroll:CheckArriveTime()
	if not self.executeArriveTime then
		return
	end

	if self:GetElapsedTime() >= self.executeArriveTime then
		self:NextOne()

		self.executeArriveTime = nil
	end

	return
end

function NcDoStroll:OnArrive()
	self.isStopping = true

	self:ClearProcessAction()

	local var_15_0 = self:GetCurrWaypoint()

	if var_15_0:DisappearWhenArrive() then
		self:DisappearUnit()

		return
	end

	self:PauseMove()
	self:DoRatation()
	var_15_0:RandomArriveAction()

	if not var_15_0:GetActionWhenArrive() then
		self:EndArriveAction()

		return
	end

	self:ExecuteArriveAction()

	return
end

function NcDoStroll:EndArriveAction()
	local var_16_0 = self:GetCurrWaypoint():GetStartNextOneTime()

	if var_16_0 <= 0 then
		self:NextOne()
	else
		self.executeArriveTime = self:GetElapsedTime() + var_16_0
	end

	return
end

function NcDoStroll:DisappearUnit()
	_IslandGetUnit(self.unitType, self.unitId):Disable()

	return
end

function NcDoStroll:DoRatation()
	local var_18_0 = self:GetCurrWaypoint():GetRotationWhenArrive()

	if var_18_0 == 0 then
		return
	end

	self.targetRotation = Quaternion.Euler(0, var_18_0, 0)

	return
end

function NcDoStroll:ExecuteArriveAction()
	local var_19_0 = self:GetCurrWaypoint():GetActionWhenArrive()

	if not var_19_0 then
		self:EndArriveAction()

		return
	end

	if var_19_0.type == IslandWayPoint.ACTION_TYPE_CHATBUBBLE then
		seriesAsync({
			function(arg_20_0)
				_IslandPlayBubble(var_19_0.action, arg_20_0)

				return
			end
		}, function()
			self:EndArriveAction()

			return
		end)
	elseif var_19_0.type == IslandWayPoint.ACTION_TYPE_ANIM then
		self:PlayArriveAnimation(var_19_0.action)
	end

	return
end

function NcDoStroll:PlayArriveAnimation(arg_22_1)
	if not self.animator:GetCurrentAnimatorStateInfo(0):IsName(arg_22_1) then
		self:CrossFadeInFixedTime(Animator.StringToHash(arg_22_1), 0.2)

		self.executeArriveAnimation = {
			state = arg_22_1
		}
	else
		self:EndArriveAction()
	end

	return
end

function NcDoStroll:CheckProcessTime()
	if not self.executeProcessActionTime then
		return
	end

	if self:GetElapsedTime() >= self.executeProcessActionTime then
		self:ExecuteProcessAction()

		self.executeProcessActionTime = nil
	end

	return
end

function NcDoStroll:CheckProcessAnimation()
	if not self.executeProcessAnimation then
		return
	end

	self:CheckAnimationState(self.animator, self.executeProcessAnimation.state, function()
		self:ResumeMove()

		self.executeProcessAnimation = nil

		return
	end)

	return
end

function NcDoStroll:OnProcess()
	local var_26_0 = self:GetPrevWaypoint()

	var_26_0:RandomProcessAction()

	local var_26_1 = var_26_0:GetActionWhenProcess()

	if not var_26_1 then
		return
	end

	self.executeProcessActionTime = self:GetElapsedTime() + var_26_1.time

	return
end

function NcDoStroll:ClearProcessAction()
	if self.executeProcessActionTime then
		self.executeProcessActionTime = nil
	end

	if self.executeProcessAnimation then
		self.executeProcessAnimation = nil
	end

	return
end

function NcDoStroll:ExecuteProcessAction()
	local var_28_0 = self:GetPrevWaypoint():GetActionWhenProcess()

	if not var_28_0 then
		return
	end

	self:PauseMove()

	if var_28_0.type == IslandWayPoint.ACTION_TYPE_CHATBUBBLE then
		seriesAsync({
			function(arg_29_0)
				_IslandPlayBubble(var_28_0.action, arg_29_0)

				return
			end
		}, function()
			self:ResumeMove()

			return
		end)
	elseif var_28_0.type == IslandWayPoint.ACTION_TYPE_ANIM then
		self:PlayProcessAnimation(var_28_0.action)
	end

	return
end

function NcDoStroll:PlayProcessAnimation(arg_31_1)
	if not self.animator:GetCurrentAnimatorStateInfo(0):IsName(arg_31_1) then
		self:CrossFadeInFixedTime(Animator.StringToHash(arg_31_1), 0.2)

		self.executeProcessAnimation = {
			state = arg_31_1
		}
	else
		self:ResumeMove()
	end

	return
end

function NcDoStroll:GetPrevWaypoint()
	if self.index == 1 then
		return self.waypoints[#self.waypoints]
	end

	return self.waypoints[self.index - 1]
end

function NcDoStroll:GetCurrWaypoint()
	return self.waypoints[self.index]
end

function NcDoStroll:OnDrawGizmosSelected()
	if not self:IsLegalPath() then
		return
	end

	local var_34_0 = self.waypoints

	for iter_34_0 = 1, #self.waypoints do
		if iter_34_0 == #var_34_0 then
			break
		end

		LuaHelper.DrawText("point" .. iter_34_0, self.waypoints[1].position, Vector3(1, 0, 0))
		LuaHelper.DrawLine(self.waypoints[1].position, var_34_0[iter_34_0 + 1].position, Vector3(1, 0, 0), 0)
	end

	LuaHelper.DrawText("point" .. #var_34_0, var_34_0[#var_34_0].position, Vector3(1, 0, 0))
	LuaHelper.DrawLine(var_34_0[#var_34_0].position, var_34_0[1].position, Vector3(1, 0, 0), 0)

	return
end

function NcDoStroll:CrossFadeInFixedTime(arg_35_1, arg_35_2)
	for iter_35_0 = 1, self.animator.layerCount do
		self.animator:CrossFadeInFixedTime(arg_35_1, 0.2, iter_35_0 - 1)
	end

	return
end

return NcDoStroll
