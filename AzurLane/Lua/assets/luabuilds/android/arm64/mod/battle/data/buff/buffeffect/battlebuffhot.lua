ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffHOT = var_0_10002("BattleBuffHOT", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffHOT.__name = "BattleBuffHOT"

function var_0.Battle.BattleBuffHOT.Ctor(arg_1_0, arg_1_1)
	var_0.Battle.BattleBuffHOT.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0.Battle.BattleBuffHOT.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	if not arg_2_0._tempData.arg_list.number then
		var_2_0 = 0
	end

	arg_2_0._number = var_2_0
	arg_2_0._numberBase = arg_2_0._number

	local var_2_1

	if not arg_2_0._tempData.arg_list.time then
		var_2_1 = 0
	end

	arg_2_0._time = var_2_1
	pg = var_2_1

	local var_2_2 = var_2_1.TimeMgr.GetInstance()

	arg_2_0._nextEffectTime = var_3.GetCombatTime(var_2_2) + arg_2_0._time

	local var_2_3

	if not arg_2_0._tempData.arg_list.maxHPRatio then
		var_2_3 = 0
	end

	arg_2_0._maxHPRatio = var_2_3

	local var_2_4

	if not arg_2_0._tempData.arg_list.currentHPRatio then
		var_2_4 = 0
	end

	arg_2_0._currentHPRatio = var_2_4
	arg_2_0._incorruptible = arg_2_0._tempData.arg_list.incorrupt

	return
end

function var_0.Battle.BattleBuffHOT.onStack(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0.Battle.BattleBuffHOT.onUpdate(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3.timeStamp >= arg_4_0._nextEffectTime then
		local var_4_0 = arg_4_0:CalcNumber(arg_4_1, arg_4_2)
		local var_4_1 = {
			isMiss = false,
			isCri = false,
			isHeal = true,
			incorrupt = arg_4_0._incorruptible
		}

		arg_4_1:UpdateHP(var_4_0, var_4_1)

		if arg_4_1:IsAlive() then
			arg_4_0._nextEffectTime = arg_4_0._nextEffectTime + arg_4_0._time
		end
	end

	return
end

function var_0.Battle.BattleBuffHOT.onRemove(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:CalcNumber(arg_5_1, arg_5_2)
	local var_5_1 = {
		isMiss = false,
		isCri = false,
		isHeal = true,
		incorrupt = arg_5_0._incorruptible
	}

	arg_5_1:UpdateHP(var_5_0, var_5_1)

	return
end

function var_0.Battle.BattleBuffHOT.CalcNumber(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0, var_6_1 = arg_6_1:GetHP()
	local var_6_2 = arg_6_1
	local var_6_3 = arg_6_1.GetAttrByName(var_6_2, "healingRate")

	math = var_1_10006

	local var_6_4 = var_1_10006.max(0, var_6_0 * arg_6_0._currentHPRatio + var_6_1 * arg_6_0._maxHPRatio + arg_6_0._number)

	math = var_6_2

	return (var_6_2.floor(var_6_4 * arg_6_2._stack * var_6_3))
end

return
