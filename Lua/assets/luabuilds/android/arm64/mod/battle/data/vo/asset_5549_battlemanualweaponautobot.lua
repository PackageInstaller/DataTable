ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleManualWeaponAutoBot = class("BattleManualWeaponAutoBot")
ys.Battle.BattleManualWeaponAutoBot.__name = "BattleManualWeaponAutoBot"

function ys.Battle.BattleManualWeaponAutoBot:Ctor(arg_1_1)
	var_0_0.EventListener.AttachEventListener(self)

	self._fleetVO = arg_1_1

	self:init(arg_1_1)

	return
end

function ys.Battle.BattleManualWeaponAutoBot:init()
	self._active = false
	self._isPlayFocus = true
	self._chargeVO = self._fleetVO:GetChargeWeaponVO()
	self._torpedoVO = self._fleetVO:GetTorpedoWeaponVO()
	self._AAVO = self._fleetVO:GetAirAssistVO()
	self._totalTime = 0
	self._lastActiveTimeStamp = nil

	return
end

function ys.Battle.BattleManualWeaponAutoBot:Update()
	if self._active then
		if not self._torpedoVO:IsOverLoad() and self._fleetVO:QuickCastTorpedo() then
			return
		end

		if not self._AAVO:IsOverLoad() and self._fleetVO:UnleashAllInStrike() then
			return
		end

		if not self._chargeVO:IsOverLoad() and self._fleetVO:QuickTagChrageWeapon(self._isPlayFocus) then
			return
		end
	end

	return
end

function ys.Battle.BattleManualWeaponAutoBot:IsActive()
	return self._active
end

function ys.Battle.BattleManualWeaponAutoBot:SetActive(arg_5_1, arg_5_2)
	if self._active ~= arg_5_1 and arg_5_1 == true then
		self._lastActiveTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime()
	elseif self._active ~= arg_5_1 and arg_5_1 == false and self._lastActiveTimeStamp ~= nil then
		self._totalTime = self._totalTime + (pg.TimeMgr.GetInstance():GetCombatTime() - self._lastActiveTimeStamp)
		self._lastActiveTimeStamp = nil
	end

	self._fleetVO:AutoBotUpdated(arg_5_1)

	self._active = arg_5_1
	self._isPlayFocus = arg_5_2

	return
end

function ys.Battle.BattleManualWeaponAutoBot:GetTotalActiveDuration()
	if self._lastActiveTimeStamp then
		self._totalTime = self._totalTime + (pg.TimeMgr.GetInstance():GetCombatTime() - self._lastActiveTimeStamp)
		self._lastActiveTimeStamp = nil
	end

	return self._totalTime
end

function ys.Battle.BattleManualWeaponAutoBot.Dispose(arg_7_0)
	arg_7_0._chargeVO = nil
	arg_7_0._torpedoVO = nil
	arg_7_0._AAVO = nil
	arg_7_0._dataProxy = nil
	arg_7_0._uiMediator = nil

	var_0_0.EventListener.DetachEventListener(arg_7_0)

	return
end

return
