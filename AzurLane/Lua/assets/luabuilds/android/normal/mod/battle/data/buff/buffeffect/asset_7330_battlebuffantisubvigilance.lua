ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffAntiSubVigilance", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffAntiSubVigilance = var_0_1
var_0_1.__name = "BattleBuffAntiSubVigilance"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._vigilantRange = arg_2_0._tempData.arg_list.vigilanceRange
	arg_2_0._sonarRange = var_3.sonarRange
	arg_2_0._sonarFrequency = var_3.sonarFrequency

	return
end

function var_0_1.onAttach(arg_3_0, arg_3_1)
	arg_3_0._vigilantUnit = arg_3_1
	arg_3_0._vigilantState = arg_3_1:InitAntiSubState(arg_3_0._sonarRange, arg_3_0._sonarFrequency)

	local var_3_0 = arg_3_0:getTargetList(arg_3_0._vigilantUnit, "TargetHarmNearest", {
		range = 200
	})
	local var_3_1 = arg_3_0._vigilantState

	var_3.InitCheck(var_3_1, #var_3_0)

	pg = var_3

	local var_3_2 = var_3.TimeMgr.GetInstance()

	arg_3_0._sonarCheckTimeStamp = var_3.GetCombatTime(var_3_2)

	return
end

function var_0_1.onUpdate(arg_4_0)
	if #arg_4_0:getTargetList(arg_4_0._vigilantUnit, "TargetHarmNearest", {
		range = arg_4_0._vigilantRange
	}) > 0 then
		local var_4_0 = arg_4_0._vigilantState

		var_2.VigilantAreaEngage(var_4_0)
	end

	local var_4_1 = #arg_4_0:getTargetList(arg_4_0._vigilantUnit, "TargetHarmNearest", {
		range = 200
	})
	local var_4_2 = #arg_4_0:getTargetList(arg_4_0._vigilantUnit, {
		"TargetAllFoe",
		"TargetHarmNearest",
		"TargetDiveState"
	}, {
		range = arg_4_0._sonarRange
	})
	local var_4_3 = arg_4_0._vigilantState

	var_4.Update(var_4_3, var_4_1, var_4_2)

	pg = var_4

	local var_4_4 = var_4.TimeMgr.GetInstance()

	if var_4.GetCombatTime(var_4_4) - arg_4_0._sonarCheckTimeStamp >= arg_4_0._sonarFrequency then
		local var_4_5 = arg_4_0._vigilantState

		var_5.SonarDetect(var_4_5, var_4_2)

		arg_4_0._sonarCheckTimeStamp = var_4
	end

	return
end

function var_0_1.onAntiSubHateChain(arg_5_0)
	local var_5_0 = arg_5_0._vigilantState

	var_1.HateChain(var_5_0)

	return
end

function var_0_1.onTeammateShipDying(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0._vigilantState

	var_4.MineExplode(var_6_0)

	return
end

function var_0_1.onSubmarinFreeDive(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return
end

function var_0_1.onSubmarinFreeFloat(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0._vigilantState

	var_4.SubmarineFloat(var_8_0)

	return
end

return
