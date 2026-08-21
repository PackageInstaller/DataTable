ys = ys or {}

local var_0_0 = class("BattleBuffAntiSubVigilance", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAntiSubVigilance = var_0_0
var_0_0.__name = "BattleBuffAntiSubVigilance"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._vigilantRange = arg_2_0._tempData.arg_list.vigilanceRange
	arg_2_0._sonarRange = arg_2_0._tempData.arg_list.sonarRange
	arg_2_0._sonarFrequency = arg_2_0._tempData.arg_list.sonarFrequency

	return
end

function var_0_0.onAttach(arg_3_0, arg_3_1)
	arg_3_0._vigilantUnit = arg_3_1
	arg_3_0._vigilantState = arg_3_1:InitAntiSubState(arg_3_0._sonarRange, arg_3_0._sonarFrequency)

	arg_3_0._vigilantState:InitCheck(#arg_3_0:getTargetList(arg_3_0._vigilantUnit, "TargetHarmNearest", {
		range = 200
	}))

	arg_3_0._sonarCheckTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function var_0_0.onUpdate(arg_4_0)
	local var_4_0

	if #arg_4_0:getTargetList(arg_4_0._vigilantUnit, "TargetHarmNearest", {
		range = arg_4_0._vigilantRange
	}) > 0 then
		arg_4_0._vigilantState:VigilantAreaEngage()

		var_4_0 = #arg_4_0:getTargetList(arg_4_0._vigilantUnit, {
			"TargetAllFoe",
			"TargetHarmNearest",
			"TargetDiveState"
		}, {
			range = arg_4_0._sonarRange
		})
	end

	arg_4_0._vigilantState:Update(#arg_4_0:getTargetList(arg_4_0._vigilantUnit, "TargetHarmNearest", {
		range = 200
	}), var_4_0)

	local var_4_1 = pg.TimeMgr.GetInstance():GetCombatTime()

	if var_4_1 - arg_4_0._sonarCheckTimeStamp >= arg_4_0._sonarFrequency then
		arg_4_0._vigilantState:SonarDetect(var_4_0)

		arg_4_0._sonarCheckTimeStamp = var_4_1
	end

	return
end

function var_0_0.onAntiSubHateChain(arg_5_0)
	arg_5_0._vigilantState:HateChain()

	return
end

function var_0_0.onTeammateShipDying(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._vigilantState:MineExplode()

	return
end

function var_0_0.onSubmarinFreeDive(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return
end

function var_0_0.onSubmarinFreeFloat(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0._vigilantState:SubmarineFloat()

	return
end

return
