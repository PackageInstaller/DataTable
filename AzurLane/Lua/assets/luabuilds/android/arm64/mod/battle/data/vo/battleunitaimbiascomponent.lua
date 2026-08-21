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

function ys.Battle.BattleUnitAimBiasComponent.Dispose(arg_2_0)
	arg_2_0:clear()

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

function ys.Battle.BattleUnitAimBiasComponent.ConfigRangeFormula(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._rangeFormulaFunc = arg_4_1
	arg_4_0._decayFormulaFunc = arg_4_2

	arg_4_0:init()

	return
end

function ys.Battle.BattleUnitAimBiasComponent.ConfigMinRange(arg_5_0, arg_5_1)
	arg_5_0._minBiasRange = arg_5_1

	return
end

function ys.Battle.BattleUnitAimBiasComponent.Active(arg_6_0, arg_6_1)
	arg_6_0._state = arg_6_1
	arg_6_0._currentBiasRange = arg_6_0._maxBiasRange
	arg_6_0._activeTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime()
	arg_6_0._lastUpdateTimeStamp = arg_6_0._activeTimeStamp

	return
end

function ys.Battle.BattleUnitAimBiasComponent.GetHost(arg_7_0)
	return arg_7_0._host
end

function ys.Battle.BattleUnitAimBiasComponent.Update(arg_8_0, arg_8_1)
	arg_8_0._pos = arg_8_0._host:GetPosition()

	local var_8_0 = var_0_4.GetCurrent(arg_8_0._host, "aimBiasDecaySpeedRatio") * arg_8_0._maxBiasRange

	arg_8_0._ratioSpeed = var_8_0
	arg_8_0._combinedSpeed = arg_8_0._decaySpeed + var_0_4.GetCurrent(arg_8_0._host, "aimBiasDecaySpeed") + var_8_0

	if arg_8_0._state == var_0_6.STATE_SUMMON_SICKNESS then
		if arg_8_1 - arg_8_0._activeTimeStamp > var_0_3.AIM_BIAS_ENEMY_INIT_TIME then
			arg_8_0:ChangeState(var_0_6.STATE_ACTIVITING)
		end
	elseif arg_8_0._state == var_0_6.STATE_SKILL_EXPOSE then
		arg_8_0._biasAttr = 0
	else
		arg_8_0._currentBiasRange = Mathf.Clamp(arg_8_0._currentBiasRange - arg_8_0._combinedSpeed * (arg_8_1 - arg_8_0._lastUpdateTimeStamp), arg_8_0._minBiasRange, arg_8_0._maxBiasRange)
		arg_8_0._biasAttr = arg_8_0._currentBiasRange

		if arg_8_0._currentBiasRange <= arg_8_0._minBiasRange then
			arg_8_0:ChangeState(var_0_6.STATE_TOTAL_EXPOSE)
		else
			arg_8_0:ChangeState(var_0_6.STATE_ACTIVITING)
		end
	end

	arg_8_0._lastUpdateTimeStamp = arg_8_1

	arg_8_0:biasEffect()

	return
end

function ys.Battle.BattleUnitAimBiasComponent.GetCurrentRate(arg_9_0)
	return (arg_9_0._currentBiasRange - arg_9_0._minBiasRange) / arg_9_0._progressLength
end

function ys.Battle.BattleUnitAimBiasComponent.GetDecayRatioSpeed(arg_10_0)
	return arg_10_0._ratioSpeed
end

function ys.Battle.BattleUnitAimBiasComponent.GetCurrentState(arg_11_0)
	return arg_11_0._state
end

function ys.Battle.BattleUnitAimBiasComponent.IsFaint(arg_12_0)
	return arg_12_0._state == var_0_6.STATE_TOTAL_EXPOSE or arg_12_0._state == var_0_6.STATE_SKILL_EXPOSE
end

function ys.Battle.BattleUnitAimBiasComponent.GetPosition(arg_13_0)
	return arg_13_0._pos
end

function ys.Battle.BattleUnitAimBiasComponent.GetCrewCount(arg_14_0)
	return #arg_14_0._crewList
end

function ys.Battle.BattleUnitAimBiasComponent.GetRange(arg_15_0)
	return arg_15_0._state == var_0_6.STATE_SKILL_EXPOSE and arg_15_0._minBiasRange or arg_15_0._currentBiasRange
end

function ys.Battle.BattleUnitAimBiasComponent.GetDecayFactorType(arg_16_0)
	if arg_16_0._host:GetCurrentOxyState() == var_0_2.OXY_STATE.DIVE then
		return var_0_6.DIVING
	else
		return var_0_6.NORMAL
	end

	return
end

function ys.Battle.BattleUnitAimBiasComponent.IsHostile(arg_17_0)
	return arg_17_0._hostile
end

function ys.Battle.BattleUnitAimBiasComponent.SetDecayFactor(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 == 0 then
		arg_18_0._decaySpeed = 0

		return
	end

	if arg_18_0._cacheFactor == arg_18_1 and arg_18_0._cacheType == arg_18_0:GetDecayFactorType() then
		return
	end

	arg_18_0._decaySpeed = arg_18_0:GetDecayFactorType() == var_0_6.DIVING and var_0_5.CalculateBiasDecayDiving(arg_18_1) or arg_18_0._decayFormulaFunc(arg_18_1)
	arg_18_0._decaySpeed = arg_18_0._decaySpeed + arg_18_2

	return
end

function ys.Battle.BattleUnitAimBiasComponent.AppendCrew(arg_19_0, arg_19_1)
	if table.contains(arg_19_0._crewList, arg_19_1) then
		return
	end

	table.insert(arg_19_0._crewList, arg_19_1)
	arg_19_0:switchHost()
	arg_19_0:flush()
	arg_19_1:AttachAimBias(arg_19_0)

	arg_19_0._currentBiasRange = arg_19_0._maxBiasRange

	return
end

function ys.Battle.BattleUnitAimBiasComponent.RemoveCrew(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0._crewList) do
		if iter_20_1 == arg_20_1 then
			table.remove(arg_20_0._crewList, iter_20_0)

			break
		end
	end

	if #arg_20_0._crewList == 0 then
		arg_20_0:clear()
	else
		arg_20_0:switchHost()
		arg_20_0:flush()
	end

	return
end

function ys.Battle.BattleUnitAimBiasComponent.UpdateSkillLock(arg_21_0)
	if var_0_4.IsLockAimBias(arg_21_0._host) then
		arg_21_0:ChangeState(var_0_6.STATE_SKILL_EXPOSE)
	elseif arg_21_0._currentBiasRange <= arg_21_0._minBiasRange then
		arg_21_0:ChangeState(var_0_6.STATE_TOTAL_EXPOSE)
	else
		arg_21_0:ChangeState(var_0_6.STATE_ACTIVITING)
	end

	arg_21_0._host:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_AIMBIAS_LOCK))

	return
end

function ys.Battle.BattleUnitAimBiasComponent.SmokeExitPause(arg_22_0)
	local var_22_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	arg_22_0._pauseStartTimeStamp = var_22_0

	var_0_4.SetCurrent(arg_22_0._host, "lockAimBias", 1)
	arg_22_0:UpdateSkillLock()
	arg_22_0:Update(var_22_0)

	arg_22_0._smokeRestoreTimer = pg.TimeMgr.GetInstance():AddBattleTimer("smokeRestoreTimer", 0, var_0_3.AIM_BIAS_SMOKE_RESTORE_DURATION, function()
		arg_22_0:removeRestoreTimer()
		arg_22_0._host:DetachAimBias()

		return
	end, true)

	return
end

function ys.Battle.BattleUnitAimBiasComponent.SomkeExitResume(arg_24_0)
	arg_24_0:removeRestoreTimer()

	arg_24_0._lastUpdateTimeStamp = arg_24_0._lastUpdateTimeStamp + (pg.TimeMgr.GetInstance():GetCombatTime() - arg_24_0._pauseStartTimeStamp)

	arg_24_0:UpdateSkillLock()

	return
end

function ys.Battle.BattleUnitAimBiasComponent.SmokeRecover(arg_25_0)
	arg_25_0._currentBiasRange = math.min(arg_25_0._maxBiasRange, arg_25_0._currentBiasRange + arg_25_0._maxBiasRange * var_0_3.AIM_BIAS_SMOKE_RECOVERY_RATE)

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

function ys.Battle.BattleUnitAimBiasComponent.switchHost(arg_28_0)
	arg_28_0._host = arg_28_0._crewList[1]

	arg_28_0._host:HostAimBias()

	return
end

function ys.Battle.BattleUnitAimBiasComponent.flush(arg_29_0)
	arg_29_0._maxBiasRange = math.max(arg_29_0._rangeFormulaFunc(arg_29_0._crewList), arg_29_0._minBiasRange)

	local var_29_0 = arg_29_0._host:GetTemplate().cld_box

	arg_29_0._progressLength = arg_29_0._maxBiasRange - arg_29_0._minBiasRange

	return
end

function ys.Battle.BattleUnitAimBiasComponent.biasEffect(arg_30_0)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0._crewList) do
		var_0_4.SetCurrent(iter_30_1, "aimBias", arg_30_0._biasAttr)
	end

	return
end

function ys.Battle.BattleUnitAimBiasComponent.removeRestoreTimer(arg_31_0)
	var_0_4.SetCurrent(arg_31_0._host, "lockAimBias", 0)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_31_0._smokeRestoreTimer)

	arg_31_0._smokeRestoreTimer = nil

	return
end

function ys.Battle.BattleUnitAimBiasComponent.clear(arg_32_0)
	if arg_32_0._smokeRestoreTimer then
		arg_32_0:removeRestoreTimer()
	end

	arg_32_0._crewList = {}
	arg_32_0._pos = nil
	arg_32_0._state = var_0_6.STATE_EXPIRE

	return
end

return
