ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleFormulas
local var_0_3 = ys.Battle.BattleConst
local var_0_4 = ys.Battle.BattleConfig
local var_0_5 = ys.Battle.BattleDataFunction
local var_0_8 = ys.Battle.BattleConst.WeaponSearchType
local var_0_9 = ys.Battle.BattleConst.WeaponSuppressType
local BattleFleetRangeAntiAirUnit = class("BattleFleetRangeAntiAirUnit", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleFleetRangeAntiAirUnit = BattleFleetRangeAntiAirUnit
BattleFleetRangeAntiAirUnit.__name = "BattleFleetRangeAntiAirUnit"

function BattleFleetRangeAntiAirUnit:Ctor()
	BattleFleetRangeAntiAirUnit.super.Ctor(self)

	self._currentState = BattleFleetRangeAntiAirUnit.STATE_DISABLE

	self:init()

	return
end

function BattleFleetRangeAntiAirUnit:init()
	self._crewUnitList = {}
	self._hitFXResIDList = {}
	self._range = 0
	self._majorEmitterList = {}
	self._GCD = 0.5
	self._tmpData = {}
	self._tmpData.bullet_ID = {
		var_0_4.AntiAirConfig.RangeBulletID
	}
	self._tmpData.barrage_ID = {
		var_0_4.AntiAirConfig.RangeBarrageID
	}
	self._tmpData.aim_type = var_0_3.WeaponAimType.AIM
	self._tmpData.axis_angle = 0
	self._tmpData.search_type = var_0_8.SECTOR
	self._tmpData.suppress = var_0_9.NONE
	self._tmpData.queue = 0
	self._tmpData.action_index = ""
	self._tmpData.fire_sfx = "battle/cannon-air"
	self._tmpData.spawn_bound = var_0_4.AntiAirConfig.RangeAntiAirBone
	self._tmpData.shakescreen = 0
	self._tmpData.fire_fx_loop_type = 0
	self._tmpData.attack_attribute = var_0_3.WeaponDamageAttr.AIR
	self._tmpData.attack_attribute_ratio = 100
	self._tmpData.expose = 0
	self._fireFXFlag = self._tmpData.fire_fx_loop_type
	self._preCastInfo = {}
	self._convertedBulletVelocity = var_0_2.ConvertBulletSpeed(var_0_5.GetBulletTmpDataFromID(self._tmpData.bullet_ID[1]).velocity)
	self._bulletList = self._tmpData.bullet_ID

	self:ShiftBarrage(self._tmpData.barrage_ID)

	return
end

function BattleFleetRangeAntiAirUnit:AppendCrewUnit(arg_3_1)
	local var_3_0 = arg_3_1:GetFleetRangeAntiAirList()

	if #var_3_0 > 0 then
		self._currentState = BattleFleetRangeAntiAirUnit.STATE_READY
		self._crewUnitList[arg_3_1] = var_3_0

		self:flush()
	end

	return
end

function BattleFleetRangeAntiAirUnit:RemoveCrewUnit(arg_4_1)
	if self._crewUnitList[arg_4_1] then
		if arg_4_1 == self._host then
			self._host:DetachFleetRangeAAWeapon()
		end

		self._crewUnitList[arg_4_1] = nil

		self:flush()
	end

	return
end

function BattleFleetRangeAntiAirUnit:FlushCrewUnit(arg_5_1)
	local var_5_0 = arg_5_1:GetFleetRangeAntiAirList()

	if #var_5_0 <= 0 then
		self:RemoveCrewUnit(arg_5_1)
	elseif self._crewUnitList[arg_5_1] == nil then
		self:AppendCrewUnit(arg_5_1)
	else
		self._crewUnitList[arg_5_1] = var_5_0

		self:flush()
	end

	return
end

function BattleFleetRangeAntiAirUnit:Spawn(arg_6_1, arg_6_2)
	local var_6_1 = self._dataProxy:CreateBulletUnit(arg_6_1, self._host, self, (self:getAimPoint(arg_6_2)))

	self:setBulletSkin(var_6_1, arg_6_1)
	self:TriggerBuffWhenSpawn(var_6_1)

	return var_6_1
end

function BattleFleetRangeAntiAirUnit:getAimPoint(arg_7_1)
	local var_7_0

	if target then
		local var_7_1 = arg_7_1:GetPosition()

		var_7_0 = Vector3(var_7_1.x + self._aimOffset, 0, var_7_1.z)
	else
		local var_7_2 = self:GetHost():GetPosition()

		var_7_0 = Vector3(var_7_2.x + self._maxRangeSqr * self._hostIFF + self._aimOffset, 0, var_7_2.z)
	end

	return var_7_0
end

function BattleFleetRangeAntiAirUnit:GetCrewUnitList()
	return self._crewUnitList
end

function BattleFleetRangeAntiAirUnit:GetRange()
	return self._range
end

function BattleFleetRangeAntiAirUnit:GetAttackAngle()
	return self._aimAngle
end

function BattleFleetRangeAntiAirUnit:GetReloadTime()
	return self._interval
end

function BattleFleetRangeAntiAirUnit:flush()
	self._range = 0
	self._interval = 0
	self._aimAngle = 0
	self._aimOffset = 0
	self._maxRangeSqr = 0
	self._minRangeSqr = 0
	self._hitFXResIDList = {}
	self._SFXID = nil
	self._exploRange = 0

	local var_12_0 = {}
	local var_12_1 = 0

	for iter_12_0, iter_12_1 in pairs(self._crewUnitList) do
		for iter_12_2, iter_12_3 in ipairs(iter_12_1) do
			var_12_1 = var_12_1 + 1
			self._interval = self._interval + iter_12_3:GetReloadTime()

			local var_12_2 = iter_12_3:GetTemplateData()

			self._range = self._range + var_12_2.range
			self._SFXID = var_12_2.fire_sfx
			self._aimAngle = self._aimAngle + iter_12_3:GetAttackAngle()
			self._maxRangeSqr = self._maxRangeSqr + iter_12_3:GetWeaponMaxRange()
			self._minRangeSqr = self._minRangeSqr + iter_12_3:GetWeaponMinRange()

			local var_12_3 = var_0_5.GetBulletTmpDataFromID(iter_12_3:GetTemplateData().bullet_ID[1])

			self._hitFXResIDList[iter_12_3] = var_12_3.hit_fx
			self._exploRange = self._exploRange + var_12_3.hit_type.range
			self._aimOffset = self._aimOffset + (var_12_3.extra_param.aim_offset or 0)
		end

		var_12_0[#var_12_0 + 1] = {
			weight = var_0_2.AntiAirPowerWeight((iter_12_0:GetAttrByName("antiAirPower"))),
			rst = iter_12_0
		}
	end

	if var_12_1 == 0 then
		self._currentState = BattleFleetRangeAntiAirUnit.STATE_DISABLE
	else
		self:SwitchHost()

		self._maxRangeSqr = self._maxRangeSqr / var_12_1
		self._minRangeSqr = self._minRangeSqr / var_12_1
		self._exploRange = self._exploRange / var_12_1
		self._aimAngle = self._aimAngle / var_12_1
		self._aimOffset = self._aimOffset / var_12_1 * self._host:GetIFF()
		self._interval = self._interval / var_12_1 + 0.5
		self._weightList, self._totalWeight = var_0_2.GenerateWeightList(var_12_0)
	end

	return
end

function BattleFleetRangeAntiAirUnit:DoAreaSplit(arg_13_1)
	for iter_13_0, iter_13_1 in pairs(self._crewUnitList) do
		iter_13_0:TriggerBuff(var_0_3.BuffEffectType.ON_ANTIAIR_FIRE_FAR, {})
		iter_13_0:PlayFX(iter_13_1[1]:GetTemplateData().fire_fx, true)
	end

	for iter_13_2, iter_13_3 in pairs(self._hitFXResIDList) do
		pg.EffectMgr.GetInstance():PlayBattleEffect(var_0_0.Battle.BattleFXPool.GetInstance():GetFX(iter_13_3), arg_13_1:GetPosition() + Vector3((math.random() * 2 - 1) * self._exploRange, 10, (math.random() * 2 - 1) * self._exploRange), true)
	end

	self._dataProxy:SpawnColumnArea(var_0_3.BulletField.AIR, arg_13_1:GetIFF(), arg_13_1:GetPosition(), self._exploRange, -1, function(arg_14_0)
		local var_14_0 = {}
		local var_14_1 = self._dataProxy:GetAircraftList()

		for iter_14_0, iter_14_1 in ipairs(arg_14_0) do
			if iter_14_1.Active then
				if var_14_1[iter_14_1.UID] and var_14_1[iter_14_1.UID]:IsVisitable() then
					var_14_0[#var_14_0 + 1] = var_14_1[iter_14_1.UID]
				end
			end
		end

		local var_14_2 = var_0_2.CalculateFleetAntiAirTotalDamage(self)
		local var_14_3 = var_0_2.GetMeteoDamageRatio(#var_14_0)

		for iter_14_2, iter_14_3 in ipairs(var_14_0) do
			self._dataProxy:HandleDirectDamage(iter_14_3, math.max(1, math.floor(var_14_2 * var_14_3[iter_14_2])), (var_0_2.WeightListRandom(self._weightList, self._totalWeight)))
		end

		return
	end)

	if RANGE_ANTI_AREA then
		local var_13_0 = var_0_0.Battle.BattleFXPool.GetInstance():GetFX("AlertArea")

		var_13_0.transform.localScale = Vector3(self._exploRange, 1, self._exploRange)

		pg.EffectMgr.GetInstance():PlayBattleEffect(var_13_0, arg_13_1:GetPosition())
	end

	self._dataProxy:RemoveBulletUnit(arg_13_1:GetUniqueID())

	return
end

function BattleFleetRangeAntiAirUnit:SwitchHost()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(self._crewUnitList) do
		table.insert(var_15_0, iter_15_0)
	end

	table.sort(var_15_0, function(arg_16_0, arg_16_1)
		return arg_16_0:GetMainUnitIndex() < arg_16_1:GetMainUnitIndex()
	end)

	if self._host == var_15_0[1] then
		return
	end

	self:SetHostData(var_15_0[1])
	self._host:AttachFleetRangeAAWeapon(self)

	return
end

function BattleFleetRangeAntiAirUnit:GetFilteredList()
	return (self:FilterAngle((self:FilterRange((self:FilterTarget())))))
end

function BattleFleetRangeAntiAirUnit:FilterTarget()
	local var_18_0 = {}
	local var_18_1 = self._host:GetIFF()

	for iter_18_0, iter_18_1 in pairs((self._dataProxy:GetAircraftList())) do
		if iter_18_1:GetIFF() ~= var_18_1 and iter_18_1:IsVisitable() then
			var_18_0[1] = iter_18_1
		end
	end

	return var_18_0
end

function BattleFleetRangeAntiAirUnit:Update()
	if self._currentState ~= BattleFleetRangeAntiAirUnit.STATE_DISABLE then
		BattleFleetRangeAntiAirUnit.super.Update(self)
	end

	return
end

function BattleFleetRangeAntiAirUnit:RemovePrecastTimer()
	return
end

function BattleFleetRangeAntiAirUnit:Dispose()
	BattleFleetRangeAntiAirUnit.super.Dispose(self)

	self._crewUnitList = nil
	self._weightList = nil
	self._hitFXResIDList = nil
	self._SFXID = nil

	return
end

return
