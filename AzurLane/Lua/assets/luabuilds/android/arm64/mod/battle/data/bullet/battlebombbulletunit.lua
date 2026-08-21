ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleBulletEvent
local var_0_2 = ys.Battle.BattleConfig

ys.Battle.BattleBombBulletUnit = class("BattleBombBulletUnit", ys.Battle.BattleBulletUnit)
ys.Battle.BattleBombBulletUnit.__name = "BattleBombBulletUnit"

local var_0_3 = ys.Battle.BattleBombBulletUnit

function ys.Battle.BattleBombBulletUnit.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_3.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._randomOffset = Vector3.zero

	return
end

function ys.Battle.BattleBombBulletUnit.InitSpeed(arg_2_0)
	arg_2_0._yAngle = arg_2_0._barrageLowPriority and arg_2_0._baseAngle + arg_2_0._barrageAngle or math.rad2Deg * math.atan2(arg_2_0._explodePos.z - arg_2_0._spawnPos.z, arg_2_0._explodePos.x - arg_2_0._spawnPos.x)

	arg_2_0:calcSpeed()

	arg_2_0.updateSpeed = var_0_3.doNothing

	return
end

function ys.Battle.BattleBombBulletUnit.Update(arg_3_0)
	if arg_3_0._exist then
		var_0_3.super.Update(arg_3_0)
	end

	return
end

function ys.Battle.BattleBombBulletUnit.GetPierceCount(arg_4_0)
	return 1
end

function ys.Battle.BattleBombBulletUnit.IsOutRange(arg_5_0, arg_5_1)
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

function ys.Battle.BattleBombBulletUnit.OutRange(arg_6_0)
	arg_6_0:DispatchEvent(var_0_0.Event.New(var_0_1.EXPLODE, {
		UID = unitUniqueID
	}))
	var_0_3.super.OutRange(arg_6_0)

	return
end

function ys.Battle.BattleBombBulletUnit.SetSpawnPosition(arg_7_0, arg_7_1)
	var_0_3.super.SetSpawnPosition(arg_7_0, arg_7_1)

	if arg_7_0._barragePriority then
		arg_7_0._explodePos = arg_7_0._explodePos + Vector3(arg_7_0._offsetX, 0, arg_7_0._offsetZ)

		local var_7_0 = pg.Tool.FilterY(arg_7_0._spawnPos)

		arg_7_0._explodePos = Quaternion.Euler(0, arg_7_0._barrageAngle, 0) * (arg_7_0._explodePos - var_7_0) + var_7_0
	end

	if arg_7_0._fixToRange and Vector3.BattleDistance(arg_7_0._explodePos, arg_7_0._spawnPos) > arg_7_0._range then
		arg_7_0._explodePos = Vector3.Normalize((pg.Tool.FilterY(arg_7_0._explodePos - arg_7_0._spawnPos))) * arg_7_0._range + arg_7_0._spawnPos
	end

	if arg_7_0._convertedVelocity ~= 0 then
		local var_7_1 = Vector3.Distance(pg.Tool.FilterY(arg_7_0._spawnPos), arg_7_0._explodePos) / arg_7_0._convertedVelocity

		arg_7_0._verticalSpeed = arg_7_0:GetTemplate().extra_param.launchVrtSpeed or (arg_7_0._explodePos.y - arg_7_0._spawnPos.y) / var_7_1 - 0.5 * arg_7_0._gravity * var_7_1
	end

	return
end

function ys.Battle.BattleBombBulletUnit.SetExplodePosition(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetTemplate().extra_param

	arg_8_0._explodePos = var_8_0.targetFixX and var_8_0.targetFixZ and Vector3(var_8_0.targetFixX, 0, var_8_0.targetFixZ) or arg_8_1:Clone()

	if not arg_8_0._barragePriority then
		arg_8_0._explodePos = arg_8_0._explodePos + arg_8_0._randomOffset
	end

	arg_8_0._explodePos.y = var_0_2.BombDetonateHeight

	return
end

function ys.Battle.BattleBombBulletUnit.SetShiftInfo(arg_9_0, arg_9_1, arg_9_2)
	var_0_3.super.SetShiftInfo(arg_9_0, arg_9_1, arg_9_2)

	if arg_9_0:GetTemplate().extra_param.currentdrop then
		arg_9_0._explodePos.x = arg_9_0._explodePos.x + arg_9_0._offsetX
		arg_9_0._explodePos.z = arg_9_0._explodePos.z + arg_9_0._offsetZ
	end

	return
end

function ys.Battle.BattleBombBulletUnit.SetTemplateData(arg_10_0, arg_10_1)
	var_0_3.super.SetTemplateData(arg_10_0, arg_10_1)

	local var_10_0 = arg_10_0:GetTemplate().extra_param

	arg_10_0._barragePriority = var_10_0.barragePriority
	arg_10_0._barrageLowPriority = var_10_0.barrageLowPriority
	arg_10_0._fixToRange = var_10_0.fixToRange

	if var_10_0.barragePriority then
		arg_10_0._randomOffset = Vector3.zero
	else
		local var_10_1 = var_10_0.accuracy
		local var_10_2 = 0

		if var_10_0.accuracy then
			var_10_2 = arg_10_0:GetAttrByName(var_10_1)
		end

		local var_10_3 = var_10_0.randomOffsetX or 0
		local var_10_4 = var_10_0.randomOffsetZ or 0
		local var_10_5 = math.max(0, var_10_3 - var_10_2)
		local var_10_6 = math.max(0, var_10_4 - var_10_2)
		local var_10_7 = var_10_0.offsetX or 0
		local var_10_8 = var_10_0.offsetZ or 0

		if var_10_5 ~= 0 then
			var_10_5 = var_10_5 * (math.random() - 0.5) + var_10_7
		end

		if var_10_6 ~= 0 then
			var_10_6 = var_10_6 * (math.random() - 0.5) + var_10_8
		end

		local var_10_9 = var_10_0.targetOffsetX or 0
		local var_10_10 = var_10_0.targetOffsetZ or 0

		arg_10_0._randomOffset = Vector3(var_10_5 + var_10_9, 0, var_10_6 + var_10_10)
	end

	if var_10_0.timeToExplode then
		arg_10_0._explodeTime = pg.TimeMgr.GetInstance():GetCombatTime() + var_10_0.timeToExplode
	end

	arg_10_0._gravity = var_10_0.gravity or var_0_0.Battle.BattleConfig.GRAVITY
	arg_10_0._hitInterval = arg_10_1.hit_type.interval or 0.2

	return
end

function ys.Battle.BattleBombBulletUnit.DealDamage(arg_11_0)
	arg_11_0._nextDamageTime = pg.TimeMgr.GetInstance():GetCombatTime() + arg_11_0._hitInterval

	return
end

function ys.Battle.BattleBombBulletUnit.CanDealDamage(arg_12_0)
	local var_12_0

	if not arg_12_0._nextDamageTime then
		arg_12_0._nextDamageTime = pg.TimeMgr.GetInstance():GetCombatTime() + arg_12_0._tempData.extra_param.alert_duration

		do return false end

		goto label_12_0

		var_12_0 = pg.TimeMgr.GetInstance()
	end

	do return arg_12_0._nextDamageTime < var_12_0:GetCombatTime() end

	::label_12_0::

	return
end

function ys.Battle.BattleBombBulletUnit.HideBullet(arg_13_0)
	arg_13_0._position.x = 0
	arg_13_0._position.y = 100
	arg_13_0._position.z = 0

	return
end

function ys.Battle.BattleBombBulletUnit.GetExplodePostion(arg_14_0)
	return arg_14_0._explodePos
end

return
