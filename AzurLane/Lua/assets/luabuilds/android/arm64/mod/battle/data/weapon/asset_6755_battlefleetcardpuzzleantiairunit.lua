ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleEvent
local var_0_2 = var_0.Battle.BattleFormulas
local var_0_3 = var_0.Battle.BattleConst
local var_0_4 = var_0.Battle.BattleConfig
local var_0_5 = var_0.Battle.BattleDataFunction
local var_0_6 = var_0.Battle.BattleAttr
local var_0_7 = var_0.Battle.BattleVariable

class = var_0_10008

local var_0_8 = var_0_10008("BattleFleetCardPuzzleAntiAirUnit")

var_0.Battle.BattleFleetCardPuzzleAntiAirUnit = var_0_8
var_0_8.__name = "BattleFleetCardPuzzleAntiAirUnit"
var_0_8.STATE_DISABLE = "DISABLE"
var_0_8.STATE_READY = "READY"
var_0_8.STATE_PRECAST = "PRECAST"
var_0_8.STATE_PRECAST_FINISH = "STATE_PRECAST_FINISH"
var_0_8.STATE_ATTACK = "ATTACK"
var_0_8.STATE_OVER_HEAT = "OVER_HEAT"

function var_0_8.Ctor(arg_1_0, arg_1_1)
	arg_1_0._client = arg_1_1

	arg_1_0:init()

	return
end

function var_0_8.init(arg_2_0)
	arg_2_0._crewUnitList = {}
	arg_2_0._hitFXResIDList = {}
	arg_2_0._currentState = var_0_8.STATE_DISABLE
	arg_2_0._dataProxy = var_0.Battle.BattleDataProxy.GetInstance()
	arg_2_0._range = 0

	return
end

function var_0_8.AppendCrewUnit(arg_3_0, arg_3_1)
	arg_3_0._crewUnitList[arg_3_1] = true
	arg_3_0._currentState = var_0_8.STATE_READY

	arg_3_0:flush()

	return
end

function var_0_8.RemoveCrewUnit(arg_4_0, arg_4_1)
	arg_4_0._crewUnitList[arg_4_1] = nil

	arg_4_0:flush()

	return
end

function var_0_8.SwitchHost(arg_5_0, arg_5_1)
	arg_5_0._host = arg_5_1

	return
end

function var_0_8.GetCrewUnitList(arg_6_0)
	return arg_6_0._crewUnitList
end

function var_0_8.GetRange(arg_7_0)
	return arg_7_0._range
end

function var_0_8.flush(arg_8_0)
	arg_8_0._range = 0
	arg_8_0._interval = 0

	local var_8_0 = 0

	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0._crewUnitList) do
		arg_8_0._range = arg_8_0._range + iter_8_0:GetTemplate().AA_range
		arg_8_0._interval = arg_8_0._interval + iter_8_0:GetTemplate().AA_CD
		var_8_0 = var_8_0 + 1
	end

	arg_8_0._range = arg_8_0._range / var_8_0
	arg_8_0._interval = arg_8_0._interval / var_8_0

	return
end

function var_0_8.Update(arg_9_0)
	local var_9_0 = arg_9_0._client

	if var_1.IsAAActive(var_9_0) and arg_9_0._currentState == var_0_8.STATE_READY then
		local var_9_1 = arg_9_0:FilterTarget()
		local var_9_2 = arg_9_0:FilterRange(var_9_1)

		if arg_9_0:CompareDistance(var_9_2) then
			arg_9_0:Fire(var_2)
		end
	end

	return
end

function var_0_8.FilterTarget(arg_10_0)
	local var_10_0 = arg_10_0._dataProxy
	local var_10_1 = var_1.GetAircraftList(var_10_0)
	local var_10_2 = {}
	local var_10_3 = arg_10_0._host
	local var_10_4 = var_3.GetIFF(var_10_3)
	local var_10_5 = 1

	pairs = var_10_3

	for iter_10_0, iter_10_1 in var_10_3(var_10_1) do
		if iter_10_1:GetIFF() ~= var_10_4 and iter_10_1:IsVisitable() then
			var_10_2[var_10_5] = iter_10_1
			var_10_5 = var_10_5 + 1
		end
	end

	return var_10_2
end

function var_0_8.FilterRange(arg_11_0, arg_11_1)
	for iter_11_0 = #arg_11_1, 1, -1 do
		if arg_11_0:IsOutOfRange(arg_11_1[iter_11_0]) then
			table = var_6

			var_6.remove(arg_11_1, iter_11_0)
		end
	end

	return arg_11_1
end

function var_0_8.IsOutOfRange(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getTrackingHost()

	return var_2.GetDistance(var_12_0, arg_12_1) > arg_12_0._range
end

function var_0_8.CompareDistance(arg_13_0, arg_13_1)
	local var_13_0 = 999999
	local var_13_1

	ipairs = var_1_10004

	for iter_13_0, iter_13_1 in var_1_10004(arg_13_1) do
		if var_13_0 > iter_13_1:GetPosition().x then
			var_13_1 = iter_13_1
			var_13_0 = iter_13_1:GetPosition().x
		end
	end

	return var_13_1
end

function var_0_8.getTrackingHost(arg_14_0)
	return arg_14_0._host
end

function var_0_8.Fire(arg_15_0, arg_15_1)
	if arg_15_0._currentState == arg_15_0.DISABLE then
		return
	end

	local var_15_0 = arg_15_1:GetUniqueID()
	local var_15_1 = arg_15_0._dataProxy

	var_3.KillAircraft(var_15_1, var_15_0)
	arg_15_0:EnterCoolDown()

	local var_15_2 = arg_15_0._client

	var_3.ConsumeAACounter(var_15_2)

	return
end

function var_0_8.EnterCoolDown(arg_16_0)
	arg_16_0._currentState = arg_16_0.STATE_OVER_HEAT

	arg_16_0:AddCDTimer(arg_16_0._interval)

	return
end

function var_0_8.GetCurrentState(arg_17_0)
	return arg_17_0._currentState
end

function var_0_8.AddCDTimer(arg_18_0, arg_18_1)
	local function var_18_0()
		arg_18_0._currentState = arg_18_0.STATE_READY

		local var_19_0 = arg_18_0

		var_0.RemoveCDTimer(var_19_0)

		return
	end

	arg_18_0:RemoveCDTimer()

	pg = var_3

	local var_18_1 = var_3.TimeMgr.GetInstance()

	arg_18_0._cdTimer = var_3.AddBattleTimer(var_18_1, "weaponTimer", -1, arg_18_1, var_18_0, true)

	return
end

function var_0_8.RemoveCDTimer(arg_20_0)
	pg = var_1_10001

	local var_20_0 = var_1_10001.TimeMgr.GetInstance()

	var_1.RemoveBattleTimer(var_20_0, arg_20_0._cdTimer)

	arg_20_0._cdTimer = nil

	return
end

function var_0_8.Dispose(arg_21_0)
	arg_21_0:RemoveCDTimer()

	arg_21_0._crewUnitList = nil
	arg_21_0._hitFXResIDList = nil
	arg_21_0._dataProxy = nil
	arg_21_0._SFXID = nil

	return
end

return
