ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffReflectDamage = class("BattleBuffReflectDamage", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffReflectDamage.__name = "BattleBuffReflectDamage"

local var_0_1 = ys.Battle.BattleBuffReflectDamage

function ys.Battle.BattleBuffReflectDamage.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffReflectDamage.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._triggerValve = arg_2_0._tempData.arg_list.valve
	arg_2_0._reflectRate = arg_2_0._tempData.arg_list.reflectRate
	arg_2_0._reflectTargetChoice = arg_2_0._tempData.arg_list.reflectTarget.target_choise
	arg_2_0._reflectTargetParam = arg_2_0._tempData.arg_list.reflectTarget.arg_list

	return
end

function ys.Battle.BattleBuffReflectDamage.onDamageConclude(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_0:damageCheck(arg_3_3) and not arg_3_3.isReflect then
		local var_3_0, var_3_1 = arg_3_1:GetHP()

		if -arg_3_3.validDHP >= math.floor(var_3_1 * arg_3_0._triggerValve) then
			local var_3_2 = arg_3_0:getTargetList(arg_3_1, arg_3_0._reflectTargetChoice, arg_3_0._reflectTargetParam, {})

			if #var_3_2 ~= 0 then
				var_0_0.Battle.BattleDataProxy.GetInstance():HandleDirectDamage(var_3_2[1], math.floor(arg_3_0._reflectRate * -arg_3_3.validDHP), arg_3_1, nil, true)
			end
		end
	end

	return
end

return
