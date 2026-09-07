ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst

ys.Battle.BattleSupportHiveUnit = class("BattleSupportHiveUnit", ys.Battle.BattleWeaponUnit)
ys.Battle.BattleSupportHiveUnit.__name = "BattleSupportHiveUnit"

local var_0_3 = ys.Battle.BattleSupportHiveUnit

function ys.Battle.BattleSupportHiveUnit.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleSupportHiveUnit:Update()
	self:UpdateReload()
	self:updateMovementInfo()

	if self._currentState == self.STATE_READY then
		if self._host:GetUnitType() ~= var_0_1.UnitType.PLAYER_UNIT then
			if self._preCastInfo.time == nil then
				self._currentState = self.STATE_PRECAST_FINISH
			else
				self:PreCast()
			end
		elseif #var_0_0.Battle.BattleTargetChoise.TargetAircraftGB(self._host) > 0 then
			self._currentState = self.STATE_PRECAST_FINISH
		end
	end

	if self._currentState == self.STATE_PRECAST_FINISH then
		self:updateMovementInfo()
		self:Fire()
	end

	return
end

function ys.Battle.BattleSupportHiveUnit:Fire()
	self:DispatchGCD()

	self._currentState = self.STATE_ATTACK

	self:DoAttack()

	return true
end

function ys.Battle.BattleSupportHiveUnit.createMajorEmitter(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	var_0_3.super.createMajorEmitter(arg_4_0, arg_4_1, arg_4_2, nil, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		local var_5_0, var_5_1 = arg_4_0:SpwanAircraft(arg_5_2)

		var_5_0:AddCreateTimer(var_5_1, 1.5)

		if arg_4_0._debugRecordDEFAircraft then
			table.insert(arg_4_0._debugRecordDEFAircraft, var_5_0)
		end

		return
	end, nil)

	return
end

function ys.Battle.BattleSupportHiveUnit:SpwanAircraft(arg_6_1)
	local var_6_0 = math.deg2Rad * (self:GetBaseAngle() + arg_6_1)

	return self._dataProxy:CreateAircraft(self._host, self._tmpData.id, self:GetPotential(), self._skinID), (Vector3(math.cos(var_6_0), 0, math.sin(var_6_0)))
end

function ys.Battle.BattleSupportHiveUnit:GetATKAircraftList()
	self._debugRecordATKAircraft = self._debugRecordATKAircraft or {}

	return self._debugRecordATKAircraft
end

function ys.Battle.BattleSupportHiveUnit:GetDEFAircraftList()
	self._debugRecordDEFAircraft = self._debugRecordDEFAircraft or {}

	return self._debugRecordDEFAircraft
end

function ys.Battle.BattleSupportHiveUnit:GetDamageSUM()
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs((self:GetDEFAircraftList())) do
		for iter_9_2, iter_9_3 in ipairs((iter_9_1:GetWeapon())) do
			var_9_0 = var_9_0 + iter_9_3:GetDamageSUM()
		end
	end

	return var_9_0
end

return
