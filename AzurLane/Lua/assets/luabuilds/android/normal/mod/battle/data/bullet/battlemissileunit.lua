ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle.BattleBulletEvent

pg = var_0_10004

local var_0_4 = var_0_10004.bfConsts
local var_0_5 = var_0.Battle.BattleFormulas
local var_0_6 = var_0.Battle.BattleConfig

class = var_0_10007

local var_0_7 = var_0_10007("BattleMissileUnit", var_0.Battle.BattleBulletUnit)

var_0_7.__name = "BattleMissileUnit"
var_0.Battle.BattleMissileUnit = var_0_7
var_0_7.STATE_LAUNCH = "Launch"
var_0_7.STATE_ATTACK = "Attack"
var_0_7.TYPE_COORD = 1
var_0_7.TYPE_RANGE = 2
var_0_7.TYPE_TARGET = 3

function var_0_7.Ctor(arg_1_0, ...)
	var_0_7.super.Ctor(arg_1_0, ...)

	arg_1_0._state = arg_1_0.STATE_LAUNCH

	return
end

function var_0_7.SetTemplateData(arg_2_0, arg_2_1)
	var_0_7.super.SetTemplateData(arg_2_0, arg_2_1)
	arg_2_0:ResetVelocity(0)

	local var_2_0

	if not arg_2_0:GetTemplate().extra_param.gravity then
		var_2_0 = var_0.Battle.BattleConfig.GRAVITY
	end

	arg_2_0._gravity = var_2_0

	local var_2_1

	if not var_2.aimType then
		var_2_1 = var_0_7.TYPE_TARGET
	end

	arg_2_0._targetType = var_2_1

	return
end

function var_0_7.GetPierceCount(arg_3_0)
	return 1
end

function var_0_7.RegisterOnTheAir(arg_4_0, arg_4_1)
	arg_4_0._onTheHighest = arg_4_1

	return
end

function var_0_7.SetExplodePosition(arg_5_0, arg_5_1)
	arg_5_0._explodePos = arg_5_1:Clone()
	arg_5_0._explodePos.y = var_0_1.BombDetonateHeight

	return
end

function var_0_7.GetExplodePostion(arg_6_0)
	return arg_6_0._explodePos
end

local var_0_8 = 1 / var_0_6.viewFPS

function var_0_7.SetSpawnPosition(arg_7_0, arg_7_1)
	var_0_7.super.SetSpawnPosition(arg_7_0, arg_7_1)

	arg_7_0._verticalSpeed = arg_7_0:GetTemplate().extra_param.launchVrtSpeed

	return
end

function var_0_7.Update(arg_8_0, arg_8_1)
	var_0_7.super.Update(arg_8_0, arg_8_1)

	if arg_8_0._state == arg_8_0.STATE_LAUNCH and arg_8_1 > arg_8_0:GetTemplate().extra_param.launchRiseTime + arg_8_0._timeStamp then
		arg_8_0:CompleteRise()
	end

	return
end

function var_0_7.CompleteRise(arg_9_0)
	arg_9_0._state = arg_9_0.STATE_ATTACK
	arg_9_0._gravity = 0

	if arg_9_0._onTheHighest then
		arg_9_0._onTheHighest()
	end

	local var_9_0 = arg_9_0:GetTemplate().extra_param.fallTime

	arg_9_0._targetPos = arg_9_0._explodePos
	math = var_2

	local var_9_1 = var_2.rad2Deg

	math = var_1_10003
	arg_9_0._yAngle = var_9_1 * var_1_10003.atan2(arg_9_0._explodePos.z - arg_9_0._spawnPos.z, arg_9_0._explodePos.x - arg_9_0._spawnPos.x)
	arg_9_0._verticalSpeed = -(arg_9_0._position.y / var_9_0) * var_0_8
	pg = var_2

	local var_9_2 = var_2.Tool.FilterY(arg_9_0._explodePos - arg_9_0._position)
	local var_9_3 = var_2.Magnitude(var_9_2)

	arg_9_0:ResetVelocity(var_0_5.ConvertBulletDataSpeed(var_9_3 / var_9_0 * var_0_8))
	arg_9_0:calcSpeed()

	return
end

function var_0_7.IsOutRange(arg_10_0)
	return arg_10_0._state == arg_10_0.STATE_ATTACK and arg_10_0._position.y <= var_0_1.BombDetonateHeight
end

function var_0_7.OutRange(arg_11_0, arg_11_1)
	local var_11_0 = {
		UID = arg_11_1
	}

	arg_11_0:DispatchEvent(var_0.Event.New(var_0_3.EXPLODE, var_11_0))
	var_0_7.super.OutRange(arg_11_0)

	return
end

function var_0_7.GetMissileTargetPosition(arg_12_0)
	if arg_12_0._targetType == var_0_7.TYPE_RANGE then
		return arg_12_0:aimRange()
	elseif arg_12_0._targetType == var_0_7.TYPE_COORD then
		return arg_12_0:aimCoord()
	elseif arg_12_0._targetType == var_0_7.TYPE_TARGET then
		return arg_12_0:aimTarget()
	end

	return
end

function var_0_7.aimRange(arg_13_0)
	local var_13_0 = arg_13_0._range
	local var_13_1 = arg_13_0._range * arg_13_0:GetIFF()

	Vector3 = var_3

	return (var_3(arg_13_0._spawnPos.x + var_13_1, 0, 0))
end

function var_0_7.aimCoord(arg_14_0)
	local var_14_0 = arg_14_0:GetTemplate().extra_param.missileX
	local var_14_1 = var_1.missileZ

	if not var_14_0 or not var_14_1 then
		return arg_14_0:aimRange()
	end

	Vector3 = var_1_10004

	return (var_1_10004(var_14_0, 0, var_14_1))
end

function var_0_7.aimTarget(arg_15_0)
	local var_15_0 = arg_15_0:GetWeapon()

	if not var_1.GetHost(var_15_0) or not var_2:IsAlive() then
		return arg_15_0:aimCoord()
	end

	local var_15_1 = var_1:Tracking()
	local var_15_2

	if not (var_1:GetTemplateData().aim_type == var_0_2.WeaponAimType.AIM and var_15_1) or not var_1:CalculateRandTargetPosition(arg_15_0, var_15_1) then
		var_15_2 = var_1:CalculateFixedExplodePosition(arg_15_0)
	end

	return var_15_2
end

return
