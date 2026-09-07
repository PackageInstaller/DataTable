ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleUnitEvent
local var_0_3 = ys.Battle.BattleTargetChoise
local BattleManualAAMissileUnit = class("BattleManualAAMissileUnit", ys.Battle.BattleManualTorpedoUnit)

ys.Battle.BattleManualAAMissileUnit = BattleManualAAMissileUnit
BattleManualAAMissileUnit.__name = "BattleManualAAMissileUnit"

function BattleManualAAMissileUnit:Ctor()
	BattleManualAAMissileUnit.super.Ctor(self)

	self._strikeMode = nil
	self._strikeModeData = nil

	return
end

function BattleManualAAMissileUnit:createMajorEmitter(arg_2_1, arg_2_2, arg_2_3)
	arg_2_3 = arg_2_3 or BattleManualAAMissileUnit.EMITTER_NORMAL

	local var_2_0 = var_0_0.Battle[arg_2_3].New(function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		local var_3_0 = self:Spawn(self._emitBulletIDList[arg_2_2], arg_3_4, BattleManualAAMissileUnit.INTERNAL)

		var_3_0:SetOffsetPriority(arg_3_3)
		var_3_0:SetShiftInfo(arg_3_0, arg_3_1)

		if self._tmpData.aim_type == var_0_1.WeaponAimType.AIM and arg_3_4 ~= nil then
			var_3_0:SetRotateInfo(arg_3_4:GetBeenAimedPosition(), self:GetBaseAngle(), arg_3_2)
		else
			var_3_0:SetRotateInfo(nil, self:GetBaseAngle(), arg_3_2)
		end

		var_3_0:setTrackingTarget(arg_3_4)

		local var_3_1 = {}

		for iter_3_0, iter_3_1 in pairs(self._strikeModeData) do
			var_3_1[iter_3_0] = iter_3_1
		end

		var_3_0:SetTrackingFXData(var_3_1)
		self:DispatchBulletEvent(var_3_0)

		return var_3_0
	end, function()
		for iter_4_0, iter_4_1 in ipairs(self._majorEmitterList) do
			if iter_4_1:GetState() ~= iter_4_1.STATE_STOP then
				return
			end
		end

		self:DispatchEvent(var_0_0.Event.New(var_0_2.MANUAL_WEAPON_FIRE, {}))

		self._strikeModeData = nil

		return
	end, arg_2_1)

	self._majorEmitterList[#self._majorEmitterList + 1] = var_2_0

	return var_2_0
end

function BattleManualAAMissileUnit:IsStrikeMode()
	return self._strikeMode
end

function BattleManualAAMissileUnit:IsAttacking()
	return self._currentState == BattleManualAAMissileUnit.STATE_ATTACK
end

function BattleManualAAMissileUnit:Update()
	self:UpdateReload()

	if self:IsStrikeMode() then
		self:MarkTarget()
	end

	return
end

function BattleManualAAMissileUnit:EnterStrikeMode()
	self._strikeMode = true
	self._strikeModeData = {}
	self._strikeModeData.fxName = self._preCastInfo.fx

	self:MarkTarget()

	return
end

function BattleManualAAMissileUnit:MarkTarget()
	self:updateMovementInfo()

	local var_9_0 = self:Tracking()

	if self._strikeModeData.aimingTarget == var_9_0 then
		return
	end

	local var_9_1 = var_0_0.Battle.BattleState.GetInstance():GetSceneMediator()

	if self._strikeModeData.aimingTarget and self._strikeModeData.aimingFX then
		local var_9_2 = var_9_1:GetCharacter(self._strikeModeData.aimingTarget:GetUniqueID())

		if var_9_2 then
			var_9_2:RemoveFX(self._strikeModeData.aimingFX)
		end
	end

	table.clear(self._strikeModeData)

	if not var_9_0 then
		return
	end

	local var_9_3

	if self._preCastInfo.fx and #self._preCastInfo.fx > 0 then
		var_9_3 = var_9_1:GetCharacter(var_9_0:GetUniqueID()):AddFX(self._preCastInfo.fx)
	end

	self._strikeModeData.aimingTarget = var_9_0
	self._strikeModeData.aimingFX = var_9_3

	return
end

function BattleManualAAMissileUnit:CancelStrikeMode()
	if self._strikeModeData.aimingTarget and self._strikeModeData.aimingFX then
		local var_10_0 = var_0_0.Battle.BattleState.GetInstance():GetSceneMediator():GetCharacter(self._strikeModeData.aimingTarget:GetUniqueID())

		if var_10_0 then
			var_10_0:RemoveFX(self._strikeModeData.aimingFX)
		end
	end

	self._strikeMode = nil
	self._strikeModeData = nil

	return
end

function BattleManualAAMissileUnit:Tracking()
	return var_0_3.TargetWeightiest(self, nil, self:GetFilteredList())[1]
end

function BattleManualAAMissileUnit:Fire()
	self._strikeMode = nil

	var_0_0.Battle.BattleWeaponUnit.Fire(self, self._strikeModeData.aimingTarget)

	return true
end

function BattleManualAAMissileUnit:DoAttack(arg_13_1, ...)
	if arg_13_1 == nil or not arg_13_1:IsAlive() or self:outOfFireRange(arg_13_1) then
		arg_13_1 = nil

		if self._strikeModeData.aimingTarget and self._strikeModeData.aimingFX then
			local var_13_0 = var_0_0.Battle.BattleState.GetInstance():GetSceneMediator():GetCharacter(self._strikeModeData.aimingTarget:GetUniqueID())

			if var_13_0 then
				var_13_0:RemoveFX(self._strikeModeData.aimingFX)
			end
		end

		self._strikeModeData.aimingTarget = nil
		self._strikeModeData.aimingFX = nil
	end

	var_0_0.Battle.BattleWeaponUnit.DoAttack(self, arg_13_1, ...)

	return
end

function BattleManualAAMissileUnit:Prepar()
	self._currentState = self.STATE_PRECAST

	self:EnterStrikeMode()

	return
end

function BattleManualAAMissileUnit:Cancel()
	self._currentState = self.STATE_READY

	self:CancelStrikeMode()

	return
end

return
