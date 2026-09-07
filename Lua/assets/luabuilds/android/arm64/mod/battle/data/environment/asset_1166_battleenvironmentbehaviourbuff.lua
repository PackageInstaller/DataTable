ys = ys or {}

local var_0_0 = ys
local BattleEnvironmentBehaviourBuff = class("BattleEnvironmentBehaviourBuff", ys.Battle.BattleEnvironmentBehaviour)

ys.Battle.BattleEnvironmentBehaviourBuff = BattleEnvironmentBehaviourBuff
BattleEnvironmentBehaviourBuff.__name = "BattleEnvironmentBehaviourBuff"

function BattleEnvironmentBehaviourBuff:Ctor()
	BattleEnvironmentBehaviourBuff.super.Ctor(self)

	return
end

function BattleEnvironmentBehaviourBuff:SetTemplate(arg_2_1)
	BattleEnvironmentBehaviourBuff.super.SetTemplate(self, arg_2_1)

	self._buffID = self._tmpData.buff_id
	self._buffLevel = self._tmpData.level or 1

	return
end

function BattleEnvironmentBehaviourBuff:doBehaviour()
	for iter_3_0, iter_3_1 in ipairs(self._cldUnitList) do
		if iter_3_1:IsAlive() then
			iter_3_1:AddBuff((var_0_0.Battle.BattleBuffUnit.New(self._buffID, self._buffLevel)))
		end
	end

	BattleEnvironmentBehaviourBuff.super.doBehaviour(self)

	return
end

return
