ys = ys or {}

local var_0_0 = ys
local BattleEnvironmentBehaviourDamage = class("BattleEnvironmentBehaviourDamage", ys.Battle.BattleEnvironmentBehaviour)

ys.Battle.BattleEnvironmentBehaviourDamage = BattleEnvironmentBehaviourDamage
BattleEnvironmentBehaviourDamage.__name = "BattleEnvironmentBehaviourDamage"

function BattleEnvironmentBehaviourDamage:Ctor()
	BattleEnvironmentBehaviourDamage.super.Ctor(self)

	return
end

function BattleEnvironmentBehaviourDamage:SetTemplate(arg_2_1)
	BattleEnvironmentBehaviourDamage.super.SetTemplate(self, arg_2_1)

	self._rate = self._tmpData.hp_rate or 0
	self._damage = self._tmpData.damage or 0
	self._offset = self._tmpData.offset or 0

	return
end

function BattleEnvironmentBehaviourDamage:doBehaviour()
	for iter_3_0, iter_3_1 in ipairs(self._cldUnitList) do
		local var_3_0 = {
			isMiss = false,
			isCri = false,
			isHeal = false
		}
		local var_3_1, var_3_2 = iter_3_1:GetHP()

		iter_3_1:UpdateHP(-math.max(0, math.floor(var_3_2 * self._rate) + self._damage + math.random(-self._offset, self._offset)), var_3_0)

		if not iter_3_1:IsAlive() then
			var_0_0.Battle.BattleAttr.Spirit(iter_3_1)
			var_0_0.Battle.BattleAttr.AppendInvincible(iter_3_1)
		end
	end

	BattleEnvironmentBehaviourDamage.super.doBehaviour(self)

	return
end

return
