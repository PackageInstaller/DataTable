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

function ys.Battle.BattleBuffCastSkillDamageCount:SetArgs(arg_2_1, arg_2_2)
	self._level = arg_2_2:GetLv()
	self._skillTable = self._tempData.arg_list.damage_attr_list
	self._attrTable = {}

	return
end

function ys.Battle.BattleBuffCastSkillDamageCount:onTakeDamage(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.damageAttr then
		self._attrTable[arg_3_3.damageAttr] = (self._attrTable[arg_3_3.damageAttr] or 0) + arg_3_3.damage
	end

	return
end

function ys.Battle.BattleBuffCastSkillDamageCount:onRemove(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0

	for iter_4_0, iter_4_1 in pairs(self._attrTable) do
		if 0 <= iter_4_1 then
			var_4_0 = iter_4_0
		end
	end

	if not var_4_0 then
		return
	end

	self._skill = var_0_0.Battle.BattleSkillUnit.GenerateSpell(self._skillTable[var_4_0], self._level, arg_4_1, arg_4_3)

	if arg_4_3 and arg_4_3.target then
		self._skill:SetTarget({
			arg_4_3.target
		})
	end

	self._skill:Cast(arg_4_1, self._commander)

	return
end

function ys.Battle.BattleBuffCastSkillDamageCount:Interrupt()
	var_0_2.super.Interrupt(self)

	if self._skill then
		self._skill:Interrupt()
	end

	return
end

function ys.Battle.BattleBuffCastSkillDamageCount:Clear()
	var_0_2.super.Clear(self)

	if self._skill then
		self._skill:Clear()

		self._skill = nil
	end

	return
end

return
