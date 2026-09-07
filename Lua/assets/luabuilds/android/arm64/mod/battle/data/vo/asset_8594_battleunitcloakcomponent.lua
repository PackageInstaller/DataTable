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

function ys.Battle.BattleUnitCloakComponent:Ctor(arg_1_1)
	self._client = arg_1_1

	self:initCloak()

	return
end

function ys.Battle.BattleUnitCloakComponent:Update(arg_2_1)
	self._lastCloakUpdateStamp = self._lastCloakUpdateStamp or arg_2_1

	self:updateCloakValue(arg_2_1)
	self:UpdateCloakState()

	self._lastCloakUpdateStamp = arg_2_1

	var_0_0.Battle.BattleBuffDOT.UpdateCloakLock(self._client)

	return
end

function ys.Battle.BattleUnitCloakComponent:UpdateCloakConfig()
	self._exposeBase = var_0_4.GetCurrent(self._client, "cloakExposeBase")
	self._exposeExtra = var_0_4.GetCurrent(self._client, "cloakExposeExtra")
	self._restoreValue = var_0_4.GetCurrent(self._client, "cloakRestore")
	self._recovery = var_0_4.GetCurrent(self._client, "cloakRecovery")

	self:adjustCloakAttr()
	self._client:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_CLOAK_CONFIG))

	return
end

function ys.Battle.BattleUnitCloakComponent.SetRecoverySpeed(arg_4_0, arg_4_1)
	arg_4_0._fieldRecoveryOverride = arg_4_1

	return
end

function ys.Battle.BattleUnitCloakComponent:AppendExpose(arg_5_1)
	self._cloakValue = Mathf.Clamp(self._cloakValue + arg_5_1, self:GetCloakBottom(), self._exposeValue)

	self:UpdateCloakState()

	return
end

function ys.Battle.BattleUnitCloakComponent:AppendStrikeExpose()
	self._strikeCount = self._strikeCount + 1

	self:AppendExpose((math.min(self._strikeExposeAdditive * self._strikeCount, self._strikeExposeAdditiveLimit)))

	return
end

function ys.Battle.BattleUnitCloakComponent:AppendBombardExpose()
	self._bombardCount = self._bombardCount + 1

	self:AppendExpose((math.min(self._bombardExposeAdditive * self._bombardCount, self._bombardExposeAdditiveLimit)))

	return
end

function ys.Battle.BattleUnitCloakComponent.AppendExposeSpeed(arg_8_0, arg_8_1)
	arg_8_0._exposeSpeed = arg_8_1

	return
end

function ys.Battle.BattleUnitCloakComponent:ForceToMax()
	self:ForceToRate(1)

	return
end

function ys.Battle.BattleUnitCloakComponent:ForceToRate(arg_10_1)
	self._cloakValue = math.floor(arg_10_1 * self._exposeValue)

	self:UpdateCloakState()

	return
end

function ys.Battle.BattleUnitCloakComponent:UpdateDotExpose(arg_11_1)
	if arg_11_1 ~= self._cloakBottom then
		self._cloakBottom = arg_11_1

		self._client:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_CLOAK_LOCK))
	end

	return
end

function ys.Battle.BattleUnitCloakComponent:UpdateTauntExpose(arg_12_1)
	self._tauntCloakBottom = arg_12_1 and self._restoreValue or nil

	return
end

function ys.Battle.BattleUnitCloakComponent:UpdateCloakState()
	local var_13_0

	if self._cloakValue >= self._exposeValue then
		var_13_0 = var_0_5.STATE_UNCLOAK
	elseif self._cloakValue < self._restoreValue then
		var_13_0 = var_0_5.STATE_CLOAK
	end

	if var_13_0 and var_13_0 ~= self._currentState then
		self._currentState = var_13_0

		if self._currentState == var_0_5.STATE_UNCLOAK then
			var_0_4.Uncloak(self._client)
			self:triggerBuff()
		elseif self._currentState == var_0_5.STATE_CLOAK then
			var_0_4.Cloak(self._client)
			self:triggerBuff()
		end
	end

	return
end

function ys.Battle.BattleUnitCloakComponent:GetCloakValue()
	return self._cloakValue
end

function ys.Battle.BattleUnitCloakComponent:GetCloakMax()
	return self._exposeValue
end

function ys.Battle.BattleUnitCloakComponent:GetCloakLockMin()
	return self._fireLockValue
end

function ys.Battle.BattleUnitCloakComponent:GetCloakRestoreValue()
	return self._restoreValue
end

function ys.Battle.BattleUnitCloakComponent:GetCloakBottom()
	if self._tauntCloakBottom then
		return math.max(self._tauntCloakBottom, self._cloakBottom)
	else
		return self._cloakBottom
	end

	return
end

function ys.Battle.BattleUnitCloakComponent:GetCurrentState()
	return self._currentState
end

function ys.Battle.BattleUnitCloakComponent:GetExposeSpeed()
	return self._exposeSpeed
end

function ys.Battle.BattleUnitCloakComponent:updateCloakValue(arg_21_1)
	self:AppendExpose((self._exposeSpeed - (self._fieldRecoveryOverride or self._recovery)) * (arg_21_1 - self._lastCloakUpdateStamp))

	return
end

function ys.Battle.BattleUnitCloakComponent:initCloak()
	self._exposeBase = var_0_4.GetCurrent(self._client, "cloakExposeBase")
	self._exposeExtra = var_0_4.GetCurrent(self._client, "cloakExposeExtra")
	self._restoreValue = var_0_4.GetCurrent(self._client, "cloakRestore")
	self._fireLockValue = var_0_4.GetCurrent(self._client, "cloakFireLock")
	self._cloakValue = 0
	self._exposeSpeed = 0
	self._cloakBottom = 0

	self:adjustCloakAttr()

	self._recovery = var_0_4.GetCurrent(self._client, "cloakRecovery")
	self._strikeExposeAdditive = var_0_4.GetCurrent(self._client, "cloakStrikeAdditive")
	self._bombardExposeAdditive = var_0_4.GetCurrent(self._client, "cloakBombardAdditive")
	self._strikeCount = 0
	self._bombardCount = 0
	self._strikeExposeAdditiveLimit = var_0_3.CLOAK_STRIKE_ADDITIVE_LIMIT
	self._bombardExposeAdditiveLimit = var_0_3.CLOAK_STRIKE_ADDITIVE_LIMIT
	self._exposeDotList = {}
	self._currentState = var_0_5.STATE_CLOAK

	var_0_4.Cloak(self._client)
	self:triggerBuff()

	return
end

function ys.Battle.BattleUnitCloakComponent:triggerBuff()
	local var_23_0 = var_0_4.GetCurrent(self._client, "isCloak")

	self._client:DispatchCloakStateUpdate()

	return
end

function ys.Battle.BattleUnitCloakComponent:adjustCloakAttr()
	self._exposeBase = math.max(self._exposeBase, var_0_3.CLOAK_EXPOSE_BASE_MIN)
	self._exposeValue = math.max(self._exposeBase + self._exposeExtra, var_0_3.CLOAK_EXPOSE_SKILL_MIN)
	self._restoreValue = math.max(self._exposeValue + var_0_3.CLOAK_BASE_RESTORE_DELTA, 0)
	self._cloakValue = Mathf.Clamp(self._cloakValue, 0, self._exposeValue)

	var_0_4.SetCurrent(self._client, "cloakExposeBase", self._exposeBase)
	var_0_4.SetCurrent(self._client, "cloakRestore", self._restoreValue)
	self:UpdateCloakState()

	return
end

return
