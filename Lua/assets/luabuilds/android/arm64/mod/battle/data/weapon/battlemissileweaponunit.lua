ys = ys or {}

local var_0_0 = ys.Battle.BattleConst
local var_0_2 = class("BattleMissileWeaponUnit", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleMissileWeaponUnit = var_0_2
var_0_2.__name = "BattleMissileWeaponUnit"

function var_0_2.CalculateFixedExplodePosition(arg_1_0, arg_1_1)
	return Vector3(arg_1_0._host:GetPosition().x + (arg_1_0._host:GetDirection() == var_0_0.UnitDir.RIGHT and 1 or -1) * arg_1_1._range, 0, 0)
end

function var_0_2.CalculateRandTargetPosition(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2:GetCLDZCenterPosition()
	local var_2_1 = arg_2_1:GetTemplate().extra_param
	local var_2_2 = 0

	if var_2_1.accuracy then
		var_2_2 = arg_2_1:GetAttrByName(var_2_1.accuracy)
	end

	local var_2_3 = var_2_1.randomOffsetX or 0
	local var_2_4 = var_2_1.randomOffsetZ or 0
	local var_2_5 = math.max(0, var_2_3 - var_2_2)
	local var_2_6 = math.max(0, var_2_4 - var_2_2)
	local var_2_7 = var_2_1.offsetX or 0
	local var_2_8 = var_2_1.offsetZ or 0

	if var_2_5 ~= 0 then
		var_2_5 = var_2_5 * (math.random() - 0.5) + var_2_7
	end

	if var_2_6 ~= 0 then
		var_2_6 = var_2_6 * (math.random() - 0.5) + var_2_8
	end

	local var_2_9 = var_2_1.targetOffsetX or 0
	local var_2_10 = var_2_1.targetOffsetZ or 0

	return Vector3(var_2_0.x + var_2_5 + var_2_9, 0, var_2_0.z + var_2_6 + var_2_10)
end

function var_0_2.createMajorEmitter(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	return var_0_2.super.createMajorEmitter(arg_3_0, arg_3_1, arg_3_2, arg_3_3, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		local var_4_0 = arg_3_0:Spawn(arg_3_0._emitBulletIDList[arg_3_2], arg_4_4, var_0_2.INTERNAL)

		var_4_0:SetOffsetPriority(arg_4_3)
		var_4_0:SetShiftInfo(arg_4_0, arg_4_1)
		var_4_0:SetRotateInfo(nil, arg_3_0:GetBaseAngle(), arg_4_2)
		var_4_0:RegisterOnTheAir(arg_3_0:ChoiceOntheAir(var_4_0))
		arg_3_0:DispatchBulletEvent(var_4_0)

		return
	end, nil)
end

function var_0_2.ChoiceOntheAir(arg_5_0, arg_5_1)
	return function()
		local var_6_0 = arg_5_1:GetMissileTargetPosition()
		local var_6_1, var_6_2, var_6_3 = arg_5_1:GetRotateInfo()
		local var_6_4, var_6_5 = arg_5_1:GetOffset()

		var_6_0:Add(Vector3(var_6_4, 0, var_6_5))
		arg_5_1:SetExplodePosition(arg_5_1:GetSpawnPosition() + Quaternion.Euler(0, var_6_3, 0) * pg.Tool.FilterY(var_6_0 - arg_5_1:GetSpawnPosition()))
		var_0.Battle.BattleMissileFactory.CreateBulletAlert(arg_5_1)

		return
	end
end

return
