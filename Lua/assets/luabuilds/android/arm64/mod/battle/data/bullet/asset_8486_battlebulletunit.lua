ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleBulletEvent
local var_0_2 = ys.Battle.BattleFormulas
local var_0_3 = Vector3.up
local var_0_4 = ys.Battle.BattleVariable
local var_0_5 = ys.Battle.BattleConfig
local var_0_6 = ys.Battle.BattleTargetChoise
local var_0_7 = 1 / ys.Battle.BattleConfig.viewFPS
local var_0_8 = ys.Battle.BattleConst
local var_0_9 = ys.Battle.BattleConst.AircraftUnitType

ys.Battle.BattleBulletUnit = class("BattleBulletUnit")
ys.Battle.BattleBulletUnit.__name = "BattleBulletUnit"

local var_0_10 = ys.Battle.BattleBulletUnit

ys.Battle.BattleBulletUnit.ACC_INTERVAL = ys.Battle.BattleConfig.calcInterval
ys.Battle.BattleBulletUnit.TRACKER_ANGLE = math.cos(math.deg2Rad * 10)
ys.Battle.BattleBulletUnit.MIRROR_RES = "_mirror"

function ys.Battle.BattleBulletUnit:doAccelerate(arg_1_1)
	local var_1_0, var_1_1 = self:GetAcceleration(arg_1_1)

	if var_1_0 == 0 and var_1_1 == 0 then
		return
	end

	if var_1_0 < 0 and self._speedLength + var_1_0 < 0 then
		self:reverseAcceleration()
	end

	self._speed:Set(self._speed.x + self._speedNormal.x * var_1_0 + self._speedCross.x * var_1_1, self._speed.y + self._speedNormal.y * var_1_0 + self._speedCross.y * var_1_1, self._speed.z + self._speedNormal.z * var_1_0 + self._speedCross.z * var_1_1)

	self._speedLength = self._speed:Magnitude()

	if self._speedLength ~= 0 then
		self._speedNormal:Copy(self._speed):Div(self._speedLength)
	end

	self._speedCross:Copy(self._speedNormal):Cross2(var_0_3)

	return
end

function ys.Battle.BattleBulletUnit:doTrack()
	if self:getTrackingTarget() == nil then
		local var_2_0 = var_0_6.TargetHarmNearest(self)[1]

		if var_2_0 ~= nil and self:GetDistance(var_2_0) <= self._trackRange then
			self:setTrackingTarget(var_2_0)
		end
	end

	local var_2_1 = self:getTrackingTarget()

	if var_2_1 == nil or var_2_1 == -1 then
		return
	elseif not var_2_1:IsAlive() then
		self:setTrackingTarget(-1)

		return
	elseif self:GetDistance(var_2_1) > self._trackRange then
		self:setTrackingTarget(-1)

		return
	end

	local var_2_2 = var_2_1:GetBeenAimedPosition()

	if not var_2_2 then
		return
	end

	local var_2_3 = var_2_2 - self:GetPosition()

	var_2_3:SetNormalize()

	local var_2_4 = Vector3.Normalize(self._speed)
	local var_2_5 = Vector3.Dot(var_2_4, var_2_3)

	if var_2_5 >= var_0_10.TRACKER_ANGLE then
		return
	end

	local var_2_6 = self:GetSpeedRatio()
	local var_2_7 = math.cos(self._cosAngularSpeed * var_2_6)
	local var_2_8 = var_2_5
	local var_2_9 = var_2_4.z * var_2_3.x - var_2_4.x * var_2_3.z

	if var_2_5 < var_2_7 then
		var_2_8 = var_2_7
		var_2_9 = math.sin(self._sinAngularSpeed * var_2_6) * (var_2_9 >= 0 and 1 or -1)
	end

	self._speed:Set(self._speed.x * var_2_8 + self._speed.z * var_2_9, 0, self._speed.z * var_2_8 - self._speed.x * var_2_9)

	return
end

function ys.Battle.BattleBulletUnit:doOrbit()
	local var_3_0 = pg.Tool.FilterY(self._weapon:GetPosition())
	local var_3_1 = pg.Tool.FilterY(self:GetPosition())

	self._speed = (var_3_1 - var_3_0).magnitude > 10 and ((var_3_0 - var_3_1).normalized + self._speed.normalized).normalized or (Vector3(-(var_3_0 - var_3_1).normalized.z, 0, (var_3_0 - var_3_1).normalized.x) + self._speed.normalized).normalized

	return
end

function ys.Battle.BattleBulletUnit:RotateY(arg_4_1)
	local var_4_0 = math.cos(arg_4_1)
	local var_4_1 = math.sin(arg_4_1)

	return Vector3(self.x * var_4_0 + self.z * var_4_1, self.y, self.z * var_4_0 - self.x * var_4_1)
end

function ys.Battle.BattleBulletUnit:doCircle()
	if not self._originPos then
		return
	end

	local var_5_0 = self:GetSpeedRatio() * (1 + var_0_0.Battle.BattleAttr.GetCurrent(self, "bulletSpeedRatio"))
	local var_5_1 = pg.Tool.FilterY(self._position - self._originPos)
	local var_5_2 = self._convertedVelocity
	local var_5_3 = var_5_1:Magnitude()
	local var_5_4 = var_5_3 - self._centripetalSpeed * var_5_0 * self._inverseFlag

	if var_5_3 - self._centripetalSpeed * var_5_0 * self._inverseFlag < 0 then
		self._inverseFlag = -self._inverseFlag or self._inverseFlag
	end

	local var_5_5

	if var_5_3 <= 1e-05 then
		do return end

		var_5_5 = var_5_2 / var_5_3
	end

	self._speed = self:RotateY(var_5_5 * (self._circleAntiClockwise and 1 or -1) * var_5_0):Mul(var_5_4 / var_5_3):Sub(var_5_1)

	return
end

function ys.Battle.BattleBulletUnit:doNothing()
	if self._gravity ~= 0 then
		self._verticalSpeed = self._verticalSpeed + self._gravity * self:GetSpeedRatio()
	end

	return
end

function ys.Battle.BattleBulletUnit.Ctor(arg_7_0, arg_7_1, arg_7_2)
	var_0_0.EventDispatcher.AttachEventDispatcher(arg_7_0)

	arg_7_0._battleProxy = var_0_0.Battle.BattleDataProxy.GetInstance()
	arg_7_0._uniqueID = arg_7_1
	arg_7_0._speedExemptKey = "bullet_" .. arg_7_1
	arg_7_0._IFF = arg_7_2
	arg_7_0._collidedList = {}
	arg_7_0._speed = Vector3.zero
	arg_7_0._exist = true
	arg_7_0._timeStamp = 0
	arg_7_0._dmgEnhanceRate = 1
	arg_7_0._frame = 0
	arg_7_0._reachDestFlag = false
	arg_7_0._verticalSpeed = 0
	arg_7_0._damageList = {}

	return
end

function ys.Battle.BattleBulletUnit:Update(arg_8_1)
	local var_8_0 = self:GetSpeedRatio()

	self:updateSpeed(arg_8_1)
	self:updateBarrageTransform(arg_8_1)
	self._position:Set(self._position.x + self._speed.x * var_8_0, self._position.y + self._speed.y * var_8_0, self._position.z + self._speed.z * var_8_0)

	self._position.y = self._position.y + self._verticalSpeed * var_8_0

	if self._gravity == 0 then
		self._reachDestFlag = Vector3.SqrDistance(self._spawnPos, self._position) > self._sqrRange
	else
		if self._fieldSwitchHeight ~= 0 and self._position.y <= self._fieldSwitchHeight then
			self._field = var_0_8.BulletField.SURFACE
		end

		self._reachDestFlag = self._position.y <= var_0_5.BombDetonateHeight
	end

	return
end

function ys.Battle.BattleBulletUnit:ActiveCldBox()
	self._cldComponent:SetActive(true)

	return
end

function ys.Battle.BattleBulletUnit:DeactiveCldBox()
	self._cldComponent:SetActive(false)

	return
end

function ys.Battle.BattleBulletUnit.SetStartTimeStamp(arg_11_0, arg_11_1)
	arg_11_0._timeStamp = arg_11_1

	return
end

function ys.Battle.BattleBulletUnit:Hit(arg_12_1, arg_12_2)
	self._collidedList[arg_12_1] = true

	self:DispatchEvent(var_0_0.Event.New(var_0_1.HIT, {
		UID = arg_12_1,
		type = arg_12_2
	}))

	return
end

function ys.Battle.BattleBulletUnit:Intercepted()
	self:DispatchEvent(var_0_0.Event.New(var_0_1.INTERCEPTED, {}))

	return
end

function ys.Battle.BattleBulletUnit:Reflected()
	self._speed.x = -self._speed.x

	return
end

function ys.Battle.BattleBulletUnit:ResetVelocity(arg_15_1)
	local var_15_0 = self:GetTemplate().extra_param

	if not arg_15_1 then
		arg_15_1 = self._tempData.velocity

		if var_15_0.velocity_offset then
			arg_15_1 = math.random(arg_15_1 - var_15_0.velocity_offset, arg_15_1 + var_15_0.velocity_offset)
		elseif var_15_0.velocity_offsetF then
			arg_15_1 = arg_15_1 + math.random() * 2 * var_15_0.velocity_offsetF - var_15_0.velocity_offsetF
		end
	end

	self._velocity = arg_15_1
	self._convertedVelocity = var_0_2.ConvertBulletSpeed(self._velocity)

	return
end

function ys.Battle.BattleBulletUnit:SetTemplateData(arg_16_1)
	self._tempData = setmetatable({}, {
		__index = arg_16_1
	})

	local var_16_0 = self:GetTemplate().extra_param

	self:SetModleID(arg_16_1.modle_ID, var_0_10.ORIGNAL_RES)
	self:SetSFXID(self._tempData.hit_sfx, self._tempData.miss_sfx)
	self:ResetVelocity()

	self._pierceCount = arg_16_1.pierce_count

	self:FixRange()
	self:InitCldComponent()

	self._accTable = Clone(self._tempData.acceleration)

	table.sort(self._accTable, function(arg_17_0, arg_17_1)
		return arg_17_0.t < arg_17_1.t
	end)

	self._field = arg_16_1.effect_type
	self._gravity = var_16_0.gravity or 0
	self._fieldSwitchHeight = var_16_0.effectSwitchHeight or 0
	self._ignoreShield = self._tempData.extra_param.ignoreShield == true
	self._autoRotate = self._tempData.extra_param.dontRotate ~= true

	self:SetDiverFilter()

	return
end

function ys.Battle.BattleBulletUnit:GetModleID()
	return self._IFF == var_0_5.FOE_CODE and (self._mirrorSkin == var_0_10.MIRROR_SKIN_RES and self._modleID .. var_0_10.MIRROR_RES or self._mirrorSkin == var_0_10.ORIGNAL_RES and self:GetTemplate().extra_param.mirror == true and self._modleID .. var_0_10.MIRROR_RES or self._modleID) or self._modleID
end

ys.Battle.BattleBulletUnit.ORIGNAL_RES = -1
ys.Battle.BattleBulletUnit.SKIN_RES = 0
ys.Battle.BattleBulletUnit.MIRROR_SKIN_RES = 1

function ys.Battle.BattleBulletUnit:SetModleID(arg_19_1, arg_19_2, arg_19_3)
	self._modleID = arg_19_1
	self._mirrorSkin = arg_19_2

	if arg_19_3 and arg_19_3 ~= "" then
		self._tempData.hit_fx = arg_19_3
	end

	return
end

function ys.Battle.BattleBulletUnit.SetSFXID(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 then
		arg_20_0._hitSFX = arg_20_1
	end

	if arg_20_2 then
		arg_20_0._missSFX = arg_20_2
	end

	return
end

function ys.Battle.BattleBulletUnit:SetShiftInfo(arg_21_1, arg_21_2)
	local var_21_0 = 0
	local var_21_1 = 0
	local var_21_2 = self:GetTemplate().extra_param

	if var_21_2.randomLaunchOffsetX then
		var_21_0 = math.random() * var_21_2.randomLaunchOffsetX * 2 - var_21_2.randomLaunchOffsetX
	end

	if var_21_2.randomLaunchOffsetZ then
		var_21_1 = math.random() * var_21_2.randomLaunchOffsetZ * 2 - var_21_2.randomLaunchOffsetZ
	end

	self._offsetX = arg_21_1 + var_21_0
	self._offsetZ = arg_21_2 + var_21_1

	return
end

function ys.Battle.BattleBulletUnit:SetRotateInfo(arg_22_1, arg_22_2, arg_22_3)
	self._targetPos = arg_22_1
	self._baseAngle = arg_22_2
	self._barrageAngle = arg_22_3

	if self._barrageAngle % 360 > 0 and self._barrageAngle % 360 < 180 then
		for iter_22_0, iter_22_1 in ipairs(self._accTable) do
			if iter_22_1.flip then
				iter_22_1.v = iter_22_1.v * -1
			end
		end
	end

	return
end

function ys.Battle.BattleBulletUnit.SetBarrageTransformTempate(arg_23_0, arg_23_1)
	if #arg_23_1 > 0 then
		arg_23_0._barrageTransData = arg_23_1
	end

	return
end

function ys.Battle.BattleBulletUnit.SetAttr(arg_24_0, arg_24_1)
	var_0_0.Battle.BattleAttr.SetAttr(arg_24_0, arg_24_1)

	return
end

function ys.Battle.BattleBulletUnit.GetAttr(arg_25_0)
	return var_0_0.Battle.BattleAttr.GetAttr(arg_25_0)
end

function ys.Battle.BattleBulletUnit:SetStandHostAttr(arg_26_1)
	self._standUnit = {}

	var_0_0.Battle.BattleAttr.SetAttr(self._standUnit, arg_26_1)

	return
end

function ys.Battle.BattleBulletUnit:GetWeaponHostAttr()
	if self._standUnit then
		return var_0_0.Battle.BattleAttr.GetAttr(self._standUnit)
	else
		return self:GetAttr()
	end

	return
end

function ys.Battle.BattleBulletUnit:GetWeaponAtkAttr()
	local var_28_1 = self._weapon:GetAtkAttrTrasnform((self:GetWeaponHostAttr()))

	return var_28_1 and var_28_1 or var_0_0.Battle.BattleAttr:GetAtkAttrByType(self:GetWeaponTempData().attack_attribute)
end

function ys.Battle.BattleBulletUnit:GetWeaponCardPuzzleEnhance()
	return self._weapon:GetCardPuzzleDamageEnhance()
end

function ys.Battle.BattleBulletUnit.SetDamageEnhance(arg_30_0, arg_30_1)
	arg_30_0._dmgEnhanceRate = arg_30_1

	return
end

function ys.Battle.BattleBulletUnit:GetDamageEnhance()
	return self._dmgEnhanceRate
end

function ys.Battle.BattleBulletUnit.GetAttrByName(arg_32_0, arg_32_1)
	return var_0_0.Battle.BattleAttr.GetCurrent(arg_32_0, arg_32_1)
end

function ys.Battle.BattleBulletUnit:GetVerticalSpeed()
	return self._verticalSpeed
end

function ys.Battle.BattleBulletUnit:IsGravitate()
	return self._gravity ~= 0
end

function ys.Battle.BattleBulletUnit.SetBuffTrigger(arg_35_0, arg_35_1)
	arg_35_0._host = arg_35_1
	arg_35_0._buffTriggerFun = {}

	return
end

function ys.Battle.BattleBulletUnit:SetBuffFun(arg_36_1, arg_36_2)
	local var_36_0 = self._buffTriggerFun[arg_36_1] or {}

	var_36_0[#var_36_0 + 1] = arg_36_2
	self._buffTriggerFun[arg_36_1] = var_36_0

	return
end

function ys.Battle.BattleBulletUnit:BuffTrigger(arg_37_1, arg_37_2)
	if self._host then
		if table.contains(var_0_9, self._host:GetUnitType()) then
			self._host:TriggerBuff(arg_37_1, arg_37_2)
		elseif self._host:IsAlive() then
			self._host:TriggerBuff(arg_37_1, arg_37_2)

			if self._buffTriggerFun[arg_37_1] then
				for iter_37_0, iter_37_1 in ipairs(self._buffTriggerFun[arg_37_1]) do
					iter_37_1(self._host, arg_37_2)
				end
			end
		end
	end

	return
end

function ys.Battle.BattleBulletUnit.SetIsCld(arg_38_0, arg_38_1)
	arg_38_0._needCld = arg_38_1

	return
end

function ys.Battle.BattleBulletUnit:GetIsCld()
	return self._needCld
end

function ys.Battle.BattleBulletUnit:IsIngoreCld()
	return self._tempData.extra_param.ingoreCld
end

function ys.Battle.BattleBulletUnit:IsFragile()
	return self._tempData.extra_param.fragile
end

function ys.Battle.BattleBulletUnit:IsIndiscriminate()
	return self._tempData.extra_param.indiscriminate
end

function ys.Battle.BattleBulletUnit:GetExtraTag()
	return self._tempData.extra_param.tag
end

function ys.Battle.BattleBulletUnit:AppendDamageUnit(arg_44_1)
	self._damageList[#self._damageList + 1] = arg_44_1

	return
end

function ys.Battle.BattleBulletUnit:DamageUnitListWriteback()
	self._weapon:UpdateCombo(self._damageList)

	return
end

function ys.Battle.BattleBulletUnit:HasAcceleration()
	return #self._accTable ~= 0
end

function ys.Battle.BattleBulletUnit:IsTracker()
	return self._accTable.tracker
end

function ys.Battle.BattleBulletUnit:IsOrbit()
	return self._accTable.orbit
end

function ys.Battle.BattleBulletUnit:IsCircle()
	return self._accTable.circle
end

function ys.Battle.BattleBulletUnit:GetAcceleration(arg_50_1)
	self._lastAccTime = self._lastAccTime or self._timeStamp

	local var_50_0 = math.modf((arg_50_1 - self._lastAccTime) / var_0_10.ACC_INTERVAL)

	self._lastAccTime = self._lastAccTime + var_0_10.ACC_INTERVAL * var_50_0

	while #self._accTable > 0 do
		local var_50_1

		if arg_50_1 - self._timeStamp + var_0_10.ACC_INTERVAL < self._accTable[#self._accTable].t then
			var_50_1 = #self._accTable - 1
		else
			return self._accTable[#self._accTable].u * var_50_0, self._accTable[#self._accTable].v * var_50_0
		end
	end

	return 0, 0
end

function ys.Battle.BattleBulletUnit:reverseAcceleration()
	for iter_51_0, iter_51_1 in ipairs(self._accTable) do
		iter_51_1.u = iter_51_1.u * -1
	end

	return
end

function ys.Battle.BattleBulletUnit:GetDistance(arg_52_1)
	if self._frame ~= self._battleProxy.FrameIndex then
		self._distanceBackup = {}
		self._frame = self._battleProxy.FrameIndex
	end

	local var_52_0 = self._distanceBackup[arg_52_1]

	if self._distanceBackup[arg_52_1] == nil then
		var_52_0 = Vector3.Distance(self:GetPosition(), arg_52_1:GetPosition())
		self._distanceBackup[arg_52_1] = var_52_0

		arg_52_1:backupDistance(self, var_52_0)
	end

	return var_52_0
end

function ys.Battle.BattleBulletUnit:backupDistance(arg_53_1, arg_53_2)
	if self._frame ~= self._battleProxy.FrameIndex then
		self._distanceBackup = {}
		self._frame = self._battleProxy.FrameIndex
	end

	self._distanceBackup[arg_53_1] = arg_53_2

	return
end

function ys.Battle.BattleBulletUnit:getTrackingTarget()
	return self._tarckingTarget
end

function ys.Battle.BattleBulletUnit.setTrackingTarget(arg_55_0, arg_55_1)
	arg_55_0._tarckingTarget = arg_55_1

	return
end

function ys.Battle.BattleBulletUnit:SetWeapon(arg_56_1)
	self._weapon = arg_56_1

	if arg_56_1 then
		self._correctedDMG = self._weapon:GetCorrectedDMG()
	end

	return
end

function ys.Battle.BattleBulletUnit:GetWeapon()
	return self._weapon
end

function ys.Battle.BattleBulletUnit:GetCorrectedDMG()
	return self._correctedDMG
end

function ys.Battle.BattleBulletUnit:OverrideCorrectedDMG(arg_59_1)
	self._correctedDMG = var_0_2.WeaponDamagePreCorrection(self._weapon, arg_59_1)

	return
end

function ys.Battle.BattleBulletUnit:GetWeaponTempData()
	return self._weapon:GetTemplateData()
end

function ys.Battle.BattleBulletUnit:GetPosition()
	return self._position or Vector3.zero
end

function ys.Battle.BattleBulletUnit:SetSpawnPosition(arg_62_1)
	self._spawnPos = arg_62_1
	self._position = arg_62_1:Clone()

	if self._gravity ~= 0 then
		local var_62_0 = math.atan2(self._speed.x, self._speed.z)

		if var_62_0 == 0 then
			self._verticalSpeed = 0
		else
			local var_62_1 = Vector3(math.cos(var_62_0) * 60, math.sin(var_62_0) * 60)

			self._verticalSpeed = -0.5 * self._gravity * (60 / self._convertedVelocity)
		end
	end

	return
end

function ys.Battle.BattleBulletUnit:GetSpawnPosition()
	return self._spawnPos
end

function ys.Battle.BattleBulletUnit:GetTemplate()
	return self._tempData
end

function ys.Battle.BattleBulletUnit:GetType()
	return self._tempData.type
end

function ys.Battle.BattleBulletUnit:GetHitSFX()
	return self._hitSFX
end

function ys.Battle.BattleBulletUnit:GetMissSFX()
	return self._missSFX
end

function ys.Battle.BattleBulletUnit:GetOutBound()
	return self._tempData.out_bound
end

function ys.Battle.BattleBulletUnit:GetUniqueID()
	return self._uniqueID
end

function ys.Battle.BattleBulletUnit:GetOffset()
	return self._offsetX, self._offsetZ, self._isOffsetPriority
end

function ys.Battle.BattleBulletUnit:GetRotateInfo()
	return self._targetPos, self._baseAngle, self._barrageAngle
end

function ys.Battle.BattleBulletUnit:IsOutRange()
	return self._reachDestFlag
end

function ys.Battle.BattleBulletUnit.SetYAngle(arg_73_0, arg_73_1)
	arg_73_0._yAngle = arg_73_1

	return
end

function ys.Battle.BattleBulletUnit.SetOffsetPriority(arg_74_0, arg_74_1)
	arg_74_0._isOffsetPriority = arg_74_1 or false

	return
end

function ys.Battle.BattleBulletUnit:GetOffsetPriority()
	return self._isOffsetPriority
end

function ys.Battle.BattleBulletUnit:GetYAngle()
	return self._yAngle
end

function ys.Battle.BattleBulletUnit:GetCurrentYAngle()
	local var_77_0 = Vector3.Normalize(self._speed)
	local var_77_1 = math.acos(var_77_0.x) / math.deg2Rad

	if var_77_0.z < 0 then
		var_77_1 = 360 - var_77_1
	end

	return var_77_1
end

function ys.Battle.BattleBulletUnit:GetIFF()
	return self._IFF
end

function ys.Battle.BattleBulletUnit:GetHost()
	return self._host
end

function ys.Battle.BattleBulletUnit:GetPierceCount()
	return self._pierceCount
end

function ys.Battle.BattleBulletUnit:AppendAttachBuff(arg_81_1)
	self._attachBuffList = self._attachBuffList or self:generateAttachBuffList()

	table.insert(self._attachBuffList, arg_81_1)

	return
end

function ys.Battle.BattleBulletUnit:GetAttachBuff()
	self._attachBuffList = self._attachBuffList or self:generateAttachBuffList()

	return self._attachBuffList
end

function ys.Battle.BattleBulletUnit:generateAttachBuffList()
	local var_83_0 = {}

	if not self:GetTemplate().attach_buff then
		-- block empty
	end

	for iter_83_0, iter_83_1 in ipairs(self:GetTemplate().attach_buff) do
		table.insert(var_83_0, {
			buff_id = iter_83_1.buff_id,
			level = iter_83_1.buff_level,
			rant = iter_83_1.rant,
			hit_ignore = iter_83_1.hit_ignore,
			group_level = iter_83_1.group_level
		})
	end

	return var_83_0
end

function ys.Battle.BattleBulletUnit:GetEffectField()
	return self._field
end

function ys.Battle.BattleBulletUnit:SetDiverFilter(arg_85_1)
	self._diveFilter = arg_85_1 == nil and (self._tempData.extra_param.diveFilter or {
		2
	}) or arg_85_1

	return
end

function ys.Battle.BattleBulletUnit:GetDiveFilter()
	return self._diveFilter
end

function ys.Battle.BattleBulletUnit:GetVelocity()
	return self._velocity
end

function ys.Battle.BattleBulletUnit:GetConvertedVelocity()
	return self._convertedVelocity
end

function ys.Battle.BattleBulletUnit:GetSpeedExemptKey()
	return self._speedExemptKey
end

function ys.Battle.BattleBulletUnit:IsCollided(arg_90_1)
	return self._collidedList[arg_90_1]
end

function ys.Battle.BattleBulletUnit:GetExist()
	return self._exist
end

function ys.Battle.BattleBulletUnit.SetExist(arg_92_0, arg_92_1)
	arg_92_0._exist = arg_92_1

	return
end

function ys.Battle.BattleBulletUnit:GetIgnoreShield()
	return self._ignoreShield
end

function ys.Battle.BattleBulletUnit.SetIgnoreShield(arg_94_0, arg_94_1)
	arg_94_0._ignoreShield = arg_94_1

	return
end

function ys.Battle.BattleBulletUnit:IsAutoRotate()
	return self._autoRotate
end

function ys.Battle.BattleBulletUnit.Dispose(arg_96_0)
	arg_96_0._dataProxy = nil

	var_0_0.EventDispatcher.DetachEventDispatcher(arg_96_0)

	return
end

function ys.Battle.BattleBulletUnit:InitCldComponent()
	local var_97_0 = self:GetTemplate().cld_box
	local var_97_1 = self:GetTemplate().cld_offset
	local var_97_2 = var_97_1[1]

	if self:GetIFF() == var_0_5.FOE_CODE then
		var_97_2 = var_97_2 * -1
	end

	self._cldComponent = var_0_0.Battle.BattleCubeCldComponent.New(var_97_0[1], var_97_0[2], var_97_0[3], var_97_2, var_97_1[3])

	self._cldComponent:SetCldData({
		type = var_0_8.CldType.BULLET,
		IFF = self:GetIFF(),
		UID = self:GetUniqueID()
	})

	return
end

function ys.Battle.BattleBulletUnit:ResetCldSurface()
	local var_98_0 = self:GetDiveFilter()

	self:GetCldData().Surface = var_98_0 and #var_98_0 == 0 and var_0_8.OXY_STATE.DIVE or var_0_8.OXY_STATE.FLOAT

	return
end

function ys.Battle.BattleBulletUnit:GetBoxSize()
	return self._cldComponent:GetCldBoxSize()
end

function ys.Battle.BattleBulletUnit:GetCldBox()
	return self._cldComponent:GetCldBox(self:GetPosition())
end

function ys.Battle.BattleBulletUnit:GetCldData()
	return self._cldComponent:GetCldData()
end

function ys.Battle.BattleBulletUnit:GetSpeed()
	return self._speed
end

function ys.Battle.BattleBulletUnit:GetSpeedRatio()
	return var_0_4.GetSpeedRatio(self._speedExemptKey, self._IFF)
end

function ys.Battle.BattleBulletUnit:InitSpeed(arg_104_1)
	if self._yAngle == nil then
		self._yAngle = (arg_104_1 or self._baseAngle) + self._barrageAngle
	end

	self:calcSpeed()

	if self:HasAcceleration() then
		self._speedLength = self._speed:Magnitude()
		self._speedNormal = Vector3(math.cos(math.deg2Rad * self._yAngle), 0, math.sin(math.deg2Rad * self._yAngle))
		self._speedCross = Vector3.Cross(self._speedNormal, var_0_3)
		self.updateSpeed = var_0_10.doAccelerate
	elseif self:IsTracker() then
		self._trackRange = self._accTable.tracker.range
		self._cosAngularSpeed = math.deg2Rad * self._accTable.tracker.angular
		self._sinAngularSpeed = math.deg2Rad * self._accTable.tracker.angular
		self._negativeCosAngularSpeed = math.deg2Rad * self._accTable.tracker.angular * -1
		self._negativeSinAngularSpeed = math.deg2Rad * self._accTable.tracker.angular * -1
		self.updateSpeed = var_0_10.doTrack
	elseif self:IsCircle() then
		self._originPos = self._accTable.circle.center or self._targetPos
		self._circleAntiClockwise = tobool(self._accTable.circle.antiClockWise)
		self._centripetalSpeed = (self._accTable.circle.centripetalSpeed or 0) * var_0_7
		self._inverseFlag = 1
		self.updateSpeed = var_0_10.doCircle
	else
		self.updateSpeed = var_0_10.doNothing
	end

	return
end

function ys.Battle.BattleBulletUnit.InheritSpeed(arg_105_0, arg_105_1)
	arg_105_0._speed = Vector3(arg_105_1.x, arg_105_1.y, arg_105_1.z)
	arg_105_0._speedInited = true

	return
end

function ys.Battle.BattleBulletUnit:calcSpeed()
	if self._speedInited then
		return
	end

	local var_106_0 = var_0_2.ConvertBulletSpeed(self._velocity * (1 + var_0_0.Battle.BattleAttr.GetCurrent(self, "bulletSpeedRatio")))

	self._speed = Vector3(var_106_0 * math.cos(math.deg2Rad * self._yAngle), 0, var_106_0 * math.sin(math.deg2Rad * self._yAngle))

	return
end

function ys.Battle.BattleBulletUnit:updateBarrageTransform(arg_107_1)
	local var_107_0

	if not self._barrageTransData or #self._barrageTransData == 0 then
		do return end

		var_107_0 = self._barrageTransData[1]
	end

	if arg_107_1 - self._timeStamp >= self._barrageTransData[1].transStartDelay then
		self._yAngle = var_107_0.transAimAngle and var_107_0.transAimAngle or math.rad2Deg * math.atan2(var_107_0.transAimPosZ - self._position.z, var_107_0.transAimPosX - self._position.x)

		self:calcSpeed()
		table.remove(self._barrageTransData, 1)

		if self._barrageTransData[1] then
			self._barrageTransData[1].transStartDelay = self._barrageTransData[1].transStartDelay + var_107_0.transStartDelay
		end
	end

	return
end

function ys.Battle.BattleBulletUnit:GetCurrentDistance()
	return Vector3.Distance(self._spawnPos, self._position)
end

function ys.Battle.BattleBulletUnit.SetOutRangeCallback(arg_109_0, arg_109_1)
	arg_109_0._outRangeFunc = arg_109_1

	return
end

function ys.Battle.BattleBulletUnit:OutRange()
	self:DispatchEvent(var_0_0.Event.New(var_0_1.OUT_RANGE, {}))
	self:_outRangeFunc()

	return
end

function ys.Battle.BattleBulletUnit:FixRange(arg_111_1, arg_111_2)
	arg_111_1 = arg_111_1 or self._tempData.range
	arg_111_2 = arg_111_2 or 0
	self._range = self._tempData.range_offset == 0 and arg_111_1 or arg_111_1 + self._tempData.range_offset * (math.random() - 0.5)
	self._range = math.max(0, self._range + arg_111_2)
	self._sqrRange = self._range * self._range

	return
end

function ys.Battle.BattleBulletUnit:ImmuneBombCLS()
	return self:GetTemplate().extra_param.ignoreB
end

function ys.Battle.BattleBulletUnit:ImmuneCLS()
	return self._immuneCLS
end

function ys.Battle.BattleBulletUnit.SetImmuneCLS(arg_114_0, arg_114_1)
	arg_114_0._immuneCLS = arg_114_1

	return
end

function ys.Battle.BattleBulletUnit:IsSpectreBullet()
	return self:GetTemplate().extra_param.spectre
end

return
