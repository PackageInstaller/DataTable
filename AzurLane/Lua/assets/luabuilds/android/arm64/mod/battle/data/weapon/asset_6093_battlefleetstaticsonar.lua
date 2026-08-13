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
local var_0_9 = var_0_4.VAN_SONAR_PROPERTY

class = var_0_10010

local var_0_10 = var_0_10010("BattleFleetStaticSonar")

var_0.Battle.BattleFleetStaticSonar = var_0_10
var_0_10.__name = "BattleFleetStaticSonar"
var_0_10.STATE_DISABLE = "DISABLE"
var_0_10.STATE_READY = "READY"

function var_0_10.Ctor(arg_1_0, arg_1_1)
	arg_1_0:init()

	arg_1_0._fleetVO = arg_1_1
	arg_1_0._currentState = var_0_10.STATE_DISABLE

	return
end

function var_0_10.GetCurrentState(arg_2_0)
	return arg_2_0._currentState
end

function var_0_10.Dispose(arg_3_0)
	arg_3_0._detectedList = nil
	arg_3_0._crewUnitList = nil
	arg_3_0._host = nil

	return
end

function var_0_10.init(arg_4_0)
	arg_4_0._crewUnitList = {}
	arg_4_0._detectedList = {}
	arg_4_0._skillDiameter = 0
	arg_4_0._radius = 0
	arg_4_0._diameter = 0

	return
end

function var_0_10.AppendExtraSkillRange(arg_5_0, arg_5_1)
	arg_5_0._skillDiameter = arg_5_0._skillDiameter + arg_5_1

	if arg_5_0._radius ~= 0 then
		arg_5_0._radius = arg_5_0._radius + arg_5_1 * 0.5
	end

	return
end

function var_0_10.AppendCrewUnit(arg_6_0, arg_6_1)
	arg_6_0._crewUnitList[arg_6_1:GetUniqueID()] = arg_6_1

	arg_6_0:flush()

	return
end

function var_0_10.RemoveCrewUnit(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:GetUniqueID()

	if arg_7_0._crewUnitList[var_7_0] then
		arg_7_0._crewUnitList[var_7_0] = nil

		arg_7_0:updateSonarState()

		if arg_7_0._currentState == var_0_10.STATE_DISABLE then
			arg_7_0:Undetect()
		end
	end

	return
end

function var_0_10.SwitchHost(arg_8_0, arg_8_1)
	arg_8_0._host = arg_8_1

	return
end

function var_0_10.GetRange(arg_9_0)
	return arg_9_0._diameter
end

function var_0_10.flush(arg_10_0)
	arg_10_0._diameter = 0

	local var_10_0, var_10_1, var_10_2 = arg_10_0:calcSonarRange()

	if var_10_0 ~= 0 then
		arg_10_0._diameter = var_10_0 + var_10_2 + var_10_1
		arg_10_0._radius = arg_10_0._diameter * 0.5
	end

	arg_10_0:updateSonarState()

	return
end

function var_0_10.calcSonarRange(arg_11_0)
	local var_11_0 = 0
	local var_11_1 = 0
	local var_11_2 = 0

	pairs = var_1_10004

	for iter_11_0, iter_11_1 in var_1_10004(arg_11_0._crewUnitList) do
		local var_11_3, var_11_4, var_11_5 = arg_11_0.getSonarProperty(iter_11_1)

		if 0 < var_11_3 then
			math = var_12
			var_11_0 = var_12.max(var_11_3, var_11_0)
		end

		var_11_1 = var_11_1 + var_11_4
		var_11_2 = var_11_2 + var_11_5
	end

	local var_11_6 = var_11_2 / var_0_4.MAIN_SONAR_PROPERTY.a

	Mathf = var_6

	local var_11_7 = var_6.Clamp(var_11_6, var_4.minRange, var_4.maxRange)

	return var_11_0, var_11_7, var_11_1
end

function var_0_10.updateSonarState(arg_12_0)
	local var_12_0 = 0

	pairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0._crewUnitList) do
		if arg_12_0.getSonarProperty(iter_12_1) > 0 then
			var_12_0 = var_12_0 + 1
		end
	end

	if var_12_0 > 0 then
		arg_12_0._currentState = var_0_10.STATE_READY
	else
		arg_12_0._currentState = var_0_10.STATE_DISABLE
	end

	local var_12_1 = var_0.Event.New(var_0.Battle.BattleEvent.SONAR_UPDATE)
	local var_12_2 = arg_12_0._fleetVO

	var_3.DispatchEvent(var_12_2, var_12_1)

	return
end

function var_0_10.getSonarProperty(arg_13_0)
	local var_13_0 = arg_13_0:GetTemplate().type
	local var_13_1 = var_0_9[var_13_0]
	local var_13_2 = 0

	if var_13_1 then
		local var_13_3 = arg_13_0:GetAttrByName("baseAntiSubPower") / var_13_1.a - var_13_1.b

		Mathf = var_6
		var_13_2 = var_6.Clamp(var_13_3, var_13_1.minRange, var_13_1.maxRange)
	end

	local var_13_4 = arg_13_0
	local var_13_5 = arg_13_0.GetAttrByName(var_13_4, "sonarRange")
	local var_13_6 = 0

	table = var_13_4

	local var_13_7 = var_13_4.contains

	ShipType = var_1_10008

	if var_13_7(var_1_10008.MainShipType, var_13_0) then
		var_13_6 = arg_13_0:GetAttrByName("baseAntiSubPower")
	end

	return var_13_2, var_13_5, var_13_6
end

function var_0_10.Update(arg_14_0, arg_14_1)
	if arg_14_0._currentState ~= var_0_10.STATE_DISABLE then
		local var_14_0 = arg_14_0._fleetVO

		var_2.DispatchSonarScan(var_14_0)
		arg_14_0:updateDetectedList()
	end

	return
end

function var_0_10.Undetect(arg_15_0)
	local var_15_0 = arg_15_0._detectedList

	ipairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(var_15_0) do
		if iter_15_1:IsAlive() then
			iter_15_1:Undetected()
		end
	end

	arg_15_0._detectedList = {}

	return
end

function var_0_10.updateDetectedList(arg_16_0)
	local var_16_0 = var_0_8.LegalTarget(arg_16_0._host)
	local var_16_1 = var_0_8.TargetDiveState(arg_16_0._host, {
		diveState = var_0_3.OXY_STATE.DIVE
	}, var_16_0)
	local var_16_2 = arg_16_0:FilterRange(var_16_1)

	ipairs = var_4

	for iter_16_0, iter_16_1 in var_4(var_16_1) do
		table = var_1_10009
		var_1_10009 = var_1_10009.contains(var_16_2, iter_16_1)
		table = var_1_10010

		if var_1_10010.contains(arg_16_0._detectedList, iter_16_1) then
			if not var_1_10009 then
				iter_16_1:Undetected()
			end
		elseif not var_1_10010 and var_1_10009 then
			iter_16_1:Detected()
		end
	end

	arg_16_0._detectedList = var_16_2

	return
end

function var_0_10.FilterTarget(arg_17_0)
	local var_17_0 = var_0_8.LegalTarget(arg_17_0._host)
	local var_17_1 = var_0_8.TargetDiveState(arg_17_0._host, {
		diveState = var_0_3.OXY_STATE.DIVE
	}, var_17_0)

	return (arg_17_0:FilterRange(var_17_1))
end

function var_0_10.FilterRange(arg_18_0, arg_18_1)
	local var_18_0 = {}

	ipairs = var_1_10003

	for iter_18_0, iter_18_1 in var_1_10003(arg_18_1) do
		if not arg_18_0:isOutOfRange(iter_18_1) then
			table = var_8

			var_8.insert(var_18_0, iter_18_1)
		end
	end

	return var_18_0
end

function var_0_10.isOutOfRange(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._host

	return var_2.GetDistance(var_19_0, arg_19_1) > arg_19_0._radius
end

function var_0_10.GetTotalRangeDetail(arg_20_0)
	local var_20_0, var_20_1, var_20_2 = arg_20_0:calcSonarRange()

	return var_20_0, var_20_1, var_20_2, arg_20_0._skillDiameter
end

return
