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
local var_0_8 = var_0.Battle.BattleTargetChoise

class = var_0_10009

local var_0_9 = var_0_10009("BattleFleetSonar")

var_0.Battle.BattleFleetSonar = var_0_9
var_0_9.__name = "BattleFleetSonar"
var_0_9.STATE_DISABLE = "DISABLE"
var_0_9.STATE_OVER_HEAT = "OVER_HEAT"
var_0_9.STATE_READY = "READY"
var_0_9.STATE_DETECTING = "DETECTING"

function var_0_9.Ctor(arg_1_0, arg_1_1)
	arg_1_0:init()

	arg_1_0._fleetVO = arg_1_1

	return
end

function var_0_9.Dispose(arg_2_0)
	arg_2_0._detectedList = nil
	arg_2_0._crewUnitList = nil
	arg_2_0._host = nil

	return
end

function var_0_9.init(arg_3_0)
	arg_3_0._crewUnitList = {}
	arg_3_0._detectedList = {}

	return
end

function var_0_9.AppendCrewUnit(arg_4_0, arg_4_1)
	arg_4_0._crewUnitList[arg_4_1:GetUniqueID()] = arg_4_1

	arg_4_0:flush()

	arg_4_0._currentState = var_0_9.STATE_READY

	return
end

function var_0_9.RemoveCrewUnit(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetUniqueID()

	if arg_5_0._crewUnitList[var_5_0] then
		arg_5_0._crewUnitList[var_5_0] = nil

		arg_5_0:flush()
	end

	return
end

function var_0_9.SwitchHost(arg_6_0, arg_6_1)
	arg_6_0._host = arg_6_1

	return
end

function var_0_9.GetRange(arg_7_0)
	return arg_7_0._range
end

function var_0_9.flush(arg_8_0)
	arg_8_0._range, arg_8_0._interval, arg_8_0._duration = 0, 0, 0

	local var_8_0 = 0
	local var_8_1 = 0
	local var_8_2 = 0
	local var_8_3 = 0

	pairs = var_1_10005

	for iter_8_0, iter_8_1 in var_1_10005(arg_8_0._crewUnitList) do
		if iter_8_1:GetAttrByName("sonarRange") > 0 then
			var_8_0 = var_8_0 + 1

			local var_8_4 = iter_8_1:GetAttrByName("sonarInterval")
			local var_8_5 = iter_8_1
			local var_8_6 = iter_8_1.GetAttrByName(var_8_5, "sonarDuration")

			math = var_8_5
			var_8_1 = var_8_5.max(var_8_1, var_10)
			var_8_2 = var_8_4 + var_8_2
			math = var_13
			var_8_3 = var_13.max(var_8_3, var_8_6)
		end
	end

	if var_8_0 > 0 then
		arg_8_0._range = var_8_1
		arg_8_0._interval = var_8_2 / var_8_0 * (1 - (var_8_0 - 1) * var_0_4.SONAR_INTERVAL_K)
		arg_8_0._duration = var_8_3 * (1 + (var_8_0 - 1) * var_0_4.SONAR_DURATION_K)
	else
		arg_8_0:Undetect()

		arg_8_0._currentState = var_0_9.STATE_DISABLE
	end

	return
end

function var_0_9.Update(arg_9_0, arg_9_1)
	if arg_9_0._currentState == var_0_9.STATE_DISABLE then
		-- block empty
	elseif arg_9_0._currentState == var_0_9.STATE_READY then
		arg_9_0:Detect()
	elseif arg_9_0._currentState == var_0_9.STATE_OVER_HEAT then
		if arg_9_1 > arg_9_0._interval + arg_9_0._overheatStartTime then
			arg_9_0:Ready()
		end
	elseif arg_9_0._currentState == var_0_9.STATE_DETECTING then
		if arg_9_1 > arg_9_0._snoarStartTime + arg_9_0._duration then
			arg_9_0:Overheat()
		else
			arg_9_0:updateDetectedList()
		end
	end

	return
end

function var_0_9.Detect(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.TimeMgr.GetInstance()

	arg_10_0._snoarStartTime = var_1.GetCombatTime(var_10_0)
	arg_10_0._currentState = var_0_9.STATE_DETECTING

	local var_10_1 = arg_10_0
	local var_10_2 = arg_10_0.FilterTarget(var_10_1)

	ipairs = var_10_1

	for iter_10_0, iter_10_1 in var_10_1(var_10_2) do
		iter_10_1:Detected(10)
	end

	arg_10_0._detectedList = var_10_2

	local var_10_3 = arg_10_0._fleetVO

	var_2.DispatchSonarScan(var_10_3)

	return
end

function var_0_9.Undetect(arg_11_0)
	arg_11_0._snoarStartTime = nil
	arg_11_0._currentState = var_0_9.STATE_OVER_HEAT

	local var_11_0 = arg_11_0._detectedList

	ipairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(var_11_0) do
		if iter_11_1:IsAlive() then
			iter_11_1:Undetected()
		end
	end

	arg_11_0._detectedList = {}

	return
end

function var_0_9.updateDetectedList(arg_12_0)
	local var_12_0 = arg_12_0:FilterTarget()
	local var_12_1 = #arg_12_0._detectedList

	while var_12_1 > 0 do
		local var_12_2 = arg_12_0._detectedList[var_12_1]

		if not var_3.IsAlive(var_12_2) then
			table = var_4

			var_4.remove(arg_12_0._detectedList, var_12_1)
		else
			table = var_4

			if not var_4.contains(var_12_0, var_3) then
				var_3:Undetected()

				table = var_4

				var_4.remove(arg_12_0._detectedList, var_12_1)
			end
		end

		var_12_1 = var_12_1 - 1
	end

	return
end

function var_0_9.Overheat(arg_13_0)
	arg_13_0:Undetect()

	pg = var_1

	local var_13_0 = var_1.TimeMgr.GetInstance()

	arg_13_0._overheatStartTime = var_1.GetCombatTime(var_13_0)

	return
end

function var_0_9.Ready(arg_14_0)
	arg_14_0._overheatStartTime = nil
	arg_14_0._currentState = var_0_9.STATE_READY

	return
end

function var_0_9.FilterTarget(arg_15_0)
	local var_15_0 = var_0_8.LegalTarget(arg_15_0._host)
	local var_15_1 = var_0_8.TargetDiveState(arg_15_0._host, {
		diveState = var_0_3.OXY_STATE.DIVE
	}, var_15_0)

	return (arg_15_0:FilterRange(var_15_1))
end

function var_0_9.FilterRange(arg_16_0, arg_16_1)
	for iter_16_0 = #arg_16_1, 1, -1 do
		if arg_16_0:isOutOfRange(arg_16_1[iter_16_0]) then
			table = var_6

			var_6.remove(arg_16_1, iter_16_0)
		end
	end

	return arg_16_1
end

function var_0_9.isOutOfRange(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._host

	return var_2.GetDistance(var_17_0, arg_17_1) > arg_17_0._range
end

return
