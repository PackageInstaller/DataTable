ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffHealingSteal = var_0_10002("BattleBuffHealingSteal", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffHealingSteal.__name = "BattleBuffHealingSteal"

local var_0_2 = var_0.Battle.BattleBuffHealingSteal

var_0_2.FX_TYPE = var_0.Battle.BattleBuffEffect.FX_TYPE_LINK

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	if not arg_2_0._tempData.arg_list.stealingRate then
		var_2_0 = 1
	end

	arg_2_0._stealRate = var_2_0

	local var_2_1

	if not var_3.arsorbRate then
		var_2_1 = 1
	end

	arg_2_0._absorbRate = var_2_1

	return
end

function var_0_2.onTakeHealing(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_3.damage

	if arg_3_2:GetCaster() and var_5:IsAlive() and var_5 ~= arg_3_1 then
		math = var_6
		arg_3_3.damage = var_3_0 - var_6.ceil(var_3_0 * arg_3_0._stealRate)

		local var_3_1 = var_5
		local var_3_2 = var_5.GetAttrByName(var_3_1, "healingRate")
		local var_3_3 = var_6 * arg_3_0._absorbRate

		math = var_3_1

		local var_3_4 = var_3_1.ceil(var_3_2 * var_3_3)
		local var_3_5 = {
			isMiss = false,
			isCri = false,
			isShare = false,
			isHeal = true
		}

		var_5:UpdateHP(var_3_4, var_3_5)
	end

	return
end

return
