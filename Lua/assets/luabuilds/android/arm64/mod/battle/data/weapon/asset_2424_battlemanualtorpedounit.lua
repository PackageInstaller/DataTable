ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local BattleManualTorpedoUnit = class("BattleManualTorpedoUnit", ys.Battle.BattleTorpedoUnit)

ys.Battle.BattleManualTorpedoUnit = BattleManualTorpedoUnit
BattleManualTorpedoUnit.__name = "BattleManualTorpedoUnit"

function BattleManualTorpedoUnit:Ctor()
	BattleManualTorpedoUnit.super.Ctor(self)

	return
end

function BattleManualTorpedoUnit:createMajorEmitter(arg_2_1, arg_2_2)
	BattleManualTorpedoUnit.super.createMajorEmitter(self, arg_2_1, arg_2_2, nil, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = self:Spawn(self._emitBulletIDList[arg_2_2], nil, BattleManualTorpedoUnit.INTERNAL)

		var_3_0:SetOffsetPriority(arg_3_3)
		var_3_0:SetShiftInfo(arg_3_0, arg_3_1)
		var_3_0:SetRotateInfo(nil, self._botAutoAimAngle, arg_3_2)
		self:DispatchBulletEvent(var_3_0)

		return var_3_0
	end, function()
		return
	end)

	return
end

function BattleManualTorpedoUnit:Update()
	self:UpdateReload()

	return
end

function BattleManualTorpedoUnit:SetPlayerTorpedoWeaponVO(arg_6_1)
	self._playerTorpedoVO = arg_6_1

	return
end

function BattleManualTorpedoUnit:TriggerBuffOnReady()
	self._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_MANUAL_TORPEDO_READY, {})

	return
end

function BattleManualTorpedoUnit:Fire(arg_8_1)
	if arg_8_1 then
		self:updateMovementInfo()

		local var_8_0 = var_0_0.Battle.BattleTargetChoise.TargetHarmRandomByWeight(self._host, nil, self:GetFilteredList())[1]

		if var_8_0 then
			local var_8_1 = var_8_0:GetPosition()
			local var_8_2 = self._host:GetPosition()

			self._botAutoAimAngle = math.rad2Deg * math.atan2(var_8_1.z - var_8_2.z, var_8_1.x - var_8_2.x)
		else
			self._botAutoAimAngle = self:GetBaseAngle()
		end
	else
		self._botAutoAimAngle = self:GetBaseAngle()
	end

	return BattleManualTorpedoUnit.super.Fire(self)
end

function BattleManualTorpedoUnit:DoAttack()
	self:DispatchEvent(var_0_0.Event.New(var_0_1.TORPEDO_WEAPON_FIRE, {}))
	BattleManualTorpedoUnit.super.DoAttack(self)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.MANUAL_WEAPON_FIRE, {}))

	return
end

function BattleManualTorpedoUnit:InitialCD()
	BattleManualTorpedoUnit.super.InitialCD(self)
	self._playerTorpedoVO:InitialDeduct(self)
	self._playerTorpedoVO:Charge(self)

	return
end

function BattleManualTorpedoUnit:EnterCoolDown()
	BattleManualTorpedoUnit.super.EnterCoolDown(self)
	self._playerTorpedoVO:Charge(self)

	return
end

function BattleManualTorpedoUnit:OverHeat()
	BattleManualTorpedoUnit.super.OverHeat(self)
	self._playerTorpedoVO:Deduct(self)

	return
end

function BattleManualTorpedoUnit:Cease()
	if self._currentState == BattleManualTorpedoUnit.STATE_OVER_HEAT then
		self:interruptAllEmitter()
	end

	return
end

function BattleManualTorpedoUnit:handleCoolDown()
	self._currentState = self.STATE_READY

	self._playerTorpedoVO:Plus(self)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.TORPEDO_WEAPON_READY, {}))
	self:DispatchEvent(var_0_0.Event.New(var_0_1.MANUAL_WEAPON_READY, {}))
	self:TriggerBuffOnReady()

	self._CDstartTime = nil
	self._reloadBoostList = {}

	return
end

function BattleManualTorpedoUnit:FlushReloadMax(arg_15_1)
	if BattleManualTorpedoUnit.super.FlushReloadMax(self, arg_15_1) then
		return true
	end

	self._playerTorpedoVO:RefreshReloadingBar()

	return
end

function BattleManualTorpedoUnit:FlushReloadRequire()
	if BattleManualTorpedoUnit.super.FlushReloadRequire(self) then
		return true
	end

	self._playerTorpedoVO:RefreshReloadingBar()

	return
end

function BattleManualTorpedoUnit:QuickCoolDown()
	if self._currentState == self.STATE_OVER_HEAT then
		self._currentState = self.STATE_READY

		self._playerTorpedoVO:InstantCoolDown(self)
		self:DispatchEvent(var_0_0.Event.New(var_0_1.MANUAL_WEAPON_INSTANT_READY, {}))

		self._CDstartTime = nil
		self._reloadBoostList = {}
	end

	return
end

function BattleManualTorpedoUnit:Prepar()
	if self._host:IsCease() then
		return false
	else
		self._currentState = self.STATE_PRECAST

		self:DispatchEvent((var_0_0.Event.New(var_0_1.TORPEDO_WEAPON_PREPAR, {})))

		return true
	end

	return
end

function BattleManualTorpedoUnit:Cancel()
	self._currentState = self.STATE_READY

	self:DispatchEvent((var_0_0.Event.New(var_0_1.TORPEDO_WEAPON_CANCEL, {})))

	return
end

function BattleManualTorpedoUnit:ReloadBoost(arg_20_1)
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in ipairs(self._reloadBoostList) do
		var_20_0 = var_20_0 + iter_20_1
	end

	local var_20_1 = var_20_0 + arg_20_1

	fixValue = (var_20_0 + arg_20_1 < 0 and math.max(var_20_1, (self._reloadRequire - (pg.TimeMgr.GetInstance():GetCombatTime() - self._jammingTime - self._CDstartTime)) * -1) or math.min(var_20_1, pg.TimeMgr.GetInstance():GetCombatTime() - self._jammingTime - self._CDstartTime)) - var_20_1 + arg_20_1

	table.insert(self._reloadBoostList, fixValue)

	return
end

function BattleManualTorpedoUnit:AppendReloadBoost(arg_21_1)
	if self._currentState == self.STATE_OVER_HEAT then
		self._playerTorpedoVO:ReloadBoost(self, arg_21_1)
	end

	return
end

return
