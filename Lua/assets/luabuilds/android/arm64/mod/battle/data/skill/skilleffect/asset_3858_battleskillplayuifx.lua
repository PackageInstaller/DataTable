ys = ys or {}

local var_0_0 = ys
local BattleSkillPlayUIFX = class("BattleSkillPlayUIFX", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillPlayUIFX = BattleSkillPlayUIFX
BattleSkillPlayUIFX.__name = "BattleSkillPlayUIFX"

function BattleSkillPlayUIFX:Ctor(arg_1_1, arg_1_2)
	BattleSkillPlayUIFX.super.Ctor(self, arg_1_1, arg_1_2)

	self._FXID = self._tempData.arg_list.effect
	self._scale = self._tempData.arg_list.scale
	self._order = self._tempData.arg_list.order

	return
end

function BattleSkillPlayUIFX:DoDataEffect(arg_2_1, arg_2_2)
	var_0_0.Battle.BattleDataProxy.GetInstance():SpawnUIFX(self._FXID, self.calcCorrdinate(self._tempData.arg_list, arg_2_1, arg_2_2), self._scale, self._order)

	return
end

function BattleSkillPlayUIFX:DoDataEffectWithoutTarget(arg_3_1)
	var_0_0.Battle.BattleDataProxy.GetInstance():SpawnUIFX(self._FXID, self.calcCorrdinate(self._tempData.arg_list, arg_3_1), self._scale, self._order)

	return
end

return
