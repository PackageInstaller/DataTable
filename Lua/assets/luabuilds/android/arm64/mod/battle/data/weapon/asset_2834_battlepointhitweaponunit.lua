ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleUnitEvent
local BattlePointHitWeaponUnit = class("BattlePointHitWeaponUnit", ys.Battle.BattleWeaponUnit)

ys.Battle.BattlePointHitWeaponUnit = BattlePointHitWeaponUnit
BattlePointHitWeaponUnit.__name = "BattlePointHitWeaponUnit"

function BattlePointHitWeaponUnit:Ctor()
	BattlePointHitWeaponUnit.super.Ctor(self)

	BattlePointHitWeaponUnit._strikePoint = nil
	BattlePointHitWeaponUnit._strikeRequire = 1
	BattlePointHitWeaponUnit._strikeMode = false

	return
end

function BattlePointHitWeaponUnit:DispatchBlink(arg_2_1)
	self:DispatchEvent((var_0_0.Event.New(var_0_2.CHARGE_WEAPON_FINISH, {
		callbackFunc = arg_2_1,
		timeScale = var_0_0.Battle.BattleConfig.FOCUS_MAP_RATE
	})))

	return
end

function BattlePointHitWeaponUnit:RemoveAllLock()
	self._lockList = {}

	return
end

function BattlePointHitWeaponUnit:createMajorEmitter(arg_4_1, arg_4_2)
	BattlePointHitWeaponUnit.super.createMajorEmitter(self, arg_4_1, arg_4_2, BattlePointHitWeaponUnit.EMITTER_NORMAL, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0
		local var_5_1

		if self._strikePoint then
			var_5_1 = self._strikePoint
			var_5_0 = self:SpawnPointBullet(self._emitBulletIDList[arg_4_2], self._strikePoint)
		else
			local var_5_2 = self._lockList[1]

			var_5_0 = self:Spawn(self._emitBulletIDList[arg_4_2], self._lockList[1], self.INTERNAL)
			var_5_1 = self._lockList[1]:GetBeenAimedPosition() or var_5_2:GetPosition()
		end

		var_5_0:SetOffsetPriority(arg_5_3)
		var_5_0:SetShiftInfo(arg_5_0, arg_5_1)
		var_5_0:SetRotateInfo(var_5_1, 0, 0)
		var_0_0.Battle.BattleVariable.AddExempt(var_5_0:GetSpeedExemptKey(), var_5_0:GetIFF(), var_0_0.Battle.BattleConfig.SPEED_FACTOR_FOCUS_CHARACTER)
		self:DispatchBulletEvent(var_5_0)

		return
	end, function()
		self._strikePoint = nil

		self:RemoveAllLock()

		return
	end)

	return
end

function BattlePointHitWeaponUnit:SetPlayerChargeWeaponVO(arg_7_1)
	self._playerChargeWeaponVo = arg_7_1

	return
end

function BattlePointHitWeaponUnit:Charge()
	self._currentState = self.STATE_PRECAST
	self._lockList = {}

	self:DispatchEvent((var_0_0.Event.New(var_0_2.POINT_HIT_CHARGE, {})))

	self._strikeMode = true

	return
end

function BattlePointHitWeaponUnit:CancelCharge()
	if self._currentState ~= self.STATE_PRECAST then
		return
	end

	self:RemoveAllLock()

	self._currentState = self.STATE_READY

	self:DispatchEvent((var_0_0.Event.New(var_0_2.POINT_HIT_CANCEL, {})))

	self._strikeMode = nil

	return
end

function BattlePointHitWeaponUnit:QuickTag()
	self._currentState = self.STATE_PRECAST
	self._lockList = {}

	self:updateMovementInfo()

	self._lockList[#self._lockList + 1] = self:Tracking()

	return
end

function BattlePointHitWeaponUnit:CancelQuickTag()
	self._currentState = self.STATE_READY
	self._lockList = {}

	return
end

function BattlePointHitWeaponUnit:Update(arg_12_1)
	self:UpdateReload()

	return
end

function BattlePointHitWeaponUnit:Fire(arg_13_1)
	if self._host:IsCease() then
		self:CancelQuickTag()

		return false
	end

	if self._currentState ~= self.STATE_PRECAST then
		return
	end

	self._strikePoint = arg_13_1

	self._host:CloakExpose(var_0_0.Battle.BattleConfig.CLOAK_BOMBARD_BASE_EXPOSE)
	self._host:BombardExpose()

	self._strikeMode = false

	return BattlePointHitWeaponUnit.super.Fire(self)
end

function BattlePointHitWeaponUnit:DoAttack(arg_14_1)
	var_0_0.Battle.PlayBattleSFX(self._tmpData.fire_sfx)
	self:DispatchEvent((var_0_0.Event.New(var_0_2.CHARGE_WEAPON_FIRE, {
		weapon = self
	})))
	self:cacheBulletID()
	self:TriggerBuffOnSteday()

	for iter_14_0, iter_14_1 in ipairs(self._majorEmitterList) do
		iter_14_1:Ready()
	end

	for iter_14_2, iter_14_3 in ipairs(self._majorEmitterList) do
		iter_14_3:Fire(arg_14_1, self:GetDirection(), self:GetAttackAngle())
		iter_14_3:SetTimeScale(false)
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_2.MANUAL_WEAPON_FIRE, {}))
	self:TriggerBuffOnFire()
	var_0_0.Battle.BattleCameraUtil.GetInstance():StartShake(pg.shake_template[var_0_1.ShakeType.FIRE])

	return
end

function BattlePointHitWeaponUnit:TriggerBuffOnReady()
	if self._tmpData.type == var_0_1.EquipmentType.MANUAL_MISSILE then
		self._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_MANUAL_MISSILE_READY, {})
	else
		self._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_CHARGE_READY, {})
	end

	return
end

function BattlePointHitWeaponUnit:Spawn(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0

	if arg_16_2 == nil then
		self:updateMovementInfo()

		arg_16_2 = self:TrackingRandom(self:GetFilteredList())
		var_16_0 = arg_16_2 == nil and Vector3.zero or arg_16_2:GetBeenAimedPosition() or arg_16_2:GetPosition()
	else
		var_16_0 = arg_16_2:GetBeenAimedPosition() or arg_16_2:GetPosition()
	end

	local var_16_1 = self._dataProxy:CreateBulletUnit(arg_16_1, self._host, self, var_16_0)

	self:setBulletSkin(var_16_1, arg_16_1)
	self:TriggerBuffWhenSpawn(var_16_1)

	if arg_16_3 == self.INTERNAL then
		var_16_1:SetDamageEnhance(1 + self._host:GetAttrByName("initialEnhancement"))
		self:TriggerBuffWhenSpawn(var_16_1, var_0_1.BuffEffectType.ON_INTERNAL_BULLET_CREATE)
	end

	return var_16_1
end

function BattlePointHitWeaponUnit:SpawnPointBullet(arg_17_1, arg_17_2)
	local var_17_0 = self._dataProxy:CreateBulletUnit(arg_17_1, self._host, self, arg_17_2)

	self:TriggerBuffWhenSpawn(var_17_0, var_0_1.BuffEffectType.ON_MANUAL_BULLET_CREATE)
	self:setBulletSkin(var_17_0, arg_17_1)
	var_17_0:SetDamageEnhance(var_0_0.Battle.BattleConfig.ChargeWeaponConfig.Enhance + (self._host:GetAttrByName("initialEnhancement") + self._host:GetAttrByName("manualEnhancement")))
	self:TriggerBuffWhenSpawn(var_17_0)
	self:TriggerBuffWhenSpawn(var_17_0, var_0_1.BuffEffectType.ON_INTERNAL_BULLET_CREATE)

	return var_17_0
end

function BattlePointHitWeaponUnit:TriggerBuffOnFire()
	if self._tmpData.type == var_0_1.EquipmentType.MANUAL_MISSILE then
		self._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_MANUAL_MISSILE_FIRE, {})
	else
		self._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_CHARGE_FIRE, {})
	end

	return
end

function BattlePointHitWeaponUnit:InitialCD()
	BattlePointHitWeaponUnit.super.InitialCD(self)
	self._playerChargeWeaponVo:InitialDeduct(self)
	self._playerChargeWeaponVo:Charge(self)

	return
end

function BattlePointHitWeaponUnit:EnterCoolDown()
	BattlePointHitWeaponUnit.super.EnterCoolDown(self)
	self._playerChargeWeaponVo:Charge(self)

	return
end

function BattlePointHitWeaponUnit:OverHeat()
	BattlePointHitWeaponUnit.super.OverHeat(self)
	self._playerChargeWeaponVo:Deduct(self)

	return
end

function BattlePointHitWeaponUnit:GetMinAngle()
	return self:GetAttackAngle()
end

function BattlePointHitWeaponUnit:GetLockList()
	return self._lockList
end

function BattlePointHitWeaponUnit:GetFilteredList()
	return (self:filterEnemyUnitType((BattlePointHitWeaponUnit.super.GetFilteredList(self))))
end

function BattlePointHitWeaponUnit:filterEnemyUnitType(arg_25_1)
	local var_25_0 = {}
	local var_25_1 = {}
	local var_25_2 = -9999

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		local var_25_3 = iter_25_1:GetTargetedPriority()

		if var_25_3 == nil then
			var_25_1[#var_25_1 + 1] = iter_25_1
		elseif var_25_2 < var_25_3 then
			var_25_2 = var_25_3
			var_25_0 = {}
			var_25_0[#var_25_0 + 1] = iter_25_1
		elseif var_25_2 == var_25_3 then
			var_25_0[#var_25_0 + 1] = iter_25_1
		end
	end

	for iter_25_2, iter_25_3 in ipairs(var_25_1) do
		var_25_0[#var_25_0 + 1] = iter_25_3
	end

	return var_25_0
end

function BattlePointHitWeaponUnit:handleCoolDown()
	self._currentState = self.STATE_READY

	self._playerChargeWeaponVo:Plus(self)
	self:DispatchEvent(var_0_0.Event.New(var_0_2.MANUAL_WEAPON_READY, {}))
	self:TriggerBuffOnReady()

	self._CDstartTime = nil
	self._reloadBoostList = {}

	return
end

function BattlePointHitWeaponUnit:FlushReloadMax(arg_27_1)
	if BattlePointHitWeaponUnit.super.FlushReloadMax(self, arg_27_1) then
		return true
	end

	self._playerChargeWeaponVo:RefreshReloadingBar()

	return
end

function BattlePointHitWeaponUnit:FlushReloadRequire()
	if BattlePointHitWeaponUnit.super.FlushReloadRequire(self) then
		return true
	end

	self._playerChargeWeaponVo:RefreshReloadingBar()

	return
end

function BattlePointHitWeaponUnit:QuickCoolDown()
	if self._currentState == self.STATE_OVER_HEAT then
		self._currentState = self.STATE_READY

		self._playerChargeWeaponVo:InstantCoolDown(self)
		self:DispatchEvent(var_0_0.Event.New(var_0_2.MANUAL_WEAPON_INSTANT_READY, {}))

		self._CDstartTime = nil
		self._reloadBoostList = {}
	end

	return
end

function BattlePointHitWeaponUnit:ReloadBoost(arg_30_1)
	local var_30_0 = 0

	for iter_30_0, iter_30_1 in ipairs(self._reloadBoostList) do
		var_30_0 = var_30_0 + iter_30_1
	end

	local var_30_1 = var_30_0 + arg_30_1

	fixValue = (var_30_0 + arg_30_1 < 0 and math.max(var_30_1, (self._reloadRequire - (pg.TimeMgr.GetInstance():GetCombatTime() - self._jammingTime - self._CDstartTime)) * -1) or math.min(var_30_1, pg.TimeMgr.GetInstance():GetCombatTime() - self._jammingTime - self._CDstartTime)) - var_30_1 + arg_30_1

	table.insert(self._reloadBoostList, fixValue)

	return
end

function BattlePointHitWeaponUnit:AppendReloadBoost(arg_31_1)
	if self._currentState == self.STATE_OVER_HEAT then
		self._playerChargeWeaponVo:ReloadBoost(self, arg_31_1)
	end

	return
end

function BattlePointHitWeaponUnit:IsStrikeMode()
	return self._strikeMode
end

return
