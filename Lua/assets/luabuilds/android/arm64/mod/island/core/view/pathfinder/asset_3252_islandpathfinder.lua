local IslandPathFinder = class("IslandPathFinder", import("..IslandBaseUnit"))

function IslandPathFinder:Ctor(arg_1_1)
	IslandPathFinder.super.Ctor(self, arg_1_1)

	self.unitList = self:GetView():GetAllUnits()
	self.starting = false

	self:Init()

	return
end

function IslandPathFinder:Start(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1.unitId or 0
	local var_2_1 = arg_2_1.speed or 1.5
	local var_2_2 = arg_2_1.unitType or IslandConst.UNIT_LIST_OBJ

	self.hideFlag = defaultValue(arg_2_1.hide, false)

	local var_2_3 = self:FindUnit(var_2_0, var_2_2)

	if not var_2_3 then
		onNextTick(arg_2_2)

		return
	end

	var_2_3:Enable()
	var_2_3:WarpAgent()
	assert(var_2_3, "unit is nil" .. var_2_0)

	self.unit = var_2_3
	self.callback = arg_2_2

	var_2_3:SetNavAgentStopDistance(0.26)
	var_2_3:SetDestination(BuildVector3(arg_2_1.position), var_2_1, arg_2_1.radius, arg_2_1.charaRadius)
	var_2_3:CheckMovement()

	self.starting = true

	return
end

function IslandPathFinder:IsSameUnit(arg_3_1)
	if not self.unit then
		return false
	end

	return arg_3_1.id == self.unit.id and arg_3_1.unitType == self.unit.unitType
end

function IslandPathFinder:FindUnit(arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		return self:GetView().player
	end

	for iter_4_0, iter_4_1 in ipairs(self.unitList) do
		if iter_4_1:GetUnitType() == arg_4_2 and iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end

	return nil
end

function IslandPathFinder:OnUpdate()
	if not self.starting then
		return
	end

	local var_5_0 = self.unit.agent

	if not self.unit.agent.pathPending and var_5_0.remainingDistance <= var_5_0.stoppingDistance then
		self:EndAction()
	end

	return
end

function IslandPathFinder:EndAction()
	self.unit:SetNavAgentStopDistance(2)
	self.unit:StopMove()

	if self.hideFlag then
		self.unit:Disable()
	end

	self.callback()

	self.starting = false

	return
end

function IslandPathFinder:Stop()
	self:EndAction()

	return
end

function IslandPathFinder:OnDispose()
	self.starting = nil
	self.callback = nil
	self.unitList = nil

	return
end

return IslandPathFinder
