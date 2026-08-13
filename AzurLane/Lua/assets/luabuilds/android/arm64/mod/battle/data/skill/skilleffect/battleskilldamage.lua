ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleSkillDamage = var_0_10002("BattleSkillDamage", var_0.Battle.BattleSkillEffect)
var_0.Battle.BattleSkillDamage.__name = "BattleSkillDamage"

function var_0.Battle.BattleSkillDamage.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = var_0.Battle.BattleSkillDamage.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	lv = var_1_10006

	var_1_0(var_1_1, var_1_2, var_1_10006)

	local var_1_3

	if not arg_1_0._tempData.arg_list.number then
		var_1_3 = 0
	end

	arg_1_0._number = var_1_3

	local var_1_4

	if not arg_1_0._tempData.arg_list.current_hp_rate then
		var_1_4 = 0
	end

	arg_1_0._currentHPRate = var_1_4

	local var_1_5

	if not arg_1_0._tempData.arg_list.rate then
		var_1_5 = 0
	end

	arg_1_0._maxHPRate = var_1_5

	local var_1_6

	if not arg_1_0._tempData.arg_list.ignoreInvincible then
		var_1_6 = false
	end

	arg_1_0._ignoreInvincible = var_1_6
	arg_1_0._proxy = var_0.Battle.BattleDataProxy.GetInstance()

	return
end

function var_0.Battle.BattleSkillDamage.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2
	local var_2_1, var_2_2 = arg_2_2.GetHP(var_2_0)

	math = var_2_0

	local var_2_3 = var_2_0.floor(var_2_2 * arg_2_0._maxHPRate)

	math = var_1_10006

	local var_2_4 = var_2_3 + var_1_10006.floor(var_2_1 * arg_2_0._currentHPRate) + arg_2_0._number
	local var_2_5

	if not arg_2_0._ignoreInvincible then
		var_2_5 = nil
	end

	local var_2_6 = arg_2_0._proxy

	var_7.HandleDirectDamage(var_2_6, arg_2_2, var_2_4, arg_2_1, var_2_5, false, arg_2_0._ignoreInvincible)

	if not arg_2_2:IsAlive() then
		var_0.Battle.BattleAttr.Spirit(arg_2_2)
		var_0.Battle.BattleAttr.AppendInvincible(arg_2_2)
	end

	return
end

return
