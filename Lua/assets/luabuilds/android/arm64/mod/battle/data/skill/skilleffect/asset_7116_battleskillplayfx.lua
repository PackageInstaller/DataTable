ys = ys or {}

local var_0_0 = ys
local BattleSkillPlayFX = class("BattleSkillPlayFX", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillPlayFX = BattleSkillPlayFX
BattleSkillPlayFX.__name = "BattleSkillPlayFX"

function BattleSkillPlayFX:Ctor(arg_1_1, arg_1_2)
	BattleSkillPlayFX.super.Ctor(self, arg_1_1, arg_1_2)

	self._FXID = self._tempData.arg_list.effect

	return
end

function BattleSkillPlayFX:DoDataEffect(arg_2_1, arg_2_2)
	var_0_0.Battle.BattleDataProxy.GetInstance():SpawnEffect(self._FXID, (self.calcCorrdinate(self._tempData.arg_list, arg_2_1, arg_2_2)))

	return
end

function BattleSkillPlayFX:DoDataEffectWithoutTarget(arg_3_1)
	var_0_0.Battle.BattleDataProxy.GetInstance():SpawnEffect(self._FXID, (self.calcCorrdinate(self._tempData.arg_list, arg_3_1)))

	return
end

return
