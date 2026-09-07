ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleDataFunction
local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleConfig
local BattleLaserUnit = class("BattleLaserUnit", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleLaserUnit = BattleLaserUnit
BattleLaserUnit.__name = "BattleLaserUnit"
BattleLaserUnit.STATE_ATTACK = "FIB"
BattleLaserUnit.BEAM_STATE_READY = "beamStateReady"
BattleLaserUnit.BEAM_STATE_OVER_HEAT = "beamStateOverHeat"

function BattleLaserUnit:Ctor()
	BattleLaserUnit.super.Ctor(self)

	return
end

function BattleLaserUnit:Clear()
	if self._alertTimer then
		pg.TimeMgr.GetInstance():RemoveBattleTimer(self._alertTimer)
	end

	self._alertTimer = nil

	for iter_2_0, iter_2_1 in ipairs(self._beamList) do
		if iter_2_1:GetBeamState() == iter_2_1.BEAM_STATE_ATTACK then
			self._dataProxy:RemoveAreaOfEffect(iter_2_1:GetAoeData():GetUniqueID())
		end

		iter_2_1:ClearBeam()
	end

	BattleLaserUnit.super.Clear(self)

	return
end

function BattleLaserUnit:Update()
	self:UpdateReload()

	if self._currentState == self.STATE_READY then
		self:updateMovementInfo()

		local var_3_0 = self:Tracking()

		if var_3_0 then
			if self._preCastInfo.time ~= nil then
				self:PreCast(var_3_0)
			else
				self._currentState = self.STATE_PRECAST_FINISH
			end
		end
	end

	if self._currentState == self.STATE_PRECAST then
		-- block empty
	elseif self._currentState == self.STATE_PRECAST_FINISH then
		self:updateMovementInfo()
		self:Fire(self:Tracking())
	end

	if self._attackStartTime then
		self:updateMovementInfo()
		self:updateBeamList()
	end

	return
end

function BattleLaserUnit:DoAttack(arg_4_1)
	if arg_4_1 == nil or not arg_4_1:IsAlive() or self:outOfFireRange(arg_4_1) then
		arg_4_1 = nil
	end

	self._attackStartTime = pg.TimeMgr.GetInstance():GetCombatTime()

	if self._tmpData.aim_type == var_0_2.WeaponAimType.AIM and arg_4_1 ~= nil then
		self._aimPos = arg_4_1:GetBeenAimedPosition()
	end

	self:cacheBulletID()

	for iter_4_0, iter_4_1 in ipairs(self._beamList) do
		iter_4_1:ChangeBeamState(iter_4_1.BEAM_STATE_READY)

		if var_0_1.GetBarrageTmpDataFromID(iter_4_1:GetBeamInfoID()).first_delay == 0 then
			self:createBeam(iter_4_1)
		end
	end

	var_0_0.Battle.PlayBattleSFX(self._tmpData.fire_sfx)
	self:TriggerBuffOnFire()
	self:CheckAndShake()

	return
end

function BattleLaserUnit:SetTemplateData(arg_5_1)
	BattleLaserUnit.super.SetTemplateData(self, arg_5_1)
	self:initBeamList()

	return
end

function BattleLaserUnit:initBeamList()
	self._alertList = {}
	self._beamList = {}

	for iter_6_0, iter_6_1 in ipairs(self._tmpData.bullet_ID) do
		self._beamList[iter_6_0] = var_0_0.Battle.BattleBeamUnit.New(iter_6_1, self._tmpData.barrage_ID[iter_6_0])
	end

	return
end

function BattleLaserUnit:updateBeamList()
	local var_7_0 = pg.TimeMgr.GetInstance():GetCombatTime() - self._attackStartTime
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in ipairs(self._beamList) do
		if iter_7_1:GetBeamState() == iter_7_1.BEAM_STATE_READY then
			if var_7_0 > var_0_1.GetBarrageTmpDataFromID(iter_7_1:GetBeamInfoID()).first_delay then
				self:createBeam(iter_7_1)
			end
		elseif iter_7_1:GetBeamState() == iter_7_1.BEAM_STATE_ATTACK then
			if not iter_7_1:IsBeamActive() then
				iter_7_1:ClearBeam()

				var_7_1 = var_7_1 + 1
			else
				iter_7_1:UpdateBeamPos(self._hostPos)
				iter_7_1:UpdateBeamAngle()

				if iter_7_1:CanDealDamage() then
					self:doBeamDamage(iter_7_1)
				end
			end
		elseif iter_7_1:GetBeamState() == iter_7_1.BEAM_STATE_FINISH then
			var_7_1 = var_7_1 + 1
		end
	end

	if var_7_1 == #self._beamList then
		self:EnterCoolDown()
	end

	return
end

function BattleLaserUnit:createBeam(arg_8_1)
	local var_8_0 = var_0_1.GetBarrageTmpDataFromID(arg_8_1:GetBeamInfoID())
	local var_8_1 = self._host:GetIFF()
	local var_8_2 = Vector3(self._hostPos.x + var_8_0.offset_x, 0, self._hostPos.z + var_8_0.offset_z)
	local var_8_3 = self._dataProxy:SpawnLastingCubeArea(var_0_2.AOEField.SURFACE, var_8_1, var_8_2, var_8_0.delta_offset_x, var_8_0.delta_offset_z, var_8_0.delay, function(arg_9_0)
		for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
			if iter_9_1.Active then
				arg_8_1:AddCldUnit(self._dataProxy:GetUnitList()[iter_9_1.UID])
			end
		end

		return
	end, function(arg_10_0)
		if arg_10_0.Active then
			arg_8_1:RemoveCldUnit(self._dataProxy:GetUnitList()[arg_10_0.UID])
		end

		return
	end, false, var_0_1.GetBulletTmpDataFromID(arg_8_1:GetBulletID()).modle_ID)

	if self._aimPos == nil then
		arg_8_1:SetAimAngle(0)
	elseif var_8_0.offset_prioritise then
		arg_8_1:SetAimPosition(self._aimPos, var_8_2, var_8_1)
	else
		local var_8_4

		if var_8_1 == var_0_3.FRIENDLY_CODE then
			var_8_4 = math.rad2Deg * math.atan2(self._aimPos.z - self._hostPos.z, self._aimPos.x - self._hostPos.x)
		elseif var_8_1 == var_0_3.FOE_CODE then
			var_8_4 = math.rad2Deg * math.atan2(self._hostPos.z - self._aimPos.z, self._hostPos.x - self._aimPos.x)
		end

		arg_8_1:SetAimAngle(var_8_4)
	end

	if var_8_1 == var_0_3.FRIENDLY_CODE then
		var_8_3:SetAnchorPointAlignment(var_8_3.ALIGNMENT_LEFT)
	elseif var_8_1 == var_0_3.FOE_CODE then
		var_8_3:SetAnchorPointAlignment(var_8_3.ALIGNMENT_RIGHT)
	end

	var_8_3:SetFXStatic(true)
	arg_8_1:SetAoeData(var_8_3)
	arg_8_1:BeginFocus()
	arg_8_1:ChangeBeamState(arg_8_1.BEAM_STATE_ATTACK)

	return
end

function BattleLaserUnit:doBeamDamage(arg_11_1)
	arg_11_1:DealDamage()

	local var_11_0 = self:Spawn(arg_11_1:GetBulletID())

	for iter_11_0, iter_11_1 in pairs((arg_11_1:GetCldUnitList())) do
		if not iter_11_1:IsAlive() or arg_11_1:GetBeamExtraParam().mainFilter == true and iter_11_1:IsMainFleetUnit() then
			-- block empty
		else
			self._dataProxy:HandleDamage(var_11_0, iter_11_1)

			local var_11_1, var_11_2 = var_0_0.Battle.BattleFXPool.GetInstance():GetFX(arg_11_1:GetFXID())

			pg.EffectMgr.GetInstance():PlayBattleEffect(var_11_1, var_11_2:Add(iter_11_1:GetPosition()), true)
			var_0_0.Battle.PlayBattleSFX(arg_11_1:GetSFXID())
		end
	end

	self._dataProxy:RemoveBulletUnit(var_11_0:GetUniqueID())

	return
end

function BattleLaserUnit:EnterCoolDown()
	self._attackStartTime = nil

	BattleLaserUnit.super.EnterCoolDown(self)

	return
end

return
