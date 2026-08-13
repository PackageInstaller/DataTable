ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffReflectDamage = var_0_10002("BattleBuffReflectDamage", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffReflectDamage.__name = "BattleBuffReflectDamage"

local var_0_2 = var_0.Battle.BattleBuffReflectDamage

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._triggerValve = arg_2_0._tempData.arg_list.valve
	arg_2_0._reflectRate = var_3.reflectRate
	arg_2_0._reflectTargetChoice = var_3.reflectTarget.target_choise
	arg_2_0._reflectTargetParam = var_3.reflectTarget.arg_list

	return
end

function var_0_2.onDamageConclude(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_0:damageCheck(arg_3_3) and not arg_3_3.isReflect then
		local var_3_0, var_3_1 = arg_3_1:GetHP()
		local var_3_2 = -arg_3_3.validDHP

		math = var_7

		if var_3_2 >= var_7.floor(var_3_1 * arg_3_0._triggerValve) then
			local var_3_3 = var_0.Battle.BattleDataProxy.GetInstance()
			local var_3_4 = arg_3_0

			if #arg_3_0.getTargetList(var_3_4, arg_3_1, arg_3_0._reflectTargetChoice, arg_3_0._reflectTargetParam, {}) ~= 0 then
				local var_3_5 = var_8[1]

				math = var_3_4

				local var_3_6 = var_3_4.floor(arg_3_0._reflectRate * var_3_2)

				var_3_3:HandleDirectDamage(var_3_5, var_3_6, arg_3_1, nil, true)
			end
		end
	end

	return
end

return
