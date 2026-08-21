ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffFixDamage = class("BattleBuffFixDamage", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffFixDamage.__name = "BattleBuffFixDamage"

local var_0_1 = ys.Battle.BattleBuffFixDamage

function ys.Battle.BattleBuffFixDamage.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffFixDamage.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._fixProb = arg_2_0._tempData.arg_list.rant or 10000
	arg_2_0._fixValue = arg_2_0._tempData.arg_list.value
	arg_2_0._fixRate = arg_2_0._tempData.arg_list.rate

	return
end

function ys.Battle.BattleBuffFixDamage.onBeforeTakeDamage(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_0:damageCheck(arg_3_3) then
		return
	end

	local var_3_0 = arg_3_3.damage
	local var_3_1 = arg_3_3.damage

	if (arg_3_0._fixProb >= 10000 or var_0_0.Battle.BattleFormulas.IsHappen(arg_3_0._fixProb)) and (arg_3_0._fixValue or arg_3_0._fixRate) then
		if arg_3_0._fixRate then
			var_3_1 = math.max(1, var_3_0 * arg_3_0._fixRate)
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
		var_3_3 = math.floor(var_3_4 * var_3_2.cap_hp_rate)
	elseif var_3_2.cap_hp_rate_max then
		var_3_3 = math.floor(var_3_5 * var_3_2.cap_hp_rate_max)
	end

	if var_3_3 then
		if var_3_2.cap_ceiling then
			var_3_3 = math.max(var_3_3, var_3_2.cap_ceiling)
		elseif var_3_2.cap_ceiling_rate then
			var_3_3 = math.max(var_3_3, math.floor(var_3_2.cap_ceiling_rate * var_3_5))
		end

		if var_3_3 < var_3_1 then
			arg_3_3.capFlag = true
			var_3_1 = var_3_3
		end
	end

	arg_3_3.damage = math.floor(var_3_1)

	return
end

return
