ys = ys or {}

local var_0_0 = ys
local BattleEnvironmentBehaviourForce = class("BattleEnvironmentBehaviourForce", ys.Battle.BattleEnvironmentBehaviour)

ys.Battle.BattleEnvironmentBehaviourForce = BattleEnvironmentBehaviourForce
BattleEnvironmentBehaviourForce.__name = "BattleEnvironmentBehaviourForce"

function BattleEnvironmentBehaviourForce:Ctor()
	self._moveEndTime = nil
	self._lastSpeed = nil
	self._speed = Vector3.zero
	self._targetIndex = 0

	BattleEnvironmentBehaviourForce.super.Ctor(self)

	return
end

function BattleEnvironmentBehaviourForce:SetTemplate(arg_2_1)
	BattleEnvironmentBehaviourForce.super.SetTemplate(self, arg_2_1)

	self._route = arg_2_1.route or {}
	self._moveEndTime = pg.TimeMgr.GetInstance():GetCombatTime()

	local var_2_0 = self._unit:GetTemplate()
	local var_2_1
	local var_2_2

	if #var_2_0.cld_data == 1 then
		var_2_1 = var_2_0.cld_data[1]
		var_2_2 = var_2_0.cld_data[1]
	elseif #var_2_0.cld_data == 2 then
		var_2_1, var_2_2 = unpack(var_2_0.cld_data)
	end

	local var_2_3 = {}

	var_2_3[1] = var_0_0.Battle.BattleDataProxy.GetInstance():GetTotalBounds()
	var_2_3[3] = var_2_3[3] + var_2_1
	var_2_3[4] = var_2_3[4] - var_2_1
	var_2_3[2] = var_2_3[2] + var_2_2
	var_2_3[1] = var_2_3[1] - var_2_2
	self._bounds = var_2_3

	return
end

function BattleEnvironmentBehaviourForce:doBehaviour()
	local var_3_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	if self._moveEndTime and var_3_0 >= self._moveEndTime then
		self._targetIndex = self._targetIndex + 1
		self._moveEndTime = nil

		if self._lastSpeed then
			self._speed:Add(self._lastSpeed)

			self._lastSpeed = nil
		end

		local var_3_1 = self._route[self._targetIndex]

		if self._route[self._targetIndex] then
			self._lastSpeed = Vector3(unpack(var_3_1)):Normalize() * var_3_1[4]
			self._moveEndTime = var_3_0 + var_3_1[5]
		end
	end

	self._unit._aoeData:SetPosition((self:UpdateAndRestrictPosition((self._unit._aoeData:GetPosition()))))
	BattleEnvironmentBehaviourForce.super.doBehaviour(self)

	return
end

function BattleEnvironmentBehaviourForce:UpdateAndRestrictPosition(arg_4_1)
	if self._speed:SqrMagnitude() < 0.01 then
		return arg_4_1
	end

	local var_4_0 = self._bounds
	local var_4_1 = arg_4_1 + self._speed

	if (arg_4_1 + self._speed).x < self._bounds[3] then
		self._speed.x = math.abs(self._speed.x)
		var_4_1.x = var_4_0[3] + math.abs(var_4_1.x - var_4_0[3])
	elseif var_4_0[4] < var_4_1.x then
		self._speed.x = -math.abs(self._speed.x)
		var_4_1.x = var_4_0[4] - math.abs(var_4_1.x - var_4_0[4])
	end

	if var_4_1.z < var_4_0[2] then
		self._speed.z = math.abs(self._speed.z)
		var_4_1.z = var_4_0[2] + math.abs(var_4_1.z - var_4_0[2])
	elseif var_4_0[1] < var_4_1.z then
		self._speed.z = -math.abs(self._speed.z)
		var_4_1.z = var_4_0[1] - math.abs(var_4_1.z - var_4_0[1])
	end

	return var_4_1
end

function BattleEnvironmentBehaviourForce:Dispose()
	BattleEnvironmentBehaviourForce.super.Dispose(self)
	table.clear(self)

	return
end

return
