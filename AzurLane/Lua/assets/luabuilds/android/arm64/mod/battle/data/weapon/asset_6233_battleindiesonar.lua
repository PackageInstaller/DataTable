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

local var_0_9 = var_0_10009("BattleIndieSonar")

var_0.Battle.BattleIndieSonar = var_0_9
var_0_9.__name = "BattleIndieSonar"

function var_0_9.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._fleetVO = arg_1_1
	arg_1_0._range = 180
	arg_1_0._duration = arg_1_3

	return
end

function var_0_9.SwitchHost(arg_2_0, arg_2_1)
	arg_2_0._host = arg_2_1

	return
end

function var_0_9.Detect(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.TimeMgr.GetInstance()

	arg_3_0._snoarStartTime = var_1.GetCombatTime(var_3_0)

	local var_3_1 = arg_3_0:FilterTarget()

	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(var_3_1) do
		iter_3_1:Detected(arg_3_0._duration)
	end

	arg_3_0._detectedList = var_3_1

	local var_3_2 = arg_3_0._fleetVO

	var_2.DispatchSonarScan(var_3_2, true)

	return
end

function var_0_9.Update(arg_4_0, arg_4_1)
	if arg_4_1 > arg_4_0._snoarStartTime + arg_4_0._duration then
		arg_4_0._detectedList = nil

		local var_4_0 = arg_4_0._fleetVO

		var_2.RemoveIndieSonar(var_4_0, arg_4_0)
	end

	return
end

function var_0_9.FilterTarget(arg_5_0)
	local var_5_0 = var_0_8.LegalTarget(arg_5_0._host)

	return (var_0_8.TargetDiveState(arg_5_0._host, {
		diveState = var_0_3.OXY_STATE.DIVE
	}, var_5_0))
end

return
