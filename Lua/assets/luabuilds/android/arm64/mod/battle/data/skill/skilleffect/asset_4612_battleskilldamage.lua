ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleSkillDamage = class("BattleSkillDamage", ys.Battle.BattleSkillEffect)
ys.Battle.BattleSkillDamage.__name = "BattleSkillDamage"

function ys.Battle.BattleSkillDamage:Ctor(arg_1_1)
	var_0_0.Battle.BattleSkillDamage.super.Ctor(self, arg_1_1, lv)

	self._number = self._tempData.arg_list.number or 0
	self._currentHPRate = self._tempData.arg_list.current_hp_rate or 0
	self._maxHPRate = self._tempData.arg_list.rate or 0
	self._ignoreInvincible = self._tempData.arg_list.ignoreInvincible or false
	self._proxy = var_0_0.Battle.BattleDataProxy.GetInstance()

	return
end

function ys.Battle.BattleSkillDamage:DoDataEffect(arg_2_1, arg_2_2)
	local var_2_0, var_2_1 = arg_2_2:GetHP()

	self._proxy:HandleDirectDamage(arg_2_2, math.floor(var_2_1 * self._maxHPRate) + math.floor(var_2_0 * self._currentHPRate) + self._number, arg_2_1, self._ignoreInvincible or nil, false, self._ignoreInvincible)

	if not arg_2_2:IsAlive() then
		var_0_0.Battle.BattleAttr.Spirit(arg_2_2)
		var_0_0.Battle.BattleAttr.AppendInvincible(arg_2_2)
	end

	return
end

return
