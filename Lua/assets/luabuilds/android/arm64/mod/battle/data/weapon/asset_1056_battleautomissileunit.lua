ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleTargetChoise
local BattleAutoMissileUnit = class("BattleAutoMissileUnit", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleAutoMissileUnit = BattleAutoMissileUnit
BattleAutoMissileUnit.__name = "BattleAutoMissileUnit"

function BattleAutoMissileUnit:Ctor()
	BattleAutoMissileUnit.super.Ctor(self)

	return
end

function BattleAutoMissileUnit:createMajorEmitter(arg_2_1, arg_2_2, arg_2_3)
	arg_2_3 = arg_2_3 or BattleAutoMissileUnit.EMITTER_NORMAL

	local var_2_0 = var_0_0.Battle[arg_2_3].New(function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		local var_3_0 = self:Spawn(self._emitBulletIDList[arg_2_2], arg_3_4, BattleAutoMissileUnit.INTERNAL)

		var_3_0:SetOffsetPriority(arg_3_3)
		var_3_0:SetShiftInfo(arg_3_0, arg_3_1)

		if self._tmpData.aim_type == var_0_1.WeaponAimType.AIM and arg_3_4 ~= nil then
			var_3_0:SetRotateInfo(arg_3_4:GetBeenAimedPosition(), self:GetBaseAngle(), arg_3_2)
		else
			var_3_0:SetRotateInfo(nil, self:GetBaseAngle(), arg_3_2)
		end

		var_3_0:setTrackingTarget(arg_3_4)
		var_3_0:SetTrackingFXData({})
		self:DispatchBulletEvent(var_3_0)

		return var_3_0
	end, function()
		for iter_4_0, iter_4_1 in ipairs(self._majorEmitterList) do
			if iter_4_1:GetState() ~= iter_4_1.STATE_STOP then
				return
			end
		end

		self:EnterCoolDown()

		return
	end, arg_2_1)

	self._majorEmitterList[#self._majorEmitterList + 1] = var_2_0

	return var_2_0
end

function BattleAutoMissileUnit:Tracking()
	return var_0_3.TargetWeightiest(self, nil, self:GetFilteredList())[1]
end

return
