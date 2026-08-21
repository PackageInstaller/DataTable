ys = ys or {}

local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleConfig
local var_0_7 = ys.Battle.BattleTargetChoise
local var_0_8 = class("BattleFleetSonar")

ys.Battle.BattleFleetSonar = var_0_8
var_0_8.__name = "BattleFleetSonar"
var_0_8.STATE_DISABLE = "DISABLE"
var_0_8.STATE_OVER_HEAT = "OVER_HEAT"
var_0_8.STATE_READY = "READY"
var_0_8.STATE_DETECTING = "DETECTING"

function var_0_8.Ctor(arg_1_0, arg_1_1)
	arg_1_0:init()

	arg_1_0._fleetVO = arg_1_1

	return
end

function var_0_8.Dispose(arg_2_0)
	arg_2_0._detectedList = nil
	arg_2_0._crewUnitList = nil
	arg_2_0._host = nil

	return
end

function var_0_8.init(arg_3_0)
	arg_3_0._crewUnitList = {}
	arg_3_0._detectedList = {}

	return
end

function var_0_8.AppendCrewUnit(arg_4_0, arg_4_1)
	arg_4_0._crewUnitList[arg_4_1:GetUniqueID()] = arg_4_1

	arg_4_0:flush()

	arg_4_0._currentState = var_0_8.STATE_READY

	return
end

function var_0_8.RemoveCrewUnit(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetUniqueID()

	if arg_5_0._crewUnitList[var_5_0] then
		arg_5_0._crewUnitList[var_5_0] = nil

		arg_5_0:flush()
	end

	return
end

function var_0_8.SwitchHost(arg_6_0, arg_6_1)
	arg_6_0._host = arg_6_1

	return
end

function var_0_8.GetRange(arg_7_0)
	return arg_7_0._range
end

function var_0_8.flush(arg_8_0)
	arg_8_0._range, arg_8_0._interval, arg_8_0._duration = 0, 0, 0

	local var_8_0 = 0
	local var_8_1 = 0
	local var_8_2 = 0
	local var_8_3 = 0

	for iter_8_0, iter_8_1 in pairs(arg_8_0._crewUnitList) do
		local var_8_4 = iter_8_1:GetAttrByName("sonarRange")

		if var_8_4 > 0 then
			var_8_0 = var_8_0 + 1
			var_8_1 = math.max(var_8_1, var_8_4)
			var_8_2 = iter_8_1:GetAttrByName("sonarInterval") + var_8_2
			var_8_3 = math.max(var_8_3, (iter_8_1:GetAttrByName("sonarDuration")))
		end
	end

	if var_8_0 > 0 then
		arg_8_0._range = var_8_1
		arg_8_0._interval = var_8_2 / var_8_0 * (1 - (var_8_0 - 1) * var_0_3.SONAR_INTERVAL_K)
		arg_8_0._duration = var_8_3 * (1 + (var_8_0 - 1) * var_0_3.SONAR_DURATION_K)
	else
		arg_8_0:Undetect()

		arg_8_0._currentState = var_0_8.STATE_DISABLE
	end

	return
end

function var_0_8.Update(arg_9_0, arg_9_1)
	if arg_9_0._currentState == var_0_8.STATE_DISABLE then
		-- block empty
	elseif arg_9_0._currentState == var_0_8.STATE_READY then
		arg_9_0:Detect()
	elseif arg_9_0._currentState == var_0_8.STATE_OVER_HEAT then
		if arg_9_1 > arg_9_0._interval + arg_9_0._overheatStartTime then
			arg_9_0:Ready()
		end
	elseif arg_9_0._currentState == var_0_8.STATE_DETECTING then
		if arg_9_1 > arg_9_0._snoarStartTime + arg_9_0._duration then
			arg_9_0:Overheat()
		else
			arg_9_0:updateDetectedList()
		end
	end

	return
end

function var_0_8.Detect(arg_10_0)
	arg_10_0._snoarStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	arg_10_0._currentState = var_0_8.STATE_DETECTING

	local var_10_0 = arg_10_0:FilterTarget()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		iter_10_1:Detected(10)
	end

	arg_10_0._detectedList = var_10_0

	arg_10_0._fleetVO:DispatchSonarScan()

	return
end

function var_0_8.Undetect(arg_11_0)
	arg_11_0._snoarStartTime = nil
	arg_11_0._currentState = var_0_8.STATE_OVER_HEAT

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._detectedList) do
		if iter_11_1:IsAlive() then
			iter_11_1:Undetected()
		end
	end

	arg_11_0._detectedList = {}

	return
end

function var_0_8.updateDetectedList(arg_12_0)
	local var_12_0 = arg_12_0:FilterTarget()
	local var_12_1 = #arg_12_0._detectedList

	while var_12_1 > 0 do
		if not arg_12_0._detectedList[var_12_1]:IsAlive() then
			table.remove(arg_12_0._detectedList, var_12_1)
		elseif not table.contains(var_12_0, arg_12_0._detectedList[var_12_1]) then
			arg_12_0._detectedList[var_12_1]:Undetected()
			table.remove(arg_12_0._detectedList, var_12_1)
		end

		var_12_1 = var_12_1 - 1
	end

	return
end

function var_0_8.Overheat(arg_13_0)
	arg_13_0:Undetect()

	arg_13_0._overheatStartTime = pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function var_0_8.Ready(arg_14_0)
	arg_14_0._overheatStartTime = nil
	arg_14_0._currentState = var_0_8.STATE_READY

	return
end

function var_0_8.FilterTarget(arg_15_0)
	return (arg_15_0:FilterRange((var_0_7.TargetDiveState(arg_15_0._host, {
		diveState = var_0_2.OXY_STATE.DIVE
	}, (var_0_7.LegalTarget(arg_15_0._host))))))
end

function var_0_8.FilterRange(arg_16_0, arg_16_1)
	for iter_16_0 = #arg_16_1, 1, -1 do
		if arg_16_0:isOutOfRange(arg_16_1[iter_16_0]) then
			table.remove(arg_16_1, iter_16_0)
		end
	end

	return arg_16_1
end

function var_0_8.isOutOfRange(arg_17_0, arg_17_1)
	return arg_17_0._host:GetDistance(arg_17_1) > arg_17_0._range
end

return
