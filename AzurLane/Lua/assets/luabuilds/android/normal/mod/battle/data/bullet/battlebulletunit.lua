ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleBulletEvent
local var_0_2 = var_0.Battle.BattleFormulas

Vector3 = var_0_10003

local var_0_3 = var_0_10003.up
local var_0_4 = var_0.Battle.BattleVariable
local var_0_5 = var_0.Battle.BattleConfig
local var_0_6 = var_0.Battle.BattleTargetChoise
local var_0_7 = 1 / var_0.Battle.BattleConfig.viewFPS
local var_0_8 = var_0.Battle.BattleConst
local var_0_9 = var_0.Battle.BattleConst.AircraftUnitType
local var_0_10 = var_0.Battle

class = var_0_10012
var_0_10.BattleBulletUnit = var_0_10012("BattleBulletUnit")
var_0.Battle.BattleBulletUnit.__name = "BattleBulletUnit"

local var_0_11 = var_0.Battle.BattleBulletUnit

var_0_11.ACC_INTERVAL = var_0_5.calcInterval
math = var_12

local var_0_12 = var_12.cos

math = var_13
var_0_11.TRACKER_ANGLE = var_0_12(var_13.deg2Rad * 10)
var_0_11.MIRROR_RES = "_mirror"

function var_0_11.doAccelerate(arg_1_0, arg_1_1)
	local var_1_0, var_1_1 = arg_1_0:GetAcceleration(arg_1_1)

	if var_1_0 == 0 and var_1_1 == 0 then
		return
	end

	if var_1_0 < 0 and arg_1_0._speedLength + var_1_0 < 0 then
		arg_1_0:reverseAcceleration()
	end

	local var_1_2 = arg_1_0._speed

	var_4.Set(var_1_2, arg_1_0._speed.x + arg_1_0._speedNormal.x * var_1_0 + arg_1_0._speedCross.x * var_1_1, arg_1_0._speed.y + arg_1_0._speedNormal.y * var_1_0 + arg_1_0._speedCross.y * var_1_1, arg_1_0._speed.z + arg_1_0._speedNormal.z * var_1_0 + arg_1_0._speedCross.z * var_1_1)

	local var_1_3 = arg_1_0._speed

	arg_1_0._speedLength = var_4.Magnitude(var_1_3)

	if arg_1_0._speedLength ~= 0 then
		local var_1_4 = arg_1_0._speedNormal
		local var_1_5 = var_4.Copy(var_1_4, arg_1_0._speed)

		var_4.Div(var_1_5, arg_1_0._speedLength)
	end

	local var_1_6 = arg_1_0._speedCross
	local var_1_7 = var_4.Copy(var_1_6, arg_1_0._speedNormal)

	var_4.Cross2(var_1_7, var_0_3)

	return
end

function var_0_11.doTrack(arg_2_0)
	if arg_2_0:getTrackingTarget() == nil and var_0_6.TargetHarmNearest(arg_2_0)[1] ~= nil and arg_2_0:GetDistance(var_1) <= arg_2_0._trackRange then
		arg_2_0:setTrackingTarget(var_1)
	end

	if arg_2_0:getTrackingTarget() == nil or var_1 == -1 then
		return
	elseif not var_1:IsAlive() then
		arg_2_0:setTrackingTarget(-1)

		return
	elseif arg_2_0:GetDistance(var_1) > arg_2_0._trackRange then
		arg_2_0:setTrackingTarget(-1)

		return
	end

	if not var_1:GetBeenAimedPosition() then
		return
	end

	local var_2_0 = var_2 - arg_2_0:GetPosition()

	var_3.SetNormalize(var_2_0)

	Vector3 = var_4

	local var_2_1 = var_4.Normalize(arg_2_0._speed)

	Vector3 = var_5

	local var_2_2 = var_5.Dot(var_2_1, var_3)
	local var_2_3 = var_2_1.z * var_3.x - var_2_1.x * var_3.z

	if var_2_2 >= var_0_11.TRACKER_ANGLE then
		return
	end

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.GetSpeedRatio(var_2_4)

	math = var_2_4

	local var_2_6 = var_2_4.cos(arg_2_0._cosAngularSpeed * var_2_5)

	math = var_9

	local var_2_7 = var_9.sin(arg_2_0._sinAngularSpeed * var_2_5)
	local var_2_8 = var_2_2
	local var_2_9 = var_2_3

	if var_2_2 < var_2_6 then
		var_2_8 = var_2_6
		var_2_9 = var_2_7 * (var_2_9 >= 0 and 1 or -1)
	end

	local var_2_10 = arg_2_0._speed.x * var_2_8 + arg_2_0._speed.z * var_2_9
	local var_2_11 = arg_2_0._speed.z * var_2_8 - arg_2_0._speed.x * var_2_9
	local var_2_12 = arg_2_0._speed

	var_14.Set(var_2_12, var_2_10, 0, var_2_11)

	return
end

function var_0_11.doOrbit(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.Tool.FilterY
	local var_3_1 = arg_3_0._weapon
	local var_3_2 = var_3_0(var_2.GetPosition(var_3_1))

	pg = var_2

	local var_3_3 = (var_2.Tool.FilterY(arg_3_0:GetPosition()) - var_3_2).magnitude
	local var_3_4 = (var_3_2 - var_2).normalized
	local var_3_5

	if 10 < var_3_3 then
		var_3_5 = (var_3_4 + arg_3_0._speed.normalized).normalized
	else
		Vector3 = var_6
		var_3_5 = (var_6(-var_3_4.z, 0, var_3_4.x) + arg_3_0._speed.normalized).normalized
	end

	arg_3_0._speed = var_3_5

	return
end

function var_0_11.RotateY(arg_4_0, arg_4_1)
	math = var_1_10002

	local var_4_0 = var_1_10002.cos(arg_4_1)

	math = var_3

	local var_4_1 = var_3.sin(arg_4_1)

	Vector3 = var_4

	return var_4(arg_4_0.x * var_4_0 + arg_4_0.z * var_4_1, arg_4_0.y, arg_4_0.z * var_4_0 - arg_4_0.x * var_4_1)
end

function var_0_11.doCircle(arg_5_0)
	if not arg_5_0._originPos then
		return
	end

	local var_5_0 = arg_5_0:GetSpeedRatio() * (1 + var_0.Battle.BattleAttr.GetCurrent(arg_5_0, "bulletSpeedRatio"))

	pg = var_2

	local var_5_1 = var_2.Tool.FilterY(arg_5_0._position - arg_5_0._originPos)
	local var_5_2 = arg_5_0._convertedVelocity
	local var_5_3

	if not (var_5_1:Magnitude() - arg_5_0._centripetalSpeed * var_5_0 * arg_5_0._inverseFlag < 0) or not -arg_5_0._inverseFlag then
		var_5_3 = arg_5_0._inverseFlag
	end

	arg_5_0._inverseFlag = var_5_3

	if var_4 <= 1e-05 then
		return
	end

	local var_5_4 = arg_5_0._circleAntiClockwise
	local var_5_5 = var_5_2 / var_4 * (var_5_4 and 1 or -1) * var_5_0
	local var_5_6 = arg_5_0.RotateY(var_5_1, var_5_5)
	local var_5_7 = var_8.Mul(var_5_6, var_5 / var_4)

	arg_5_0._speed = var_9.Sub(var_5_7, var_5_1)

	return
end

function var_0_11.doNothing(arg_6_0)
	if arg_6_0._gravity ~= 0 then
		arg_6_0._verticalSpeed = arg_6_0._verticalSpeed + arg_6_0._gravity * arg_6_0:GetSpeedRatio()
	end

	return
end

function var_0_11.Ctor(arg_7_0, arg_7_1, arg_7_2)
	var_0.EventDispatcher.AttachEventDispatcher(arg_7_0)

	arg_7_0._battleProxy = var_0.Battle.BattleDataProxy.GetInstance()
	arg_7_0._uniqueID = arg_7_1
	arg_7_0._speedExemptKey = "bullet_" .. arg_7_1
	arg_7_0._IFF = arg_7_2
	arg_7_0._collidedList = {}
	Vector3 = var_3
	arg_7_0._speed = var_3.zero
	arg_7_0._exist = true
	arg_7_0._timeStamp = 0
	arg_7_0._dmgEnhanceRate = 1
	arg_7_0._frame = 0
	arg_7_0._reachDestFlag = false
	arg_7_0._verticalSpeed = 0
	arg_7_0._damageList = {}

	return
end

function var_0_11.Update(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetSpeedRatio()

	arg_8_0:updateSpeed(arg_8_1)
	arg_8_0:updateBarrageTransform(arg_8_1)

	local var_8_1 = arg_8_0._position

	var_3.Set(var_8_1, arg_8_0._position.x + arg_8_0._speed.x * var_8_0, arg_8_0._position.y + arg_8_0._speed.y * var_8_0, arg_8_0._position.z + arg_8_0._speed.z * var_8_0)

	arg_8_0._position.y = arg_8_0._position.y + arg_8_0._verticalSpeed * var_8_0

	if arg_8_0._gravity == 0 then
		Vector3 = var_3
		arg_8_0._reachDestFlag = var_3.SqrDistance(arg_8_0._spawnPos, arg_8_0._position) > arg_8_0._sqrRange
	else
		if arg_8_0._fieldSwitchHeight ~= 0 and arg_8_0._position.y <= arg_8_0._fieldSwitchHeight then
			arg_8_0._field = var_0_8.BulletField.SURFACE
		end

		arg_8_0._reachDestFlag = arg_8_0._position.y <= var_0_5.BombDetonateHeight
	end

	return
end

function var_0_11.ActiveCldBox(arg_9_0)
	local var_9_0 = arg_9_0._cldComponent

	var_1.SetActive(var_9_0, true)

	return
end

function var_0_11.DeactiveCldBox(arg_10_0)
	local var_10_0 = arg_10_0._cldComponent

	var_1.SetActive(var_10_0, false)

	return
end

function var_0_11.SetStartTimeStamp(arg_11_0, arg_11_1)
	arg_11_0._timeStamp = arg_11_1

	return
end

function var_0_11.Hit(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._collidedList[arg_12_1] = true

	local var_12_0 = {
		UID = arg_12_1,
		type = arg_12_2
	}

	arg_12_0:DispatchEvent(var_0.Event.New(var_0_1.HIT, var_12_0))

	return
end

function var_0_11.Intercepted(arg_13_0)
	arg_13_0:DispatchEvent(var_0.Event.New(var_0_1.INTERCEPTED, {}))

	return
end

function var_0_11.Reflected(arg_14_0)
	arg_14_0._speed.x = -arg_14_0._speed.x

	return
end

function var_0_11.ResetVelocity(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._tempData
	local var_15_1 = arg_15_0:GetTemplate().extra_param

	if not arg_15_1 then
		arg_15_1 = var_15_0.velocity

		if var_15_1.velocity_offset then
			math = var_4
			arg_15_1 = var_4.random(arg_15_1 - var_15_1.velocity_offset, arg_15_1 + var_15_1.velocity_offset)
		elseif var_15_1.velocity_offsetF then
			math = var_4
			arg_15_1 = arg_15_1 + var_4.random() * 2 * var_15_1.velocity_offsetF - var_15_1.velocity_offsetF
		end
	end

	arg_15_0._velocity = arg_15_1
	arg_15_0._convertedVelocity = var_0_2.ConvertBulletSpeed(arg_15_0._velocity)

	return
end

function var_0_11.SetTemplateData(arg_16_0, arg_16_1)
	setmetatable = var_1_10002
	arg_16_0._tempData = var_1_10002({}, {
		__index = arg_16_1
	})

	local var_16_0 = arg_16_0:GetTemplate().extra_param

	arg_16_0:SetModleID(arg_16_1.modle_ID, var_0_11.ORIGNAL_RES)
	arg_16_0:SetSFXID(arg_16_0._tempData.hit_sfx, arg_16_0._tempData.miss_sfx)
	arg_16_0:ResetVelocity()

	arg_16_0._pierceCount = arg_16_1.pierce_count

	arg_16_0:FixRange()
	arg_16_0:InitCldComponent()

	Clone = var_3
	arg_16_0._accTable = var_3(arg_16_0._tempData.acceleration)
	table = var_3

	var_3.sort(arg_16_0._accTable, function(arg_17_0, arg_17_1)
		return arg_17_0.t < arg_17_1.t
	end)

	arg_16_0._field = arg_16_1.effect_type

	local var_16_1

	if not var_16_0.gravity then
		var_16_1 = 0
	end

	arg_16_0._gravity = var_16_1

	local var_16_2

	if not var_16_0.effectSwitchHeight then
		var_16_2 = 0
	end

	arg_16_0._fieldSwitchHeight = var_16_2
	arg_16_0._ignoreShield = arg_16_0._tempData.extra_param.ignoreShield == true
	arg_16_0._autoRotate = arg_16_0._tempData.extra_param.dontRotate ~= true

	arg_16_0:SetDiverFilter()

	return
end

function var_0_11.GetModleID(arg_18_0)
	local var_18_0 = arg_18_0:GetTemplate().extra_param
	local var_18_1

	if arg_18_0._IFF == var_0_5.FOE_CODE then
		if arg_18_0._mirrorSkin == var_0_11.MIRROR_SKIN_RES then
			var_18_1 = arg_18_0._modleID .. var_0_11.MIRROR_RES
		elseif arg_18_0._mirrorSkin == var_0_11.ORIGNAL_RES and var_18_0.mirror == true then
			var_18_1 = arg_18_0._modleID .. var_0_11.MIRROR_RES
		else
			var_18_1 = arg_18_0._modleID
		end
	else
		var_18_1 = arg_18_0._modleID
	end

	return var_18_1
end

var_0_11.ORIGNAL_RES = -1
var_0_11.SKIN_RES = 0
var_0_11.MIRROR_SKIN_RES = 1

function var_0_11.SetModleID(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_0._modleID = arg_19_1
	arg_19_0._mirrorSkin = arg_19_2

	if arg_19_3 and arg_19_3 ~= "" then
		arg_19_0._tempData.hit_fx = arg_19_3
	end

	return
end

function var_0_11.SetSFXID(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 then
		arg_20_0._hitSFX = arg_20_1
	end

	if arg_20_2 then
		arg_20_0._missSFX = arg_20_2
	end

	return
end

function var_0_11.SetShiftInfo(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = 0
	local var_21_1 = 0

	if arg_21_0:GetTemplate().extra_param.randomLaunchOffsetX then
		math = var_6
		var_21_0 = var_6.random() * var_5.randomLaunchOffsetX * 2 - var_5.randomLaunchOffsetX
	end

	if var_5.randomLaunchOffsetZ then
		math = var_6
		var_21_1 = var_6.random() * var_5.randomLaunchOffsetZ * 2 - var_5.randomLaunchOffsetZ
	end

	arg_21_0._offsetX = arg_21_1 + var_21_0
	arg_21_0._offsetZ = arg_21_2 + var_21_1

	return
end

function var_0_11.SetRotateInfo(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_0._targetPos = arg_22_1
	arg_22_0._baseAngle = arg_22_2
	arg_22_0._barrageAngle = arg_22_3

	if arg_22_0._barrageAngle % 360 > 0 and var_4 < 180 then
		ipairs = var_5

		for iter_22_0, iter_22_1 in var_5(arg_22_0._accTable) do
			if iter_22_1.flip then
				iter_22_1.v = iter_22_1.v * -1
			end
		end
	end

	return
end

function var_0_11.SetBarrageTransformTempate(arg_23_0, arg_23_1)
	if #arg_23_1 > 0 then
		arg_23_0._barrageTransData = arg_23_1
	end

	return
end

function var_0_11.SetAttr(arg_24_0, arg_24_1)
	var_0.Battle.BattleAttr.SetAttr(arg_24_0, arg_24_1)

	return
end

function var_0_11.GetAttr(arg_25_0)
	return var_0.Battle.BattleAttr.GetAttr(arg_25_0)
end

function var_0_11.SetStandHostAttr(arg_26_0, arg_26_1)
	arg_26_0._standUnit = {}

	var_0.Battle.BattleAttr.SetAttr(arg_26_0._standUnit, arg_26_1)

	return
end

function var_0_11.GetWeaponHostAttr(arg_27_0)
	if arg_27_0._standUnit then
		return var_0.Battle.BattleAttr.GetAttr(arg_27_0._standUnit)
	else
		return arg_27_0:GetAttr()
	end

	return
end

function var_0_11.GetWeaponAtkAttr(arg_28_0)
	local var_28_0 = arg_28_0:GetWeaponHostAttr()
	local var_28_1
	local var_28_2 = arg_28_0._weapon

	if var_3.GetAtkAttrTrasnform(var_28_2, var_28_0) then
		var_28_1 = var_3
	else
		local var_28_3 = arg_28_0:GetWeaponTempData().attack_attribute

		var_28_1 = var_0.Battle.BattleAttr.GetAtkAttrByType(var_28_0, var_28_3)
	end

	return var_28_1
end

function var_0_11.GetWeaponCardPuzzleEnhance(arg_29_0)
	local var_29_0 = arg_29_0._weapon

	return var_1.GetCardPuzzleDamageEnhance(var_29_0)
end

function var_0_11.SetDamageEnhance(arg_30_0, arg_30_1)
	arg_30_0._dmgEnhanceRate = arg_30_1

	return
end

function var_0_11.GetDamageEnhance(arg_31_0)
	return arg_31_0._dmgEnhanceRate
end

function var_0_11.GetAttrByName(arg_32_0, arg_32_1)
	return var_0.Battle.BattleAttr.GetCurrent(arg_32_0, arg_32_1)
end

function var_0_11.GetVerticalSpeed(arg_33_0)
	return arg_33_0._verticalSpeed
end

function var_0_11.IsGravitate(arg_34_0)
	return arg_34_0._gravity ~= 0
end

function var_0_11.SetBuffTrigger(arg_35_0, arg_35_1)
	arg_35_0._host = arg_35_1
	arg_35_0._buffTriggerFun = {}

	return
end

function var_0_11.SetBuffFun(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0

	if not arg_36_0._buffTriggerFun[arg_36_1] then
		var_36_0 = {}
	end

	var_36_0[#var_36_0 + 1] = arg_36_2
	arg_36_0._buffTriggerFun[arg_36_1] = var_36_0

	return
end

function var_0_11.BuffTrigger(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_0._host then
		table = var_1_10004

		if var_1_10004.contains(var_0_9, var_3:GetUnitType()) then
			local var_37_0 = arg_37_0._host

			var_4.TriggerBuff(var_37_0, arg_37_1, arg_37_2)
		elseif var_3:IsAlive() then
			local var_37_1 = arg_37_0._host

			var_4.TriggerBuff(var_37_1, arg_37_1, arg_37_2)

			if arg_37_0._buffTriggerFun[arg_37_1] then
				ipairs = var_37_1

				for iter_37_0, iter_37_1 in var_37_1(var_4) do
					iter_37_1(arg_37_0._host, arg_37_2)
				end
			end
		end
	end

	return
end

function var_0_11.SetIsCld(arg_38_0, arg_38_1)
	arg_38_0._needCld = arg_38_1

	return
end

function var_0_11.GetIsCld(arg_39_0)
	return arg_39_0._needCld
end

function var_0_11.IsIngoreCld(arg_40_0)
	return arg_40_0._tempData.extra_param.ingoreCld
end

function var_0_11.IsFragile(arg_41_0)
	return arg_41_0._tempData.extra_param.fragile
end

function var_0_11.IsIndiscriminate(arg_42_0)
	return arg_42_0._tempData.extra_param.indiscriminate
end

function var_0_11.GetExtraTag(arg_43_0)
	return arg_43_0._tempData.extra_param.tag
end

function var_0_11.AppendDamageUnit(arg_44_0, arg_44_1)
	arg_44_0._damageList[#arg_44_0._damageList + 1] = arg_44_1

	return
end

function var_0_11.DamageUnitListWriteback(arg_45_0)
	local var_45_0 = arg_45_0._weapon

	var_1.UpdateCombo(var_45_0, arg_45_0._damageList)

	return
end

function var_0_11.HasAcceleration(arg_46_0)
	return #arg_46_0._accTable ~= 0
end

function var_0_11.IsTracker(arg_47_0)
	return arg_47_0._accTable.tracker
end

function var_0_11.IsOrbit(arg_48_0)
	return arg_48_0._accTable.orbit
end

function var_0_11.IsCircle(arg_49_0)
	return arg_49_0._accTable.circle
end

function var_0_11.GetAcceleration(arg_50_0, arg_50_1)
	local var_50_0

	if not arg_50_0._lastAccTime then
		var_50_0 = arg_50_0._timeStamp
	end

	arg_50_0._lastAccTime = var_50_0
	math = var_50_0

	local var_50_1 = var_50_0.modf((arg_50_1 - arg_50_0._lastAccTime) / var_0_11.ACC_INTERVAL)

	arg_50_0._lastAccTime = arg_50_0._lastAccTime + var_0_11.ACC_INTERVAL * var_50_1

	local var_50_2 = arg_50_1 - arg_50_0._timeStamp
	local var_50_3 = #arg_50_0._accTable

	while var_50_3 > 0 do
		local var_50_4 = arg_50_0._accTable[var_50_3]

		if var_50_2 + var_0_11.ACC_INTERVAL < var_50_4.t then
			var_50_3 = var_50_3 - 1
		else
			return var_50_4.u * var_50_1, var_50_4.v * var_50_1
		end
	end

	return 0, 0
end

function var_0_11.reverseAcceleration(arg_51_0)
	ipairs = var_1_10001

	for iter_51_0, iter_51_1 in var_1_10001(arg_51_0._accTable) do
		iter_51_1.u = iter_51_1.u * -1
	end

	return
end

function var_0_11.GetDistance(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0._battleProxy.FrameIndex

	if arg_52_0._frame ~= var_52_0 then
		arg_52_0._distanceBackup = {}
		arg_52_0._frame = var_52_0
	end

	local var_52_1

	if arg_52_0._distanceBackup[arg_52_1] == nil then
		Vector3 = var_1_10004
		var_52_1 = var_1_10004.Distance(arg_52_0:GetPosition(), arg_52_1:GetPosition())
		arg_52_0._distanceBackup[arg_52_1] = var_52_1

		arg_52_1:backupDistance(arg_52_0, var_52_1)
	end

	return var_52_1
end

function var_0_11.backupDistance(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = arg_53_0._battleProxy.FrameIndex

	if arg_53_0._frame ~= var_53_0 then
		arg_53_0._distanceBackup = {}
		arg_53_0._frame = var_53_0
	end

	arg_53_0._distanceBackup[arg_53_1] = arg_53_2

	return
end

function var_0_11.getTrackingTarget(arg_54_0)
	return arg_54_0._tarckingTarget
end

function var_0_11.setTrackingTarget(arg_55_0, arg_55_1)
	arg_55_0._tarckingTarget = arg_55_1

	return
end

function var_0_11.SetWeapon(arg_56_0, arg_56_1)
	arg_56_0._weapon = arg_56_1

	if arg_56_1 then
		local var_56_0 = arg_56_0._weapon

		arg_56_0._correctedDMG = var_2.GetCorrectedDMG(var_56_0)
	end

	return
end

function var_0_11.GetWeapon(arg_57_0)
	return arg_57_0._weapon
end

function var_0_11.GetCorrectedDMG(arg_58_0)
	return arg_58_0._correctedDMG
end

function var_0_11.OverrideCorrectedDMG(arg_59_0, arg_59_1)
	arg_59_0._correctedDMG = var_0_2.WeaponDamagePreCorrection(arg_59_0._weapon, arg_59_1)

	return
end

function var_0_11.GetWeaponTempData(arg_60_0)
	local var_60_0 = arg_60_0._weapon

	return var_1.GetTemplateData(var_60_0)
end

function var_0_11.GetPosition(arg_61_0)
	local var_61_0

	if not arg_61_0._position then
		Vector3 = var_61_0
		var_61_0 = var_61_0.zero
	end

	return var_61_0
end

function var_0_11.SetSpawnPosition(arg_62_0, arg_62_1)
	arg_62_0._spawnPos = arg_62_1
	arg_62_0._position = arg_62_1:Clone()

	if arg_62_0._gravity ~= 0 then
		math = var_2

		if var_2.atan2(arg_62_0._speed.x, arg_62_0._speed.z) == 0 then
			arg_62_0._verticalSpeed = 0
		else
			Vector3 = var_3
			math = var_4

			local var_62_0 = var_4.cos(var_2) * 60

			math = var_5

			local var_62_1 = var_3(var_62_0, var_5.sin(var_2) * 60)
			local var_62_2 = 60 / arg_62_0._convertedVelocity

			arg_62_0._verticalSpeed = -0.5 * arg_62_0._gravity * var_62_2
		end
	end

	return
end

function var_0_11.GetSpawnPosition(arg_63_0)
	return arg_63_0._spawnPos
end

function var_0_11.GetTemplate(arg_64_0)
	return arg_64_0._tempData
end

function var_0_11.GetType(arg_65_0)
	return arg_65_0._tempData.type
end

function var_0_11.GetHitSFX(arg_66_0)
	return arg_66_0._hitSFX
end

function var_0_11.GetMissSFX(arg_67_0)
	return arg_67_0._missSFX
end

function var_0_11.GetOutBound(arg_68_0)
	return arg_68_0._tempData.out_bound
end

function var_0_11.GetUniqueID(arg_69_0)
	return arg_69_0._uniqueID
end

function var_0_11.GetOffset(arg_70_0)
	return arg_70_0._offsetX, arg_70_0._offsetZ, arg_70_0._isOffsetPriority
end

function var_0_11.GetRotateInfo(arg_71_0)
	return arg_71_0._targetPos, arg_71_0._baseAngle, arg_71_0._barrageAngle
end

function var_0_11.IsOutRange(arg_72_0)
	return arg_72_0._reachDestFlag
end

function var_0_11.SetYAngle(arg_73_0, arg_73_1)
	arg_73_0._yAngle = arg_73_1

	return
end

function var_0_11.SetOffsetPriority(arg_74_0, arg_74_1)
	arg_74_0._isOffsetPriority = arg_74_1 or false

	return
end

function var_0_11.GetOffsetPriority(arg_75_0)
	return arg_75_0._isOffsetPriority
end

function var_0_11.GetYAngle(arg_76_0)
	return arg_76_0._yAngle
end

function var_0_11.GetCurrentYAngle(arg_77_0)
	Vector3 = var_1_10001

	local var_77_0 = var_1_10001.Normalize(arg_77_0._speed)

	math = var_2

	local var_77_1 = var_2.acos(var_77_0.x)

	math = var_3

	local var_77_2 = var_77_1 / var_3.deg2Rad

	if var_77_0.z < 0 then
		var_77_2 = 360 - var_77_2
	end

	return var_77_2
end

function var_0_11.GetIFF(arg_78_0)
	return arg_78_0._IFF
end

function var_0_11.GetHost(arg_79_0)
	return arg_79_0._host
end

function var_0_11.GetPierceCount(arg_80_0)
	return arg_80_0._pierceCount
end

function var_0_11.AppendAttachBuff(arg_81_0, arg_81_1)
	local var_81_0

	if not arg_81_0._attachBuffList then
		var_81_0 = arg_81_0:generateAttachBuffList()
	end

	arg_81_0._attachBuffList = var_81_0
	table = var_81_0

	var_81_0.insert(arg_81_0._attachBuffList, arg_81_1)

	return
end

function var_0_11.GetAttachBuff(arg_82_0)
	local var_82_0

	if not arg_82_0._attachBuffList then
		var_82_0 = arg_82_0:generateAttachBuffList()
	end

	arg_82_0._attachBuffList = var_82_0

	return arg_82_0._attachBuffList
end

function var_0_11.generateAttachBuffList(arg_83_0)
	local var_83_0 = {}
	local var_83_1 = arg_83_0

	if not arg_83_0.GetTemplate(var_83_1).attach_buff then
		local var_83_2 = {}
	end

	ipairs = var_83_1

	for iter_83_0, iter_83_1 in var_83_1(arg_83_0:GetTemplate().attach_buff) do
		local var_83_3 = {
			buff_id = iter_83_1.buff_id,
			level = iter_83_1.buff_level,
			rant = iter_83_1.rant,
			hit_ignore = iter_83_1.hit_ignore,
			group_level = iter_83_1.group_level
		}

		table = var_9

		var_9.insert(var_83_0, var_83_3)
	end

	return var_83_0
end

function var_0_11.GetEffectField(arg_84_0)
	return arg_84_0._field
end

function var_0_11.SetDiverFilter(arg_85_0, arg_85_1)
	if arg_85_1 == nil then
		local var_85_0

		if not arg_85_0._tempData.extra_param.diveFilter then
			var_85_0 = {
				2
			}
		end

		arg_85_0._diveFilter = var_85_0
	else
		arg_85_0._diveFilter = arg_85_1
	end

	return
end

function var_0_11.GetDiveFilter(arg_86_0)
	return arg_86_0._diveFilter
end

function var_0_11.GetVelocity(arg_87_0)
	return arg_87_0._velocity
end

function var_0_11.GetConvertedVelocity(arg_88_0)
	return arg_88_0._convertedVelocity
end

function var_0_11.GetSpeedExemptKey(arg_89_0)
	return arg_89_0._speedExemptKey
end

function var_0_11.IsCollided(arg_90_0, arg_90_1)
	return arg_90_0._collidedList[arg_90_1]
end

function var_0_11.GetExist(arg_91_0)
	return arg_91_0._exist
end

function var_0_11.SetExist(arg_92_0, arg_92_1)
	arg_92_0._exist = arg_92_1

	return
end

function var_0_11.GetIgnoreShield(arg_93_0)
	return arg_93_0._ignoreShield
end

function var_0_11.SetIgnoreShield(arg_94_0, arg_94_1)
	arg_94_0._ignoreShield = arg_94_1

	return
end

function var_0_11.IsAutoRotate(arg_95_0)
	return arg_95_0._autoRotate
end

function var_0_11.Dispose(arg_96_0)
	arg_96_0._dataProxy = nil

	var_0.EventDispatcher.DetachEventDispatcher(arg_96_0)

	return
end

function var_0_11.InitCldComponent(arg_97_0)
	local var_97_0 = arg_97_0:GetTemplate().cld_box
	local var_97_1 = arg_97_0:GetTemplate().cld_offset[1]

	if arg_97_0:GetIFF() == var_0_5.FOE_CODE then
		var_97_1 = var_97_1 * -1
	end

	arg_97_0._cldComponent = var_0.Battle.BattleCubeCldComponent.New(var_97_0[1], var_97_0[2], var_97_0[3], var_97_1, var_2[3])

	local var_97_2 = {
		type = var_0_8.CldType.BULLET,
		IFF = arg_97_0:GetIFF(),
		UID = arg_97_0:GetUniqueID()
	}
	local var_97_3 = arg_97_0._cldComponent

	var_5.SetCldData(var_97_3, var_97_2)

	return
end

function var_0_11.ResetCldSurface(arg_98_0)
	if arg_98_0:GetDiveFilter() and #var_1 == 0 then
		arg_98_0:GetCldData().Surface = var_0_8.OXY_STATE.DIVE
	else
		arg_98_0:GetCldData().Surface = var_0_8.OXY_STATE.FLOAT
	end

	return
end

function var_0_11.GetBoxSize(arg_99_0)
	local var_99_0 = arg_99_0._cldComponent

	return var_1.GetCldBoxSize(var_99_0)
end

function var_0_11.GetCldBox(arg_100_0)
	local var_100_0 = arg_100_0._cldComponent

	return var_1.GetCldBox(var_100_0, arg_100_0:GetPosition())
end

function var_0_11.GetCldData(arg_101_0)
	local var_101_0 = arg_101_0._cldComponent

	return var_1.GetCldData(var_101_0)
end

function var_0_11.GetSpeed(arg_102_0)
	return arg_102_0._speed
end

function var_0_11.GetSpeedRatio(arg_103_0)
	return var_0_4.GetSpeedRatio(arg_103_0._speedExemptKey, arg_103_0._IFF)
end

function var_0_11.InitSpeed(arg_104_0, arg_104_1)
	if arg_104_0._yAngle == nil then
		arg_104_0._yAngle = (arg_104_1 or arg_104_0._baseAngle) + arg_104_0._barrageAngle
	end

	arg_104_0:calcSpeed()

	if arg_104_0:HasAcceleration() then
		local var_104_0 = arg_104_0._speed

		arg_104_0._speedLength = var_2.Magnitude(var_104_0)
		math = var_2

		local var_104_1 = var_2.deg2Rad * arg_104_0._yAngle

		Vector3 = var_3
		math = var_1_10004

		local var_104_2 = var_1_10004.cos(var_104_1)
		local var_104_3 = 0

		math = var_1_10006
		arg_104_0._speedNormal = var_3(var_104_2, var_104_3, var_1_10006.sin(var_104_1))
		Vector3 = var_3
		arg_104_0._speedCross = var_3.Cross(arg_104_0._speedNormal, var_0_3)
		arg_104_0.updateSpeed = var_0_11.doAccelerate
	elseif arg_104_0:IsTracker() then
		arg_104_0._trackRange = arg_104_0._accTable.tracker.range
		math = var_3
		arg_104_0._cosAngularSpeed = var_3.deg2Rad * var_2.angular
		math = var_3
		arg_104_0._sinAngularSpeed = var_3.deg2Rad * var_2.angular
		math = var_3
		arg_104_0._negativeCosAngularSpeed = var_3.deg2Rad * var_2.angular * -1
		math = var_3
		arg_104_0._negativeSinAngularSpeed = var_3.deg2Rad * var_2.angular * -1
		arg_104_0.updateSpeed = var_0_11.doTrack
	elseif arg_104_0:IsCircle() then
		local var_104_4

		if not arg_104_0._accTable.circle.center then
			var_104_4 = arg_104_0._targetPos
		end

		arg_104_0._originPos = var_104_4
		tobool = var_104_4
		arg_104_0._circleAntiClockwise = var_104_4(var_2.antiClockWise)

		local var_104_5

		if not var_2.centripetalSpeed then
			var_104_5 = 0
		end

		arg_104_0._centripetalSpeed = var_104_5 * var_0_7
		arg_104_0._inverseFlag = 1
		arg_104_0.updateSpeed = var_0_11.doCircle
	else
		arg_104_0.updateSpeed = var_0_11.doNothing
	end

	return
end

function var_0_11.InheritSpeed(arg_105_0, arg_105_1)
	Vector3 = var_1_10002
	arg_105_0._speed = var_1_10002(arg_105_1.x, arg_105_1.y, arg_105_1.z)
	arg_105_0._speedInited = true

	return
end

function var_0_11.calcSpeed(arg_106_0)
	if arg_106_0._speedInited then
		return
	end

	local var_106_0 = 1 + var_0.Battle.BattleAttr.GetCurrent(arg_106_0, "bulletSpeedRatio")
	local var_106_1 = arg_106_0._velocity * var_106_0
	local var_106_2 = var_0_2.ConvertBulletSpeed(var_106_1)

	math = var_3

	local var_106_3 = var_3.deg2Rad * arg_106_0._yAngle

	Vector3 = var_4
	math = var_1_10005

	local var_106_4 = var_106_2 * var_1_10005.cos(var_106_3)
	local var_106_5 = 0

	math = var_1_10007
	arg_106_0._speed = var_4(var_106_4, var_106_5, var_106_2 * var_1_10007.sin(var_106_3))

	return
end

function var_0_11.updateBarrageTransform(arg_107_0, arg_107_1)
	if not arg_107_0._barrageTransData or #arg_107_0._barrageTransData == 0 then
		return
	end

	if arg_107_1 - arg_107_0._timeStamp >= arg_107_0._barrageTransData[1].transStartDelay then
		if var_3.transAimAngle then
			arg_107_0._yAngle = var_3.transAimAngle
		else
			math = var_4

			local var_107_0 = var_4.rad2Deg

			math = var_1_10005
			arg_107_0._yAngle = var_107_0 * var_1_10005.atan2(var_3.transAimPosZ - arg_107_0._position.z, var_3.transAimPosX - arg_107_0._position.x)
		end

		arg_107_0:calcSpeed()

		table = var_4

		var_4.remove(arg_107_0._barrageTransData, 1)

		if arg_107_0._barrageTransData[1] then
			var_4.transStartDelay = var_4.transStartDelay + var_3.transStartDelay
		end
	end

	return
end

function var_0_11.GetCurrentDistance(arg_108_0)
	Vector3 = var_1_10001

	return var_1_10001.Distance(arg_108_0._spawnPos, arg_108_0._position)
end

function var_0_11.SetOutRangeCallback(arg_109_0, arg_109_1)
	arg_109_0._outRangeFunc = arg_109_1

	return
end

function var_0_11.OutRange(arg_110_0)
	arg_110_0:DispatchEvent(var_0.Event.New(var_0_1.OUT_RANGE, {}))
	arg_110_0._outRangeFunc(arg_110_0)

	return
end

function var_0_11.FixRange(arg_111_0, arg_111_1, arg_111_2)
	arg_111_1 = arg_111_1 or arg_111_0._tempData.range
	arg_111_2 = arg_111_2 or 0

	if arg_111_0._tempData.range_offset == 0 then
		arg_111_0._range = arg_111_1
	else
		math = var_1_10004
		arg_111_0._range = arg_111_1 + var_3 * (var_1_10004.random() - 0.5)
	end

	math = var_1_10004
	arg_111_0._range = var_1_10004.max(0, arg_111_0._range + arg_111_2)
	arg_111_0._sqrRange = arg_111_0._range * arg_111_0._range

	return
end

function var_0_11.ImmuneBombCLS(arg_112_0)
	return arg_112_0:GetTemplate().extra_param.ignoreB
end

function var_0_11.ImmuneCLS(arg_113_0)
	return arg_113_0._immuneCLS
end

function var_0_11.SetImmuneCLS(arg_114_0, arg_114_1)
	arg_114_0._immuneCLS = arg_114_1

	return
end

function var_0_11.IsSpectreBullet(arg_115_0)
	return arg_115_0:GetTemplate().extra_param.spectre
end

return
