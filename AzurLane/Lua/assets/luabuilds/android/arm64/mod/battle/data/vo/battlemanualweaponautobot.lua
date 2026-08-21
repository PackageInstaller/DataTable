ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleManualWeaponAutoBot = class("BattleManualWeaponAutoBot")
ys.Battle.BattleManualWeaponAutoBot.__name = "BattleManualWeaponAutoBot"

function ys.Battle.BattleManualWeaponAutoBot.Ctor(arg_1_0, arg_1_1)
	var_0_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._fleetVO = arg_1_1

	arg_1_0:init(arg_1_1)

	return
end

function ys.Battle.BattleManualWeaponAutoBot.init(arg_2_0)
	arg_2_0._active = false
	arg_2_0._isPlayFocus = true
	arg_2_0._chargeVO = arg_2_0._fleetVO:GetChargeWeaponVO()
	arg_2_0._torpedoVO = arg_2_0._fleetVO:GetTorpedoWeaponVO()
	arg_2_0._AAVO = arg_2_0._fleetVO:GetAirAssistVO()
	arg_2_0._totalTime = 0
	arg_2_0._lastActiveTimeStamp = nil

	return
end

function ys.Battle.BattleManualWeaponAutoBot.Update(arg_3_0)
	if arg_3_0._active then
		if not arg_3_0._torpedoVO:IsOverLoad() and arg_3_0._fleetVO:QuickCastTorpedo() then
			return
		end

		if not arg_3_0._AAVO:IsOverLoad() and arg_3_0._fleetVO:UnleashAllInStrike() then
			return
		end

		if not arg_3_0._chargeVO:IsOverLoad() and arg_3_0._fleetVO:QuickTagChrageWeapon(arg_3_0._isPlayFocus) then
			return
		end
	end

	return
end

function ys.Battle.BattleManualWeaponAutoBot.IsActive(arg_4_0)
	return arg_4_0._active
end

function ys.Battle.BattleManualWeaponAutoBot.SetActive(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._active ~= arg_5_1 and arg_5_1 == true then
		arg_5_0._lastActiveTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime()
	elseif arg_5_0._active ~= arg_5_1 and arg_5_1 == false and arg_5_0._lastActiveTimeStamp ~= nil then
		arg_5_0._totalTime = arg_5_0._totalTime + (pg.TimeMgr.GetInstance():GetCombatTime() - arg_5_0._lastActiveTimeStamp)
		arg_5_0._lastActiveTimeStamp = nil
	end

	arg_5_0._fleetVO:AutoBotUpdated(arg_5_1)

	arg_5_0._active = arg_5_1
	arg_5_0._isPlayFocus = arg_5_2

	return
end

function ys.Battle.BattleManualWeaponAutoBot.GetTotalActiveDuration(arg_6_0)
	if arg_6_0._lastActiveTimeStamp then
		arg_6_0._totalTime = arg_6_0._totalTime + (pg.TimeMgr.GetInstance():GetCombatTime() - arg_6_0._lastActiveTimeStamp)
		arg_6_0._lastActiveTimeStamp = nil
	end

	return arg_6_0._totalTime
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
