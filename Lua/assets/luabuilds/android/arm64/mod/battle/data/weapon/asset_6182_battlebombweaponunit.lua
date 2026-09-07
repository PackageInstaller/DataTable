ys = ys or {}

local var_0_0 = ys
local BattleBombWeaponUnit = class("BattleBombWeaponUnit", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleBombWeaponUnit = BattleBombWeaponUnit
BattleBombWeaponUnit.__name = "BattleBombWeaponUnit"

function BattleBombWeaponUnit:Ctor()
	BattleBombWeaponUnit.super.Ctor(self)

	self._alertCache = {}
	self._cacheList = {}

	return
end

function BattleBombWeaponUnit:Clear()
	if self._alertTimer then
		pg.TimeMgr.GetInstance():RemoveBattleTimer(self._alertTimer)
	end

	self._alertTimer = nil

	for iter_2_0, iter_2_1 in pairs(self._cacheList) do
		iter_2_1:Destroy()
	end

	BattleBombWeaponUnit._cacheList = nil

	BattleBombWeaponUnit.super.Clear(self)

	return
end

function BattleBombWeaponUnit:HostOnEnemy()
	BattleBombWeaponUnit.super.HostOnEnemy(self)

	if self._preCastInfo.alertTime ~= nil then
		self._showPrecastAlert = true
		self._alertTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", -1, self._preCastInfo.alertTime or 3, function()
			self._alertTimer:Stop()
			self:Fire()

			return
		end, true, true)
	end

	return
end

function BattleBombWeaponUnit:Update(arg_5_1)
	self:UpdateReload()

	if self._currentState == self.STATE_READY then
		self:updateMovementInfo()

		local var_5_0 = self:Tracking()

		if var_5_0 then
			if self._showPrecastAlert then
				self:PreCast(var_5_0)
			else
				self._currentState = self.STATE_PRECAST_FINISH
			end
		end
	end

	if self._currentState == self.STATE_PRECAST_FINISH then
		self:updateMovementInfo()

		local var_5_1 = self:Tracking()
		local var_5_2 = self:GetDirection()
		local var_5_3 = self:GetAttackAngle()

		for iter_5_0, iter_5_1 in ipairs(self._majorEmitterList) do
			iter_5_1:Ready()
		end

		for iter_5_2, iter_5_3 in ipairs(self._majorEmitterList) do
			iter_5_3:Fire(var_5_1, var_5_2, var_5_3)
		end

		BattleBombWeaponUnit.super.Fire(self, var_5_1)
	end

	return
end

function BattleBombWeaponUnit:PreCast(arg_6_1)
	self:cacheBulletID()

	for iter_6_0, iter_6_1 in ipairs(self._majorEmitterList) do
		iter_6_1:Ready()
	end

	for iter_6_2, iter_6_3 in ipairs(self._majorEmitterList) do
		iter_6_3:Fire(arg_6_1, self:GetDirection(), self:GetAttackAngle())
	end

	BattleBombWeaponUnit.super.PreCast(self)
	self._alertTimer:Start()

	return
end

function BattleBombWeaponUnit:AddPreCastTimer()
	self._precastTimer = pg.TimeMgr.GetInstance():AddBattleTimer("weaponPrecastTimer", 0, self._preCastInfo.time, function()
		self._currentState = self.STATE_OVER_HEAT

		self:RemovePrecastTimer()
		self._host:SetWeaponPreCastBound(false)
		self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.WEAPON_PRE_CAST_FINISH, self._preCastInfo)))

		return
	end, true)

	return
end

function BattleBombWeaponUnit:createMajorEmitter(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = {}
	local var_9_2 = var_0_0.Battle.BattleBulletEmitter.New(function()
		self:DispatchBulletEvent(table.remove(var_9_0, 1))

		return
	end, function()
		for iter_11_0, iter_11_1 in ipairs(self._cacheList) do
			if iter_11_1:GetState() ~= iter_11_1.STATE_STOP then
				return
			end
		end

		self:EnterCoolDown()

		return
	end, arg_9_1)

	self._cacheList[var_9_2] = var_9_2

	BattleBombWeaponUnit.super.createMajorEmitter(self, arg_9_1, arg_9_2, nil, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		local var_12_0 = self:Spawn(self._emitBulletIDList[arg_9_2], arg_12_4)

		var_12_0:SetOffsetPriority(arg_12_3)
		var_12_0:SetShiftInfo(arg_12_0, arg_12_1)

		if self._tmpData.aim_type == var_0_0.Battle.BattleConst.WeaponAimType.AIM and arg_12_4 ~= nil then
			var_12_0:SetRotateInfo(arg_12_4:GetBeenAimedPosition(), self:GetBaseAngle(), arg_12_2)
		else
			var_12_0:SetRotateInfo(nil, self:GetBaseAngle(), arg_12_2)
		end

		table.insert(var_9_0, var_12_0)
		self:showBombAlert(var_12_0)

		return
	end, function()
		return
	end)

	return
end

function BattleBombWeaponUnit:DoAttack()
	self:TriggerBuffOnSteday()

	for iter_14_0, iter_14_1 in pairs(self._cacheList) do
		iter_14_1:Ready()
	end

	for iter_14_2, iter_14_3 in pairs(self._cacheList) do
		iter_14_3:Fire(nil, self:GetDirection())
	end

	var_0_0.Battle.PlayBattleSFX(self._tmpData.fire_sfx)
	self:TriggerBuffOnFire()
	self:CheckAndShake()

	return
end

function BattleBombWeaponUnit:showBombAlert(arg_15_1)
	arg_15_1:SetExist(false)

	if arg_15_1:GetTemplate().alert_fx ~= "" then
		var_0_0.Battle.BattleBombBulletFactory.CreateBulletAlert(arg_15_1)
	end

	return
end

return
