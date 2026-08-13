ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleEnvironmentBehaviourDamage", var_0.Battle.BattleEnvironmentBehaviour)

var_0.Battle.BattleEnvironmentBehaviourDamage = var_0_3
var_0_3.__name = "BattleEnvironmentBehaviourDamage"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.SetTemplate(arg_2_0, arg_2_1)
	var_0_3.super.SetTemplate(arg_2_0, arg_2_1)

	local var_2_0

	if not arg_2_0._tmpData.hp_rate then
		var_2_0 = 0
	end

	arg_2_0._rate = var_2_0

	local var_2_1

	if not arg_2_0._tmpData.damage then
		var_2_1 = 0
	end

	arg_2_0._damage = var_2_1

	local var_2_2

	if not arg_2_0._tmpData.offset then
		var_2_2 = 0
	end

	arg_2_0._offset = var_2_2

	return
end

function var_0_3.doBehaviour(arg_3_0)
	ipairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0._cldUnitList) do
		local var_3_0 = {
			isMiss = false,
			isCri = false,
			isHeal = false
		}
		local var_3_1, var_3_2 = iter_3_1:GetHP()

		math = var_1_10009
		var_1_10009 = var_1_10009.max

		local var_3_3 = 0

		math = var_1_10011
		var_1_10011 = var_1_10011.floor(var_3_2 * arg_3_0._rate) + arg_3_0._damage
		math = var_12
		var_1_10009 = var_1_10009(var_3_3, var_1_10011 + var_12.random(-arg_3_0._offset, arg_3_0._offset))
		var_1_10011 = iter_3_1

		iter_3_1.UpdateHP(var_1_10011, -var_1_10009, var_3_0)

		var_1_10011 = iter_3_1

		if not iter_3_1.IsAlive(var_1_10011) then
			var_0.Battle.BattleAttr.Spirit(iter_3_1)
			var_0.Battle.BattleAttr.AppendInvincible(iter_3_1)
		end
	end

	var_0_3.super.doBehaviour(arg_3_0)

	return
end

return
