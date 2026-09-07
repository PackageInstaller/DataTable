ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleConfig
local var_0_3 = ys.Battle.BattleFormulas
local var_0_4 = ys.Battle.BattleConst.WeaponSuppressType
local var_0_5 = ys.Battle.BattleConst.WeaponSearchType
local var_0_6 = ys.Battle.BattleDataFunction
local var_0_7 = ys.Battle.BattleAttr
local var_0_8 = ys.Battle.BattleTargetChoise
local BattleWeaponUnit = class("BattleWeaponUnit")

ys.Battle.BattleWeaponUnit = BattleWeaponUnit
BattleWeaponUnit.__name = "BattleWeaponUnit"
BattleWeaponUnit.INTERNAL = "internal"
BattleWeaponUnit.EXTERNAL = "external"
BattleWeaponUnit.EMITTER_NORMAL = "BattleBulletEmitter"
BattleWeaponUnit.EMITTER_SHOTGUN = "BattleShotgunEmitter"
BattleWeaponUnit.STATE_DISABLE = "DISABLE"
BattleWeaponUnit.STATE_READY = "READY"
BattleWeaponUnit.STATE_PRECAST = "PRECAST"
BattleWeaponUnit.STATE_PRECAST_FINISH = "STATE_PRECAST_FINISH"
BattleWeaponUnit.STATE_ATTACK = "ATTACK"
BattleWeaponUnit.STATE_OVER_HEAT = "OVER_HEAT"

function BattleWeaponUnit:Ctor()
	var_0_0.EventDispatcher.AttachEventDispatcher(self)

	self._currentState = self.STATE_READY
	self._equipmentIndex = -1
	self._dataProxy = var_0_0.Battle.BattleDataProxy.GetInstance()
	self._tempEmittersList = {}
	self._dumpedEmittersList = {}
	self._reloadFacotrList = {}
	self._diveEnabled = true
	self._comboIDList = {}
	self._jammingTime = 0
	self._reloadBoostList = {}
	self._CLDCount = 0
	self._damageSum = 0
	self._CTSum = 0
	self._ACCSum = 0

	return
end

function BattleWeaponUnit:HostOnEnemy()
	self._hostOnEnemy = true

	return
end

function BattleWeaponUnit:SetPotentialFactor(arg_3_1)
	self._potential = arg_3_1

	if self._correctedDMG then
		self._correctedDMG = var_0_3.WeaponDamagePreCorrection(self)
	end

	return
end

function BattleWeaponUnit:GetEquipmentLabel()
	return self._equipmentLabelList or {}
end

function BattleWeaponUnit:SetEquipmentLabel(arg_5_1)
	self._equipmentLabelList = arg_5_1

	return
end

function BattleWeaponUnit:SetTemplateData(arg_6_1)
	self._potential = self._potential or 1
	self._tmpData = arg_6_1
	self._maxRangeSqr = arg_6_1.range
	self._minRangeSqr = arg_6_1.min_range
	self._fireFXFlag = arg_6_1.fire_fx_loop_type
	self._oxyList = arg_6_1.oxy_type
	self._bulletList = arg_6_1.bullet_ID
	self._majorEmitterList = {}

	self:ShiftBarrage(arg_6_1.barrage_ID)

	self._GCD = arg_6_1.recover_time
	self._preCastInfo = arg_6_1.precast_param
	self._correctedDMG = var_0_3.WeaponDamagePreCorrection(self)
	self._convertedAtkAttr = var_0_3.WeaponAtkAttrPreRatio(self)

	self:FlushReloadMax(1)

	return
end

function BattleWeaponUnit:createMajorEmitter(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	arg_7_3 = arg_7_3 or BattleWeaponUnit.EMITTER_NORMAL

	local var_7_0 = var_0_0.Battle[arg_7_3].New(arg_7_4 or function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		local var_8_0 = self:Spawn(self._emitBulletIDList[arg_7_2], arg_8_4, BattleWeaponUnit.INTERNAL)

		var_8_0:SetOffsetPriority(arg_8_3)
		var_8_0:SetShiftInfo(arg_8_0, arg_8_1)

		if self._tmpData.aim_type == var_0_1.WeaponAimType.AIM and arg_8_4 ~= nil then
			var_8_0:SetRotateInfo(arg_8_4:GetBeenAimedPosition(), self:GetBaseAngle(), arg_8_2)
		else
			var_8_0:SetRotateInfo(nil, self:GetBaseAngle(), arg_8_2)
		end

		self:DispatchBulletEvent(var_8_0)

		return var_8_0
	end, arg_7_5 or function()
		for iter_9_0, iter_9_1 in ipairs(self._majorEmitterList) do
			if iter_9_1:GetState() ~= iter_9_1.STATE_STOP then
				return
			end
		end

		self:EnterCoolDown()

		return
	end, arg_7_1)

	self._majorEmitterList[#self._majorEmitterList + 1] = var_7_0

	return var_7_0
end

function BattleWeaponUnit:interruptAllEmitter()
	if self._majorEmitterList then
		for iter_10_0, iter_10_1 in ipairs(self._majorEmitterList) do
			iter_10_1:Interrupt()
		end
	end

	for iter_10_2, iter_10_3 in ipairs(self._tempEmittersList) do
		for iter_10_4, iter_10_5 in ipairs(iter_10_3) do
			iter_10_5:Interrupt()
		end
	end

	for iter_10_6, iter_10_7 in ipairs(self._dumpedEmittersList) do
		for iter_10_8, iter_10_9 in ipairs(iter_10_7) do
			iter_10_9:Interrupt()
		end
	end

	return
end

function BattleWeaponUnit:cacheSectorData()
	self._upperEdge = math.deg2Rad * (self:GetAttackAngle() / 2)
	self._lowerEdge = -1 * self._upperEdge

	if self:GetDirection() == var_0_1.UnitDir.LEFT then
		self._normalizeOffset = math.pi - math.deg2Rad * self._tmpData.axis_angle
	elseif self:GetDirection() == var_0_1.UnitDir.RIGHT then
		self._normalizeOffset = math.deg2Rad * self._tmpData.axis_angle
	end

	self._wholeCircle = math.pi - self._normalizeOffset
	self._negativeCircle = -math.pi - self._normalizeOffset
	self._wholeCircleNormalizeOffset = self._normalizeOffset - math.pi * 2
	self._negativeCircleNormalizeOffset = self._normalizeOffset + math.pi * 2

	return
end

function BattleWeaponUnit:cacheSquareData()
	self._frontRange = self._tmpData.angle
	self._backRange = self._tmpData.axis_angle
	self._upperRange = self._tmpData.min_range
	self._lowerRange = self._tmpData.range

	return
end

function BattleWeaponUnit:SetModelID(arg_13_1)
	self._modelID = arg_13_1

	return
end

function BattleWeaponUnit:SetSkinData(arg_14_1)
	self._skinID = arg_14_1

	local var_14_0, var_14_1, var_14_2, var_14_3, var_14_4, var_14_5 = var_0_6.GetEquipSkin(self._skinID)

	self:SetModelID(var_14_0)

	if var_14_4 ~= "" then
		self._skinFireFX = var_14_4
	end

	if var_14_5 ~= "" then
		self._skinHitFX = var_14_5
	end

	local var_14_6, var_14_7 = var_0_6.GetEquipSkinSFX(self._skinID)

	self._skinHixSFX = var_14_6
	self._skinMissSFX = var_14_7

	return
end

function BattleWeaponUnit:SetDerivateSkin(arg_15_1)
	self._derivateSkinID = arg_15_1

	local var_15_0, var_15_1, var_15_2, var_15_3, var_15_4, var_15_5 = var_0_6.GetEquipSkin(self._derivateSkinID)

	self._derivateBullet = var_15_1
	self._derivateTorpedo = var_15_2
	self._derivateBoom = var_15_3
	self._derviateHitFX = var_15_5

	local var_15_6, var_15_7 = var_0_6.GetEquipSkinSFX(self._derivateSkinID)

	self._skinHixSFX = var_15_6
	self._skinMissSFX = var_15_7

	return
end

function BattleWeaponUnit:GetSkinID()
	return self._skinID
end

function BattleWeaponUnit:setBulletSkin(arg_17_1, arg_17_2)
	if self._derivateSkinID then
		local var_17_0 = var_0_6.GetBulletTmpDataFromID(arg_17_2).type

		if var_17_0 == var_0_1.BulletType.BOMB and self._derivateBoom ~= "" then
			arg_17_1:SetModleID(self._derivateBoom, nil, self._derviateHitFX)
		elseif var_17_0 == var_0_1.BulletType.TORPEDO and self._derivateTorpedo ~= "" then
			arg_17_1:SetModleID(self._derivateTorpedo, nil, self._derviateHitFX)
		elseif self._derivateBullet ~= "" then
			arg_17_1:SetModleID(self._derivateBullet, nil, self._derviateHitFX)
		end

		arg_17_1:SetSFXID(self._skinHixSFX, self._skinMissSFX)
	elseif self._modelID then
		arg_17_1:SetModleID(self._modelID, (self._skinID or nil) and var_0_6.GetEquipSkinDataFromID(self._skinID).mirror, self._skinHitFX)
		arg_17_1:SetSFXID(self._skinHixSFX, self._skinMissSFX)
	end

	return
end

function BattleWeaponUnit:SetSrcEquipmentID(arg_18_1)
	self._srcEquipID = arg_18_1

	return
end

function BattleWeaponUnit:SetEquipmentIndex(arg_19_1)
	self._equipmentIndex = arg_19_1

	return
end

function BattleWeaponUnit:GetEquipmentIndex()
	return self._equipmentIndex
end

function BattleWeaponUnit:SetHostData(arg_21_1)
	self._host = arg_21_1
	self._hostUnitType = self._host:GetUnitType()
	self._hostIFF = arg_21_1:GetIFF()

	if self._tmpData.search_type == var_0_5.SECTOR then
		self:cacheSectorData()

		self.outOfFireRange = self.IsOutOfAngle
		self.IsOutOfFireArea = self.IsOutOfSector
	elseif self._tmpData.search_type == var_0_5.SQUARE then
		self:cacheSquareData()

		self.outOfFireRange = self.IsOutOfSquare
		self.IsOutOfFireArea = self.IsOutOfSquare
	elseif self._tmpData.search_type == var_0_5.STRIKE then
		self:cacheSquareData()

		self.outOfFireRange = self.IsOutOfSquare
	end

	self._baseAngle = self:GetDirection() == var_0_1.UnitDir.RIGHT and 0 or 180

	return
end

function BattleWeaponUnit:SetStandHost(arg_22_1)
	self._standHost = arg_22_1

	return
end

function BattleWeaponUnit:OverrideGCD(arg_23_1)
	self._GCD = arg_23_1

	return
end

function BattleWeaponUnit:updateMovementInfo()
	self._hostPos = self._host:GetPosition()

	return
end

function BattleWeaponUnit:GetWeaponId()
	return self._tmpData.id
end

function BattleWeaponUnit:GetTemplateData()
	return self._tmpData
end

function BattleWeaponUnit:GetType()
	return self._tmpData.type
end

function BattleWeaponUnit:GetPotential()
	return self._potential or 1
end

function BattleWeaponUnit:GetSrcEquipmentID()
	return self._srcEquipID
end

function BattleWeaponUnit:SetFixedFlag()
	self._isFixedWeapon = true

	return
end

function BattleWeaponUnit:IsFixedWeapon()
	return self._isFixedWeapon
end

function BattleWeaponUnit:IsAttacking()
	return self._currentState == BattleWeaponUnit.STATE_ATTACK or self._currentState == self.STATE_PRECAST
end

function BattleWeaponUnit:Update()
	self:UpdateReload()

	if not self._diveEnabled then
		return
	end

	if self._currentState == self.STATE_READY then
		self:updateMovementInfo()

		if self._tmpData.suppress == var_0_4.SUPPRESSION or self:CheckPreCast() then
			if self._preCastInfo.time == nil or not self._hostOnEnemy then
				self._currentState = self.STATE_PRECAST_FINISH
			else
				self:PreCast()
			end
		end
	end

	if self._currentState == self.STATE_PRECAST_FINISH then
		self:updateMovementInfo()
		self:Fire(self:Tracking())
	end

	return
end

function BattleWeaponUnit:CheckReloadTimeStamp()
	return self._CDstartTime and self:GetReloadFinishTimeStamp() <= pg.TimeMgr.GetInstance():GetCombatTime()
end

function BattleWeaponUnit:UpdateReload()
	if self._CDstartTime and not self._jammingStartTime then
		if self:GetReloadFinishTimeStamp() <= pg.TimeMgr.GetInstance():GetCombatTime() then
			self:handleCoolDown()
		else
			return
		end
	end

	return
end

function BattleWeaponUnit:CheckPreCast()
	if self._tmpData.search_type == var_0_5.STRIKE then
		return not self:IsPointOutOfSquare((self._host:GetStrikePoint()))
	else
		for iter_36_0, iter_36_1 in pairs(self:GetFilteredList()) do
			return true
		end
	end

	return false
end

function BattleWeaponUnit:ChangeDiveState()
	if self._host:GetOxyState() then
		local var_37_0 = self._host:GetOxyState():GetWeaponType()

		for iter_37_0, iter_37_1 in ipairs(self._oxyList) do
			if table.contains(var_37_0, iter_37_1) then
				self._diveEnabled = true

				return
			end
		end

		self._diveEnabled = false
	end

	return
end

function BattleWeaponUnit:getTrackingHost()
	return self._host
end

BattleWeaponUnit.TrackingFunc = {
	farthest = BattleWeaponUnit.TrackingFarthest,
	leastHP = BattleWeaponUnit.TrackingLeastHP
}

function BattleWeaponUnit:Tracking()
	if self._tmpData.search_type == var_0_5.STRIKE then
		return nil
	end

	local var_39_0 = var_0_7.GetCurrentTargetSelect(self._host)
	local var_39_1
	local var_39_2 = self:GetFilteredList()

	var_39_1 = var_39_0 and (BattleWeaponUnit.TrackingFunc[var_39_0] and BattleWeaponUnit.TrackingFunc[var_39_0](self, var_39_2) or self:TrackingTag(var_39_2, var_39_0)) or self:TrackingNearest(var_39_2)

	if var_39_1 and var_0_7.GetCurrentGuardianID(var_39_1) then
		local var_39_3 = var_0_7.GetCurrentGuardianID(var_39_1)

		for iter_39_0, iter_39_1 in ipairs(var_39_2) do
			if iter_39_1:GetUniqueID() == var_39_3 then
				var_39_1 = iter_39_1

				break
			end
		end
	end

	return var_39_1
end

function BattleWeaponUnit:GetFilteredList()
	local var_40_0 = self:FilterTarget()

	if self._tmpData.search_type == var_0_5.SECTOR then
		var_40_0 = self:FilterRange(var_40_0)
		var_40_0 = self:FilterAngle(var_40_0)
	elseif self._tmpData.search_type == var_0_5.SQUARE then
		var_40_0 = self:FilterSquare(var_40_0)
	end

	return var_40_0
end

function BattleWeaponUnit:FixWeaponRange(arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	self._maxRangeSqr = arg_41_1 or self._tmpData.range
	self._minRangeSqr = arg_41_3 or self._tmpData.min_range
	self._fixBulletRange = arg_41_2
	self._bulletRangeOffset = arg_41_4

	return
end

function BattleWeaponUnit:GetWeaponMaxRange()
	return self._maxRangeSqr
end

function BattleWeaponUnit:GetWeaponMinRange()
	return self._minRangeSqr
end

function BattleWeaponUnit:GetFixBulletRange()
	return self._fixBulletRange, self._bulletRangeOffset
end

function BattleWeaponUnit:TrackingNearest(arg_45_1)
	local var_45_0

	for iter_45_0, iter_45_1 in ipairs(arg_45_1) do
		if self:getTrackingHost():GetDistance(iter_45_1) <= self._maxRangeSqr then
			var_45_0 = iter_45_1
		end
	end

	return var_45_0
end

function BattleWeaponUnit:TrackingFarthest(arg_46_1)
	local var_46_0

	for iter_46_0, iter_46_1 in ipairs(arg_46_1) do
		if 0 < self:getTrackingHost():GetDistance(iter_46_1) then
			var_46_0 = iter_46_1
		end
	end

	return var_46_0
end

function BattleWeaponUnit:TrackingLeastHP(arg_47_1)
	local var_47_0

	for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
		if iter_47_1:GetCurrentHP() < math.huge then
			var_47_0 = iter_47_1
		end
	end

	return var_47_0
end

function BattleWeaponUnit:TrackingRandom(arg_48_1)
	local var_48_0 = {}

	for iter_48_0, iter_48_1 in pairs(arg_48_1) do
		table.insert(var_48_0, iter_48_1)
	end

	if #var_48_0 == 0 then
		return nil
	else
		return var_48_0[math.random(#var_48_0)]
	end

	return
end

function BattleWeaponUnit:TrackingTag(arg_49_1, arg_49_2)
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
		if iter_49_1:ContainsLabelTag({
			arg_49_2
		}) then
			table.insert(var_49_0, iter_49_1)
		end
	end

	if #var_49_0 == 0 then
		return self:TrackingNearest(arg_49_1)
	else
		return var_49_0[math.random(#var_49_0)]
	end

	return
end

function BattleWeaponUnit:FilterTarget()
	local var_50_0 = {}
	local var_50_1 = 1

	for iter_50_0, iter_50_1 in pairs((var_0_8.LegalWeaponTarget(self._host))) do
		local var_50_2 = iter_50_1:GetCurrentOxyState()

		if var_0_7.IsCloak(iter_50_1) then
			-- block empty
		elseif not table.contains(self._tmpData.search_condition, var_50_2) then
			-- block empty
		else
			local var_50_3 = true

			if var_50_2 == var_0_1.OXY_STATE.FLOAT then
				-- block empty
			elseif var_50_2 == var_0_1.OXY_STATE.DIVE and not iter_50_1:IsRunMode() and not iter_50_1:GetDiveDetected() and iter_50_1:GetDiveInvisible() then
				var_50_3 = false
			end

			if var_50_3 then
				var_50_0[var_50_1] = iter_50_1
				var_50_1 = var_50_1 + 1
			end
		end
	end

	return var_50_0
end

function BattleWeaponUnit:FilterAngle(arg_51_1)
	if self:GetAttackAngle() >= 360 then
		return arg_51_1
	end

	for iter_51_0 = #arg_51_1, 1, -1 do
		if self:IsOutOfAngle(arg_51_1[iter_51_0]) then
			table.remove(arg_51_1, iter_51_0)
		end
	end

	return arg_51_1
end

function BattleWeaponUnit:FilterRange(arg_52_1)
	for iter_52_0 = #arg_52_1, 1, -1 do
		if self:IsOutOfRange(arg_52_1[iter_52_0]) then
			table.remove(arg_52_1, iter_52_0)
		end
	end

	return arg_52_1
end

function BattleWeaponUnit:FilterSquare(arg_53_1)
	local var_53_0 = self:GetDirection()
	local var_53_1 = var_0_8.TargetWeightiest(self._host, nil, (var_0_8.TargetInsideArea(self._host, {
		lineX = self._host:GetPosition().x + self._backRange * var_53_0 * -1,
		dir = var_53_0
	}, arg_53_1)))

	for iter_53_0 = #arg_53_1, 1, -1 do
		if self:IsOutOfSquare(arg_53_1[iter_53_0]) then
			table.remove(arg_53_1, iter_53_0)
		end
	end

	for iter_53_1 = #arg_53_1, 1, -1 do
		if not table.contains(var_53_1, arg_53_1[iter_53_1]) then
			table.remove(arg_53_1, iter_53_1)
		end
	end

	return arg_53_1
end

function BattleWeaponUnit:GetAttackAngle()
	return self._tmpData.angle
end

function BattleWeaponUnit:IsOutOfAngle(arg_55_1)
	if self:GetAttackAngle() >= 360 then
		return false
	end

	local var_55_0 = arg_55_1:GetPosition()
	local var_55_1 = math.atan2(var_55_0.z - self._hostPos.z, var_55_0.x - self._hostPos.x)

	var_55_1 = var_55_1 > self._wholeCircle and var_55_1 + self._wholeCircleNormalizeOffset or var_55_1 < self._negativeCircle and var_55_1 + self._negativeCircleNormalizeOffset or var_55_1 + self._normalizeOffset

	if var_55_1 > self._lowerEdge and var_55_1 < self._upperEdge then
		return false
	else
		return true
	end

	return
end

function BattleWeaponUnit:IsOutOfRange(arg_56_1)
	local var_56_0 = self:getTrackingHost():GetDistance(arg_56_1)

	return var_56_0 > self._maxRangeSqr or var_56_0 < self:GetMinimumRange()
end

function BattleWeaponUnit:IsOutOfSector(arg_57_1)
	return self:IsOutOfRange(arg_57_1) or self:IsOutOfAngle(arg_57_1)
end

function BattleWeaponUnit:IsOutOfSquare(arg_58_1)
	return self:IsPointOutOfSquare((arg_58_1:GetPosition()))
end

function BattleWeaponUnit:IsPointOutOfSquare(arg_59_1)
	local var_59_0 = false
	local var_59_1 = (arg_59_1.x - self._hostPos.x) * self:GetDirection()

	if self._backRange < 0 then
		if var_59_1 > 0 and var_59_1 <= self._frontRange and var_59_1 >= math.abs(self._backRange) then
			var_59_0 = true
		end
	elseif var_59_1 > 0 and var_59_1 <= self._frontRange or var_59_1 < 0 and math.abs(var_59_1) < self._backRange then
		var_59_0 = true
	end

	if not var_59_0 then
		return true
	else
		return false
	end

	return
end

function BattleWeaponUnit:PreCast()
	self._currentState = self.STATE_PRECAST

	self:AddPreCastTimer()

	if self._preCastInfo.armor then
		self._precastArmor = self._preCastInfo.armor
	end

	local var_60_0 = var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.WEAPON_PRE_CAST, self._preCastInfo)

	self._host:SetWeaponPreCastBound(self._preCastInfo.isBound)
	self:DispatchEvent(var_60_0)

	return
end

function BattleWeaponUnit:Fire(arg_61_1)
	if self._host:IsCease() then
		return false
	else
		self:DispatchGCD()

		self._currentState = self.STATE_ATTACK

		if self._tmpData.action_index == "" then
			self:DoAttack(arg_61_1)
		else
			self:DispatchFireEvent(arg_61_1, self._tmpData.action_index)
		end
	end

	return true
end

function BattleWeaponUnit:DoAttack(arg_62_1)
	if arg_62_1 == nil or not arg_62_1:IsAlive() or self:outOfFireRange(arg_62_1) then
		arg_62_1 = nil
	end

	local var_62_0 = self:GetDirection()
	local var_62_1 = self:GetAttackAngle()

	self:cacheBulletID()
	self:TriggerBuffOnSteday()

	for iter_62_0, iter_62_1 in ipairs(self._majorEmitterList) do
		iter_62_1:Ready()
	end

	for iter_62_2, iter_62_3 in ipairs(self._majorEmitterList) do
		iter_62_3:Fire(arg_62_1, var_62_0, var_62_1)
	end

	self._host:CloakExpose(self._tmpData.expose)
	var_0_0.Battle.PlayBattleSFX(self._tmpData.fire_sfx)
	self:TriggerBuffOnFire()
	self:CheckAndShake()

	return
end

function BattleWeaponUnit:TriggerBuffOnSteday()
	self._host:TriggerBuff(var_0_1.BuffEffectType.ON_WEAPON_STEDAY, {
		equipIndex = self._equipmentIndex
	})

	return
end

function BattleWeaponUnit:TriggerBuffOnFire()
	self._host:TriggerBuff(var_0_1.BuffEffectType.ON_FIRE, {
		equipIndex = self._equipmentIndex
	})

	return
end

function BattleWeaponUnit:TriggerBuffOnReady()
	return
end

function BattleWeaponUnit:UpdateCombo(arg_66_1)
	if self._hostUnitType ~= var_0_1.UnitType.PLAYER_UNIT or not self._host:IsAlive() then
		return
	end

	if #arg_66_1 > 0 then
		local var_66_0 = 0

		for iter_66_0, iter_66_1 in ipairs(arg_66_1) do
			if table.contains(self._comboIDList, iter_66_1) then
				var_66_0 = var_66_0 + 1
			end

			self._host:TriggerBuff(var_0_1.BuffEffectType.ON_COMBO, {
				equipIndex = self._equipmentIndex,
				matchUnitCount = var_66_0
			})

			break
		end

		self._comboIDList = arg_66_1
	end

	return
end

function BattleWeaponUnit:SingleFire(arg_67_1, arg_67_2, arg_67_3, arg_67_4)
	local var_67_0 = {}

	self._tempEmittersList[#self._tempEmittersList + 1] = var_67_0

	if arg_67_1 and arg_67_1:IsAlive() then
		-- block empty
	else
		arg_67_1 = nil
	end

	arg_67_2 = arg_67_2 or BattleWeaponUnit.EMITTER_NORMAL

	for iter_67_0, iter_67_1 in ipairs(self._barrageList) do
		var_67_0[#var_67_0 + 1] = var_0_0.Battle[arg_67_2].New(function(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
			local var_68_0 = self:Spawn(((arg_67_4 or nil) and (self._tmpData.bullet_ID or self._bulletList))[iter_67_0], arg_67_1, BattleWeaponUnit.EXTERNAL)

			var_68_0:SetOffsetPriority(arg_68_3)
			var_68_0:SetShiftInfo(arg_68_0, arg_68_1)

			if arg_67_1 ~= nil then
				var_68_0:SetRotateInfo(arg_67_1:GetBeenAimedPosition(), self:GetBaseAngle(), arg_68_2)
			else
				var_68_0:SetRotateInfo(nil, self:GetBaseAngle(), arg_68_2)
			end

			self:DispatchBulletEvent(var_68_0)

			return
		end, function()
			for iter_69_0, iter_69_1 in ipairs(var_67_0) do
				if iter_69_1:GetState() ~= iter_69_1.STATE_STOP then
					return
				end
			end

			for iter_69_2, iter_69_3 in ipairs(var_67_0) do
				iter_69_3:Destroy()
			end

			local var_69_0

			for iter_69_4, iter_69_5 in ipairs(self._tempEmittersList) do
				if iter_69_5 == var_67_0 then
					var_69_0 = iter_69_4
				end
			end

			table.remove(self._tempEmittersList, var_69_0)

			var_67_0 = nil
			self._fireFXFlag = self._tmpData.fire_fx_loop_type

			if arg_67_3 then
				arg_67_3()
			end

			return
		end, iter_67_1)
	end

	for iter_67_2, iter_67_3 in ipairs(var_67_0) do
		iter_67_3:Ready()
		iter_67_3:Fire(arg_67_1, self:GetDirection(), self:GetAttackAngle())
	end

	self._host:CloakExpose(self._tmpData.expose)
	self:CheckAndShake()

	return
end

function BattleWeaponUnit:SetModifyInitialCD()
	self._modInitCD = true

	return
end

function BattleWeaponUnit:GetModifyInitialCD()
	return self._modInitCD
end

function BattleWeaponUnit:InitialCD()
	if self._tmpData.initial_over_heat == 1 then
		self:AddCDTimer(self:GetReloadTime())
	end

	return
end

function BattleWeaponUnit:EnterCoolDown()
	self._fireFXFlag = self._tmpData.fire_fx_loop_type

	self:AddCDTimer(self:GetReloadTime())

	return
end

function BattleWeaponUnit:UpdatePrecastArmor(arg_74_1)
	if self._currentState ~= BattleWeaponUnit.STATE_PRECAST or not self._precastArmor then
		return
	end

	self._precastArmor = self._precastArmor + arg_74_1

	if self._precastArmor <= 0 then
		self:Interrupt()
	end

	return
end

function BattleWeaponUnit:Interrupt()
	self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.WEAPON_PRE_CAST_FINISH, self._preCastInfo)))
	self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.WEAPON_INTERRUPT, self._preCastInfo)))
	self:TriggerBuffWhenPrecastFinish(var_0_1.BuffEffectType.ON_WEAPON_INTERRUPT)
	self:RemovePrecastTimer()
	self:EnterCoolDown()

	return
end

function BattleWeaponUnit:Cease()
	if self._currentState == BattleWeaponUnit.STATE_ATTACK or self._currentState == BattleWeaponUnit.STATE_PRECAST or self._currentState == BattleWeaponUnit.STATE_PRECAST_FINISH then
		self:interruptAllEmitter()
		self:EnterCoolDown()
	end

	return
end

function BattleWeaponUnit:AppendReloadBoost()
	return
end

function BattleWeaponUnit:DispatchGCD()
	if self._GCD > 0 then
		self._host:EnterGCD(self._GCD, self._tmpData.queue)
	end

	return
end

function BattleWeaponUnit:Clear()
	self:RemovePrecastTimer()

	if self._majorEmitterList then
		for iter_79_0, iter_79_1 in ipairs(self._majorEmitterList) do
			iter_79_1:Destroy()
		end
	end

	for iter_79_2, iter_79_3 in ipairs(self._tempEmittersList) do
		for iter_79_4, iter_79_5 in ipairs(iter_79_3) do
			iter_79_5:Destroy()
		end
	end

	for iter_79_6, iter_79_7 in ipairs(self._dumpedEmittersList) do
		for iter_79_8, iter_79_9 in ipairs(iter_79_7) do
			iter_79_9:Destroy()
		end
	end

	if self._currentState ~= self.STATE_OVER_HEAT then
		self._currentState = self.STATE_DISABLE
	end

	return
end

function BattleWeaponUnit:Dispose()
	var_0_0.EventDispatcher.DetachEventDispatcher(self)
	self:RemovePrecastTimer()

	self._dataProxy = nil

	return
end

function BattleWeaponUnit:AddCDTimer(arg_81_1)
	self._currentState = self.STATE_OVER_HEAT
	self._CDstartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	self._reloadRequire = arg_81_1

	return
end

function BattleWeaponUnit:GetCDStartTimeStamp()
	return self._CDstartTime
end

function BattleWeaponUnit:handleCoolDown()
	self._currentState = self.STATE_READY
	self._CDstartTime = nil
	self._jammingTime = 0

	return
end

function BattleWeaponUnit:OverHeat()
	self._currentState = self.STATE_OVER_HEAT

	return
end

function BattleWeaponUnit:RemovePrecastTimer()
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._precastTimer)
	self._host:SetWeaponPreCastBound(false)

	self._precastArmor = nil
	self._precastTimer = nil

	return
end

function BattleWeaponUnit:AddPreCastTimer()
	self._precastTimer = pg.TimeMgr.GetInstance():AddBattleTimer("weaponPrecastTimer", 0, self._preCastInfo.time, function()
		self._currentState = self.STATE_PRECAST_FINISH

		self:RemovePrecastTimer()
		self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.WEAPON_PRE_CAST_FINISH, self._preCastInfo)))
		self:TriggerBuffWhenPrecastFinish(var_0_1.BuffEffectType.ON_WEAPON_SUCCESS)
		self:Tracking()

		return
	end, true)

	return
end

function BattleWeaponUnit:Spawn(arg_88_1, arg_88_2)
	local var_88_1 = self._dataProxy:CreateBulletUnit(arg_88_1, self._host, self, self._tmpData.search_type == var_0_5.STRIKE and self._host:GetStrikePoint() or arg_88_2 == nil and Vector3.zero or arg_88_2:GetBeenAimedPosition() or arg_88_2:GetPosition())

	self:setBulletSkin(var_88_1, arg_88_1)
	self:setBulletOrb(var_88_1)
	self:TriggerBuffWhenSpawn(var_88_1)

	return var_88_1
end

function BattleWeaponUnit:FixAmmo(arg_89_1)
	self._fixedAmmo = arg_89_1

	return
end

function BattleWeaponUnit:GetFixAmmo()
	return self._fixedAmmo
end

function BattleWeaponUnit:ShiftBullet(arg_91_1)
	local var_91_0 = {}

	for iter_91_0 = 1, #self._bulletList do
		var_91_0[iter_91_0] = arg_91_1
	end

	self._bulletList = var_91_0

	return
end

function BattleWeaponUnit:RevertBullet()
	self._bulletList = self._tmpData.bullet_ID

	return
end

function BattleWeaponUnit:cacheBulletID()
	self._emitBulletIDList = self._bulletList

	return
end

function BattleWeaponUnit:setBulletOrb(arg_94_1)
	if not self._orbID then
		return
	end

	arg_94_1:AppendAttachBuff({
		buff_id = self._orbID,
		rant = self._orbRant,
		level = self._orbLevel
	})

	return
end

function BattleWeaponUnit:SetBulletOrbData(arg_95_1)
	self._orbID = arg_95_1.buffID
	self._orbRant = arg_95_1.rant
	self._orbLevel = arg_95_1.level

	return
end

function BattleWeaponUnit:ShiftBarrage(arg_96_1)
	for iter_96_0, iter_96_1 in ipairs(self._majorEmitterList) do
		table.insert(self._dumpedEmittersList, iter_96_1)
	end

	self._majorEmitterList = {}

	if type(arg_96_1) == "number" then
		local var_96_0 = {}

		for iter_96_2 = 1, #self._barrageList do
			var_96_0[iter_96_2] = arg_96_1
		end

		self._barrageList = var_96_0
	elseif type(arg_96_1) == "table" then
		self._barrageList = arg_96_1
	end

	for iter_96_3, iter_96_4 in ipairs(self._barrageList) do
		self:createMajorEmitter(iter_96_4, iter_96_3)
	end

	return
end

function BattleWeaponUnit:RevertBarrage()
	self:ShiftBarrage(self._tmpData.barrage_ID)

	return
end

function BattleWeaponUnit:GetPrimalAmmoType()
	return var_0_6.GetBulletTmpDataFromID(self._tmpData.bullet_ID[1]).ammo_type
end

function BattleWeaponUnit:TriggerBuffWhenSpawn(arg_99_1, arg_99_2)
	self._host:TriggerBuff(arg_99_2 or var_0_1.BuffEffectType.ON_BULLET_CREATE, {
		_bullet = arg_99_1,
		equipIndex = self._equipmentIndex,
		bulletTag = arg_99_1:GetExtraTag()
	})

	return
end

function BattleWeaponUnit:TriggerBuffWhenPrecastFinish(arg_100_1)
	if self._preCastInfo.armor then
		self._host:TriggerBuff(arg_100_1, {
			weaponID = self._tmpData.id
		})
	end

	return
end

function BattleWeaponUnit:DispatchBulletEvent(arg_101_1, arg_101_2)
	local var_101_0 = arg_101_2
	local var_101_1

	if self._fireFXFlag ~= 0 then
		var_101_1 = self._skinFireFX or self._tmpData.fire_fx

		if self._fireFXFlag ~= -1 then
			self._fireFXFlag = self._fireFXFlag - 1
		end
	end

	if type(self._tmpData.spawn_bound) == "table" and not var_101_0 then
		local var_101_2 = self._dataProxy:GetStageInfo().mainUnitPosition

		var_101_0 = var_101_2 and var_101_2[self._hostIFF] and Clone(var_101_2[self._hostIFF][self._tmpData.spawn_bound[1]]) or Clone(var_0_2.MAIN_UNIT_POS[self._hostIFF][self._tmpData.spawn_bound[1]])
	end

	self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CREATE_BULLET, {
		spawnBound = self._tmpData.spawn_bound,
		bullet = arg_101_1,
		fireFxID = var_101_1,
		position = var_101_0
	})))

	return
end

function BattleWeaponUnit:DispatchFireEvent(arg_102_1, arg_102_2)
	self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.FIRE, {
		target = arg_102_1,
		actionIndex = arg_102_2
	})))

	return
end

function BattleWeaponUnit:CheckAndShake()
	if self._tmpData.shakescreen ~= 0 then
		var_0_0.Battle.BattleCameraUtil.GetInstance():StartShake(pg.shake_template[self._tmpData.shakescreen])
	end

	return
end

function BattleWeaponUnit:GetBaseAngle()
	return self._baseAngle
end

function BattleWeaponUnit:GetHost()
	return self._host
end

function BattleWeaponUnit:GetStandHost()
	return self._standHost
end

function BattleWeaponUnit:GetPosition()
	return self._hostPos
end

function BattleWeaponUnit:GetDirection()
	return self._host:GetDirection()
end

function BattleWeaponUnit:GetCurrentState()
	return self._currentState
end

function BattleWeaponUnit:GetReloadTime()
	local var_110_0 = var_0_7.GetCurrent(self._host, "loadSpeed")

	if self._reloadMax ~= self._cacheReloadMax or var_110_0 ~= self._cacheHostReload then
		self._cacheReloadMax = self._reloadMax
		self._cacheHostReload = var_110_0
		self._cacheReloadTime = var_0_3.CalculateReloadTime(self._reloadMax, var_0_7.GetCurrent(self._host, "loadSpeed"))
	end

	return self._cacheReloadTime
end

function BattleWeaponUnit:GetReloadTimeByRate(arg_111_1)
	return (var_0_3.CalculateReloadTime(self._cacheReloadMax * arg_111_1, (var_0_7.GetCurrent(self._host, "loadSpeed"))))
end

function BattleWeaponUnit:GetReloadFinishTimeStamp()
	local var_112_0 = 0

	for iter_112_0, iter_112_1 in ipairs(self._reloadBoostList) do
		var_112_0 = var_112_0 + iter_112_1
	end

	return self._reloadRequire + self._CDstartTime + self._jammingTime + var_112_0
end

function BattleWeaponUnit:AppendFactor(arg_113_1)
	return
end

function BattleWeaponUnit:StartJamming()
	if self._currentState ~= BattleWeaponUnit.STATE_READY then
		self._jammingStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	end

	return
end

function BattleWeaponUnit:JammingEliminate()
	if not self._jammingStartTime then
		return
	end

	self._jammingTime = pg.TimeMgr.GetInstance():GetCombatTime() - self._jammingStartTime
	self._jammingStartTime = nil

	return
end

function BattleWeaponUnit:FlushReloadMax(arg_116_1)
	arg_116_1 = arg_116_1 or 1
	self._reloadMax = self._tmpData.reload_max * arg_116_1

	if not self._CDstartTime or self._reloadRequire == 0 then
		return true
	end

	self._reloadRequire = BattleWeaponUnit:FlushRequireByInverse((var_0_7.GetCurrent(self._host, "loadSpeed")))

	return
end

function BattleWeaponUnit:AppendReloadFactor(arg_117_1, arg_117_2)
	self._reloadFacotrList[arg_117_1] = arg_117_2

	return
end

function BattleWeaponUnit:RemoveReloadFactor(arg_118_1)
	if self._reloadFacotrList[arg_118_1] then
		self._reloadFacotrList[arg_118_1] = nil
	end

	return
end

function BattleWeaponUnit:GetReloadFactorList()
	return self._reloadFacotrList
end

function BattleWeaponUnit:FlushReloadRequire()
	if not self._CDstartTime or self._reloadRequire == 0 then
		return true
	end

	self._reloadRequire = BattleWeaponUnit:FlushRequireByInverse((var_0_3.CaclulateReloadAttr(self._reloadMax, self._reloadRequire)))

	return
end

function BattleWeaponUnit:GetMinimumRange()
	return self._minRangeSqr
end

function BattleWeaponUnit:GetCorrectedDMG()
	return self._correctedDMG
end

function BattleWeaponUnit:GetConvertedAtkAttr()
	return self._convertedAtkAttr
end

function BattleWeaponUnit:SetAtkAttrTrasnform(arg_124_1, arg_124_2, arg_124_3)
	self._atkAttrTrans = arg_124_1
	self._atkAttrTransA = arg_124_2
	self._atkAttrTransB = arg_124_3

	return
end

function BattleWeaponUnit:GetAtkAttrTrasnform(arg_125_1)
	return (self._atkAttrTrans or nil) and math.min((arg_125_1[self._atkAttrTrans] or 0) / self._atkAttrTransA, self._atkAttrTransB)
end

function BattleWeaponUnit:IsReady()
	return self._currentState == self.STATE_READY
end

function BattleWeaponUnit:FlushRequireByInverse(arg_127_1)
	local var_127_0 = pg.TimeMgr.GetInstance():GetCombatTime() - self._CDstartTime

	return var_127_0 + var_0_3.CalculateReloadTime(self._reloadMax - var_0_3.CaclulateReloaded(var_127_0, arg_127_1), var_0_7.GetCurrent(self._host, "loadSpeed"))
end

function BattleWeaponUnit:SetSupportWeapon()
	self._isSupportWeapon = true

	return
end

function BattleWeaponUnit:SetCardPuzzleDamageEnhance(arg_129_1)
	self._cardPuzzleEnhance = arg_129_1

	return
end

function BattleWeaponUnit:GetCardPuzzleDamageEnhance()
	return self._cardPuzzleEnhance or 1
end

function BattleWeaponUnit:GetReloadRate()
	if self._currentState == self.STATE_READY then
		return 0
	elseif self._CDstartTime then
		return (self:GetReloadFinishTimeStamp() - pg.TimeMgr.GetInstance():GetCombatTime()) / self._reloadRequire
	else
		return 1
	end

	return
end

function BattleWeaponUnit:WeaponStatistics(arg_132_1, arg_132_2, arg_132_3)
	self._CLDCount = self._CLDCount + 1
	self._damageSum = arg_132_1 + self._damageSum

	if arg_132_2 then
		self._CTSum = self._CTSum + 1
	end

	if not arg_132_3 then
		self._ACCSum = self._ACCSum + 1
	end

	return
end

function BattleWeaponUnit:GetDamageSUM()
	return self._damageSum
end

function BattleWeaponUnit:GetCTRate()
	return self._CTSum / self._CLDCount
end

function BattleWeaponUnit:GetACCRate()
	return self._ACCSum / self._CLDCount
end

return
