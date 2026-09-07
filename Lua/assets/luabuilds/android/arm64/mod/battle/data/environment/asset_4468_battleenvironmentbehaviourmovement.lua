ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleConfig
local BattleEnvironmentBehaviourMovement = class("BattleEnvironmentBehaviourMovement", ys.Battle.BattleEnvironmentBehaviour)

ys.Battle.BattleEnvironmentBehaviourMovement = BattleEnvironmentBehaviourMovement
BattleEnvironmentBehaviourMovement.__name = "BattleEnvironmentBehaviourMovement"

function BattleEnvironmentBehaviourMovement:Ctor()
	self._movebeginTime = nil
	self._moveEndTime = nil
	self._lastPosition = nil
	self._destPosition = nil
	self._targetIndex = 1

	BattleEnvironmentBehaviourMovement.super.Ctor(self)

	return
end

function BattleEnvironmentBehaviourMovement:SetTemplate(arg_2_1)
	BattleEnvironmentBehaviourMovement.super.SetTemplate(self, arg_2_1)

	self._route = arg_2_1.route or {}
	self._random_duration = arg_2_1.random_duration or {
		1,
		5
	}
	self._random_speed = arg_2_1.random_speed or 1

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

	var_2_3[1] = var_0_0.Battle.BattleDataProxy.GetInstance():GetFleetBoundByIFF(var_0_2.FRIENDLY_CODE)
	var_2_3[3] = var_2_3[3] + var_2_1
	var_2_3[4] = var_2_3[4] - var_2_1
	var_2_3[2] = var_2_3[2] + var_2_2
	var_2_3[1] = var_2_3[1] - var_2_2
	self._bounds = var_2_3
	self._lastPosition = Vector3(unpack(var_2_0.coordinate))

	if arg_2_1.random_range then
		self._randomRangeX = arg_2_1.random_range[1]
		self._randomRangeZ = arg_2_1.random_range[2]
		self._resetRandomRange = true
	end

	return
end

function BattleEnvironmentBehaviourMovement:doBehaviour()
	local var_3_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	if not self._moveEndTime then
		self._movebeginTime = var_3_0

		if self._route[self._targetIndex] then
			self._destPosition = Vector3(unpack(self._route[self._targetIndex]))
			self._moveEndTime = var_3_0 + self._route[self._targetIndex][4]
			self._targetIndex = self._targetIndex + 1
		else
			local var_3_1 = self:GenerateRandomPlayerAreaPoint()
			local var_3_2 = math.random(unpack(self._random_duration))
			local var_3_3 = (var_3_1 - self._lastPosition):Magnitude()

			if var_3_3 < var_3_2 * self._random_speed then
				var_3_2 = var_3_3 / self._random_speed
			else
				var_3_1 = Vector3.Lerp(self._lastPosition, var_3_1, var_3_2 * self._random_speed / var_3_3)
			end

			self._moveEndTime = var_3_0 + var_3_2
			self._destPosition = var_3_1
		end
	end

	if var_3_0 < self._moveEndTime then
		self._unit._aoeData:SetPosition((Vector3.Lerp(self._lastPosition, self._destPosition, (var_3_0 - self._movebeginTime) / (self._moveEndTime - self._movebeginTime))))
	else
		self._unit._aoeData:SetPosition(self._destPosition)

		self._lastPosition = self._destPosition
		self._moveEndTime = nil
	end

	BattleEnvironmentBehaviourMovement.super.doBehaviour(self)

	return
end

function BattleEnvironmentBehaviourMovement:GenerateRandomPlayerAreaPoint()
	local var_4_0 = math.random(self._bounds[3], self._bounds[4])
	local var_4_1 = math.random(self._bounds[2], self._bounds[1])

	if self._resetRandomRange then
		self:resetRandomBound(var_4_0, var_4_1)
	end

	return Vector3(var_4_0, 0, var_4_1)
end

function BattleEnvironmentBehaviourMovement:resetRandomBound(arg_5_1, arg_5_2)
	self._bounds[3] = arg_5_1 - self._randomRangeX
	self._bounds[4] = arg_5_1 + self._randomRangeX
	self._bounds[2] = arg_5_2 - self._randomRangeZ
	self._bounds[1] = arg_5_2 + self._randomRangeZ
	self._resetRandomRange = false

	return
end

function BattleEnvironmentBehaviourMovement:Dispose()
	BattleEnvironmentBehaviourMovement.super.Dispose(self)
	table.clear(self)

	return
end

return
