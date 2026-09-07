ys = ys or {}
ys.Battle.BattleSkillConsumeBuff = class("BattleSkillConsumeBuff", ys.Battle.BattleSkillEffect)
ys.Battle.BattleSkillConsumeBuff.__name = "BattleSkillConsumeBuff"

local var_0_0 = ys.Battle.BattleSkillConsumeBuff

function ys.Battle.BattleSkillConsumeBuff:Ctor(arg_1_1, arg_1_2)
	var_0_0.super.Ctor(self, arg_1_1, arg_1_2)

	self._buffID = self._tempData.arg_list.buff_id
	self._count = self._tempData.arg_list.consume_count

	return
end

function ys.Battle.BattleSkillConsumeBuff:DoDataEffect(arg_2_1, arg_2_2)
	if arg_2_2:IsAlive() then
		arg_2_2:ConsumeBuffStack(self._buffID, self._count)
	end

	return
end

return
