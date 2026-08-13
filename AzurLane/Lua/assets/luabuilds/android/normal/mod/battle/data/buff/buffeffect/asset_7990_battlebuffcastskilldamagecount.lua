ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleAttr
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleBuffCastSkillDamageCount = var_0_10003("BattleBuffCastSkillDamageCount", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffCastSkillDamageCount.__name = "BattleBuffCastSkillDamageCount"

local var_0_3 = var_0.Battle.BattleBuffCastSkillDamageCount

var_0_3.FX_TYPE = var_0.Battle.BattleBuffEffect.FX_TYPE_CASTER

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_3.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._level = arg_2_2:GetLv()
	arg_2_0._skillTable = arg_2_0._tempData.arg_list.damage_attr_list
	arg_2_0._attrTable = {}

	return
end

function var_0_3.onTakeDamage(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.damageAttr then
		local var_3_0

		if not arg_3_0._attrTable[var_4] then
			var_3_0 = 0
		end

		local var_3_1 = var_3_0 + arg_3_3.damage

		arg_3_0._attrTable[var_4] = var_3_1
	end

	return
end

function var_0_3.onRemove(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = 0
	local var_4_1

	pairs = var_1_10006

	for iter_4_0, iter_4_1 in var_1_10006(arg_4_0._attrTable) do
		if var_4_0 <= iter_4_1 then
			var_4_0 = iter_4_1
			var_4_1 = iter_4_0
		end
	end

	if not var_4_1 then
		return
	end

	local var_4_2 = arg_4_0._skillTable[var_4_1]

	arg_4_0._skill = var_0.Battle.BattleSkillUnit.GenerateSpell(var_4_2, arg_4_0._level, arg_4_1, arg_4_3)

	if arg_4_3 and arg_4_3.target then
		local var_4_3 = arg_4_0._skill

		var_7.SetTarget(var_4_3, {
			arg_4_3.target
		})
	end

	local var_4_4 = arg_4_0._skill

	var_7.Cast(var_4_4, arg_4_1, arg_4_0._commander)

	return
end

function var_0_3.Interrupt(arg_5_0)
	var_0_3.super.Interrupt(arg_5_0)

	if arg_5_0._skill then
		local var_5_0 = arg_5_0._skill

		var_1.Interrupt(var_5_0)
	end

	return
end

function var_0_3.Clear(arg_6_0)
	var_0_3.super.Clear(arg_6_0)

	if arg_6_0._skill then
		local var_6_0 = arg_6_0._skill

		var_1.Clear(var_6_0)

		arg_6_0._skill = nil
	end

	return
end

return
