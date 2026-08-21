ys = ys or {}

local var_0_2 = ys.Battle.BattleConst
local var_0_7 = ys.Battle.BattleTargetChoise
local var_0_8 = class("BattleIndieSonar")

ys.Battle.BattleIndieSonar = var_0_8
var_0_8.__name = "BattleIndieSonar"

function var_0_8.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._fleetVO = arg_1_1
	arg_1_0._range = 180
	arg_1_0._duration = arg_1_3

	return
end

function var_0_8.SwitchHost(arg_2_0, arg_2_1)
	arg_2_0._host = arg_2_1

	return
end

function var_0_8.Detect(arg_3_0)
	arg_3_0._snoarStartTime = pg.TimeMgr.GetInstance():GetCombatTime()

	local var_3_0 = arg_3_0:FilterTarget()

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		iter_3_1:Detected(arg_3_0._duration)
	end

	arg_3_0._detectedList = var_3_0

	arg_3_0._fleetVO:DispatchSonarScan(true)

	return
end

function var_0_8.Update(arg_4_0, arg_4_1)
	if arg_4_1 > arg_4_0._snoarStartTime + arg_4_0._duration then
		arg_4_0._detectedList = nil

		arg_4_0._fleetVO:RemoveIndieSonar(arg_4_0)
	end

	return
end

function var_0_8.FilterTarget(arg_5_0)
	return (var_0_7.TargetDiveState(arg_5_0._host, {
		diveState = var_0_2.OXY_STATE.DIVE
	}, (var_0_7.LegalTarget(arg_5_0._host))))
end

return
