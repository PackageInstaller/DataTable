ys = ys or {}

local var_0_2 = ys.Battle.BattleConst
local var_0_6 = ys.Battle.BattleTargetChoise
local var_0_7 = ys.Battle.BattleConfig.VAN_SONAR_PROPERTY
local var_0_8 = class("BattleFleetStaticSonar")

ys.Battle.BattleFleetStaticSonar = var_0_8
var_0_8.__name = "BattleFleetStaticSonar"
var_0_8.STATE_DISABLE = "DISABLE"
var_0_8.STATE_READY = "READY"

function var_0_8.Ctor(arg_1_0, arg_1_1)
	arg_1_0:init()

	arg_1_0._fleetVO = arg_1_1
	arg_1_0._currentState = var_0_8.STATE_DISABLE

	return
end

function var_0_8.GetCurrentState(arg_2_0)
	return arg_2_0._currentState
end

function var_0_8.Dispose(arg_3_0)
	arg_3_0._detectedList = nil
	arg_3_0._crewUnitList = nil
	arg_3_0._host = nil

	return
end

function var_0_8.init(arg_4_0)
	arg_4_0._crewUnitList = {}
	arg_4_0._detectedList = {}
	arg_4_0._skillDiameter = 0
	arg_4_0._radius = 0
	arg_4_0._diameter = 0

	return
end

function var_0_8.AppendExtraSkillRange(arg_5_0, arg_5_1)
	arg_5_0._skillDiameter = arg_5_0._skillDiameter + arg_5_1

	if arg_5_0._radius ~= 0 then
		arg_5_0._radius = arg_5_0._radius + arg_5_1 * 0.5
	end

	return
end

function var_0_8.AppendCrewUnit(arg_6_0, arg_6_1)
	arg_6_0._crewUnitList[arg_6_1:GetUniqueID()] = arg_6_1

	arg_6_0:flush()

	return
end

function var_0_8.RemoveCrewUnit(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:GetUniqueID()

	if arg_7_0._crewUnitList[var_7_0] then
		arg_7_0._crewUnitList[var_7_0] = nil

		arg_7_0:updateSonarState()

		if arg_7_0._currentState == var_0_8.STATE_DISABLE then
			arg_7_0:Undetect()
		end
	end

	return
end

function var_0_8.SwitchHost(arg_8_0, arg_8_1)
	arg_8_0._host = arg_8_1

	return
end

function var_0_8.GetRange(arg_9_0)
	return arg_9_0._diameter
end

function var_0_8.flush(arg_10_0)
	arg_10_0._diameter = 0

	local var_10_0, var_10_1, var_10_2 = arg_10_0:calcSonarRange()

	if var_10_0 ~= 0 then
		arg_10_0._diameter = var_10_0 + var_10_2 + var_10_1
		arg_10_0._radius = arg_10_0._diameter * 0.5
	end

	arg_10_0:updateSonarState()

	return
end

function var_0_8.calcSonarRange(arg_11_0)
	local var_11_0 = 0
	local var_11_1 = 0
	local var_11_2 = 0

	for iter_11_0, iter_11_1 in pairs(arg_11_0._crewUnitList) do
		local var_11_3, var_11_4, var_11_5 = arg_11_0.getSonarProperty(iter_11_1)

		if var_11_3 > 0 then
			var_11_0 = math.max(var_11_3, var_11_0)
		end

		var_11_1 = var_11_1 + var_11_4
		var_11_2 = var_11_2 + var_11_5
	end

	return var_11_0, Mathf.Clamp(var_11_2 / var_0.MAIN_SONAR_PROPERTY.a, var_0.MAIN_SONAR_PROPERTY.minRange, var_0.MAIN_SONAR_PROPERTY.maxRange), var_11_1
end

function var_0_8.updateSonarState(arg_12_0)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in pairs(arg_12_0._crewUnitList) do
		if arg_12_0.getSonarProperty(iter_12_1) > 0 then
			var_12_0 = var_12_0 + 1
		end
	end

	arg_12_0._currentState = var_12_0 > 0 and var_0_8.STATE_READY or var_0_8.STATE_DISABLE

	arg_12_0._fleetVO:DispatchEvent((var_0.Event.New(var_0.Battle.BattleEvent.SONAR_UPDATE)))

	return
end

function var_0_8.getSonarProperty(arg_13_0)
	local var_13_0 = arg_13_0:GetTemplate().type
	local var_13_1 = 0

	if var_0_7[var_13_0] then
		var_13_1 = Mathf.Clamp(arg_13_0:GetAttrByName("baseAntiSubPower") / var_0_7[var_13_0].a - var_0_7[var_13_0].b, var_0_7[var_13_0].minRange, var_0_7[var_13_0].maxRange)
	end

	local var_13_2 = arg_13_0:GetAttrByName("sonarRange")
	local var_13_3 = 0

	if table.contains(ShipType.MainShipType, var_13_0) then
		var_13_3 = arg_13_0:GetAttrByName("baseAntiSubPower")
	end

	return var_13_1, var_13_2, var_13_3
end

function var_0_8.Update(arg_14_0, arg_14_1)
	if arg_14_0._currentState ~= var_0_8.STATE_DISABLE then
		arg_14_0._fleetVO:DispatchSonarScan()
		arg_14_0:updateDetectedList()
	end

	return
end

function var_0_8.Undetect(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0._detectedList) do
		if iter_15_1:IsAlive() then
			iter_15_1:Undetected()
		end
	end

	arg_15_0._detectedList = {}

	return
end

function var_0_8.updateDetectedList(arg_16_0)
	local var_16_0 = var_0_6.TargetDiveState(arg_16_0._host, {
		diveState = var_0_2.OXY_STATE.DIVE
	}, (var_0_6.LegalTarget(arg_16_0._host)))
	local var_16_1 = arg_16_0:FilterRange(var_16_0)

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_2 = table.contains(var_16_1, iter_16_1)
		local var_16_3 = table.contains(arg_16_0._detectedList, iter_16_1)

		if var_16_3 then
			if not var_16_2 then
				iter_16_1:Undetected()
			end
		elseif not var_16_3 and var_16_2 then
			iter_16_1:Detected()
		end
	end

	arg_16_0._detectedList = var_16_1

	return
end

function var_0_8.FilterTarget(arg_17_0)
	return (arg_17_0:FilterRange((var_0_6.TargetDiveState(arg_17_0._host, {
		diveState = var_0_2.OXY_STATE.DIVE
	}, (var_0_6.LegalTarget(arg_17_0._host))))))
end

function var_0_8.FilterRange(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		if not arg_18_0:isOutOfRange(iter_18_1) then
			table.insert({}, iter_18_1)
		end
	end

	return {}
end

function var_0_8.isOutOfRange(arg_19_0, arg_19_1)
	return arg_19_0._host:GetDistance(arg_19_1) > arg_19_0._radius
end

function var_0_8.GetTotalRangeDetail(arg_20_0)
	local var_20_0, var_20_1, var_20_2 = arg_20_0:calcSonarRange()

	return var_20_0, var_20_1, var_20_2, arg_20_0._skillDiameter
end

return
