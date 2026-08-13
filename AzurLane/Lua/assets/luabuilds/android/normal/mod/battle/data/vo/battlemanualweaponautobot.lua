ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleVariable
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleManualWeaponAutoBot = var_0_10004("BattleManualWeaponAutoBot")
var_0.Battle.BattleManualWeaponAutoBot.__name = "BattleManualWeaponAutoBot"

local var_0_4 = var_0.Battle.BattleManualWeaponAutoBot

function var_0_4.Ctor(arg_1_0, arg_1_1)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._fleetVO = arg_1_1

	arg_1_0:init(arg_1_1)

	return
end

function var_0_4.init(arg_2_0)
	arg_2_0._active = false
	arg_2_0._isPlayFocus = true

	local var_2_0 = arg_2_0._fleetVO

	arg_2_0._chargeVO = var_1.GetChargeWeaponVO(var_2_0)

	local var_2_1 = arg_2_0._fleetVO

	arg_2_0._torpedoVO = var_1.GetTorpedoWeaponVO(var_2_1)

	local var_2_2 = arg_2_0._fleetVO

	arg_2_0._AAVO = var_1.GetAirAssistVO(var_2_2)
	arg_2_0._totalTime = 0
	arg_2_0._lastActiveTimeStamp = nil

	return
end

function var_0_4.Update(arg_3_0)
	if arg_3_0._active then
		local var_3_0 = arg_3_0._torpedoVO

		if not var_1.IsOverLoad(var_3_0) then
			local var_3_1 = arg_3_0._fleetVO

			if var_1.QuickCastTorpedo(var_3_1) then
				return
			end
		end

		local var_3_2 = arg_3_0._AAVO

		if not var_1.IsOverLoad(var_3_2) then
			local var_3_3 = arg_3_0._fleetVO

			if var_1.UnleashAllInStrike(var_3_3) then
				return
			end
		end

		local var_3_4 = arg_3_0._chargeVO

		if not var_1.IsOverLoad(var_3_4) then
			local var_3_5 = arg_3_0._fleetVO

			if var_1.QuickTagChrageWeapon(var_3_5, arg_3_0._isPlayFocus) then
				return
			end
		end
	end

	return
end

function var_0_4.IsActive(arg_4_0)
	return arg_4_0._active
end

function var_0_4.SetActive(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._active ~= arg_5_1 and arg_5_1 == true then
		pg = var_3

		local var_5_0 = var_3.TimeMgr.GetInstance()

		arg_5_0._lastActiveTimeStamp = var_3.GetCombatTime(var_5_0)
	elseif arg_5_0._active ~= arg_5_1 and arg_5_1 == false and arg_5_0._lastActiveTimeStamp ~= nil then
		pg = var_3

		local var_5_1 = var_3.TimeMgr.GetInstance()
		local var_5_2 = var_3.GetCombatTime(var_5_1)

		arg_5_0._totalTime = arg_5_0._totalTime + (var_5_2 - arg_5_0._lastActiveTimeStamp)
		arg_5_0._lastActiveTimeStamp = nil
	end

	local var_5_3 = arg_5_0._fleetVO

	var_3.AutoBotUpdated(var_5_3, arg_5_1)

	arg_5_0._active = arg_5_1
	arg_5_0._isPlayFocus = arg_5_2

	return
end

function var_0_4.GetTotalActiveDuration(arg_6_0)
	if arg_6_0._lastActiveTimeStamp then
		pg = var_1

		local var_6_0 = var_1.TimeMgr.GetInstance()
		local var_6_1 = var_1.GetCombatTime(var_6_0)

		arg_6_0._totalTime = arg_6_0._totalTime + (var_6_1 - arg_6_0._lastActiveTimeStamp)
		arg_6_0._lastActiveTimeStamp = nil
	end

	return arg_6_0._totalTime
end

function var_0_4.Dispose(arg_7_0)
	arg_7_0._chargeVO = nil
	arg_7_0._torpedoVO = nil
	arg_7_0._AAVO = nil
	arg_7_0._dataProxy = nil
	arg_7_0._uiMediator = nil

	var_0.EventListener.DetachEventListener(arg_7_0)

	return
end

return
