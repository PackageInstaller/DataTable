ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle.BattleConfig
local var_0_4 = var_0.Battle.BattleAttr
local var_0_5 = var_0.Battle.BattleFormulas
local var_0_6 = var_0.Battle

class = var_0_10007
var_0_6.BattleUnitAimBiasComponent = var_0_10007("BattleUnitAimBiasComponent")
var_0.Battle.BattleUnitAimBiasComponent.__name = "BattleUnitAimBiasComponent"

local var_0_7 = var_0.Battle.BattleUnitAimBiasComponent

var_0_7.NORMAL = 1
var_0_7.DIVING = 2
var_0_7.STATE_SUMMON_SICKNESS = "STATE_SUMMON_SICKNESS"
var_0_7.STATE_ACTIVITING = "STATE_ACTIVITING"
var_0_7.STATE_SKILL_EXPOSE = "STATE_SKILL_EXPOSE"
var_0_7.STATE_TOTAL_EXPOSE = "STATE_TOTAL_EXPOSE"
var_0_7.STATE_EXPIRE = "STATE_EXPIRE"

function var_0_7.Ctor(arg_1_0)
	return
end

function var_0_7.Dispose(arg_2_0)
	arg_2_0:clear()

	return
end

function var_0_7.init(arg_3_0)
	arg_3_0._crewList = {}
	arg_3_0._maxBiasRange = 0
	arg_3_0._minBiasRange = 0
	arg_3_0._currentBiasRange = 0
	arg_3_0._biasAttr = 0
	arg_3_0._decaySpeed = 0
	arg_3_0._ratioSpeed = 0
	arg_3_0._combinedSpeed = 0
	Vector3 = var_1
	arg_3_0._pos = var_1.zero

	return
end

function var_0_7.ConfigRangeFormula(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._rangeFormulaFunc = arg_4_1
	arg_4_0._decayFormulaFunc = arg_4_2

	arg_4_0:init()

	return
end

function var_0_7.ConfigMinRange(arg_5_0, arg_5_1)
	arg_5_0._minBiasRange = arg_5_1

	return
end

function var_0_7.Active(arg_6_0, arg_6_1)
	arg_6_0._state = arg_6_1
	arg_6_0._currentBiasRange = arg_6_0._maxBiasRange
	pg = var_2

	local var_6_0 = var_2.TimeMgr.GetInstance()

	arg_6_0._activeTimeStamp = var_2.GetCombatTime(var_6_0)
	arg_6_0._lastUpdateTimeStamp = arg_6_0._activeTimeStamp

	return
end

function var_0_7.GetHost(arg_7_0)
	return arg_7_0._host
end

function var_0_7.Update(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._host

	arg_8_0._pos = var_2.GetPosition(var_8_0)

	local var_8_1 = var_0_4.GetCurrent(arg_8_0._host, "aimBiasDecaySpeed")

	arg_8_0._ratioSpeed = var_0_4.GetCurrent(arg_8_0._host, "aimBiasDecaySpeedRatio") * arg_8_0._maxBiasRange
	arg_8_0._combinedSpeed = arg_8_0._decaySpeed + var_8_1 + var_3

	if arg_8_0._state == var_0_7.STATE_SUMMON_SICKNESS then
		if arg_8_1 - arg_8_0._activeTimeStamp > var_0_3.AIM_BIAS_ENEMY_INIT_TIME then
			arg_8_0:ChangeState(var_0_7.STATE_ACTIVITING)
		end
	elseif arg_8_0._state == var_0_7.STATE_SKILL_EXPOSE then
		arg_8_0._biasAttr = 0
	else
		local var_8_2 = arg_8_0._combinedSpeed * (arg_8_1 - arg_8_0._lastUpdateTimeStamp)

		Mathf = var_5
		arg_8_0._currentBiasRange = var_5.Clamp(arg_8_0._currentBiasRange - var_8_2, arg_8_0._minBiasRange, arg_8_0._maxBiasRange)
		arg_8_0._biasAttr = arg_8_0._currentBiasRange

		if arg_8_0._currentBiasRange <= arg_8_0._minBiasRange then
			arg_8_0:ChangeState(var_0_7.STATE_TOTAL_EXPOSE)
		else
			arg_8_0:ChangeState(var_0_7.STATE_ACTIVITING)
		end
	end

	arg_8_0._lastUpdateTimeStamp = arg_8_1

	arg_8_0:biasEffect()

	return
end

function var_0_7.GetCurrentRate(arg_9_0)
	return (arg_9_0._currentBiasRange - arg_9_0._minBiasRange) / arg_9_0._progressLength
end

function var_0_7.GetDecayRatioSpeed(arg_10_0)
	return arg_10_0._ratioSpeed
end

function var_0_7.GetCurrentState(arg_11_0)
	return arg_11_0._state
end

function var_0_7.IsFaint(arg_12_0)
	return arg_12_0._state == var_0_7.STATE_TOTAL_EXPOSE or arg_12_0._state == var_0_7.STATE_SKILL_EXPOSE
end

function var_0_7.GetPosition(arg_13_0)
	return arg_13_0._pos
end

function var_0_7.GetCrewCount(arg_14_0)
	return #arg_14_0._crewList
end

function var_0_7.GetRange(arg_15_0)
	local var_15_0

	if arg_15_0._state == var_0_7.STATE_SKILL_EXPOSE then
		var_15_0 = arg_15_0._minBiasRange
	else
		var_15_0 = arg_15_0._currentBiasRange
	end

	return var_15_0
end

function var_0_7.GetDecayFactorType(arg_16_0)
	local var_16_0 = arg_16_0._host

	if var_1.GetCurrentOxyState(var_16_0) == var_0_2.OXY_STATE.DIVE then
		return var_0_7.DIVING
	else
		return var_0_7.NORMAL
	end

	return
end

function var_0_7.IsHostile(arg_17_0)
	return arg_17_0._hostile
end

function var_0_7.SetDecayFactor(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 == 0 then
		arg_18_0._decaySpeed = 0

		return
	end

	if arg_18_0._cacheFactor == arg_18_1 and arg_18_0._cacheType == arg_18_0:GetDecayFactorType() then
		return
	end

	if arg_18_0:GetDecayFactorType() == var_0_7.DIVING then
		arg_18_0._decaySpeed = var_0_5.CalculateBiasDecayDiving(arg_18_1)
	else
		arg_18_0._decaySpeed = arg_18_0._decayFormulaFunc(arg_18_1)
	end

	arg_18_0._decaySpeed = arg_18_0._decaySpeed + arg_18_2

	return
end

function var_0_7.AppendCrew(arg_19_0, arg_19_1)
	table = var_1_10002

	if var_1_10002.contains(arg_19_0._crewList, arg_19_1) then
		return
	end

	table = var_2

	var_2.insert(arg_19_0._crewList, arg_19_1)
	arg_19_0:switchHost()
	arg_19_0:flush()
	arg_19_1:AttachAimBias(arg_19_0)

	arg_19_0._currentBiasRange = arg_19_0._maxBiasRange

	return
end

function var_0_7.RemoveCrew(arg_20_0, arg_20_1)
	local var_20_0

	ipairs = var_1_10003

	for iter_20_0, iter_20_1 in var_1_10003(arg_20_0._crewList) do
		if iter_20_1 == arg_20_1 then
			table = var_1_10008

			var_1_10008.remove(arg_20_0._crewList, iter_20_0)

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

function var_0_7.UpdateSkillLock(arg_21_0)
	if var_0_4.IsLockAimBias(arg_21_0._host) then
		arg_21_0:ChangeState(var_0_7.STATE_SKILL_EXPOSE)
	elseif arg_21_0._currentBiasRange <= arg_21_0._minBiasRange then
		arg_21_0:ChangeState(var_0_7.STATE_TOTAL_EXPOSE)
	else
		arg_21_0:ChangeState(var_0_7.STATE_ACTIVITING)
	end

	local var_21_0 = arg_21_0._host

	var_2.DispatchEvent(var_21_0, var_0.Event.New(var_0_1.UPDATE_AIMBIAS_LOCK))

	return
end

function var_0_7.SmokeExitPause(arg_22_0)
	pg = var_1_10001

	local var_22_0 = var_1_10001.TimeMgr.GetInstance()

	arg_22_0._pauseStartTimeStamp = var_1.GetCombatTime(var_22_0)

	var_0_4.SetCurrent(arg_22_0._host, "lockAimBias", 1)
	arg_22_0:UpdateSkillLock()

	local var_22_1 = arg_22_0

	arg_22_0.Update(var_22_1, var_1)

	local function var_22_2()
		local var_23_0 = arg_22_0

		var_0.removeRestoreTimer(var_23_0)

		local var_23_1 = arg_22_0._host

		var_0.DetachAimBias(var_23_1)

		return
	end

	pg = var_22_1

	local var_22_3 = var_22_1.TimeMgr.GetInstance()

	arg_22_0._smokeRestoreTimer = var_3.AddBattleTimer(var_22_3, "smokeRestoreTimer", 0, var_0_3.AIM_BIAS_SMOKE_RESTORE_DURATION, var_22_2, true)

	return
end

function var_0_7.SomkeExitResume(arg_24_0)
	arg_24_0:removeRestoreTimer()

	pg = var_1

	local var_24_0 = var_1.TimeMgr.GetInstance()
	local var_24_1 = var_1.GetCombatTime(var_24_0) - arg_24_0._pauseStartTimeStamp

	arg_24_0._lastUpdateTimeStamp = arg_24_0._lastUpdateTimeStamp + var_24_1

	arg_24_0:UpdateSkillLock()

	return
end

function var_0_7.SmokeRecover(arg_25_0)
	math = var_1_10001
	arg_25_0._currentBiasRange = var_1_10001.min(arg_25_0._maxBiasRange, arg_25_0._currentBiasRange + arg_25_0._maxBiasRange * var_0_3.AIM_BIAS_SMOKE_RECOVERY_RATE)

	return
end

function var_0_7.ChangeState(arg_26_0, arg_26_1)
	arg_26_0._state = arg_26_1

	return
end

function var_0_7.SetHostile(arg_27_0)
	arg_27_0._hostile = true

	return
end

function var_0_7.switchHost(arg_28_0)
	arg_28_0._host = arg_28_0._crewList[1]

	local var_28_0 = arg_28_0._host

	var_1.HostAimBias(var_28_0)

	return
end

function var_0_7.flush(arg_29_0)
	math = var_1_10001
	arg_29_0._maxBiasRange = var_1_10001.max(arg_29_0._rangeFormulaFunc(arg_29_0._crewList), arg_29_0._minBiasRange)

	local var_29_0 = arg_29_0._host
	local var_29_1 = var_1.GetTemplate(var_29_0).cld_box

	arg_29_0._progressLength = arg_29_0._maxBiasRange - arg_29_0._minBiasRange

	return
end

function var_0_7.biasEffect(arg_30_0)
	ipairs = var_1_10001

	for iter_30_0, iter_30_1 in var_1_10001(arg_30_0._crewList) do
		var_0_4.SetCurrent(iter_30_1, "aimBias", arg_30_0._biasAttr)
	end

	return
end

function var_0_7.removeRestoreTimer(arg_31_0)
	var_0_4.SetCurrent(arg_31_0._host, "lockAimBias", 0)

	pg = var_1

	local var_31_0 = var_1.TimeMgr.GetInstance()

	var_1.RemoveBattleTimer(var_31_0, arg_31_0._smokeRestoreTimer)

	arg_31_0._smokeRestoreTimer = nil

	return
end

function var_0_7.clear(arg_32_0)
	if arg_32_0._smokeRestoreTimer then
		arg_32_0:removeRestoreTimer()
	end

	arg_32_0._crewList = {}
	arg_32_0._pos = nil
	arg_32_0._state = var_0_7.STATE_EXPIRE

	return
end

return
