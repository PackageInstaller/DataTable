ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle.BattleConfig
local var_0_4 = var_0.Battle.BattleAttr
local var_0_5 = var_0.Battle

class = var_0_10006
var_0_5.BattleUnitCloakComponent = var_0_10006("BattleUnitCloakComponent")
var_0.Battle.BattleUnitCloakComponent.__name = "BattleUnitCloakComponent"

local var_0_6 = var_0.Battle.BattleUnitCloakComponent

var_0_6.STATE_CLOAK = "STATE_CLOAK"
var_0_6.STATE_UNCLOAK = "STATE_UNCLOAK"

function var_0_6.Ctor(arg_1_0, arg_1_1)
	arg_1_0._client = arg_1_1

	arg_1_0:initCloak()

	return
end

function var_0_6.Update(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_0._lastCloakUpdateStamp then
		var_2_0 = arg_2_1
	end

	arg_2_0._lastCloakUpdateStamp = var_2_0

	arg_2_0:updateCloakValue(arg_2_1)
	arg_2_0:UpdateCloakState()

	arg_2_0._lastCloakUpdateStamp = arg_2_1

	var_0.Battle.BattleBuffDOT.UpdateCloakLock(arg_2_0._client)

	return
end

function var_0_6.UpdateCloakConfig(arg_3_0)
	arg_3_0._exposeBase = var_0_4.GetCurrent(arg_3_0._client, "cloakExposeBase")
	arg_3_0._exposeExtra = var_0_4.GetCurrent(arg_3_0._client, "cloakExposeExtra")
	arg_3_0._restoreValue = var_0_4.GetCurrent(arg_3_0._client, "cloakRestore")
	arg_3_0._recovery = var_0_4.GetCurrent(arg_3_0._client, "cloakRecovery")

	arg_3_0:adjustCloakAttr()

	local var_3_0 = arg_3_0._client

	var_1.DispatchEvent(var_3_0, var_0.Event.New(var_0_1.UPDATE_CLOAK_CONFIG))

	return
end

function var_0_6.SetRecoverySpeed(arg_4_0, arg_4_1)
	arg_4_0._fieldRecoveryOverride = arg_4_1

	return
end

function var_0_6.AppendExpose(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._cloakValue + arg_5_1
	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.GetCloakBottom(var_5_1)

	Mathf = var_5_1
	arg_5_0._cloakValue = var_5_1.Clamp(var_5_0, var_5_2, arg_5_0._exposeValue)

	arg_5_0:UpdateCloakState()

	return
end

function var_0_6.AppendStrikeExpose(arg_6_0)
	math = var_1_10001

	local var_6_0 = var_1_10001.min(arg_6_0._strikeExposeAdditive * arg_6_0._strikeCount, arg_6_0._strikeExposeAdditiveLimit)

	arg_6_0._strikeCount = arg_6_0._strikeCount + 1

	arg_6_0:AppendExpose(var_6_0)

	return
end

function var_0_6.AppendBombardExpose(arg_7_0)
	math = var_1_10001

	local var_7_0 = var_1_10001.min(arg_7_0._bombardExposeAdditive * arg_7_0._bombardCount, arg_7_0._bombardExposeAdditiveLimit)

	arg_7_0._bombardCount = arg_7_0._bombardCount + 1

	arg_7_0:AppendExpose(var_7_0)

	return
end

function var_0_6.AppendExposeSpeed(arg_8_0, arg_8_1)
	arg_8_0._exposeSpeed = arg_8_1

	return
end

function var_0_6.ForceToMax(arg_9_0)
	arg_9_0:ForceToRate(1)

	return
end

function var_0_6.ForceToRate(arg_10_0, arg_10_1)
	math = var_1_10002
	arg_10_0._cloakValue = var_1_10002.floor(arg_10_1 * arg_10_0._exposeValue)

	arg_10_0:UpdateCloakState()

	return
end

function var_0_6.UpdateDotExpose(arg_11_0, arg_11_1)
	if arg_11_1 ~= arg_11_0._cloakBottom then
		arg_11_0._cloakBottom = arg_11_1

		local var_11_0 = arg_11_0._client

		var_2.DispatchEvent(var_11_0, var_0.Event.New(var_0_1.UPDATE_CLOAK_LOCK))
	end

	return
end

function var_0_6.UpdateTauntExpose(arg_12_0, arg_12_1)
	if arg_12_1 then
		arg_12_0._tauntCloakBottom = arg_12_0._restoreValue
	else
		arg_12_0._tauntCloakBottom = nil
	end

	return
end

function var_0_6.UpdateCloakState(arg_13_0)
	local var_13_0

	if arg_13_0._cloakValue >= arg_13_0._exposeValue then
		var_13_0 = var_0_6.STATE_UNCLOAK
	elseif arg_13_0._cloakValue < arg_13_0._restoreValue then
		var_13_0 = var_0_6.STATE_CLOAK
	end

	if var_13_0 and var_13_0 ~= arg_13_0._currentState then
		arg_13_0._currentState = var_13_0

		if arg_13_0._currentState == var_0_6.STATE_UNCLOAK then
			var_0_4.Uncloak(arg_13_0._client)
			arg_13_0:triggerBuff()
		elseif arg_13_0._currentState == var_0_6.STATE_CLOAK then
			var_0_4.Cloak(arg_13_0._client)
			arg_13_0:triggerBuff()
		end
	end

	return
end

function var_0_6.GetCloakValue(arg_14_0)
	return arg_14_0._cloakValue
end

function var_0_6.GetCloakMax(arg_15_0)
	return arg_15_0._exposeValue
end

function var_0_6.GetCloakLockMin(arg_16_0)
	return arg_16_0._fireLockValue
end

function var_0_6.GetCloakRestoreValue(arg_17_0)
	return arg_17_0._restoreValue
end

function var_0_6.GetCloakBottom(arg_18_0)
	if arg_18_0._tauntCloakBottom then
		math = var_1

		return var_1.max(arg_18_0._tauntCloakBottom, arg_18_0._cloakBottom)
	else
		return arg_18_0._cloakBottom
	end

	return
end

function var_0_6.GetCurrentState(arg_19_0)
	return arg_19_0._currentState
end

function var_0_6.GetExposeSpeed(arg_20_0)
	return arg_20_0._exposeSpeed
end

function var_0_6.updateCloakValue(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1 - arg_21_0._lastCloakUpdateStamp
	local var_21_1

	if not arg_21_0._fieldRecoveryOverride then
		var_21_1 = arg_21_0._recovery
	end

	local var_21_2 = (arg_21_0._exposeSpeed - var_21_1) * var_21_0

	arg_21_0:AppendExpose(var_21_2)

	return
end

function var_0_6.initCloak(arg_22_0)
	arg_22_0._exposeBase = var_0_4.GetCurrent(arg_22_0._client, "cloakExposeBase")
	arg_22_0._exposeExtra = var_0_4.GetCurrent(arg_22_0._client, "cloakExposeExtra")
	arg_22_0._restoreValue = var_0_4.GetCurrent(arg_22_0._client, "cloakRestore")
	arg_22_0._fireLockValue = var_0_4.GetCurrent(arg_22_0._client, "cloakFireLock")
	arg_22_0._cloakValue = 0
	arg_22_0._exposeSpeed = 0
	arg_22_0._cloakBottom = 0

	arg_22_0:adjustCloakAttr()

	arg_22_0._recovery = var_0_4.GetCurrent(arg_22_0._client, "cloakRecovery")
	arg_22_0._strikeExposeAdditive = var_0_4.GetCurrent(arg_22_0._client, "cloakStrikeAdditive")
	arg_22_0._bombardExposeAdditive = var_0_4.GetCurrent(arg_22_0._client, "cloakBombardAdditive")
	arg_22_0._strikeCount = 0
	arg_22_0._bombardCount = 0
	arg_22_0._strikeExposeAdditiveLimit = var_0_3.CLOAK_STRIKE_ADDITIVE_LIMIT
	arg_22_0._bombardExposeAdditiveLimit = var_0_3.CLOAK_STRIKE_ADDITIVE_LIMIT
	arg_22_0._exposeDotList = {}
	arg_22_0._currentState = var_0_6.STATE_CLOAK

	var_0_4.Cloak(arg_22_0._client)
	arg_22_0:triggerBuff()

	return
end

function var_0_6.triggerBuff(arg_23_0)
	local var_23_0 = var_0_4.GetCurrent(arg_23_0._client, "isCloak")
	local var_23_1 = arg_23_0._client

	var_2.DispatchCloakStateUpdate(var_23_1)

	return
end

function var_0_6.adjustCloakAttr(arg_24_0)
	math = var_1_10001
	arg_24_0._exposeBase = var_1_10001.max(arg_24_0._exposeBase, var_0_3.CLOAK_EXPOSE_BASE_MIN)
	math = var_1
	arg_24_0._exposeValue = var_1.max(arg_24_0._exposeBase + arg_24_0._exposeExtra, var_0_3.CLOAK_EXPOSE_SKILL_MIN)
	math = var_1
	arg_24_0._restoreValue = var_1.max(arg_24_0._exposeValue + var_0_3.CLOAK_BASE_RESTORE_DELTA, 0)
	Mathf = var_1
	arg_24_0._cloakValue = var_1.Clamp(arg_24_0._cloakValue, 0, arg_24_0._exposeValue)

	var_0_4.SetCurrent(arg_24_0._client, "cloakExposeBase", arg_24_0._exposeBase)
	var_0_4.SetCurrent(arg_24_0._client, "cloakRestore", arg_24_0._restoreValue)
	arg_24_0:UpdateCloakState()

	return
end

return
