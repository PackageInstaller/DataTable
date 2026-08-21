ys = ys or {}

local var_0_7 = class("BattleFleetCardPuzzleAntiAirUnit")

ys.Battle.BattleFleetCardPuzzleAntiAirUnit = var_0_7
var_0_7.__name = "BattleFleetCardPuzzleAntiAirUnit"
var_0_7.STATE_DISABLE = "DISABLE"
var_0_7.STATE_READY = "READY"
var_0_7.STATE_PRECAST = "PRECAST"
var_0_7.STATE_PRECAST_FINISH = "STATE_PRECAST_FINISH"
var_0_7.STATE_ATTACK = "ATTACK"
var_0_7.STATE_OVER_HEAT = "OVER_HEAT"

function var_0_7.Ctor(arg_1_0, arg_1_1)
	arg_1_0._client = arg_1_1

	arg_1_0:init()

	return
end

function var_0_7.init(arg_2_0)
	arg_2_0._crewUnitList = {}
	arg_2_0._hitFXResIDList = {}
	arg_2_0._currentState = var_0_7.STATE_DISABLE
	arg_2_0._dataProxy = var_0.Battle.BattleDataProxy.GetInstance()
	arg_2_0._range = 0

	return
end

function var_0_7.AppendCrewUnit(arg_3_0, arg_3_1)
	arg_3_0._crewUnitList[arg_3_1] = true
	arg_3_0._currentState = var_0_7.STATE_READY

	arg_3_0:flush()

	return
end

function var_0_7.RemoveCrewUnit(arg_4_0, arg_4_1)
	arg_4_0._crewUnitList[arg_4_1] = nil

	arg_4_0:flush()

	return
end

function var_0_7.SwitchHost(arg_5_0, arg_5_1)
	arg_5_0._host = arg_5_1

	return
end

function var_0_7.GetCrewUnitList(arg_6_0)
	return arg_6_0._crewUnitList
end

function var_0_7.GetRange(arg_7_0)
	return arg_7_0._range
end

function var_0_7.flush(arg_8_0)
	arg_8_0._range = 0
	arg_8_0._interval = 0

	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(arg_8_0._crewUnitList) do
		arg_8_0._range = arg_8_0._range + iter_8_0:GetTemplate().AA_range
		arg_8_0._interval = arg_8_0._interval + iter_8_0:GetTemplate().AA_CD
		var_8_0 = var_8_0 + 1
	end

	arg_8_0._range = arg_8_0._range / var_8_0
	arg_8_0._interval = arg_8_0._interval / var_8_0

	return
end

function var_0_7.Update(arg_9_0)
	if arg_9_0._client:IsAAActive() and arg_9_0._currentState == var_0_7.STATE_READY then
		local var_9_0 = arg_9_0:CompareDistance((arg_9_0:FilterRange((arg_9_0:FilterTarget()))))

		if var_9_0 then
			arg_9_0:Fire(var_9_0)
		end
	end

	return
end

function var_0_7.FilterTarget(arg_10_0)
	local var_10_0 = arg_10_0._host:GetIFF()

	for iter_10_0, iter_10_1 in pairs((arg_10_0._dataProxy:GetAircraftList())) do
		local var_10_1

		if iter_10_1:GetIFF() ~= var_10_0 and iter_10_1:IsVisitable() then
			({})[1] = iter_10_1
			var_10_1 = 1 + 1
		end
	end

	return {}
end

function var_0_7.FilterRange(arg_11_0, arg_11_1)
	for iter_11_0 = #arg_11_1, 1, -1 do
		if arg_11_0:IsOutOfRange(arg_11_1[iter_11_0]) then
			table.remove(arg_11_1, iter_11_0)
		end
	end

	return arg_11_1
end

function var_0_7.IsOutOfRange(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getTrackingHost()

	return var_12_0:GetDistance(arg_12_1) > arg_12_0._range
end

function var_0_7.CompareDistance(arg_13_0, arg_13_1)
	local var_13_0

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_1

		if 999999 > iter_13_1:GetPosition().x then
			var_13_0 = iter_13_1
			var_13_1 = iter_13_1:GetPosition().x
		end
	end

	return var_13_0
end

function var_0_7.getTrackingHost(arg_14_0)
	return arg_14_0._host
end

function var_0_7.Fire(arg_15_0, arg_15_1)
	if arg_15_0._currentState == arg_15_0.DISABLE then
		return
	end

	arg_15_0._dataProxy:KillAircraft((arg_15_1:GetUniqueID()))
	arg_15_0:EnterCoolDown()
	arg_15_0._client:ConsumeAACounter()

	return
end

function var_0_7.EnterCoolDown(arg_16_0)
	arg_16_0._currentState = arg_16_0.STATE_OVER_HEAT

	arg_16_0:AddCDTimer(arg_16_0._interval)

	return
end

function var_0_7.GetCurrentState(arg_17_0)
	return arg_17_0._currentState
end

function var_0_7.AddCDTimer(arg_18_0, arg_18_1)
	arg_18_0:RemoveCDTimer()

	arg_18_0._cdTimer = pg.TimeMgr.GetInstance():AddBattleTimer("weaponTimer", -1, arg_18_1, function()
		arg_18_0._currentState = arg_18_0.STATE_READY

		arg_18_0:RemoveCDTimer()

		return
	end, true)

	return
end

function var_0_7.RemoveCDTimer(arg_20_0)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_20_0._cdTimer)

	arg_20_0._cdTimer = nil

	return
end

function var_0_7.Dispose(arg_21_0)
	arg_21_0:RemoveCDTimer()

	arg_21_0._crewUnitList = nil
	arg_21_0._hitFXResIDList = nil
	arg_21_0._dataProxy = nil
	arg_21_0._SFXID = nil

	return
end

return
