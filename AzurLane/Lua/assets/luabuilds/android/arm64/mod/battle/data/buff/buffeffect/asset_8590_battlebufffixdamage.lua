ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffFixDamage = var_0_10002("BattleBuffFixDamage", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffFixDamage.__name = "BattleBuffFixDamage"

local var_0_2 = var_0.Battle.BattleBuffFixDamage

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	if not arg_2_0._tempData.arg_list.rant then
		var_2_0 = 10000
	end

	arg_2_0._fixProb = var_2_0
	arg_2_0._fixValue = arg_2_0._tempData.arg_list.value
	arg_2_0._fixRate = arg_2_0._tempData.arg_list.rate

	return
end

function var_0_2.onBeforeTakeDamage(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_0:damageCheck(arg_3_3) then
		return
	end

	local var_3_0 = arg_3_3.damage
	local var_3_1 = arg_3_3.damage

	if (arg_3_0._fixProb >= 10000 or var_0.Battle.BattleFormulas.IsHappen(arg_3_0._fixProb)) and (arg_3_0._fixValue or arg_3_0._fixRate) then
		if arg_3_0._fixRate then
			math = var_6
			var_3_1 = var_6.max(1, var_3_0 * arg_3_0._fixRate)
			arg_3_3.fixFlag = true
		elseif var_3_0 > arg_3_0._fixValue then
			var_3_1 = arg_3_0._fixValue
			arg_3_3.fixFlag = true
		end
	end

	local var_3_2 = arg_3_0._tempData.arg_list
	local var_3_3
	local var_3_4, var_3_5 = arg_3_1:GetHP()

	if var_3_2.cap_value then
		var_3_3 = var_3_2.cap_value
	elseif var_3_2.cap_hp_rate then
		math = var_3_6
		var_3_3 = var_3_6.floor(var_3_4 * var_3_2.cap_hp_rate)
	elseif var_3_2.cap_hp_rate_max then
		math = var_3_6
		var_3_3 = var_3_6.floor(var_3_5 * var_3_2.cap_hp_rate_max)
	end

	local var_3_6

	if var_3_3 then
		if var_3_2.cap_ceiling then
			math = var_3_6
			var_3_3 = var_3_6.max(var_3_3, var_3_2.cap_ceiling)
		elseif var_3_2.cap_ceiling_rate then
			math = var_3_6
			var_3_6 = var_3_6.max

			local var_3_7 = var_3_3

			math = var_1_10013
			var_3_3 = var_3_6(var_3_7, var_1_10013.floor(var_3_2.cap_ceiling_rate * var_3_5))
		end

		if var_3_3 < var_3_1 then
			arg_3_3.capFlag = true
			var_3_1 = var_3_3
		end
	end

	math = var_3_6
	arg_3_3.damage = var_3_6.floor(var_3_1)

	return
end

return
