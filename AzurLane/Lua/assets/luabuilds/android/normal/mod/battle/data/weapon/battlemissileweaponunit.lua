ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleDataFunction

class = var_0_10003

local var_0_3 = var_0_10003("BattleMissileWeaponUnit", var_0.Battle.BattleWeaponUnit)

var_0.Battle.BattleMissileWeaponUnit = var_0_3
var_0_3.__name = "BattleMissileWeaponUnit"

function var_0_3.CalculateFixedExplodePosition(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1._range
	local var_1_1 = arg_1_0._host
	local var_1_2 = (var_3.GetDirection(var_1_1) == var_0_1.UnitDir.RIGHT and 1 or -1) * var_1_0
	local var_1_3 = arg_1_0._host
	local var_1_4 = var_4.GetPosition(var_1_3)

	Vector3 = var_1_3

	return var_1_3(var_1_4.x + var_1_2, 0, 0)
end

function var_0_3.CalculateRandTargetPosition(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2:GetCLDZCenterPosition()
	local var_2_1 = arg_2_1:GetTemplate().extra_param.accuracy
	local var_2_2 = 0

	if var_2_1 then
		var_2_2 = arg_2_1:GetAttrByName(var_2_1)
	end

	local var_2_3

	if not var_4.randomOffsetX then
		var_2_3 = 0
	end

	local var_2_4

	if not var_4.randomOffsetZ then
		var_2_4 = 0
	end

	math = var_1_10009

	local var_2_5 = var_1_10009.max(0, var_2_3 - var_2_2)

	math = var_9

	local var_2_6 = var_9.max(0, var_2_4 - var_2_2)
	local var_2_7

	if not var_4.offsetX then
		var_2_7 = 0
	end

	local var_2_8

	if not var_4.offsetZ then
		var_2_8 = 0
	end

	if var_2_5 ~= 0 then
		math = var_11
		var_2_5 = var_2_5 * (var_11.random() - 0.5) + var_2_7
	end

	if var_2_6 ~= 0 then
		math = var_11
		var_2_6 = var_2_6 * (var_11.random() - 0.5) + var_2_8
	end

	local var_2_9

	if not var_4.targetOffsetX then
		var_2_9 = 0
	end

	local var_2_10

	if not var_4.targetOffsetZ then
		var_2_10 = 0
	end

	Vector3 = var_1_10013

	return var_1_10013(var_2_0.x + var_2_5 + var_2_9, 0, var_2_0.z + var_2_6 + var_2_10)
end

function var_0_3.createMajorEmitter(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local function var_3_0(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		local var_4_0 = arg_3_0._emitBulletIDList[arg_3_2]
		local var_4_1 = arg_3_0
		local var_4_2 = var_6.Spawn(var_4_1, var_4_0, arg_4_4, var_0_3.INTERNAL)

		var_6.SetOffsetPriority(var_4_2, arg_4_3)
		var_6:SetShiftInfo(arg_4_0, arg_4_1)

		local var_4_3 = var_6
		local var_4_4 = var_6.SetRotateInfo
		local var_4_5
		local var_4_6 = arg_3_0

		var_4_4(var_4_3, var_4_5, var_10.GetBaseAngle(var_4_6), arg_4_2)

		local var_4_7 = var_6
		local var_4_8 = var_6.RegisterOnTheAir
		local var_4_9 = arg_3_0

		var_4_8(var_4_7, var_9.ChoiceOntheAir(var_4_9, var_6))

		local var_4_10 = arg_3_0

		var_7.DispatchBulletEvent(var_4_10, var_6)

		return
	end

	return var_0_3.super.createMajorEmitter(arg_3_0, arg_3_1, arg_3_2, arg_3_3, var_3_0, nil)
end

function var_0_3.ChoiceOntheAir(arg_5_0, arg_5_1)
	return function()
		local var_6_0 = arg_5_1
		local var_6_1 = var_0.GetMissileTargetPosition(var_6_0)
		local var_6_2 = arg_5_1
		local var_6_3, var_6_4, var_6_5 = var_1.GetRotateInfo(var_6_2)
		local var_6_6 = arg_5_1
		local var_6_7, var_6_8 = var_4.GetOffset(var_6_6)
		local var_6_9 = var_6_1
		local var_6_10 = var_6_1.Add

		Vector3 = var_2_10008

		var_6_10(var_6_9, var_2_10008(var_6_7, 0, var_6_8))

		Quaternion = var_6_10

		local var_6_11 = var_6_10.Euler(0, var_6_5, 0)

		pg = var_7

		local var_6_12 = var_7.Tool.FilterY
		local var_6_13 = arg_5_1
		local var_6_14 = var_6_12(var_6_1 - var_8.GetSpawnPosition(var_6_13))
		local var_6_15 = arg_5_1
		local var_6_16 = var_8.GetSpawnPosition(var_6_15) + var_6_11 * var_6_14
		local var_6_17 = arg_5_1

		var_8.SetExplodePosition(var_6_17, var_6_16)
		var_0.Battle.BattleMissileFactory.CreateBulletAlert(arg_5_1)

		return
	end
end

return
