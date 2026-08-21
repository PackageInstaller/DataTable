ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_3 = ys.Battle.BattleConfig
local var_0_4 = ys.Battle.BattleAttr

ys.Battle.BattleUnitCloakComponent = class("BattleUnitCloakComponent")
ys.Battle.BattleUnitCloakComponent.__name = "BattleUnitCloakComponent"

local var_0_5 = ys.Battle.BattleUnitCloakComponent

ys.Battle.BattleUnitCloakComponent.STATE_CLOAK = "STATE_CLOAK"
ys.Battle.BattleUnitCloakComponent.STATE_UNCLOAK = "STATE_UNCLOAK"

function ys.Battle.BattleUnitCloakComponent.Ctor(arg_1_0, arg_1_1)
	arg_1_0._client = arg_1_1

	arg_1_0:initCloak()

	return
end

function ys.Battle.BattleUnitCloakComponent.Update(arg_2_0, arg_2_1)
	arg_2_0._lastCloakUpdateStamp = arg_2_0._lastCloakUpdateStamp or arg_2_1

	arg_2_0:updateCloakValue(arg_2_1)
	arg_2_0:UpdateCloakState()

	arg_2_0._lastCloakUpdateStamp = arg_2_1

	var_0_0.Battle.BattleBuffDOT.UpdateCloakLock(arg_2_0._client)

	return
end

function ys.Battle.BattleUnitCloakComponent.UpdateCloakConfig(arg_3_0)
	arg_3_0._exposeBase = var_0_4.GetCurrent(arg_3_0._client, "cloakExposeBase")
	arg_3_0._exposeExtra = var_0_4.GetCurrent(arg_3_0._client, "cloakExposeExtra")
	arg_3_0._restoreValue = var_0_4.GetCurrent(arg_3_0._client, "cloakRestore")
	arg_3_0._recovery = var_0_4.GetCurrent(arg_3_0._client, "cloakRecovery")

	arg_3_0:adjustCloakAttr()
	arg_3_0._client:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_CLOAK_CONFIG))

	return
end

function ys.Battle.BattleUnitCloakComponent.SetRecoverySpeed(arg_4_0, arg_4_1)
	arg_4_0._fieldRecoveryOverride = arg_4_1

	return
end

function ys.Battle.BattleUnitCloakComponent.AppendExpose(arg_5_0, arg_5_1)
	arg_5_0._cloakValue = Mathf.Clamp(arg_5_0._cloakValue + arg_5_1, arg_5_0:GetCloakBottom(), arg_5_0._exposeValue)

	arg_5_0:UpdateCloakState()

	return
end

function ys.Battle.BattleUnitCloakComponent.AppendStrikeExpose(arg_6_0)
	arg_6_0._strikeCount = arg_6_0._strikeCount + 1

	arg_6_0:AppendExpose((math.min(arg_6_0._strikeExposeAdditive * arg_6_0._strikeCount, arg_6_0._strikeExposeAdditiveLimit)))

	return
end

function ys.Battle.BattleUnitCloakComponent.AppendBombardExpose(arg_7_0)
	arg_7_0._bombardCount = arg_7_0._bombardCount + 1

	arg_7_0:AppendExpose((math.min(arg_7_0._bombardExposeAdditive * arg_7_0._bombardCount, arg_7_0._bombardExposeAdditiveLimit)))

	return
end

function ys.Battle.BattleUnitCloakComponent.AppendExposeSpeed(arg_8_0, arg_8_1)
	arg_8_0._exposeSpeed = arg_8_1

	return
end

function ys.Battle.BattleUnitCloakComponent.ForceToMax(arg_9_0)
	arg_9_0:ForceToRate(1)

	return
end

function ys.Battle.BattleUnitCloakComponent.ForceToRate(arg_10_0, arg_10_1)
	arg_10_0._cloakValue = math.floor(arg_10_1 * arg_10_0._exposeValue)

	arg_10_0:UpdateCloakState()

	return
end

function ys.Battle.BattleUnitCloakComponent.UpdateDotExpose(arg_11_0, arg_11_1)
	if arg_11_1 ~= arg_11_0._cloakBottom then
		arg_11_0._cloakBottom = arg_11_1

		arg_11_0._client:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_CLOAK_LOCK))
	end

	return
end

function ys.Battle.BattleUnitCloakComponent.UpdateTauntExpose(arg_12_0, arg_12_1)
	arg_12_0._tauntCloakBottom = arg_12_1 and arg_12_0._restoreValue or nil

	return
end

function ys.Battle.BattleUnitCloakComponent.UpdateCloakState(arg_13_0)
	local var_13_0

	if arg_13_0._cloakValue >= arg_13_0._exposeValue then
		var_13_0 = var_0_5.STATE_UNCLOAK
	elseif arg_13_0._cloakValue < arg_13_0._restoreValue then
		var_13_0 = var_0_5.STATE_CLOAK
	end

	if var_13_0 and var_13_0 ~= arg_13_0._currentState then
		arg_13_0._currentState = var_13_0

		if arg_13_0._currentState == var_0_5.STATE_UNCLOAK then
			var_0_4.Uncloak(arg_13_0._client)
			arg_13_0:triggerBuff()
		elseif arg_13_0._currentState == var_0_5.STATE_CLOAK then
			var_0_4.Cloak(arg_13_0._client)
			arg_13_0:triggerBuff()
		end
	end

	return
end

function ys.Battle.BattleUnitCloakComponent.GetCloakValue(arg_14_0)
	return arg_14_0._cloakValue
end

function ys.Battle.BattleUnitCloakComponent.GetCloakMax(arg_15_0)
	return arg_15_0._exposeValue
end

function ys.Battle.BattleUnitCloakComponent.GetCloakLockMin(arg_16_0)
	return arg_16_0._fireLockValue
end

function ys.Battle.BattleUnitCloakComponent.GetCloakRestoreValue(arg_17_0)
	return arg_17_0._restoreValue
end

function ys.Battle.BattleUnitCloakComponent.GetCloakBottom(arg_18_0)
	if arg_18_0._tauntCloakBottom then
		return math.max(arg_18_0._tauntCloakBottom, arg_18_0._cloakBottom)
	else
		return arg_18_0._cloakBottom
	end

	return
end

function ys.Battle.BattleUnitCloakComponent.GetCurrentState(arg_19_0)
	return arg_19_0._currentState
end

function ys.Battle.BattleUnitCloakComponent.GetExposeSpeed(arg_20_0)
	return arg_20_0._exposeSpeed
end

function ys.Battle.BattleUnitCloakComponent.updateCloakValue(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._fieldRecoveryOverride or arg_21_0._recovery

	arg_21_0:AppendExpose((arg_21_0._exposeSpeed - var_21_0) * (arg_21_1 - arg_21_0._lastCloakUpdateStamp))

	return
end

function ys.Battle.BattleUnitCloakComponent.initCloak(arg_22_0)
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
	arg_22_0._currentState = var_0_5.STATE_CLOAK

	var_0_4.Cloak(arg_22_0._client)
	arg_22_0:triggerBuff()

	return
end

function ys.Battle.BattleUnitCloakComponent.triggerBuff(arg_23_0)
	local var_23_0 = var_0_4.GetCurrent(arg_23_0._client, "isCloak")

	arg_23_0._client:DispatchCloakStateUpdate()

	return
end

function ys.Battle.BattleUnitCloakComponent.adjustCloakAttr(arg_24_0)
	arg_24_0._exposeBase = math.max(arg_24_0._exposeBase, var_0_3.CLOAK_EXPOSE_BASE_MIN)
	arg_24_0._exposeValue = math.max(arg_24_0._exposeBase + arg_24_0._exposeExtra, var_0_3.CLOAK_EXPOSE_SKILL_MIN)
	arg_24_0._restoreValue = math.max(arg_24_0._exposeValue + var_0_3.CLOAK_BASE_RESTORE_DELTA, 0)
	arg_24_0._cloakValue = Mathf.Clamp(arg_24_0._cloakValue, 0, arg_24_0._exposeValue)

	var_0_4.SetCurrent(arg_24_0._client, "cloakExposeBase", arg_24_0._exposeBase)
	var_0_4.SetCurrent(arg_24_0._client, "cloakRestore", arg_24_0._restoreValue)
	arg_24_0:UpdateCloakState()

	return
end

return
