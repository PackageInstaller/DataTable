ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local BattleMissileWeaponUnit = class("BattleMissileWeaponUnit", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleMissileWeaponUnit = BattleMissileWeaponUnit
BattleMissileWeaponUnit.__name = "BattleMissileWeaponUnit"

function BattleMissileWeaponUnit:CalculateFixedExplodePosition(arg_1_1)
	return Vector3(self._host:GetPosition().x + (self._host:GetDirection() == var_0_1.UnitDir.RIGHT and 1 or -1) * arg_1_1._range, 0, 0)
end

function BattleMissileWeaponUnit:CalculateRandTargetPosition(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2:GetCLDZCenterPosition()
	local var_2_1 = arg_2_1:GetTemplate().extra_param
	local var_2_2 = 0

	if var_2_1.accuracy then
		var_2_2 = arg_2_1:GetAttrByName(var_2_1.accuracy)
	end

	local var_2_3 = var_2_1.randomOffsetZ or 0
	local var_2_4 = math.max(0, (var_2_1.randomOffsetX or 0) - var_2_2)
	local var_2_5 = math.max(0, var_2_3 - var_2_2)
	local var_2_6 = var_2_1.offsetZ or 0

	if var_2_4 ~= 0 then
		var_2_4 = var_2_4 * (math.random() - 0.5) + (var_2_1.offsetX or 0)
	end

	if var_2_5 ~= 0 then
		var_2_5 = var_2_5 * (math.random() - 0.5) + var_2_6
	end

	return Vector3(var_2_0.x + var_2_4 + (var_2_1.targetOffsetX or 0), 0, var_2_0.z + var_2_5 + (var_2_1.targetOffsetZ or 0))
end

function BattleMissileWeaponUnit:createMajorEmitter(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	return BattleMissileWeaponUnit.super.createMajorEmitter(self, arg_3_1, arg_3_2, arg_3_3, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		local var_4_0 = self:Spawn(self._emitBulletIDList[arg_3_2], arg_4_4, BattleMissileWeaponUnit.INTERNAL)

		var_4_0:SetOffsetPriority(arg_4_3)
		var_4_0:SetShiftInfo(arg_4_0, arg_4_1)
		var_4_0:SetRotateInfo(nil, self:GetBaseAngle(), arg_4_2)
		var_4_0:RegisterOnTheAir(self:ChoiceOntheAir(var_4_0))
		self:DispatchBulletEvent(var_4_0)

		return
	end, nil)
end

function BattleMissileWeaponUnit:ChoiceOntheAir(arg_5_1)
	return function()
		local var_6_0 = arg_5_1:GetMissileTargetPosition()
		local var_6_1, var_6_2, var_6_3 = arg_5_1:GetRotateInfo()
		local var_6_4, var_6_5 = arg_5_1:GetOffset()

		var_6_0:Add(Vector3(var_6_4, 0, var_6_5))
		arg_5_1:SetExplodePosition(arg_5_1:GetSpawnPosition() + Quaternion.Euler(0, var_6_3, 0) * pg.Tool.FilterY(var_6_0 - arg_5_1:GetSpawnPosition()))
		var_0_0.Battle.BattleMissileFactory.CreateBulletAlert(arg_5_1)

		return
	end
end

return
