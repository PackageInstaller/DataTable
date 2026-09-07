ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_4 = ys.Battle.BattleDataFunction
local BattleSpaceLaserWeaponUnit = class("BattleSpaceLaserWeaponUnit", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleSpaceLaserWeaponUnit = BattleSpaceLaserWeaponUnit
BattleSpaceLaserWeaponUnit.__name = "BattleSpaceLaserWeaponUnit"

function BattleSpaceLaserWeaponUnit:createMajorEmitter(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	local var_1_0 = self:CreateEmitter(arg_1_3, arg_1_1, arg_1_2)

	self._majorEmitterList[#self._majorEmitterList + 1] = var_1_0

	return var_1_0
end

function BattleSpaceLaserWeaponUnit:CreateEmitter(arg_2_1, arg_2_2, arg_2_3)
	arg_2_1 = arg_2_1 or BattleSpaceLaserWeaponUnit.EMITTER_NORMAL

	local var_2_0
	local var_2_1
	local var_2_2
	local var_2_3 = 0

	local function var_2_4(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		if self._currentState == self.STATE_DISABLE then
			return
		end

		local var_3_0 = self:Spawn(self._emitBulletIDList[arg_2_3], arg_3_4, BattleSpaceLaserWeaponUnit.INTERNAL)

		var_2_3 = var_2_3 + 1
		arg_3_4 = self._tmpData.aim_type == var_0_1.WeaponAimType.AIM and arg_3_4 or nil

		var_3_0:SetOffsetPriority(arg_3_3)
		var_3_0:SetShiftInfo(arg_3_0, arg_3_1)
		var_3_0:setTrackingTarget(arg_3_4)
		var_3_0:SetYAngle(var_2_1)
		var_3_0:SetLifeTime(var_3_0:GetTemplate().extra_param.attack_time)
		var_3_0:RegisterLifeEndCB(function()
			var_2_3 = var_2_3 - 1

			if var_2_3 > 0 then
				return
			end

			if self._currentState == self.STATE_DISABLE then
				return
			end

			for iter_4_0, iter_4_1 in ipairs(self._majorEmitterList) do
				if iter_4_1:GetState() ~= iter_4_1.STATE_STOP then
					return
				end
			end

			self:EnterCoolDown()

			return
		end)

		local var_3_1 = var_2_2 or arg_3_4 and pg.Tool.FilterY(arg_3_4:GetCLDZCenterPosition())

		var_3_0:SetRotateInfo(var_3_1, self:GetBaseAngle(), arg_3_2)
		self:DispatchBulletEvent(var_3_0, var_2_0 or var_3_1)

		return var_3_0
	end

	return (var_0_0.Battle[arg_2_1].New(function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		if self._currentState == self.STATE_DISABLE then
			return
		end

		local var_5_0 = self._emitBulletIDList[arg_2_3]
		local var_5_1 = var_0_4.GetBulletTmpDataFromID(self._emitBulletIDList[arg_2_3]).extra_param.aim_time

		if not var_5_1 or var_5_1 <= 0 then
			var_2_4(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)

			return
		end

		local var_5_2 = self:Spawn(var_5_0, arg_5_4, BattleSpaceLaserWeaponUnit.INTERNAL)

		var_2_3 = var_2_3 + 1
		arg_5_4 = self._tmpData.aim_type == var_0_1.WeaponAimType.AIM and arg_5_4 or nil

		var_5_2:setTrackingTarget(arg_5_4)
		var_5_2:SetOffsetPriority(arg_5_3)
		var_5_2:SetShiftInfo(arg_5_0, arg_5_1)
		var_5_2:SetLifeTime(var_5_2:GetTemplate().extra_param.aim_time)
		var_5_2:SetAlert(true)
		var_5_2:RegisterLifeEndCB(function()
			var_2_3 = var_2_3 - 1
			var_2_0 = pg.Tool.FilterY(var_5_2:GetPosition() - Vector3(arg_5_0, 0, arg_5_1))
			var_2_1 = var_5_2:GetYAngle()
			var_2_2 = var_5_2:GetRotateInfo()

			var_2_4(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)

			return
		end)

		local var_5_3 = var_5_2:GetTemplate().alert_fx

		if var_5_3 and #var_5_3 > 0 then
			var_5_2:SetModleID(var_5_3)
		end

		local var_5_4 = arg_5_4 and pg.Tool.FilterY(arg_5_4:GetCLDZCenterPosition())

		var_5_2:SetRotateInfo(var_5_4, self:GetBaseAngle(), arg_5_2)
		self:DispatchBulletEvent(var_5_2, var_5_4)

		return var_5_2
	end, function()
		return
	end, arg_2_2))
end

function BattleSpaceLaserWeaponUnit:SingleFire(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	assert(false, "Not Support only fire for BattleSpaceLaserWeapon")

	return
end

return
