ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffCastSkillDamageCount = class("BattleBuffCastSkillDamageCount", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffCastSkillDamageCount.__name = "BattleBuffCastSkillDamageCount"

local var_0_2 = ys.Battle.BattleBuffCastSkillDamageCount

ys.Battle.BattleBuffCastSkillDamageCount.FX_TYPE = ys.Battle.BattleBuffEffect.FX_TYPE_CASTER

function ys.Battle.BattleBuffCastSkillDamageCount.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffCastSkillDamageCount.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._level = arg_2_2:GetLv()
	arg_2_0._skillTable = arg_2_0._tempData.arg_list.damage_attr_list
	arg_2_0._attrTable = {}

	return
end

function ys.Battle.BattleBuffCastSkillDamageCount.onTakeDamage(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.damageAttr then
		local var_3_0 = arg_3_0._attrTable[arg_3_3.damageAttr] or 0

		arg_3_0._attrTable[arg_3_3.damageAttr] = var_3_0 + arg_3_3.damage
	end

	return
end

function ys.Battle.BattleBuffCastSkillDamageCount.onRemove(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0

	for iter_4_0, iter_4_1 in pairs(arg_4_0._attrTable) do
		local var_4_1

		if 0 <= iter_4_1 then
			var_4_1 = iter_4_1
			var_4_0 = iter_4_0
		end
	end

	if not var_4_0 then
		return
	end

	arg_4_0._skill = var_0_0.Battle.BattleSkillUnit.GenerateSpell(arg_4_0._skillTable[var_4_0], arg_4_0._level, arg_4_1, arg_4_3)

	if arg_4_3 and arg_4_3.target then
		arg_4_0._skill:SetTarget({
			arg_4_3.target
		})
	end

	arg_4_0._skill:Cast(arg_4_1, arg_4_0._commander)

	return
end

function ys.Battle.BattleBuffCastSkillDamageCount.Interrupt(arg_5_0)
	var_0_2.super.Interrupt(arg_5_0)

	if arg_5_0._skill then
		arg_5_0._skill:Interrupt()
	end

	return
end

function ys.Battle.BattleBuffCastSkillDamageCount.Clear(arg_6_0)
	var_0_2.super.Clear(arg_6_0)

	if arg_6_0._skill then
		arg_6_0._skill:Clear()

		arg_6_0._skill = nil
	end

	return
end

return
