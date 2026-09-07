ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleConfig
local var_0_4 = ys.Battle.BattleAttr
local var_0_5 = ys.Battle.BattleFormulas

ys.Battle.BattleUnitAimBiasComponent = class("BattleUnitAimBiasComponent")
ys.Battle.BattleUnitAimBiasComponent.__name = "BattleUnitAimBiasComponent"

local var_0_6 = ys.Battle.BattleUnitAimBiasComponent

ys.Battle.BattleUnitAimBiasComponent.NORMAL = 1
ys.Battle.BattleUnitAimBiasComponent.DIVING = 2
ys.Battle.BattleUnitAimBiasComponent.STATE_SUMMON_SICKNESS = "STATE_SUMMON_SICKNESS"
ys.Battle.BattleUnitAimBiasComponent.STATE_ACTIVITING = "STATE_ACTIVITING"
ys.Battle.BattleUnitAimBiasComponent.STATE_SKILL_EXPOSE = "STATE_SKILL_EXPOSE"
ys.Battle.BattleUnitAimBiasComponent.STATE_TOTAL_EXPOSE = "STATE_TOTAL_EXPOSE"
ys.Battle.BattleUnitAimBiasComponent.STATE_EXPIRE = "STATE_EXPIRE"

function ys.Battle.BattleUnitAimBiasComponent.Ctor(arg_1_0)
	return
end

function ys.Battle.BattleUnitAimBiasComponent:Dispose()
	self:clear()

	return
end

function ys.Battle.BattleUnitAimBiasComponent.init(arg_3_0)
	arg_3_0._crewList = {}
	arg_3_0._maxBiasRange = 0
	arg_3_0._minBiasRange = 0
	arg_3_0._currentBiasRange = 0
	arg_3_0._biasAttr = 0
	arg_3_0._decaySpeed = 0
	arg_3_0._ratioSpeed = 0
	arg_3_0._combinedSpeed = 0
	arg_3_0._pos = Vector3.zero

	return
end

function ys.Battle.BattleUnitAimBiasComponent:ConfigRangeFormula(arg_4_1, arg_4_2)
	self._rangeFormulaFunc = arg_4_1
	self._decayFormulaFunc = arg_4_2

	self:init()

	return
end

function ys.Battle.BattleUnitAimBiasComponent.ConfigMinRange(arg_5_0, arg_5_1)
	arg_5_0._minBiasRange = arg_5_1

	return
end

function ys.Battle.BattleUnitAimBiasComponent:Active(arg_6_1)
	self._state = arg_6_1
	self._currentBiasRange = self._maxBiasRange
	self._activeTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime()
	self._lastUpdateTimeStamp = self._activeTimeStamp

	return
end

function ys.Battle.BattleUnitAimBiasComponent:GetHost()
	return self._host
end

function ys.Battle.BattleUnitAimBiasComponent:Update(arg_8_1)
	self._pos = self._host:GetPosition()

	local var_8_0 = var_0_4.GetCurrent(self._host, "aimBiasDecaySpeedRatio") * self._maxBiasRange

	self._ratioSpeed = var_8_0
	self._combinedSpeed = self._decaySpeed + var_0_4.GetCurrent(self._host, "aimBiasDecaySpeed") + var_8_0

	if self._state == var_0_6.STATE_SUMMON_SICKNESS then
		if arg_8_1 - self._activeTimeStamp > var_0_3.AIM_BIAS_ENEMY_INIT_TIME then
			self:ChangeState(var_0_6.STATE_ACTIVITING)
		end
	elseif self._state == var_0_6.STATE_SKILL_EXPOSE then
		self._biasAttr = 0
	else
		self._currentBiasRange = Mathf.Clamp(self._currentBiasRange - self._combinedSpeed * (arg_8_1 - self._lastUpdateTimeStamp), self._minBiasRange, self._maxBiasRange)
		self._biasAttr = self._currentBiasRange

		if self._currentBiasRange <= self._minBiasRange then
			self:ChangeState(var_0_6.STATE_TOTAL_EXPOSE)
		else
			self:ChangeState(var_0_6.STATE_ACTIVITING)
		end
	end

	self._lastUpdateTimeStamp = arg_8_1

	self:biasEffect()

	return
end

function ys.Battle.BattleUnitAimBiasComponent:GetCurrentRate()
	return (self._currentBiasRange - self._minBiasRange) / self._progressLength
end

function ys.Battle.BattleUnitAimBiasComponent:GetDecayRatioSpeed()
	return self._ratioSpeed
end

function ys.Battle.BattleUnitAimBiasComponent:GetCurrentState()
	return self._state
end

function ys.Battle.BattleUnitAimBiasComponent:IsFaint()
	return self._state == var_0_6.STATE_TOTAL_EXPOSE or self._state == var_0_6.STATE_SKILL_EXPOSE
end

function ys.Battle.BattleUnitAimBiasComponent:GetPosition()
	return self._pos
end

function ys.Battle.BattleUnitAimBiasComponent:GetCrewCount()
	return #self._crewList
end

function ys.Battle.BattleUnitAimBiasComponent:GetRange()
	return self._state == var_0_6.STATE_SKILL_EXPOSE and self._minBiasRange or self._currentBiasRange
end

function ys.Battle.BattleUnitAimBiasComponent:GetDecayFactorType()
	if self._host:GetCurrentOxyState() == var_0_2.OXY_STATE.DIVE then
		return var_0_6.DIVING
	else
		return var_0_6.NORMAL
	end

	return
end

function ys.Battle.BattleUnitAimBiasComponent:IsHostile()
	return self._hostile
end

function ys.Battle.BattleUnitAimBiasComponent:SetDecayFactor(arg_18_1, arg_18_2)
	if arg_18_1 == 0 then
		self._decaySpeed = 0

		return
	end

	if self._cacheFactor == arg_18_1 and self._cacheType == self:GetDecayFactorType() then
		return
	end

	self._decaySpeed = self:GetDecayFactorType() == var_0_6.DIVING and var_0_5.CalculateBiasDecayDiving(arg_18_1) or self._decayFormulaFunc(arg_18_1)
	self._decaySpeed = self._decaySpeed + arg_18_2

	return
end

function ys.Battle.BattleUnitAimBiasComponent:AppendCrew(arg_19_1)
	if table.contains(self._crewList, arg_19_1) then
		return
	end

	table.insert(self._crewList, arg_19_1)
	self:switchHost()
	self:flush()
	arg_19_1:AttachAimBias(self)

	self._currentBiasRange = self._maxBiasRange

	return
end

function ys.Battle.BattleUnitAimBiasComponent:RemoveCrew(arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(self._crewList) do
		if iter_20_1 == arg_20_1 then
			table.remove(self._crewList, iter_20_0)

			break
		end
	end

	if #self._crewList == 0 then
		self:clear()
	else
		self:switchHost()
		self:flush()
	end

	return
end

function ys.Battle.BattleUnitAimBiasComponent:UpdateSkillLock()
	if var_0_4.IsLockAimBias(self._host) then
		self:ChangeState(var_0_6.STATE_SKILL_EXPOSE)
	elseif self._currentBiasRange <= self._minBiasRange then
		self:ChangeState(var_0_6.STATE_TOTAL_EXPOSE)
	else
		self:ChangeState(var_0_6.STATE_ACTIVITING)
	end

	self._host:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_AIMBIAS_LOCK))

	return
end

function ys.Battle.BattleUnitAimBiasComponent:SmokeExitPause()
	local var_22_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	self._pauseStartTimeStamp = var_22_0

	var_0_4.SetCurrent(self._host, "lockAimBias", 1)
	self:UpdateSkillLock()
	self:Update(var_22_0)

	self._smokeRestoreTimer = pg.TimeMgr.GetInstance():AddBattleTimer("smokeRestoreTimer", 0, var_0_3.AIM_BIAS_SMOKE_RESTORE_DURATION, function()
		self:removeRestoreTimer()
		self._host:DetachAimBias()

		return
	end, true)

	return
end

function ys.Battle.BattleUnitAimBiasComponent:SomkeExitResume()
	self:removeRestoreTimer()

	self._lastUpdateTimeStamp = self._lastUpdateTimeStamp + (pg.TimeMgr.GetInstance():GetCombatTime() - self._pauseStartTimeStamp)

	self:UpdateSkillLock()

	return
end

function ys.Battle.BattleUnitAimBiasComponent:SmokeRecover()
	self._currentBiasRange = math.min(self._maxBiasRange, self._currentBiasRange + self._maxBiasRange * var_0_3.AIM_BIAS_SMOKE_RECOVERY_RATE)

	return
end

function ys.Battle.BattleUnitAimBiasComponent.ChangeState(arg_26_0, arg_26_1)
	arg_26_0._state = arg_26_1

	return
end

function ys.Battle.BattleUnitAimBiasComponent.SetHostile(arg_27_0)
	arg_27_0._hostile = true

	return
end

function ys.Battle.BattleUnitAimBiasComponent:switchHost()
	self._host = self._crewList[1]

	self._host:HostAimBias()

	return
end

function ys.Battle.BattleUnitAimBiasComponent:flush()
	self._maxBiasRange = math.max(self._rangeFormulaFunc(self._crewList), self._minBiasRange)

	local var_29_0 = self._host:GetTemplate().cld_box

	self._progressLength = self._maxBiasRange - self._minBiasRange

	return
end

function ys.Battle.BattleUnitAimBiasComponent:biasEffect()
	for iter_30_0, iter_30_1 in ipairs(self._crewList) do
		var_0_4.SetCurrent(iter_30_1, "aimBias", self._biasAttr)
	end

	return
end

function ys.Battle.BattleUnitAimBiasComponent:removeRestoreTimer()
	var_0_4.SetCurrent(self._host, "lockAimBias", 0)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._smokeRestoreTimer)

	self._smokeRestoreTimer = nil

	return
end

function ys.Battle.BattleUnitAimBiasComponent:clear()
	if self._smokeRestoreTimer then
		self:removeRestoreTimer()
	end

	self._crewList = {}
	self._pos = nil
	self._state = var_0_6.STATE_EXPIRE

	return
end

return
