ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleBulletEvent
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleBombBulletUnit = var_0_10004("BattleBombBulletUnit", var_0.Battle.BattleBulletUnit)
var_0.Battle.BattleBombBulletUnit.__name = "BattleBombBulletUnit"

local var_0_4 = var_0.Battle.BattleBombBulletUnit

function var_0_4.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_4.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	Vector3 = var_3
	arg_1_0._randomOffset = var_3.zero

	return
end

function var_0_4.InitSpeed(arg_2_0)
	if arg_2_0._barrageLowPriority then
		arg_2_0._yAngle = arg_2_0._baseAngle + arg_2_0._barrageAngle
	else
		math = var_1

		local var_2_0 = var_1.rad2Deg

		math = var_1_10002
		arg_2_0._yAngle = var_2_0 * var_1_10002.atan2(arg_2_0._explodePos.z - arg_2_0._spawnPos.z, arg_2_0._explodePos.x - arg_2_0._spawnPos.x)
	end

	arg_2_0:calcSpeed()

	arg_2_0.updateSpeed = var_0_4.doNothing

	return
end

function var_0_4.Update(arg_3_0)
	if arg_3_0._exist then
		var_0_4.super.Update(arg_3_0)
	end

	return
end

function var_0_4.GetPierceCount(arg_4_0)
	return 1
end

function var_0_4.IsOutRange(arg_5_0, arg_5_1)
	if not arg_5_0._exist then
		return false
	end

	if arg_5_0._explodeTime and arg_5_1 >= arg_5_0._explodeTime then
		return true
	end

	if arg_5_0._reachDestFlag and not arg_5_0._explodeTime then
		return true
	else
		return false
	end

	return
end

function var_0_4.OutRange(arg_6_0)
	local var_6_0 = {}

	unitUniqueID = var_1_10002
	var_6_0.UID = var_1_10002

	arg_6_0:DispatchEvent(var_0.Event.New(var_0_1.EXPLODE, var_6_0))
	var_0_4.super.OutRange(arg_6_0)

	return
end

function var_0_4.SetSpawnPosition(arg_7_0, arg_7_1)
	var_0_4.super.SetSpawnPosition(arg_7_0, arg_7_1)

	if arg_7_0._barragePriority then
		local var_7_0 = arg_7_0._explodePos

		Vector3 = var_1_10003
		arg_7_0._explodePos = var_7_0 + var_1_10003(arg_7_0._offsetX, 0, arg_7_0._offsetZ)
		Quaternion = var_2

		local var_7_1 = var_2.Euler(0, arg_7_0._barrageAngle, 0)

		pg = var_1_10003
		var_1_10003 = var_1_10003.Tool.FilterY(arg_7_0._spawnPos)
		arg_7_0._explodePos = var_7_1 * (arg_7_0._explodePos - var_1_10003) + var_1_10003
	end

	if arg_7_0._fixToRange then
		Vector3 = var_2

		local var_7_2 = var_2.BattleDistance(arg_7_0._explodePos, arg_7_0._spawnPos)

		if arg_7_0._range < var_7_2 then
			pg = var_1_10003
			var_1_10003 = var_1_10003.Tool.FilterY(arg_7_0._explodePos - arg_7_0._spawnPos)
			Vector3 = var_4
			arg_7_0._explodePos = var_4.Normalize(var_1_10003) * arg_7_0._range + arg_7_0._spawnPos
		end
	end

	if arg_7_0._convertedVelocity ~= 0 then
		pg = var_2

		local var_7_3 = var_2.Tool.FilterY(arg_7_0._spawnPos)

		Vector3 = var_1_10003

		local var_7_4 = var_1_10003.Distance(var_7_3, arg_7_0._explodePos) / arg_7_0._convertedVelocity
		local var_7_5 = arg_7_0._explodePos.y - arg_7_0._spawnPos.y
		local var_7_6

		if not arg_7_0:GetTemplate().extra_param.launchVrtSpeed then
			var_7_6 = var_7_5 / var_7_4 - 0.5 * arg_7_0._gravity * var_7_4
		end

		arg_7_0._verticalSpeed = var_7_6
	end

	return
end

function var_0_4.SetExplodePosition(arg_8_0, arg_8_1)
	if arg_8_0:GetTemplate().extra_param.targetFixX and var_2.targetFixZ then
		Vector3 = var_3
		arg_8_0._explodePos = var_3(var_2.targetFixX, 0, var_2.targetFixZ)
	else
		arg_8_0._explodePos = arg_8_1:Clone()
	end

	if not arg_8_0._barragePriority then
		arg_8_0._explodePos = arg_8_0._explodePos + arg_8_0._randomOffset
	end

	arg_8_0._explodePos.y = var_0_2.BombDetonateHeight

	return
end

function var_0_4.SetShiftInfo(arg_9_0, arg_9_1, arg_9_2)
	var_0_4.super.SetShiftInfo(arg_9_0, arg_9_1, arg_9_2)

	if arg_9_0:GetTemplate().extra_param.currentdrop then
		arg_9_0._explodePos.x = arg_9_0._explodePos.x + arg_9_0._offsetX
		arg_9_0._explodePos.z = arg_9_0._explodePos.z + arg_9_0._offsetZ
	end

	return
end

function var_0_4.SetTemplateData(arg_10_0, arg_10_1)
	var_0_4.super.SetTemplateData(arg_10_0, arg_10_1)

	arg_10_0._barragePriority = arg_10_0:GetTemplate().extra_param.barragePriority
	arg_10_0._barrageLowPriority = var_2.barrageLowPriority
	arg_10_0._fixToRange = var_2.fixToRange

	if var_2.barragePriority then
		Vector3 = var_3
		arg_10_0._randomOffset = var_3.zero
	else
		local var_10_0 = var_2.accuracy
		local var_10_1 = 0

		if var_10_0 then
			var_1_10007 = arg_10_0
			var_10_1 = arg_10_0.GetAttrByName(var_1_10007, var_10_0)
		end

		local var_10_2

		if not var_2.randomOffsetX then
			var_10_2 = 0
		end

		local var_10_3

		if not var_2.randomOffsetZ then
			var_10_3 = 0
		end

		math = var_1_10007

		local var_10_4 = var_1_10007.max(0, var_10_2 - var_10_1)

		math = var_7

		local var_10_5 = var_7.max(0, var_10_3 - var_10_1)
		local var_10_6

		if not var_2.offsetX then
			var_10_6 = 0
		end

		local var_10_7

		if not var_2.offsetZ then
			var_10_7 = 0
		end

		if var_10_4 ~= 0 then
			math = var_9
			var_10_4 = var_10_4 * (var_9.random() - 0.5) + var_10_6
		end

		if var_10_5 ~= 0 then
			math = var_9
			var_10_5 = var_10_5 * (var_9.random() - 0.5) + var_10_7
		end

		local var_10_8

		if not var_2.targetOffsetX then
			var_10_8 = 0
		end

		local var_10_9

		if not var_2.targetOffsetZ then
			var_10_9 = 0
		end

		Vector3 = var_1_10011
		arg_10_0._randomOffset = var_1_10011(var_10_4 + var_10_8, 0, var_10_5 + var_10_9)
	end

	if var_2.timeToExplode then
		pg = var_3

		local var_10_10 = var_3.TimeMgr.GetInstance()

		arg_10_0._explodeTime = var_3.GetCombatTime(var_10_10) + var_2.timeToExplode
	end

	local var_10_11

	if not var_2.gravity then
		var_10_11 = var_0.Battle.BattleConfig.GRAVITY
	end

	arg_10_0._gravity = var_10_11

	local var_10_12

	if not arg_10_1.hit_type.interval then
		var_10_12 = 0.2
	end

	arg_10_0._hitInterval = var_10_12

	return
end

function var_0_4.DealDamage(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.TimeMgr.GetInstance()

	arg_11_0._nextDamageTime = var_1.GetCombatTime(var_11_0) + arg_11_0._hitInterval

	return
end

function var_0_4.CanDealDamage(arg_12_0)
	if not arg_12_0._nextDamageTime then
		pg = var_1

		local var_12_0 = var_1.TimeMgr.GetInstance()

		arg_12_0._nextDamageTime = var_1.GetCombatTime(var_12_0) + arg_12_0._tempData.extra_param.alert_duration

		return false
	else
		local var_12_1 = arg_12_0._nextDamageTime

		pg = var_1_10002

		local var_12_2 = var_1_10002.TimeMgr.GetInstance()

		return var_12_1 < var_2.GetCombatTime(var_12_2)
	end

	return
end

function var_0_4.HideBullet(arg_13_0)
	arg_13_0._position.x = 0
	arg_13_0._position.y = 100
	arg_13_0._position.z = 0

	return
end

function var_0_4.GetExplodePostion(arg_14_0)
	return arg_14_0._explodePos
end

return
