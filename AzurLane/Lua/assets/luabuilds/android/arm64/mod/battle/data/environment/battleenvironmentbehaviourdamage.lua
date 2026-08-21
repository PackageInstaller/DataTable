ys = ys or {}

local var_0_2 = class("BattleEnvironmentBehaviourDamage", ys.Battle.BattleEnvironmentBehaviour)

ys.Battle.BattleEnvironmentBehaviourDamage = var_0_2
var_0_2.__name = "BattleEnvironmentBehaviourDamage"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.SetTemplate(arg_2_0, arg_2_1)
	var_0_2.super.SetTemplate(arg_2_0, arg_2_1)

	arg_2_0._rate = arg_2_0._tmpData.hp_rate or 0
	arg_2_0._damage = arg_2_0._tmpData.damage or 0
	arg_2_0._offset = arg_2_0._tmpData.offset or 0

	return
end

function var_0_2.doBehaviour(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._cldUnitList) do
		local var_3_0, var_3_1 = iter_3_1:GetHP()

		iter_3_1:UpdateHP(-math.max(0, math.floor(var_3_1 * arg_3_0._rate) + arg_3_0._damage + math.random(-arg_3_0._offset, arg_3_0._offset)), {
			isMiss = false,
			isCri = false,
			isHeal = false
		})

		if not iter_3_1:IsAlive() then
			var_0.Battle.BattleAttr.Spirit(iter_3_1)
			var_0.Battle.BattleAttr.AppendInvincible(iter_3_1)
		end
	end

	var_0_2.super.doBehaviour(arg_3_0)

	return
end

return
