ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleSkillDamage = class("BattleSkillDamage", ys.Battle.BattleSkillEffect)
ys.Battle.BattleSkillDamage.__name = "BattleSkillDamage"

function ys.Battle.BattleSkillDamage.Ctor(arg_1_0, arg_1_1)
	var_0_0.Battle.BattleSkillDamage.super.Ctor(arg_1_0, arg_1_1, lv)

	arg_1_0._number = arg_1_0._tempData.arg_list.number or 0
	arg_1_0._currentHPRate = arg_1_0._tempData.arg_list.current_hp_rate or 0
	arg_1_0._maxHPRate = arg_1_0._tempData.arg_list.rate or 0
	arg_1_0._ignoreInvincible = arg_1_0._tempData.arg_list.ignoreInvincible or false
	arg_1_0._proxy = var_0_0.Battle.BattleDataProxy.GetInstance()

	return
end

function ys.Battle.BattleSkillDamage.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0, var_2_1 = arg_2_2:GetHP()
	local var_2_2 = arg_2_0._ignoreInvincible or nil

	arg_2_0._proxy:HandleDirectDamage(arg_2_2, math.floor(var_2_1 * arg_2_0._maxHPRate) + math.floor(var_2_0 * arg_2_0._currentHPRate) + arg_2_0._number, arg_2_1, var_2_2, false, arg_2_0._ignoreInvincible)

	if not arg_2_2:IsAlive() then
		var_0_0.Battle.BattleAttr.Spirit(arg_2_2)
		var_0_0.Battle.BattleAttr.AppendInvincible(arg_2_2)
	end

	return
end

return
