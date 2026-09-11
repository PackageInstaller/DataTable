ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleUnitEvent
local BattlePointAirStrikeUnit = class("BattlePointAirStrikeUnit", ys.Battle.BattlePointHitWeaponUnit)

ys.Battle.BattlePointAirStrikeUnit = BattlePointAirStrikeUnit
BattlePointAirStrikeUnit.__name = "BattlePointAirStrikeUnit"

function BattlePointAirStrikeUnit:Ctor()
	BattlePointAirStrikeUnit.super.Ctor(self)

	BattlePointAirStrikeUnit._strikePoint = nil
	BattlePointAirStrikeUnit._strikeMode = false

	return
end

function BattlePointAirStrikeUnit:RemoveAllLock()
	self._lockList = {}

	return
end

function BattlePointAirStrikeUnit:Charge()
	self._currentState = self.STATE_PRECAST
	self._lockList = {}

	self:DispatchEvent((var_0_0.Event.New(var_0_2.POINT_HIT_CHARGE, {})))

	self._strikeMode = true

	return
end

function BattlePointAirStrikeUnit:CancelCharge()
	if self._currentState ~= self.STATE_PRECAST then
		return
	end

	self:RemoveAllLock()

	self._currentState = self.STATE_READY

	self:DispatchEvent((var_0_0.Event.New(var_0_2.POINT_HIT_CANCEL, {})))

	self._strikeMode = nil

	return
end

function BattlePointAirStrikeUnit:SetAirUnit(arg_5_1)
	self._hiveList = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = var_0_0.Battle.BattleDataFunction.CreateWeaponUnit(iter_5_1, self._host, nil, -1)

		self._host:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CREATE_TEMPORARY_WEAPON, {
			weapon = var_5_0
		})))
		table.insert(self._hiveList, var_5_0)
	end

	return
end

function BattlePointAirStrikeUnit:DoAttack(arg_6_1)
	var_0_0.Battle.PlayBattleSFX(self._tmpData.fire_sfx)
	self:DispatchEvent((var_0_0.Event.New(var_0_2.CHARGE_WEAPON_FIRE, {
		weapon = self
	})))
	self._host:TriggerBuff(var_0_1.BuffEffectType.ON_POINT_STRIKE_STEADY, {})

	for iter_6_0, iter_6_1 in ipairs(self._hiveList) do
		iter_6_1:SetStrikePoint(self._strikePoint or self._lockList[1]:GetPosition())
		iter_6_1:updateMovementInfo()
		iter_6_1:SingleFire()
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_2.MANUAL_WEAPON_FIRE, {}))
	self:TriggerBuffOnFire()

	self._strikePoint = nil

	self:RemoveAllLock()

	return
end

function BattlePointAirStrikeUnit:SetReloadTime(arg_7_1)
	self._reloadMax = arg_7_1

	return
end

function BattlePointAirStrikeUnit:AddCDTimer(arg_8_1)
	self._currentState = self.STATE_OVER_HEAT
	self._CDstartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	self._reloadRequire = arg_8_1

	return
end

function BattlePointAirStrikeUnit:TriggerBuffOnReady()
	self._host:TriggerBuff(var_0_1.BuffEffectType.ON_POINT_STRIKE_READY, {})

	return
end

function BattlePointAirStrikeUnit:TriggerBuffOnFire()
	self._host:TriggerBuff(var_0_1.BuffEffectType.ON_POINT_STRIKE, {})

	return
end

function BattlePointAirStrikeUnit:GetReloadFinishTimeStamp()
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(self._reloadBoostList) do
		var_11_0 = var_11_0 + iter_11_1
	end

	return self._reloadRequire + self._CDstartTime + self._jammingTime + var_11_0
end

function BattlePointAirStrikeUnit:GetLockList()
	return self._lockList
end

function BattlePointAirStrikeUnit:GetFilteredList()
	return (self:filterEnemyUnitType((BattlePointAirStrikeUnit.super.GetFilteredList(self))))
end

function BattlePointAirStrikeUnit:filterEnemyUnitType(arg_14_1)
	local var_14_0 = {}
	local var_14_1 = {}
	local var_14_2 = -9999

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		local var_14_3 = iter_14_1:GetTargetedPriority()

		if var_14_3 == nil then
			var_14_1[#var_14_1 + 1] = iter_14_1
		elseif var_14_2 < var_14_3 then
			var_14_2 = var_14_3
			var_14_0 = {}
			var_14_0[#var_14_0 + 1] = iter_14_1
		elseif var_14_2 == var_14_3 then
			var_14_0[#var_14_0 + 1] = iter_14_1
		end
	end

	for iter_14_2, iter_14_3 in ipairs(var_14_1) do
		var_14_0[#var_14_0 + 1] = iter_14_3
	end

	return var_14_0
end

function BattlePointAirStrikeUnit:handleCoolDown()
	self._currentState = self.STATE_READY

	self._playerChargeWeaponVo:Plus(self)
	self:DispatchEvent(var_0_0.Event.New(var_0_2.MANUAL_WEAPON_READY, {}))
	self:TriggerBuffOnReady()

	self._CDstartTime = nil
	self._reloadBoostList = {}

	return
end

function BattlePointAirStrikeUnit:FlushReloadMax(arg_16_1)
	if BattlePointAirStrikeUnit.super.FlushReloadMax(self, arg_16_1) then
		return true
	end

	self._playerChargeWeaponVo:RefreshReloadingBar()

	return
end

function BattlePointAirStrikeUnit:FlushReloadRequire()
	if BattlePointAirStrikeUnit.super.FlushReloadRequire(self) then
		return true
	end

	self._playerChargeWeaponVo:RefreshReloadingBar()

	return
end

function BattlePointAirStrikeUnit:QuickCoolDown()
	if self._currentState == self.STATE_OVER_HEAT then
		self._currentState = self.STATE_READY

		self._playerChargeWeaponVo:InstantCoolDown(self)
		self:DispatchEvent(var_0_0.Event.New(var_0_2.MANUAL_WEAPON_INSTANT_READY, {}))

		self._CDstartTime = nil
		self._reloadBoostList = {}
	end

	return
end

function BattlePointAirStrikeUnit:IsStrikeMode()
	return self._strikeMode
end

return
